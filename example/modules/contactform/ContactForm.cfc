<cfcomponent
    extends="pistachio.forms.BaseForm">
    <cfscript>

        addConstraints("name", [
            constraint(
                method="isNotBlank",
                msg="Please enter your name.")]);

        addConstraints("email", [
            constraint(
                method="isNotBlank",
                msg="Please enter your email."),
            constraint(
                method="isEmailFormat",
                msg="Please enter a valid email address.")]);

        addConstraints("message", [
            constraint(
                method="isNotBlank",
                msg="Please enter your message.")]);

    </cfscript>
    <cffunction
        name="process"
        returnType="void">
        <cfmail
            attributeCollection="#getSetting("contact_form_cfmail_attributes")#">
            <cfoutput>
                <!--- we could also just do a cfinclude here, if we did then we could use cfmailparam, so its a toss up --->
                #getPlugin("Renderer").render("contactform\email.cfm", {
                    name=getValue(key="name", escape=false)
                    , email=getValue(key="email", escape=false)
                    , message=getValue(key="message", escape=false)
                })#
            </cfoutput>
        </cfmail>

        <cflocation
            url="#cgi.script_name#/success"
            addToken="false">
    </cffunction>
</cfcomponent>
