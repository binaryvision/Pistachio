<cfcomponent
    extends="BasePlugin">
    <cffunction
        name="setValue"
        returnType="void">
        <cfargument
            name="key"
            type="string"
            required="yes">
        <cfargument
            name="value"
            type="any"
            required="yes">
        <cfset getStorage()[key] = value>
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

        <cfreturn (not valueExists(key) and isDefined("arguments.default"))
            ? arguments.default
            : getStorage()[key]>
    </cffunction>


    <cffunction
        name="setDefaultValue"
        returnType="void">
        <cfargument
            name="key"
            type="string"
            required="yes">
        <cfargument
            name="value"
            type="any"
            required="yes">
        <cfif not valueExists(key)>
            <cfset setValue(argmentCollection=arguments)>
        </cfif>
    </cffunction>


    <cffunction
        name="valueExists"
        returnType="boolean">
        <cfargument
            name="key"
            type="string"
            required="yes">
        <cfreturn StructKeyExists(getStorage(), key)>
    </cffunction>


    <cffunction
        name="removeValue"
        returnType="void">
        <cfargument
            name="key"
            type="string"
            required="yes">
        <cfreturn StructDelete(getStorage(), key)>
    </cffunction>
</cfcomponent>
