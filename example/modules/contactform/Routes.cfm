<cfscript>

addRoute(
    pattern="^/success$"
    , method="success"
    , via="GET");

addRoute(
    pattern=".*"
    , method="index"
    , via="GET,POST");

</cfscript>
