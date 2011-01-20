<cfset pistachio = new pistachio.BaseComponent(application.pistachio)>
<cfoutput>
<!doctype html>
<html>
    <head>
        #pistachio.getRequest().getCSRFMetaTags()#
        <title>Contact Form</title>
    </head>
    <body>
        #pistachio.getController().getModuleService().dispatch("contactform", pistachio.getRequest())#
    </body>
</html>
</cfoutput>
