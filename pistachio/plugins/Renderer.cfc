<cfcomponent
    cache="false"
    extends="pistachio.plugins.BasePlugin">
    <cffunction
        name="getTemplate"
        returnType="string">
        <cfargument
            name="template"
            type="string"
            required="yes">

        <cfloop
            index="local.path"
            array="#getSetting("template_paths")#">
            <cfset var templatePath = path & "/" & template>
            <cfif FileExists(ExpandPath(templatePath))>
                <cfreturn templatePath>
            </cfif>                                         
        </cfloop>

        <cfthrow
            type="pistachio.TemplateNotFound"
            message="Template Not Found"
            detail="Could not locate the template #template# in any registered template dirs.">
    </cffunction>


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

        <cfloop
            item="local._key"
            collection="#_context#">
            <cfset local[_key] = _context[_key]>
        </cfloop>

        <cfsavecontent
            variable="local.renderedTemplate">
            <cfoutput>
                <cfinclude
                    template="#getTemplate(_template)#">
            </cfoutput>
        </cfsavecontent>

        <cfreturn renderedTemplate>
    </cffunction>
</cfcomponent>



