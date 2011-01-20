<cfcomponent
    extends="pistachio.services.BaseService">
    <cfparam name="instance" default="#StructNew()#">
    <cfparam name="constants" default="#StructNew()#">
    <cfset constants.DEFAULT_REQUEST_CONTEXT_KEY = "_pistachio_request">


    <cffunction
        name="setRequestContext"
        returnType="void">
        <cfargument
            name="RequestContext"
            type="any"
            required="yes">
        <cfset request[getRequestContextKey()] = RequestContext>
    </cffunction>
    <cffunction
        name="getRequestContext"
        returnType="any">
        <cfreturn StructKeyExists(request, getRequestContextKey())
            ? request[getRequestContextKey()]
            : createRequestContext()>
    </cffunction>


    <cffunction
        name="createRequestContext"
        returnType="any">
        <cfset var context = new pistachio.http.RequestBean()>
        <cfset context.setController(getController())>
        <cfset context.setEnv(cgi)>
        <cfset context.setRequestData(GetHttpRequestData())>
        <cfset context.appendCollection(getPageContext().getRequest().getParameterMap())>
        <cfset setRequestContext(context)>
        <cfreturn context>
    </cffunction>


    <cffunction
        name="getRequestContextKey"
        returnType="string">
        <cfreturn structKeyExists(instance, "requestContextKey")
            ? instance.requestContextKey
            : constants.DEFAULT_REQUEST_CONTEXT_KEY>
    </cffunction>
</cfcomponent>
