<cfcomponent
    extends="pistachio.beans.CollectionBean">
    <cfparam name="instance" default="#StructNew()#">
    <cfparam name="constants" default="#StructNew()#">
    <cfset constants.HTTP_METHODS = "GET,POST,PUT,DELETE">
    <cfset constants.HTTP_GET     = "GET">
    <cfset constants.HTTP_POST    = "POST">
    <cfset constants.HTTP_PUT     = "PUT">
    <cfset constants.HTTP_DELETE  = "DELETE">
    <cfset constants.METHOD_OVERRIDE_PARAM = "_method">
    <cfset constants.METHOD_OVERRIDE_HEADER = "HTTP_X_HTTP_METHOD_OVERRIDE">


    <cffunction
        name="setCollection"
        returnType="void">
        <cfargument
            name="collection"
            type="struct"
            required="yes">
        <cfset super.setCollection(parseNestedParams(collection))>
    </cffunction>


    <cffunction
        name="appendCollection"
        returnType="void">
        <cfargument
            name="collection"
            type="struct"
            required="yes">
        <cfargument
            name="overwrite"
            type="boolean"
            default="yes">
        <cfset super.appendCollection(parseNestedParams(collection), overwrite)>
    </cffunction>


    <cffunction
        name="getHeaders"
        returnType="struct">
        <cfargument
            name="deepCopy"
            type="boolean"
            default="false">
        <cfreturn arguments.deepCopy
            ? Duplicate(StructGet("instance.requestData.headers"))
            : StructGet("instance.requestData.headers")>
    </cffunction>


    <cffunction
        name="setRequestData"
        returnType="void">
        <cfargument
            name="requestData"
            type="struct"
            required="yes">
        <cfset instance.requestData = requestData>
    </cffunction>
    <cffunction
        name="getRequestData"
        returnType="struct">
        <cfargument
            name="deepCopy"
            type="boolean"
            default="false">
        <cfreturn arguments.deepCopy
            ? Duplicate(StructGet("instance.requestData"))
            : StructGet("instance.requestData")>
    </cffunction>


    <cffunction
        name="setEnv"
        returnType="void">
        <cfargument
            name="env"
            type="struct"
            required="yes">
        <cfset instance.env = env>
    </cffunction>
    <cffunction
        name="getEnv"
        returnType="struct">
        <cfargument
            name="deepCopy"
            type="boolean"
            default="false">
        <cfreturn arguments.deepCopy
            ? Duplicate(StructGet("instance.env"))
            : StructGet("instance.env")>
    </cffunction>


	<cffunction
        name="getPath"
        returnType="string">
        <cfreturn getEnv().path>
    </cffunction>


	<cffunction
        name="getPathInfo"
        returnType="string">
        <cfreturn getEnv().path_info>
    </cffunction>


    <cffunction
        name="getMethod"
        returnType="string">
        <cfif getEnv().request_method EQ constants.HTTP_POST>
            <cfif valueExists(constants.METHOD_OVERRIDE_PARAM)>
                <cfset var method = UCase(Trim(getValue(constants.METHOD_OVERRIDE_PARAM)))>
            <cfelse>
                <cfif StructKeyExists(getHeaders(), constants.METHOD_OVERRIDE_HEADER)>
                    <cfset var method = UCase(Trim(getHeaders()[constants.METHOD_OVERRIDE_HEADER]))>
                </cfif>
            </cfif>

            <cfif IsDefined("local.method") and ListFind(constants.HTTP_METHODS, method)>
                <cfreturn method>
            </cfif>
        </cfif>

        <cfreturn getEnv().request_method>
    </cffunction>


    <cffunction
        name="isSSL"
        returnType="boolean">
        <cfreturn
            StructKeyExists(getEnv(), "server_port_secure")
            and IsBoolean(getEnv().server_port_secure)
            and getEnv().server_port_secure>
    </cffunction>


    <cffunction
        name="isGet"
        returnType="boolean">
        <cfreturn getMethod() EQ constants.HTTP_GET>
    </cffunction>


    <cffunction
        name="isPost"
        returnType="boolean">
        <cfreturn getMethod() EQ constants.HTTP_POST>
    </cffunction>


    <cffunction
        name="isPut"
        returnType="boolean">
        <cfreturn getMethod() EQ constants.HTTP_PUT>
    </cffunction>


    <cffunction
        name="isDelete"
        returnType="boolean">
        <cfreturn getMethod() EQ constants.HTTP_DELETE>
    </cffunction>


    <cffunction
        name="isAjax"
        returnType="boolean">
        <cfreturn
            StructKeyExists(getEnv(), "http_x_requested_with")
            and (getEnv().http_x_requested_with EQ "XMLHTTPRequest")>
    </cffunction>


    <cffunction
        name="parseNestedParams"
        access="private"
        returnType="struct">
        <cfargument
            name="struct"
            type="struct"
            required="yes">
        <cfset struct = duplicate(struct)>

        <cfloop
            item="local.item"
            collection="#struct#">
            <!--- flatten single value arrays --->
            <cfif IsArray(struct[item]) and (ArrayLen(struct[item]) eq 1)>
                <cfset struct[item] = struct[item][1]>
            </cfif>

            <!--- allow both foo.bar and foo[bar] --->
            <cfset var delimiter = ".">
            <cfset var normalizedItem = Replace(Replace(item, "]", "", "all"), "[", delimiter, "all")>
            <cfset var numNestedParams = ListLen(normalizedItem, delimiter)>

            <!--- loop through all the levels (foo.bar has 2 levels, building the structure then assign to the element if we ) --->
            <cfif numNestedParams gt 1>
                <cfset var tmpStruct = duplicate(struct)>
                <cfset var subStruct = tmpStruct>
                <cfloop
                    index="nestedParam"
                    list="#ListDeleteAt(normalizedItem, numNestedParams, delimiter)#"
                    delimiters="#delimiter#">
                    <cfif (IsDefined("subStruct.#nestedParam#")) and (not IsStruct(subStruct[nestedParam]))>
                        <!--- don't overwrite existing information --->
                        <cfset StructDelete(local, "subStruct")>
                        <cfbreak>
                    </cfif>
                    <cfset subStruct = StructGet("subStruct.#nestedParam#")>
                </cfloop>

                <cfif IsDefined("local.subStruct")>
                    <cfset subStruct[ListLast(normalizedItem, delimiter)] = struct[item]>
                    <cfset struct = tmpStruct>
                </cfif>
            </cfif>
        </cfloop>

        <cfreturn struct>
    </cffunction>
</cfcomponent>
