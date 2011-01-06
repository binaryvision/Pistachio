<cfcomponent
    hint="Extend this with your components.">
    <cfparam name="instance" default="#StructNew()#">
    <cfparam name="constants" default="#StructNew()#">


    <cffunction
        name="init"
        returnType="any">
        <cfargument
            name="controller"
            type="any"
            required="yes">
        <cfset setController(controller)>
        <cfreturn this>
    </cffunction>


    <cffunction
        name="setController"
        returnType="component">
        <cfargument
            name="controller"
            type="any"
            required="yes">
        <cfset instance.controller = controller>
        <cfreturn this>
    </cffunction>
    <cffunction
        name="getController"
        returnType="any">
        <cfreturn instance.controller>
    </cffunction>


    <cffunction
        name="getPlugin"
        returnType="any">
        <cfreturn getController().getPluginService().get(argumentCollection=arguments)>
    </cffunction>


    <cffunction
        name="getRequest"
        returnType="any">
        <cfreturn getController().getRequestService().getRequestContext()>
    </cffunction>


    <cffunction
        name="getCache"
        returnType="any">
        <cfreturn getController().getCacheService()>
    </cffunction>


    <cffunction
        name="getSetting"
        returnType="any">
        <cfreturn getController().getSetting(argumentCollection=arguments)>
    </cffunction>


    <cffunction
        name="settingExists"
        returnType="any">
        <cfreturn getController().settingExists(argumentCollection=arguments)>
    </cffunction>
</cfcomponent>
