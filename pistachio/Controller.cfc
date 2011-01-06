<cfcomponent
    hint="This is the pistachio facade">
    <cfset services = {}>


    <cffunction
        name="init"
        type="void">
        <cfargument
            name="pathToSettings"
            type="string"
            required="yes">
        <cfset loadProjectSettings(pathToSettings)>
        <cfset setCacheService(
            new pistachio.services.CacheService(this))>
        <cfset setPluginService(
            new pistachio.services.PluginService(this))>
        <cfset setModuleService(
            new pistachio.services.ModuleService(this))>
        <cfset setRequestService(
            new pistachio.services.RequestService(this))>
        <cfset loadModuleRouters()>
    </cffunction>


    <cffunction
        name="setCacheService"
        type="void">
        <cfargument
            name="CacheService"
            type="any"
            required="yes">
        <cfset services.CacheService = CacheService>
    </cffunction>
    <cffunction
        name="getCacheService"
        type="any">
        <cfreturn services.CacheService>
    </cffunction>


    <cffunction
        name="setPluginService"
        type="void">
        <cfargument
            name="PluginService"
            type="any"
            required="yes">
        <cfset services.PluginService = PluginService>
    </cffunction>
    <cffunction
        name="getPluginService"
        type="any">
        <cfreturn services.PluginService>
    </cffunction>


    <cffunction
        name="setModuleService"
        type="void">
        <cfargument
            name="ModuleService"
            type="any"
            required="yes">
        <cfset services.ModuleService = ModuleService>
    </cffunction>
    <cffunction
        name="getModuleService"
        type="any">
        <cfreturn services.ModuleService>
    </cffunction>


    <cffunction
        name="setRequestService"
        type="void">
        <cfargument
            name="RequestService"
            type="any"
            required="yes">
        <cfset services.RequestService = RequestService>
    </cffunction>
    <cffunction
        name="getRequestService"
        type="any">
        <cfreturn services.RequestService>
    </cffunction>


    <cffunction
        name="setSettings"
        returnType="any">
        <cfargument
            name="SettingsBean"
            type="any"
            required="yes">
        <cfset settings = SettingsBean>
    </cffunction>
    <cffunction
        name="getSettings"
        returnType="any">
        <cfreturn settings>
    </cffunction>


    <cffunction
        name="getSetting"
        returnType="any">
        <cfargument
            name="key"
            type="string">
        <cfargument
            name="default"
            type="any">
        <cfreturn getSettings().getValue(argumentCollection=arguments)>
    </cffunction>


    <cffunction
        name="settingExists"
        returnType="any">
        <cfargument
            name="key"
            type="string"
            required="yes">
        <cfreturn getSettings().valueExists(key)>
    </cffunction>


    <cffunction
        name="loadProjectSettings"
        access="private"
        returnType="void">
        <cfargument
            name="pathToSettings"
            type="string">
        <cfset setSettings(
            new pistachio.settings.SettingsBean(arguments.pathToSettings))>
        <cfset loadModuleSettings()>
    </cffunction>


    <cffunction
        name="loadModuleSettings"
        access="private"
        returnType="void">
        <cfloop
            index="local.modulePath"
            array="#getSetting("modules")#">
            <cfset getSettings().appendSettings(modulePath & "/settings")>
        </cfloop>
    </cffunction>


    <cffunction
        name="loadModuleRouters"
        access="private"
        returnType="void">
        <cfloop
            index="local.module"
            array="#getSetting("modules")#">
            <cfset getModuleService().addRouter(
                ListLast(module, "./"),
                new pistachio.module.Router(controller=this, pathToRoutes=module))>
        </cfloop>
    </cffunction>
</cfcomponent>
