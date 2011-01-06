<cfoutput>
    <h1>Contact Form</h1>

    <p>
        <cfoutput>#getPlugin("HelloWorld").greet()#</cfoutput>
    </p>

    <cfif contactForm.hasErrors()>
        <ul style="color:red;font-weight:bold;">
            <cfloop
                index="field"
                array="#contactForm.getErrors()#">
                <cfloop
                    index="error"
                    array="#field.errors#">
                    <li>#error#</li>
                </cfloop>
            </cfloop>
        </ul>
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
            <input type="submit" value="Submit">
        </div>
    </form>
</cfoutput>
