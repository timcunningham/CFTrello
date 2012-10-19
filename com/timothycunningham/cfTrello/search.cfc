<cfcomponent extends="root">
	<!--- Put the Private Request Scope into the variables scope for this CFC --->
	<cfset structAppend(variables,getPRC(),"true")>
	
	<!--- 	All calls can be done using the callCheckList method by passing the proper URI filter 	
			and keypairs that go in the URL.  "Helper Methods" can be written below to simplify	
			commonly used calls																	
	--->
			
	<cffunction name="callSearch" >
		<cfargument name="verb" 		type="string" 	required="true" 	default="get">
		<cfargument name="uriFilter" 	type="string" 	required="true" 	default="">
		
		<cfset var	call	= "">
		<cfinvoke method="doApicall" returnvariable="call" argumentcollection="#arguments#"/>
		<cfreturn call>
	</cffunction>	

	<cffunction name="getSearch">
		<cfargument name="query" 				type="string" 	required="true"							hint="a string with a length from 1 to 16384">
		<cfargument name="idBoards"		 		type="string" 	required="true" default="mine"			hint="A comma-separated list of objectIds, 24-character hex strings">
		<cfargument name="idOrganizations"		type="string" 	required="true" default="all"			hint="all or a comma-separated list of:idMemberCreator,data,type,date">
		<cfargument name="idCards"				type="string"	required="false"						hint="A comma-separated list of objectIds, 24-character hex strings">
		<cfargument name="modelTypes"			type="string"	required="true"	default="all"			hint="all or a comma-separated list of:actions,cards,boards,organizations,members" >
		<cfargument name="board_fields"			type="string"	required="true" default="all"			hint="all or a comma-separated list of:name,desc,closed,idOrganization,invited,pinned,url,prefs,invitations,memberships,subscribed,labelNames">
		<cfargument name="boards_limit"			type="numeric" 	required="true"	default="10"			hint="a number from 1 to 1000">
		<cfargument name="card_fields"			type="string" 	required="true"	default="all"			hint="all or a comma-separated list of:badges,checkItemStates,closed,desc,due,idBoard,idChecklists,idList,idMembers,idShort,idAttachmentCover,manualCoverAttachment,labels,name,pos,subscribed,url">
		<cfargument name="cards_limit"			type="numeric" 	required="true"	default="10"			hint="a number from 1 to 1000">
		<cfargument name="card_board"		 	type="string" 	required="true"	default="false"			hint="true or false">
		<cfargument name="card_list"		 	type="string" 	required="true"	default="false"			hint="true or false">
		<cfargument name="card_members"	 		type="string" 	required="true"	default="false"			hint="true or false">
		<cfargument name="organization_fields"	type="string"	required="true"	default="all"			hint="all or a comma-separated list of:name,displayName,desc,idBoards,invited,invitations,memberships,prefs,powerUps,url,website,logoHash">
		<cfargument name="organization_limit"	type="numeric"	required="true"	default="10"			hint="a number from 1 to 1000">
		<cfargument name="member_fields"	 	type="string" 	required="true"	default="all"			hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">
		<cfargument name="members_limit"		type="numeric"	required="true"	default="10"			hint="a number from 1 to 1000">
		<cfargument name="action_fields"		type="string"	required="true"	default="all" 			hint="all or a comma-separated list of:idMemberCreator,data,type,date" >
		<cfargument name="actions_entities"	 	type="string" 	required="true"	default="false"			hint="true or false">
		<cfargument name="actions_limit"		type="numeric"	required="true"	default="10"			hint="a number from 1 to 1000">
		<cfargument name="actions_since"		type="any"		required="true" default="null"			hint="Valid Values: A date, null or lastView">
		<cfargument name="partial"				type="string"	required="true" default="false"			hint="true or false">
		
			
		<cfset arguments.uriFilter = "search">
		<cfset arguments.verbs 		= "POST">
		<cfinvoke method="callLists" returnvariable="local.return" argumentcollection="#arguments#"/>
		<cfreturn local.return>
	</cffunction>
</cfcomponent>