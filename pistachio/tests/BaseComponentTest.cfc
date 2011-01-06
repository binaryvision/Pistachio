<cfcomponent
    extends="mxunit.framework.TestCase">
    <cffunction
        name="setUp">
        <cfset component = CreateObject("component", "pistachio.BaseComponent")>
    </cffunction>


    <cffunction
        name="testInitSetsController">
        <cfset var controller = "controller">
        <cfset component.init(controller)>
        <cfset AssertEquals(component.getController(), controller)>
    </cffunction>
</cfcomponent>
