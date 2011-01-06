<cfcomponent
    extends="pistachio.beans.CollectionBean">
    <cfparam name="instance" default="#StructNew()#">
    <cfparam name="constants" default="#StructNew()#">
    <cfset instance.context = "">
    <cfset instance.isBound = false>
    <cfset instance.constraintsMap = {}>
    <cfset instance.constraints = []>
    <cfinclude template="defaultConstraints.cfm">


    <cffunction
        name="setCollection"
        returnType="void">
        <cfargument
            name="collection"
            type="struct"
            required="yes">
        <cfset flagForValidation()>
        <cfset super.setCollection(collection)>
        <cfset flagAsBound()>
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
        <cfset flagForValidation()>
        <cfset super.appendCollection(argumentCollection=arguments)>
        <cfset flagAsBound()>
    </cffunction>


    <cffunction
        name="flagAsBound"
        returnType="void">
        <cfif not isBound()>
            <cfset instance.isBound = true>
            <cfset onDataIsBound()>
        </cfif>
    </cffunction>
    <cffunction
        name="isBound"
        returnType="boolean">
        <cfreturn instance.isBound>
    </cffunction>


    <cffunction
        name="setContext"
        returnType="void">
        <cfargument
            name="context"
            type="string"
            required="yes">
        <cfset flagForValidation()>
        <cfset instance.context = context>
    </cffunction>
    <cffunction
        name="getContext"
        returnType="string">
        <cfreturn instance.context>
    </cffunction>


    <cffunction
        name="validate"
        returnType="void">
        <cfset clearErrors()>

        <cfif not isBound()>
            <cfreturn>
        </cfif>

        <cfset onValidationStart()>
        <cfset checkAllConstraints()>
        <cfset onValidationEnd()>
    </cffunction>


    <cffunction
        name="checkAllConstraints"
        access="private"
        returnType="void">
        <cfloop
            array="#instance.constraints#"
            index="local.valueMetaData">
            <cfset checkValueConstraints(valueMetaData)>
        </cfloop>
    </cffunction>


    <cffunction
        name="checkValueConstraints"
        access="private"
        returnType="void">
        <cfargument
            name="valueMetaData"
            type="struct"
            required="yes">
        <cfset flagAsValid()>
        <cfloop
            item="local.method"
            collection="#valueMetaData.constraints#">
            <cfif not checkConstraint(
                method,
                valueMetaData.constraints[method],
                getValue(valueMetaData.key))>
                <cfset addError(
                    key=valueMetaData.key,
                    msg=valueMetaData.constraints[method].msg)>
            </cfif>
        </cfloop>
    </cffunction>


    <cffunction
        name="checkConstraint"
        returnType="boolean">
        <cfargument
            name="constraint"
            type="string"
            required="yes">
        <cfargument
            name="metaData"
            type="struct"
            required="yes">
        <cfargument
            name="value"
            type="any"
            required="yes">
        <cfif shouldCheckConstraint(metaData, getContext())>
            <cfinvoke
                returnVariable="local.result"
                component="#this#"
                method="#constraint#"
                argumentCollection="#metaData.kwargs#"
                value="#value#">
            <cfreturn result>
        </cfif>
        <cfreturn true>
    </cffunction>


    <cffunction
        name="shouldCheckConstraint"
        returnType="boolean">
        <cfargument
            name="metaData"
            type="struct"
            required="yes">
        <cfargument
            name="context"
            type="string"
            default="">
        <cfreturn (
            (not StructKeyExists(metaData, "context"))
            or isBlank(metaData.context)
            or listsIntersect(context, metaData.context))>
    </cffunction>


    <cffunction
        name="flagForValidation"
        access="private"
        returnType="void">
        <cfset StructDelete(instance, "isValid")>
    </cffunction>
    <cffunction
        name="hasBeenValidated"
        access="private"
        returnType="boolean">
        <cfreturn IsDefined("instance.isValid")>
    </cffunction>


    <cffunction
        name="flagAsValid"
        access="private"
        returnType="void">
        <cfset instance.isValid = true>
    </cffunction>
    <cffunction
        name="flagAsInvalid"
        access="private"
        returnType="void">
        <cfset instance.isValid = false>
    </cffunction>


    <cffunction
        name="constraint"
        output="true"
        returnType="struct">
        <cfargument
            name="method"
            type="string"
            required="yes">
        <cfargument
            name="msg"
            type="string"
            required="yes">
        <cfargument
            name="kwargs"
            type="struct"
            default="#structNew()#">
        <cfargument
            name="context"
            type="string"
            default="">
        <cfreturn duplicate(arguments)>
    </cffunction>


    <cffunction
        name="setConstraints"
        returnType="void">
        <cfargument
            name="key"
            type="string"
            required="yes">
        <cfargument
            name="constraints"
            type="array"
            required="yes">
        <cfset clearConstraintsByKey(key)>
        <cfset addConstraints(key, constraints)>
    </cffunction>


    <cffunction
        name="addConstraints"
        returnType="void">
        <cfargument
            name="key"
            type="string"
            required="yes">
        <cfargument
            name="constraints"
            type="array"
            default="#arrayNew(1)#">
        <cfset flagForValidation()>

        <cfif not StructKeyExists(instance.constraintsMap, key)>
            <cfset instance.constraintsMap[key] = ArrayLen(instance.constraints) + 1>
            <cfset instance.constraints[instance.constraintsMap[key]] = {
                key = key,
                constraints = {}
            }>
        </cfif>

        <cfloop
            array="#constraints#"
            index="local.constraint">
            <cfset instance.constraints[instance.constraintsMap[key]].constraints[constraint.method] = {
                msg=constraint.msg
                , kwargs=constraint.kwargs
                , context=constraint.context
            }>
        </cfloop>
    </cffunction>


    <cffunction
        name="getConstraints"
        returnType="array">
        <cfreturn duplicate(instance.constraints)>
    </cffunction>
    <cffunction
        name="getConstraintsByKey"
        returnType="struct">
        <cfargument
            name="key"
            type="string"
            required="yes">
        <cfreturn StructKeyExists(instance.constraintsMap, key)
            ? instance.constraints[instance.constraintsMap[key]].constraints
            : []>
    </cffunction>


    <cffunction
        name="clearConstraints"
        returnType="void">
        <cfset flagForValidation()>
        <cfset instance.constraints = []>
        <cfset instance.constraintsMap = {}>
    </cffunction>
    <cffunction
        name="clearConstraintsByKey"
        returnType="void">
        <cfargument
            name="key"
            type="string"
            required="yes">
        <cfargument
            name="constraintsToDelete"
            type="string">
        <cfset flagForValidation()>

        <cfif StructKeyExists(instance.constraintsMap, key)>
            <cfif not isDefined("arguments.constraintsToDelete")>
                <!---Delete all constraints--->
                <cfset StructClear(instance.constraints[instance.constraintsMap[key]].constraints)>
            <cfelse>
                <!---Only delete specific constraints--->
                <cfloop
                    list="#constraintsToDelete#"
                    index="local.constraint"
                    delimiters=",">
                    <cfset StructDelete(
                        instance.constraints[instance.constraintsMap[key]].constraints,
                        constraint)>
                </cfloop>
            </cfif>
        </cfif>
    </cffunction>


    <cffunction
        name="listsIntersect"
        returnType="boolean">
        <cfargument
            name="listA"
            type="string"
            required="yes">
        <cfargument
            name="listB"
            type="string"
            required="yes">
        <cfargument
            name="delimiter"
            type="string"
            default=",">

        <cfloop list="#listA#" index="local.value">
            <cfif listContainsNoCase(listB, value)>
                <cfreturn true>
            </cfif>
        </cfloop>
        <cfreturn false>
    </cffunction>


    <cffunction
        name="clearErrors"
        returnType="void">
        <cfset instance.errors = []>
        <cfset instance.errorsMap = {}>
    </cffunction>


    <cffunction
        name="addError"
        returnType="void">
        <cfargument
            name="key"
            type="string"
            required="yes">
        <cfargument
            name="msg"
            type="string"
            required="yes">

        <cfif not StructKeyExists(instance.errorsMap, key)>
            <cfset instance.errorsMap[key] = ArrayLen(instance.errors) + 1>
            <cfset instance.errors[instance.errorsMap[key]] = {
                key = key,
                errors = []
            }>
        </cfif>

        <cfset flagAsInvalid()>

        <cfset ArrayAppend(
            instance.errors[instance.errorsMap[key]].errors,
            msg)>
    </cffunction>


    <cffunction
        name="hasErrors"
        returnType="boolean">
        <cfargument
            name="key"
            type="string">
        <cfreturn
            isBound()
            and not ArrayIsEmpty(
                IsDefined("arguments.key")
                    ? getErrorsByKey(key)
                    : getErrors())>
    </cffunction>
    <cffunction
        name="isValid"
        returnType="boolean">
        <cfargument
            name="key"
            type="string">
        <cfreturn not hasErrors(argumentsCollection=arguments)>
    </cffunction>


    <cffunction
        name="getErrorsByKey"
        returnType="array">
        <cfargument
            name="key"
            type="string"
            required="yes">
        <cfif not hasBeenValidated()>
            <cfset validate()>
        </cfif>
        <cfreturn StructKeyExists(instance.errorsMap, key)
            ? instance.errors[instance.errorsMap[key]].errors
            : []>
    </cffunction>


    <cffunction
        name="getErrors"
        returnType="array">
        <cfif not hasBeenValidated()>
            <cfset validate()>
        </cfif>
        <cfreturn instance.errors>
    </cffunction>


    <cffunction
        name="onDataIsBound"
        hint="Called after data is bound for the first time."
        returnType="void">
        <!--- Code to run after data has been bound for the first time --->
    </cffunction>


    <cffunction
        name="onValidationStart"
        hint="Called before constraints are validated."
        returnType="void">
        <!--- Code to run pre validation --->
    </cffunction>


    <cffunction
        name="onValidationEnd"
        hint="Called after constraints have been validated."
        returnType="void">
        <!--- Code to run post validation --->
    </cffunction>
</cfcomponent>
