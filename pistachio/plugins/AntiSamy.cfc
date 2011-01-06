<cfcomponent
    cache="true"
    accessors="true"
    extends="pistachio.plugins.BasePlugin">
    <cfproperty name="policyFileStruct">


    <cffunction
        name="init"
        returnType="any">
        <cfargument
            name="controller"
            type="any"
            required="yes">
        <cfset super.init(controller)>

        <cfset setPolicyFileStruct(getSetting("antisamy_policy_files"))>

        <cfreturn this>
    </cffunction>


    <cffunction
        name="newAntiSamy"
        returnType="any">
        <cfreturn getPlugin("JavaLoader").create("org.owasp.validator.html.AntiSamy")>
    </cffunction>


    <cffunction
        name="getAntiSamy"
        returnType="any">
        <cfif not isDefined("antiSamy")>
            <cfset antiSamy = newAntiSamy()>
        </cfif>

        <cfreturn antiSamy>
    </cffunction>


    <cffunction
        name="getPolicyFile"
        returnType="string">
        <cfargument
            name="policyFile"
            type="string"
            required="yes">
        <cfif not policyFileExists(policyFile)>
            <cfthrow
                type="AntiSamy.PolicyFileNotFound"
                message="Specified AntiSamy Policy File does not exist.">
        </cfif>

        <cfreturn getPolicyFileStruct()[policyFile]>
    </cffunction>


    <cffunction
        name="policyFileExists"
        returnType="string">
        <cfargument
            name="policyFile"
            type="string"
            required="yes">
        <cfreturn StructKeyExists(getPolicyFileStruct(), policyFile)>
    </cffunction>


    <cffunction
        name="scan"
        returnType="any">
        <cfargument
            name="html"
            type="string"
            required="yes">
        <cfargument
            name="policy"
            type="string"
            required="yes">
        <cfreturn getAntiSamy().scan(html, getPolicyFile(policy))>
    </cffunction>


    <cffunction
        name="clean"
        returnType="string">
        <cfargument
            name="html"
            type="string"
            required="yes">
        <cfargument
            name="policy"
            type="string"
            required="yes">
        <cfreturn scan(argumentCollection=arguments).getCleanHTML()>
    </cffunction>
</cfcomponent>
