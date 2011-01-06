<cfcomponent
    output="false"
    extends="pistachio.BaseComponent">
    <cfparam name="instance" default="#StructNew()#">
    <cfparam name="constants" default="#StructNew()#">


    <cffunction
        name="init"
        returnType="component">
        <cfloop
            index="collection"
            array="#arguments#">
            <cfset appendCollection(collection)>
        </cfloop>
        <cfreturn this>
    </cffunction>


    <cffunction
        name="setCollection"
        returnType="void">
        <cfargument
            name="collection"
            type="struct"
            required="yes">
        <cfset instance.collection = collection>
    </cffunction>
    <cffunction
        name="getCollection"
        returnType="any">
        <cfargument
            name="deepCopy"
            type="boolean"
            default="false">
        <cfreturn deepCopy
            ? duplicate(StructGet("instance.collection"))
            : StructGet("instance.collection")>
    </cffunction>


    <cffunction
        name="appendCollection"
        returnType="void">
        <cfargument
            name="collection"
            type="struct"
            required="yes">
        <cfargument
            name="overwrite"
            type="boolean"
            default="yes">
        <cfset StructAppend(getCollection(), collection, overwrite)>
    </cffunction>


    <cffunction
        name="clearCollection"
        returnType="void">
        <cfset StructClear(getCollection())>
    </cffunction>


    <cffunction
        name="setValue"
        returnType="void">
        <cfargument
            name="key"
            type="string"
            required="yes">
        <cfargument
            name="value"
            type="any"
            required="yes">

        <cfset getCollection()[key] = value>
    </cffunction>
    <cffunction
        name="getValue"
        returnType="any">
        <cfargument
            name="key"
            type="string"
            required="yes">
        <cfargument
            name="default"
            type="any">

        <cfreturn (not valueExists(key) and isDefined("arguments.default"))
            ? default
            : getCollection()[key]>
    </cffunction>


    <cffunction
        name="setDefaultValue"
        returnType="void">
        <cfargument
            name="key"
            type="string"
            required="yes">
        <cfargument
            name="default"
            type="any"
            required="yes">

        <cfif not valueExists(key)>
            <cfset setValue(key, default)>
        </cfif>
    </cffunction>


    <cffunction
        name="valueExists"
        returnType="boolean">
        <cfargument
            name="key"
            type="string"
            required="yes">

        <cfreturn StructKeyExists(getCollection(), key)>
    </cffunction>


    <cffunction
        name="removeValue"
        returnType="boolean">
        <cfargument
            name="key"
            type="string"
            required="yes">

        <cfreturn StructDelete(getCollection(), key, true)>
    </cffunction>
</cfcomponent>
