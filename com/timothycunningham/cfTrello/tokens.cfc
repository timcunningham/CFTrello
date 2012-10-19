<cfcomponent extends="root">
	<!--- Put the Private Request Scope into the variables scope for this CFC --->
	<cfset structAppend(variables,getPRC(),"true")>
	
	<!--- 	All calls can be done using the callCheckList method by passing the proper URI filter 	
			and keypairs that go in the URL.  "Helper Methods" can be written below to simplify	
			commonly used calls																	
	--->
			
	<cffunction name="callToken" >
		<cfargument name="verb" 		type="string" 	required="true" 	default="get">
		<cfargument name="uriFilter" 	type="string" 	required="true" 	default="">
		
		<cfset var	call	= "">
		<cfinvoke method="doApicall" returnvariable="call" argumentcollection="#arguments#"/>
		<cfreturn call>
	</cffunction>	

	<cffunction name="getToken">
		<cfargument name="Token" 				type="string" 	required="true" >
		<cfargument name="fields" 				type="string" 	required="true"	default="all"			hint="all or a comma-separated list of:identifier,idMember,dateCreated,dateExpires,permissions" >
		
		<cfset var uriFilter = "Tokens/#arguments.Token#/">
		<cfreturn callToken(	uriFilter=uriFilter,fields=arguments.fields)>
	</cffunction>

	
	<cffunction name="getField" >
		<cfargument name="Token" 					type="string" 	required="true" >
		<cfargument name="field"					type="string"	required="true" 					hint="One of:identifier,idMember,dateCreated,dateExpires,permissions" >

		<cfset var uriFilter = "Tokens/#arguments.Token#/#arguments.field#">
		<cfreturn callToken(	uriFilter=uriFilter,field=arguments.field)>
	</cffunction>
	
	<cffunction name="getMember" >
		<cfargument name="Token" 			type="string" 	required="true" >
		<cfargument name="fields"			type="string"	required="true" 	default="all"			hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">
		

		<cfset var uriFilter = "Tokens/#arguments.Token#/member">
		<cfreturn callToken(uriFilter=uriFilter,fields=arguments.fields)>
	</cffunction>
	
	<cffunction name="getMemberField">
		<cfargument name="Token" 			type="string" 	required="true" >
		<cfargument name="field"			type="string"	required="true" default="true"			hint="one of:avatarHash,bio,fullName,initials,status,url,username">
	
		<cfset var uriFilter = "Tokens/#arguments.Token#/member/#arguments.field#">
		<cfreturn callToken(	uriFilter=uriFilter,field=arguments.field)>
	</cffunction>
	
	<!---	***************************************************************************************	--->
	<!---	***************************************************************************************	--->
	<!---	********************************  DELETE Methods 	***********************************	--->
	<!---	***************************************************************************************	--->	
	<!---	***************************************************************************************	--->
	<!--- 	Most DELETE methods require that you have write access to requested board.This is controlled
			in login.cfc with the getTrelloLogin method.  The scope argument for that method is 		
			read,write,account which is the highest level of permission granted via the API.  If you	
			change the scope to read, these DELETE methods will error.								--->		
	<cffunction name="deleteToken">
		<cfargument name="Token" 			type="string" 	required="true" >
		
		<cfset var uriFilter = "Tokens/#arguments.Token#">
		<cfreturn callCards(	uriFilter=uriFilter, verb="delete")>
	</cffunction>
	
	
	
	

	
