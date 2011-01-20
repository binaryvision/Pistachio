<cfimport
    prefix="p"
    taglib="/pistachio/customtags">
<cfoutput>
    <h1>Contact Form</h1>

    <p>#getPlugin("HelloWorld").greet()#</p>

    <cfif contactForm.hasErrors()>
        <p:renderErrors
            errors="#contactForm.getErrors()#">
    </cfif>

    <form
        action="#cgi.script_name#"
        method="POST">
        <div class="field">
            <label for="contact_name">Name:</label><br/>
            <input type="text" name="name" value="#contactForm.getValue("name", "")#" id="contact_name">
        </div>

        <div class="field">
            <label for="contact_email">Email:</label><br/>
            <input type="text" name="email" value="#contactForm.getValue("email", "")#" id="contact_email">
        </div>

        <div class="field">
            <label for="contact_message">Message:</label><br/>
            <textarea name="message" id="contact_message">#contactForm.getValue("message", "")#</textarea>
        </div>

        <div class="field actions">
            #getRequest().getCSRFInputTag()#
            <input type="submit" value="Submit">
        </div>
    </form>
</cfoutput>
