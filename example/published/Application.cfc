<cfcomponent
    extends="pistachio.BaseFramework">
	<cfset this.name = hash(getCurrentTemplatePath())> 
	<cfset this.sessionManagement = true>
	<cfset this.sessionTimeout = createTimeSpan(0,0,30,0)>
    <cfset this.clientManagement = true>
	<cfset this.setClientCookies = true>
    <cfset setPathToPistachioSettings("/example/config/environments/Development")>
</cfcomponent>
