<cfcomponent
    cache="true"
    extends="BaseScopeStorage">
    <cfproperty name="instance" default="#{}#">
    <cfproperty name="constants" default="#{}#">
    <cfset constants.DEFAULT_STORAGE_KEY = "_pistachio_storage">


    <cffunction
        name="getStorage"
        returnType="struct">
        <cfif not StructKeyExists(session, getStorageKey())>
            <cfset initStorage()>
        </cfif>

        <cfreturn session[getStorageKey()]>
    </cffunction>


    <cffunction
        name="initStorage"
        returnType="void">
        <cfset session[getStorageKey()] = {}>
    </cffunction>


    <cffunction
        name="setStorageKey"
        returnType="void">
        <cfargument
            name="storageKey"
            type="string">
        <cfset instance.storageKey = storageKey>
    </cffunction>
    <cffunction
        name="getStorageKey"
        returnType="string">
        <cfreturn StructKeyExists(instance, "storageKey")
            ? instance.storageKey
            : constants.DEFAULT_STORAGE_KEY>
    </cffunction>
</cfcomponent>
