<cfcomponent
    hint="Extend this with your projects Application.cfc">
    <cfparam name="instance" default="#StructNew()#">
    <cfparam name="constants" default="#StructNew()#">
    <cfset constants.DEFAULT_APP_KEY = "pistachio">


    <cffunction
        name="onApplicationStart"
        returnType="void">
        <cfset loadPistachioFacade()>
    </cffunction>


    <cffunction
        name="loadPistachioFacade"
        returnType="void">
        <cfset clearPistachioFacade()>
        <cfset application[getAppKey()] = new pistachio.Controller(getPathToPistachioSettings())>
    </cffunction>


    <cffunction
        name="clearPistachioFacade"
        returnType="void">
        <cfset StructDelete(application, getAppKey())>
    </cffunction>


    <cffunction
        name="getAppKey"
        returnType="string">
        <cfreturn structKeyExists(instance, "appKey")
            ? instance.appKey
            : constants.DEFAULT_APP_KEY>
    </cffunction>
    <cffunction
        name="setAppKey"
        returnType="void">
        <cfargument
            name="appKey"
            type="string"
            required="yes">
        <cfset instance.appKey = appKey>
    </cffunction>


    <cffunction
        name="setPathToPistachioSettings"
        returnType="void">
        <cfargument
            name="path"
            type="string"
            required="yes">
        <cfset instance.pathToPistachioSettings = path>
    </cffunction>
    <cffunction
        name="getPathToPistachioSettings"
        returnType="string">
        <cfreturn instance.pathToPistachioSettings>
    </cffunction>
</cfcomponent>
