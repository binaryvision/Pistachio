<cfscript>
component
{
    // Magenta

    pistachio_path = "/pistachio";
    pistachio_plugins_path = pistachio_path & "/plugins";

    // AntiSamy

    antisamy_lib_path = pistachio_plugins_path & "/AntiSamy";

    antisamy_policy_files = {
        slashdot  = _antiSamyFilePath("antisamy-slashdot-1.4.1.xml")
        , ebay    = _antiSamyFilePath("antisamy-ebay-1.4.1.xml")
        , tinymce = _antiSamyFilePath("antisamy-tinymce-1.4.1.xml")
        , myspace = _antiSamyFilePath("antisamy-myspace-1.4.1.xml")
    };

    // JavaLoader

    javaloader_load_paths = [         
        _antiSamyFilePath("/antisamy-bin.1.4.1.jar")
        , _antiSamyFilePath("/batik-css.jar")
        , _antiSamyFilePath("/batik-util.jar")
        , _antiSamyFilePath("/nekohtml.jar")
        , _antiSamyFilePath("/xercesImpl.jar")
    ];

    // Helpers

    private function _antiSamyFilePath(filename)
    {
        return expandPath(antisamy_lib_path & "/" & arguments.filename);
    }

}
</cfscript>
