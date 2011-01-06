<cfcomponent
    extends="pistachio.forms.BaseValidator">
    <cffunction
        name="getValue"
        output="false"
        returnType="any">
        <cfargument
            name="key"
            type="string"
            required="yes">
        <cfargument
            name="default"
            type="any">
        <cfargument
            name="escape"
            type="boolean"
            default="yes">
        <cfreturn escape
            ? escapeHTML(super.getValue(argumentCollection=arguments))
            : super.getValue(argumentCollection=arguments)>
    </cffunction>


    <cffunction
        name="escapeHTML"
        returnType="string">
        <cfargument
            name="value"
            type="string"
            required="yes">
        <cfreturn HTMLEditFormat(value)>
    </cffunction>
</cfcomponent>
