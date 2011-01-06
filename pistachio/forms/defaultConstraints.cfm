<cffunction
    name="isBlank"
    hint="Returns true if the value is blank."
    returnType="boolean">
    <cfargument
        name="value"
        type="string"
        required="yes">
    <cfreturn len(trim(value)) EQ 0>
</cffunction>


<cffunction
    name="isNotBlank"
    hint="Returns true if the value is not blank."
    returnType="boolean">
    <cfargument
        name="value"
        type="string"
        required="yes">
    <cfreturn not isBlank(value)>
</cffunction>


<cffunction
    name="isEmailFormat"
    hint="Returns true if the value is blank or is an email address."
    returnType="boolean">
    <cfargument
        name="value"
        type="string"
        required="yes">
    <cfreturn
        isBlank(value)
        or isValid("email", value)>
</cffunction>


<cffunction
    name="isPasswordFormat"
    hint="Returns true if the value is blank or is a valid password."
    returnType="boolean">
    <cfargument
        name="value"
        type="string"
        required="yes">
    <cfargument
        name="minlen"
        type="numeric"
        default="6">
    <cfreturn
        isBlank(value)
        or reFind("^.*(?=.{#minlen#,})(?=.*\d)(?=.*[a-z]).*$", value)>
</cffunction>


<cffunction
    name="isInList"
    hint="Returns true if the value is blank or is in the list."
    returnType="boolean">
    <cfargument
        name="value"
        type="string"
        required="yes">
    <cfargument
        name="list"
        type="string"
        required="yes">
    <cfreturn
        isBlank(value)
        or listFind(list, value)>
</cffunction>


<cffunction
    name="isEqualTo"
    hint="Returns true if the value is the same as the value of the supplied key."
    returnType="boolean">
    <cfargument
        name="value"
        type="string"
        required="yes">
    <cfargument
        name="key"
        type="string"
        required="yes">
    <cfset var keyValue = getValue(key)> 
    <cfreturn
        isBlank(keyValue)
        or (value eq keyValue)>
</cffunction>


<cffunction
    name="minLength"
    hint="Returns true if the value is longer than the supplied length."
    returnType="boolean">
    <cfargument
        name="value"
        type="string"
        required="yes">
    <cfargument
        name="length"
        type="numeric"
        required="yes">
    <cfreturn
        isBlank(value)
        or len(trim(value)) gte length>
</cffunction>


<cffunction
    name="maxLength"
    hint="Returns true if the value is shorter than the supplied length."
    returnType="boolean">
    <cfargument
        name="value"
        type="string"
        required="yes">
    <cfargument
        name="length"
        type="numeric"
        required="yes">
    <cfreturn
        isBlank(value)
        or len(trim(value)) lte length>
</cffunction>
