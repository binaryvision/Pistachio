<cfcomponent
    extends="pistachio.BaseComponent"
    accessors="true">
    <cfproperty
        name="pathToRoutes"
        type="string"
        getter="true">
    <cfproperty
        name="mappings"
        type="array"
        getter="true">


    <cffunction
        name="init"
        returnType="any">
        <cfargument
            name="controller"
            type="any"
            required="yes">
        <cfargument
            name="pathToRoutes"
            type="string"
            required="yes">
        <cfset super.init(controller)>
        <cfset setMappings([])>
        <cfset setPathToRoutes(pathToRoutes)>
        <cfset loadRoutes()>
        <cfreturn this>
    </cffunction>


    <cffunction
        name="addRoute"
        returnType="void">
        <cfargument
            name="pattern"
            type="string"
            required="yes">
        <cfargument
            name="component"
            type="string"
            default="#this.getPathToRoutes()#/Handlers">
        <cfargument
            name="method"
            type="string"
            required="yes">
        <cfargument
            name="kwargs"
            type="struct"
            default="#StructNew()#">
        <cfargument
            name="constraints"
            type="array"
            default="#ArrayNew(1)#">
        <cfargument
            name="via"
            type="string"
            default="ALL">
        <cfargument
            name="protectFromForgery"
            type="boolean"
            default="#this.getSetting("protect_from_forgery", "true")#">
        <cfset pattern = getController().getModuleService().newRegex(pattern)>
        <cfset ArrayAppend(this.getMappings(), arguments)>
    </cffunction>


    <cffunction
        name="loadRoutes"
        returnType="void">
        <cfinclude template="#getPathToRoutes()#/routes.cfm">
    </cffunction>


    <cffunction
        name="resolve"
        returnType="any">
        <cfargument
            name="requestContext"
            type="any"
            required="yes">
        <cfset var path = requestContext.getPathInfo()>

        <cfloop
            index="local.mapping"
            array="#getMappings()#">
            <cfif mapping.pattern.isMatch(path)
                and meetsConstraints(requestContext, mapping)>
                <cfif mapping.protectFromForgery and not requestContext.verifyCSRFToken()>
                    <cfthrow
                        type="pistachio.InvalidAuthenticityToken">
                </cfif>

                <cfreturn {
                    component=mapping.component,
                    method=mapping.method,
                    kwargs=getParams(path, mapping.pattern, mapping.kwargs)
                }>
            </cfif>
        </cfloop>

        <cfreturn false>
    </cffunction>


    <cffunction
        name="meetsConstraints"
        returnType="boolean">
        <cfargument
            name="requestContext"
            type="any"
            required="yes">
        <cfargument
            name="mapping"
            type="struct"
            required="yes">
        <cfreturn
            meetsMethodConstraints(requestContext, mapping.via)
            and meetsRequestConstraints(requestContext, mapping.constraints)>
    </cffunction>


    <cffunction
        name="meetsMethodConstraints"
        returnType="boolean"
        access="private">
        <cfargument
            name="requestContext"
            type="any"
            required="yes">
        <cfargument
            name="methods"
            type="string"
            required="yes">
        <cfreturn (
            methods.equalsIgnoreCase("all")
            or ListContainsNoCase(methods, requestContext.getMethod(), ","))>
    </cffunction>


    <cffunction
        name="meetsRequestConstraints"
        returnType="boolean"
        access="private">
        <cfargument
            name="requestContext"
            type="any"
            required="yes">
        <cfargument
            name="constraints"
            type="array"
            required="yes">
        <cfloop
            index="local.constraint"
            array="#constraints#">
            <cfif not constraintMet(requestContext, constraint)>
                <cfreturn false>
            </cfif>
        </cfloop>
        <cfreturn true>
    </cffunction>


    <cffunction
        name="constraintMet"
        returnType="boolean"
        access="private">
        <cfargument
            name="requestContext"
            type="any"
            required="yes">
        <cfargument
            name="constraint"
            type="string"
            required="yes">
        <cfinvoke
            method="#constraint#"
            returnVariable="local.result"
            requestContext="#requestContext#">
        <cfreturn result>
    </cffunction>


    <cffunction
        name="getParams"
        returnType="struct"
        access="private">
        <cfargument
            name="path"
            type="string"
            required="yes">
        <cfargument
            name="pattern"
            type="any"
            required="yes">
        <cfargument
            name="defaults"
            type="struct"
            default="#StructNew()#">
        <cfset var params = duplicate(defaults)>
        <cfset var groups = pattern.match(path).get_groups()>

        <cfloop
            index="local.group"
            array="#pattern.getGroupNames()#">
            <cfif not isNumeric(group)>
                <cfset params[group] = groups.get_item(group).ToString()>
            </cfif>
        </cfloop>

        <cfreturn params>
    </cffunction>
</cfcomponent>
