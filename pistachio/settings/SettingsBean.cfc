<cfcomponent
    hint="Settings Facade"
    extends="pistachio.beans.CollectionBean">
    <cffunction
        name="init"
        returnType="any">
        <cfargument
            name="pathToInitialSettings"
            type="string"
            required="yes">
        <cfset appendSettings(pathToInitialSettings)>
        <cfreturn this>
    </cffunction>


    <cffunction
        name="appendSettings"
        returnType="void">
        <cfargument
            name="pathToSettings"
            type="string"
            required="yes">
        <cfargument
            name="overwrite"
            type="boolean"
            default="false">
        <cfset var settings = CreateObject("component", pathToSettings)>
        <cfset settings._getVariablesScope = _getVariablesScope>
        <cfset StructAppend(
            getCollection(),
            settings._getVariablesScope(),
            overwrite)>
    </cffunction>


    <cffunction
        name="_getVariablesScope"
        returnType="struct">
        <cfreturn variables>
    </cffunction>


    <cffunction
        name="isPsuedoPrivateAttribute"
        returnType="boolean"
        access="private">
        <cfargument
            name="key"
            type="string"
            required="yes">
        <cfreturn left(arguments.key, 1) EQ "_">
    </cffunction>


    <cffunction
        name="removePsuedoPrivateAttributes"
        returnType="void"
        access="private">
        <cfargument
            name="struct"
            type="struct"
            required="yes">
        <cfloop
            item="local.key"
            collection="#struct#">
            <cfif isPsuedoPrivateAttribute(key)>
                <cfset StructDelete(struct, key)>
            </cfif>
        </cfloop>
    </cffunction>
</cfcomponent>
