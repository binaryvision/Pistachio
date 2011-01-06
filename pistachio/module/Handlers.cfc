<cfcomponent
    extends="pistachio.BaseComponent">
    <cffunction
        name="render"
        returnType="string">
        <cfargument
            name="_template"
            type="string"
            required="yes">
        <cfargument
            name="_context"
            type="struct"
            default="#StructNew()#">

        <cfreturn getPlugin("Renderer").render(argumentCollection=arguments)>
    </cffunction>


    <cffunction
        name="redirectTo"
        returnType="void">
        <cfargument
            name="url"
            type="string"
            required="yes">
        <cfargument
            name="addToken"
            type="boolean"
            default="no">
        <cflocation
            attributeCollection="#arguments#">
    </cffunction>
</cfcomponent>
