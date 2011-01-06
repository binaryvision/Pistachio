<!doctype html>
<html>
    <head>
        <title>Contact Form</title>
    </head>
    <body>
        <cffunction
            name="getController"
            returnType="any">
            <cfreturn application.pistachio>
        </cffunction>

        <cffunction
            name="getRequest"
            returnType="any">
            <cfreturn getController().getRequestService().getRequestContext()>
        </cffunction>

        <cfoutput>
            #getController().getModuleService().dispatch("contactform", getRequest())#
        </cfoutput>
    </body>
</html>
