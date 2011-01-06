<cfcomponent
    cache="true"
    extends="BaseScopeStorage">
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

        <cfif not isSimpleValue(value)>
            <cfwddx
                action="cfml2wddx"
                input="#value#"
                output="value">
        </cfif>

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

        <cfset var value = (not valueExists(key) and isDefined("arguments.default"))
            ? arguments.default
            : getStorage()[key]>

        <cfif isWDDX(value)>
            <cfwddx
                action="wddx2cfml"
                input="#value#"
                output="value">
        </cfif>

        <cfreturn value>
    </cffunction>


    <cffunction
        name="getStorage"
        returnType="struct">
        <cfreturn client>
    </cffunction>
</cfcomponent>
