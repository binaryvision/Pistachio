<cfcomponent
    extends="pistachio.services.BaseService">
    <cffunction
        name="put"
        returnType="void">
        <cfargument
            name="id"
            type="string"
            required="yes">
        <cfargument
            name="value"
            type="any"
            required="yes">
        <cfargument
            name="timeSpan"
            type="any"
            default="">
        <cfargument
            name="idleTime"
            type="any"
            default="">
        <cfset CachePut(id, value, timeSpan, idleTime)>
    </cffunction>


    <cffunction
        name="get"
        returnType="any">
        <cfargument
            name="id"
            type="string"
            required="yes">
        <cfreturn CacheGet(id)>
    </cffunction>


    <cffunction
        name="clear"
        returnType="void">
        <cfargument
            name="ids"
            hint="comma delimitered list of cache ids to remove."
            type="list"
            required="yes">
        <cfset CacheRemove(ids)>
    </cffunction>


    <cffunction
        name="clearAll"
        returnType="void">
        <cfset var keys = ArrayToList(CacheGetAllIds())>

        <cfif len(keys)>
            <cfset CacheRemove(keys)>
        </cfif>
    </cffunction>


    <cffunction
        name="getMetadata"
        returnType="struct">
        <cfargument
            name="id"
            type="string"
            required="yes">
        <cfreturn CacheGetMetadata(id)>
    </cffunction>
</cfcomponent>
