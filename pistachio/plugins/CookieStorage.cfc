<cfcomponent
    cache="true"
    accessors="true"
    extends="BaseScopeStorage">
    <cfproperty name="encryption">
    <cfproperty name="encryptionKey">
    <cfproperty name="encryptionAlgorithm">
    <cfproperty name="encryptionEncoding">


    <cffunction
        name="init"
        returnType="any">
        <cfscript>
            super.init(argumentCollection=arguments);

            setEncryption(
                getSetting("ENCRYPT_COOKIES", false));
            setEncryptionKey(
                getSetting("COOKIE_ENCRYPTION_KEY", "MagentaFramework"));
            setEncryptionAlgorithm(
                getSetting("COOKIE_ENCRYPTION_ALGORITHM", "CFMX_COMPAT"));
            setEncryptionEncoding(
                getSetting("COOKIE_ENCRYPTION_ENCODING", "UU"));

            return this;
        </cfscript>
    </cffunction>


    <cffunction
        name="setValue"
        returnType="void">
        <cfargument
            name="name"
            type="string"
            required="yes">
        <cfargument
            name="value"
            type="any"
            required="yes">
        <cfargument
            name="expires"
            type="numeric"
            default="0">
        <cfargument
            name="secure"
            type="boolean"
            default="false">
        <cfargument
            name="path"
            type="string">
        <cfargument
            name="domain"
            type="string">

        <cfif not isSimpleValue(value)>
            <cfwddx
                action="cfml2wddx"
                input="#value#"
                output="value">
        </cfif>

        <!---
            Nonsensical coldfusion, can't pass undefined struct elements 
            to cfcookie. Probably a better way of managing this.
        --->
        <cfif not StructKeyExists(arguments, "path")>
            <cfset StructDelete(arguments, "path")>
        </cfif>
        <cfif not StructKeyExists(arguments, "domain")>
            <cfset StructDelete(arguments, "domain")>
        </cfif>

        <cfif getEncryption()>
            <cfset value = encryptValue(value)>
        </cfif>

        <cfcookie attributeCollection="#arguments#">
    </cffunction>
    <cffunction
        name="getValue"
        returnType="any">
        <cfargument
            name="key"
            type="string"
            required="yes">
        <cfargument
            name="default"
            type="any">

        <cfset var value = (not valueExists(key) and isDefined("arguments.default"))
            ? arguments.default
            : getStorage()[key]>

        <cfif getEncryption()>
            <cfset value = decryptValue(value)>
        </cfif>

        <cfif isWDDX(value)>
            <cfwddx
                action="wddx2cfml"
                input="#value#"
                output="value">
        </cfif>

        <cfreturn value>
    </cffunction>


    <cffunction
        name="removeValue"
        returnType="void">
        <cfargument
            name="key"
            type="string"
            required="yes">
        <cfcookie name="#name#" expires="NOW" value='NULL'>
        <cfset StructDelete(getStorage(), name)>
    </cffunction>


    <cffunction
        name="getStorage"
        returnType="any">
        <cfreturn cookie>
    </cffunction>


    <cffunction
        name="encryptValue"
        returnType="string">
        <cfargument
            name="value"
            type="string"
            required="yes">
        <cfreturn encrypt(
            value
            , getEncryptionKey()
            , getEncryptionAlgorithm()
            , getEncryptionEncoding()
        )>
    </cffunction>


    <cffunction
        name="decryptValue"
        returnType="string">
        <cfargument
            name="value"
            type="string"
            required="yes">
        <cfreturn decrypt(
            value
            , getEncryptionKey()
            , getEncryptionAlgorithm()
            , getEncryptionEncoding()
        )>
    </cffunction>
</cfcomponent>
