<cfcomponent
    cache="true"
    extends="BaseScopeStorage">
    <cffunction
        name="getStorage"
        returnType="struct">
        <cfif not StructKeyExists(application, getStorageKey())>
            <cfset initStorage()>
        </cfif>

        <cfreturn application[getStorageKey()]>
    </cffunction>


    <cffunction
        name="initStorage"
        returnType="void">
        <cfset application[getStorageKey()] = {}>
    </cffunction>
</cfcomponent>
