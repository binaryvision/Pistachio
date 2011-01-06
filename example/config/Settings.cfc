<cfscript>
component
    extends="pistachio.settings.ProjectDefaults"
{
    project_path = "/example";

    plugins_path = project_path & "/plugins";

    modules = [
        project_path & "/modules/contactForm"
    ];

    template_paths = [
        project_path & "/templates"
    ];

    encrypt_cookies = false;
}
</cfscript>
