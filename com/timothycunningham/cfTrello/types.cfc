<cfcomponent extends="root">
	<!--- Put the Private Request Scope into the variables scope for this CFC --->
	<cfset structAppend(variables,getPRC(),"true")>
	
	<!--- 	All calls can be done using the callCheckList method by passing the proper URI filter 	
			and keypairs that go in the URL.  "Helper Methods" can be written below to simplify	
			commonly used calls																	
	--->
			
	<cffunction name="callType" >
		<cfargument name="verb" 		type="string" 	required="true" 	default="get">
		<cfargument name="uriFilter" 	type="string" 	required="true" 	default="">
		
		<cfset var	call	= "">
		<cfinvoke method="doApicall" returnvariable="call" argumentcollection="#arguments#"/>
		<cfreturn call>
	</cffunction>	

	<cffunction name="getType">
		<cfargument name="Type" 				type="string" 	required="true" >
		<cfargument name="id" 				type="string" 	required="true"	default="all"			hint="all or a comma-separated list of:identifier,idMember,dateCreated,dateExpires,permissions" >
		
		<cfset var uriFilter = "Types/#arguments.id#/">
		<cfreturn callType(	uriFilter=uriFilter)>
	</cffunction>
</cfcomponent>