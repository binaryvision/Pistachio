<cfcomponent
    extends="mxunit.framework.TestCase">
    <cffunction
        name="setUp">
        <cfset router = CreateObject("component", "pistachio.module.Router").init(
            mock().getModuleService().returns(
                new pistachio.services.ModuleService(false)),
            "/pistachio/tests/module")>
    </cffunction>


    <cffunction
        name="newRegex"
        access="private"
        returnType="any">
        <cfargument
            name="regexp"
            type="string"
            required="yes">
        <cfreturn new pistachio.services.ModuleService(false).newRegex(regexp)>
    </cffunction>


    <cffunction
        name="testGetParamsReturnsStructOfParams">
        <cfset makePublic(router, "getParams")>
        <cfset var result = router.getParams("/items/24", newRegex("^/items/(?<id>.*)$"), {})>
        <cfset assertEquals(result, {id="24"})>
    </cffunction>


    <cffunction
        name="testCanPassDefaultValuesToGetParams">
        <cfset makePublic(router, "getParams")>
        <cfset var result = router.getParams("/24", newRegex("^/(?<a>.*)$"), {a=true, b=true})>
        <cfset assertEquals(result.a, 24)>
        <cfset assertEquals(result.b, true)>
    </cffunction>


    <cffunction
        name="testMappedPathResolvesToMapping">
        <cfset router.addRoute(
            pattern="^/items/(?<id>[0-9]+)/?$",
            component="a",
            method="b"
        )>

        <cfset AssertEquals(
            router.resolve(mock().getPathInfo().returns("/items/24")),
            {
                component="a",
                method="b",
                kwargs={
                    id=24
                }
            }
        )>
    </cffunction>


    <cffunction
        name="testUnmappedPathResolvesToFalse">
        <cfset AssertFalse(
            router.resolve(mock().getPathInfo().returns("/does-not-exist"))
        )>
    </cffunction>
</cfcomponent>
