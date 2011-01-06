<cfcomponent
    cache="true"
    extends="pistachio.plugins.BasePlugin">
    <cffunction
        name="init"
        returnType="any">
        <cfargument
            name="controller"
            type="any">
        <cfset super.init(controller)>

        <cfset javaloader = CreateObject("component", "pistachio.javaloader.JavaLoader").init(
            trustedSource = getSetting("javaloader_dynamicly_recompile", "true")
            , loadPaths = getSetting("javaloader_load_paths", [])
            , loadColdFusionClassPath = getSetting("javaloader_load_coldfusion_class_path", "false")
            , sourceDirectories = getSetting("javaloader_source_paths", [])
        )>

        <cfreturn this>
    </cffunction>


    <cffunction
        name="create"
        returnType="any">
        <cfargument
            name="classPath"
            type="string"
            required="yes">
        <cfreturn javaloader.create(classPath)>
    </cffunction>
</cfcomponent>
