<cfcomponent
    extends="example.config.Settings">
    <cfset encrypt_cookies = true>
    <cfset contact_form_cfmail_attributes = {
        to="example@example.com"
        , from="example@example.com"
        , subject="Contact form"
    }>
</cfcomponent>
