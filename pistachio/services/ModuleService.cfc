<cfcomponent
    extends="pistachio.services.BaseService">
    <cffunction
        name="init"
        returnType="any">
        <cfargument
            name="controller"
            type="any"
            required="yes">
        <cfset super.init(controller)>

        <cfobject
            name="regexp"
            type="dotnet"
            class="System.Text.RegularExpressions.Regex">

        <cfreturn this>
    </cffunction>


    <cffunction
        name="newRegex"
        returnType="any">
        <cfargument
            name="pattern"
            type="string"
            required="yes">
        <cfreturn regexp.init(pattern)>
    </cffunction>


    <cffunction
        name="addRouter"
        returnType="void">
        <cfargument
            name="module"
            type="string"
            required="yes">
        <cfargument
            name="router"
            type="any"
            required="yes">
        <cfset getRouters()[module] = router>
    </cffunction>


    <cffunction
        name="getRouter"
        returnType="any">
        <cfargument
            name="module"
            type="string"
            required="yes">
        <cfreturn getRouters()[module]>
    </cffunction>


    <cffunction
        name="getRouters"
        returnType="any">
        <cfreturn StructGet("routers")>
    </cffunction>


    <cffunction
        name="dispatch"
        returnType="any">
        <cfargument
            name="module"
            type="string"
            required="yes">
        <cfargument
            name="requestContext"
            type="any"
            required="yes">
        <cfset var handler = getRouter(module).resolve(requestContext)>

        <cfif not IsStruct(handler)>
            <cfthrow
                type="pistachio.PageNotFound"
                message="404 Page not found">
        </cfif>

        <cfinvoke
            component="#handler.component#"
            method="init"
            returnVariable="local.component"
            controller="#getController()#">
        <cfinvoke
            component="#component#"
            method="#handler.method#"
            returnVariable="local.response"
            argumentCollection="#handler.kwargs#">

        <cfreturn response>
    </cffunction>
</cfcomponent>
