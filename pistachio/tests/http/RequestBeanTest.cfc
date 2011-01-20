<cfcomponent
    extends="mxunit.framework.TestCase">
    <cffunction
        name="setUp">
        <cfset _request = CreateObject("component", "pistachio.http.RequestBean")>
    </cffunction>


    <cffunction
        name="testCanGetRequestPathInfo">
        <cfset var pathInfo = "/items/1">

        <cfset _request.setEnv({
            path_info = pathInfo
        })>

        <cfset assertEquals(_request.getPathInfo(), pathInfo)>
    </cffunction>


    <cffunction
        name="testCanGetRequestMethod">
        <cfset var requestMethod = "POST">

        <cfset _request.setEnv({
            request_method = requestMethod
        })>

        <cfset assertEquals(_request.getMethod(), requestMethod)>
    </cffunction>


    <cffunction
        name="testIsSSLReturnsFalseWhenNotAnSSLRequest">
        <cfset assertFalse(_request.isSSL())>
    </cffunction>


    <cffunction
        name="testIsSSLReturnsTrueWhenSSLRequest">
        <cfset _request.setEnv({
            server_port_secure=true
        })>

        <cfset assertTrue(_request.isSSL())>
    </cffunction>


    <cffunction
        name="testIsAjaxReturnsFalseWhenNotAnAjaxRequest">
        <cfset assertFalse(_request.isAjax())>
    </cffunction>


    <cffunction
        name="testIsAjaxReturnsTrueWhenAjaxRequest">
        <cfset _request.setEnv({
            http_x_requested_with="XMLHTTPRequest"
        })>

        <cfset assertTrue(_request.isAjax())>
    </cffunction>


    <cffunction
        name="testCanOverrideMethodWithParam">
        <cfset var methodOverride = "PUT">

        <cfset _request.setEnv({
            request_method = "POST"
        })>

        <cfset _request.setCollection({
            _method=methodOverride
        })>

        <cfset assertEquals(_request.getMethod(), methodOverride)>
    </cffunction>


    <cffunction
        name="testCanOverrideMethodWithHeader">
        <cfset var methodOverride = "PUT">

        <cfset _request.setEnv({
            request_method = "POST"
        })>

        <cfset _request.setRequestData({
            headers={
                http_x_http_method_override=methodOverride
            }
        })>

        <cfset assertEquals(_request.getMethod(), methodOverride)>
    </cffunction>


    <cffunction
        name="testCannotOverrideMethodWithParamViaGet">
        <cfset _request.setEnv({
            request_method = "GET"
        })>

        <cfset _request.setCollection({
            _method="PUT"
        })>

        <cfset assertEquals(_request.getMethod(), "GET")>
    </cffunction>


    <cffunction
        name="testCannotOverrideMethodWithHeaderViaGet">
        <cfset _request.setEnv({
            request_method = "GET"
        })>

        <cfset _request.setRequestData({
            headers={
                http_x_http_method_override="PUT"
            }
        })>

        <cfset assertEquals(_request.getMethod(), "GET")>
    </cffunction>


    <cffunction
        name="testCannotOverrideMethodWithInvalidHTTPMethod">
        <cfset _request.setEnv({
            request_method = "POST"
        })>

        <cfset _request.setCollection({
            _method="NOT_A_VALID_HTTP_METHOD"
        })>

        <cfset assertEquals(_request.getMethod(), "POST")>
    </cffunction>


    <cffunction
        name="testCanGetHeader">
        <cfset _request.setRequestData({
            headers={
                foo="bar"
            }
        })>

        <cfset assertEquals(_request.getHeader("foo"), "bar")>
    </cffunction>


    <cffunction
        name="testCanCheckHeaderExists">
        <cfset _request.setRequestData({
            headers={
                foo="bar"
            }
        })>

        <cfset assertTrue(_request.headerExists("foo"))>
        <cfset assertFalse(_request.headerExists("moo"))>
    </cffunction>


    <cffunction
        name="testNestedParamsAreExpanded">
        <cfset _request.setCollection({
            "user[username]" = "foo",
            "user.password" = "bar"
        })>

        <cfset assertTrue(_request.valueExists("user"))>
        <cfset assertEquals(_request.getValue("user").username, "foo")>
        <cfset assertEquals(_request.getValue("user").password, "bar")>
    </cffunction>


    <cffunction
        name="testOriginalNestedParamsAreKeptIntact">
        <cfset _request.setCollection({
            "user[username]" = "foo",
            "user.password" = "bar"
        })>

        <cfset assertEquals(_request.getValue("user[username]"), "foo")>
        <cfset assertEquals(_request.getValue("user.password"), "bar")>
    </cffunction>


    <cffunction
        name="testNestedParamsDoNotOverwriteExistingParams">
        <cfset _request.setCollection({
            "user" = "raw",
            "user[username]" = "foo",
            "user.password" = "bar"
        })>

        <cfset assertEquals(_request.getValue("user"), "raw")>
    </cffunction>           
</cfcomponent>
