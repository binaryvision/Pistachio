<cfcomponent
    extends="pistachio.services.BaseService">
    <cffunction
        name="new"
        returnType="any">
        <cfargument
            name="plugin"
            type="string"
            required="yes">
        <cfset plugin = normalizePluginName(plugin)>

        <cfset var pluginInstance = CreateObject("component", getPluginPath(arguments.plugin))>

        <cfif not pluginMetadataExists(plugin)>
            <cfset setPluginMetadata(plugin, getMetadata(pluginInstance))>
        </cfif>

        <cfreturn pluginInstance.init(getController())>
    </cffunction>


    <cffunction
        name="get"
        returnType="any">
        <cfargument
            name="plugin"
            type="string"
            required="yes">
        <cfset plugin = normalizePluginName(plugin)>

        <cfset var pluginInstance = getCachedPlugin(plugin)>

        <cfif isNull(pluginInstance)>
            <cfset pluginInstance = new(argumentCollection=arguments)>

            <cfif pluginIsCacheable(plugin)>
                <cfset cachePlugin(plugin, pluginInstance)>
            </cfif>
        </cfif>

        <cfreturn pluginInstance>
    </cffunction>


    <cffunction
        name="normalizePluginName"
        returnType="string">
        <cfargument
            name="plugin"
            type="string"
            required="yes">
        <cfreturn replace(plugin, ".", "/", "all")>
    </cffunction>


    <cffunction
        name="getCachedPlugin"
        returnType="any">
        <cfargument
            name="plugin"
            type="string"
            required="yes">
        <cfreturn getCache().get(getPluginCacheKey(plugin))>
    </cffunction>


    <cffunction
        name="pluginIsCacheable"
        returnType="boolean">
        <cfargument
            name="plugin"
            type="string"
            required="yes">
        <cfset var pluginMetadata = getPluginMetadata(plugin)>
        <cfreturn (isDefined("pluginMetadata.cache") and pluginMetadata.cache)>
    </cffunction>


    <cffunction
        name="cachePlugin"
        returnType="void"
        access="private">
        <cfargument
            name="plugin"
            type="string"
            required="yes">
        <cfargument
            name="pluginInstance"
            type="any"
            required="yes">
        <cfset var pluginMetadata = getPluginMetadata(plugin)>

        <cfset getCache().put(
            getPluginCacheKey(plugin),
            pluginInstance,
            isDefined("pluginMetadata.timeSpan") ? pluginMetadata.timeSpan : 0,
            isDefined("pluginMetadata.idleTime") ? pluginMetadata.idleTime : 0
        )>
    </cffunction>


    <cffunction
        name="setPluginMetadata"
        returnType="void">
        <cfargument
            name="plugin"
            type="string"
            required="yes">
        <cfargument
            name="pluginMetadata"
            type="struct"
            required="yes">
        <cfset getMetadataStorage()[plugin] = pluginMetadata>
    </cffunction>
    <cffunction
        name="getPluginMetadata"
        returnType="struct">
        <cfargument
            name="plugin"
            type="string"
            required="yes">
        <cfreturn getMetadataStorage()[plugin]>
    </cffunction>


    <cffunction
        name="pluginMetadataExists"
        returnType="boolean">
        <cfargument
            name="plugin"
            type="string"
            required="yes">
        <cfreturn StructKeyExists(getMetadataStorage(), plugin)>
    </cffunction>


    <cffunction
        name="getMetadataStorage"
        returnType="struct">
        <cfreturn StructGet("metadata")>
    </cffunction>


    <cffunction
        name="getPluginPath"
        returnType="string">
        <cfargument
            name="plugin"
            type="string"
            required="yes">
        <cfreturn FileExists(getProjectPluginPhysicalPath(plugin))
            ? getProjectPluginPath(plugin)
            : getPistachioPluginPath(plugin)>
    </cffunction>


    <cffunction
        name="getProjectPluginPhysicalPath"
        returnType="string">
        <cfargument
            name="plugin"
            type="string"
            required="yes">
        <cfreturn ExpandPath(getProjectPluginPath(plugin) & ".cfc")>
    </cffunction>


    <cffunction
        name="getPluginCacheKey"
        returnType="string">
        <cfargument
            name="plugin"
            type="string"
            required="yes">
        <cfreturn "pistachio_plugin_" & arguments.plugin>
    </cffunction>


    <cffunction
        name="getProjectPluginPath"
        returnType="string">
        <cfargument
            name="plugin"
            type="string"
            required="yes">
        <cfreturn getSetting("plugins_path", "") & "/" & arguments.plugin>
    </cffunction>


    <cffunction
        name="getPistachioPluginPath"
        returnType="string">
        <cfargument
            name="plugin"
            type="string"
            required="yes">
        <cfreturn getSetting("pistachio_plugins_path") & "/" & arguments.plugin>
    </cffunction>
</cfcomponent>
