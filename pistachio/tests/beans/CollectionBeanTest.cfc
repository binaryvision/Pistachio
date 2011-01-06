<cfcomponent
    extends="mxunit.framework.TestCase">
    <cffunction
        name="setUp">
        <cfset collection = CreateObject("component", "pistachio.beans.CollectionBean")>
    </cffunction>


    <cffunction
        name="testInitAppendsCollectionsAndOverwrites">
        <cfset var structA = {a=true}>
        <cfset var structB = {a=false}>
        <cfset var expectation = {}>

        <cfset collection.init(structA, structB)>
        <cfset StructAppend(expectation, structA, true)>
        <cfset StructAppend(expectation, structB, true)>
        <cfset assertEquals(collection.getCollection(), expectation)>
    </cffunction>


    <cffunction
        name="testCanSetAndGetCollection">
        <cfset var structA = {a=true}>

        <cfset collection.setCollection(structA)>
        <cfset assertEquals(collection.getCollection(), structA)>
    </cffunction>


    <cffunction
        name="testCanAppendToCollection">
        <cfset collection.setCollection({a=true})>
        <cfset collection.appendCollection({b=true})>
        <cfset assertEquals(collection.getCollection(), {a=true, b=true})>
    </cffunction>


    <cffunction
        name="testCanClearCollection">
        <cfset collection.init({a=true})>
        <cfset collection.clearCollection()>
        <cfset assertEquals(collection.getCollection(), {})>
    </cffunction>


    <cffunction
        name="testCanSetAndGetValue">
        <cfset collection.setValue("a", true)>
        <cfset assertEquals(collection.getValue("a"), true)>
    </cffunction>


    <cffunction
        name="testGetNonExistantValueRaisesException"
        mxunit:expectedException="Expression">
        <cfset collection.getValue("does-not-exist")>
    </cffunction>


    <cffunction
        name="testCanSpecifyDefaultWhenGettingValue">
        <cfset assertEquals(collection.getValue("does-not-exist", true), true)>
    </cffunction>


    <cffunction
        name="testCanSetDefaultValueForKey">
        <cfset collection.setDefaultValue("a", true)>
        <cfset assertEquals(collection.getValue("a"), true)>
    </cffunction>


    <cffunction
        name="testSettingDefaultValueDoesNotOverwriteExistingValue">
        <cfset collection.setValue("a", true)>
        <cfset collection.setDefaultValue("a", false)>
        <cfset assertEquals(collection.getValue("a"), true)>
    </cffunction>


    <cffunction
        name="testValueExistsNonExistantValueReturnsFalse">
        <cfset assertFalse(collection.valueExists("a"))>
    </cffunction>


    <cffunction
        name="testValueExistsExistingValueReturnsTrue">
        <cfset collection.setValue("a", false)>
        <cfset assertTrue(collection.valueExists("a"))>
    </cffunction>


    <cffunction
        name="testCanRemoveValue"
        mxunit:expectedException="Expression">
        <cfset collection.setValue("a", true)>
        <cfset collection.removeValue("a")>
        <cfset collection.getValue("a")>
    </cffunction>


    <cffunction
        name="testRemoveNonExistantValueReturnsFalse">
        <cfset assertFalse(collection.removeValue("a"))>
    </cffunction>


    <cffunction
        name="testRemoveExistingValueReturnsTrue">
        <cfset collection.setValue("a", true)>
        <cfset assertTrue(collection.removeValue("a"))>
    </cffunction>
</cfcomponent>
