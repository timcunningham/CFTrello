<cfcomponent extends="root">
	<!--- Put the Private Request Scope into the variables scope for this CFC --->
	<cfset structAppend(variables,getPRC(),"true")>
	
	<!--- 	All calls can be done using the callCheckList method by passing the proper URI filter 	
			and keypairs that go in the URL.  "Helper Methods" can be written below to simplify	
			commonly used calls																	
	--->
			
	<cffunction name="callOrganization" >
		<cfargument name="verb" 		type="string" 	required="true" 	default="get">
		<cfargument name="uriFilter" 	type="string" 	required="true" 	default="">
		
		<cfset var	call	= "">
		<cfinvoke method="doApicall" returnvariable="call" argumentcollection="#arguments#"/>
		<cfreturn call>
	</cffunction>	

	<cffunction name="getOrganizationByID" >
		<cfargument name="idOrg" 				type="string" 	required="true" >
		<cfargument name="actions"				type="string"	required="true"	default="all"			hint="all or a comma-seperated list of valid actions. See: Trello Docs" >
		<cfargument name="actions_limit"		type="numeric" 	required="true" default="50"			hint="a number from 1 to 1000">
		<cfargument name="actions_fields"		type="string"	required="true" default="all"			hint="all or a comma-separated list of:idMemberCreator,data,type,date">
		<cfargument name="members"				type="string"	required="true" default="none"			hint="One of:none,normal,admins,owners,all">
		<cfargument name="member_fields"		type="string"	required="true" default="all"			hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">
		<cfargument name="member_activity"		type="string"	required="true" default="false"			hint="true or false">
		<cfargument name="membersInvited"		type="string"	required="true" default="none"			hint="One of:none,normal,admins,owners,all">
		<cfargument name="membersInvited_fields"type="string"	required="true" default="all"			hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">
		<cfargument name="boards" 				type="string" 	required="true"	default="all"			hint="One of:none,members,organization,public,open,closed,pinned,unpinned,all">	
		<cfargument name="board_fields" 		type="string" 	required="true"	default="all"			hint="all or a comma-separated list of:name,desc,closed,idOrg,invited,pinned,url,prefs,invitations,memberships,subscribed,labelNames">	
		<cfargument name="board_actions"		type="string" 	required="true"	default="all"			hint="All or a valid list of actions">	
		<cfargument name="board_actions_format"	type="string" 	required="true"	default="list"			hint="One of count, list">	
		<cfargument name="board_actions_since"	type="any"		required="true" default="null"			hint="Valid Values: A date, null or lastView">	
		<cfargument name="board_actions_limit"	type="numeric" 	required="true" default="50" 			hint="Valid Values: a number from 1 to 1000">
		<cfargument name="board_action_fields"	type="string"	required="true" default="all"			hint="all or a comma-separated list of:unread,type,date,data,idMemberCreator">
		<cfargument name="board_action_lists"	type="string"	required="true" default="none"			hint="One of:none,open,closed,all">
		<cfargument name="paid_account"			type="string"	required="true" default="false"			hint="true or false">
		<cfargument name="fields"				type="string"	required="true"default="all"			hint="all or a comma-separated list of:name,displayName,desc,idBoards,invited,invitations,Organizationships,prefs,powerUps,url,website,logoHash">
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#">
		<cfreturn callOrganization(	uriFilter=uriFilter, actions=arguments.actions,actions_limit=arguments.actions_limit,actions_fields=arguments.actions_fields,
									members=arguments.members,member_fields=arguments.member_fields,member_activity=arguments.member_activity,membersInvited=arguments.membersInvited,
									membersInvited_fields=arguments.membersInvited_fields,boards=arguments.boards,board_fields=arguments.board_fields,
									board_actions=arguments.board_actions,board_actions_format=arguments.board_actions_format,board_actions_since=arguments.board_actions_since,
									board_actions_limit=arguments.board_actions_limit,board_action_fields=arguments.board_action_fields,board_action_lists=arguments.board_action_lists,
									paid_account=arguments.paid_account,fields=arguments.fields)>
	</cffunction>

	
	<cffunction name="getField" >
		<cfargument name="idOrg" 					type="string" 	required="true" >
		<cfargument name="field"					type="string"	required="true" 					hint="one of:name,displayName,desc,idBoards,invited,invitations,Organizationships,prefs,powerUps,url,website,logoHash">

		<cfset var uriFilter = "Organizations/#arguments.idOrg#/#arguments.field#">
		<cfreturn callOrganization(	uriFilter=uriFilter,field=arguments.field)>
	</cffunction>
	
	<cffunction name="getActions" hint="Actions return a history of when actions have taken place">
		<cfargument name="idOrg" 				type="string" 	required="true" >
		<cfargument name="filter"				type="string"	required="true" default="all" 			hint="all or a comma-separated list of actions">
		<cfargument name="fields"				type="string"	required="true"	default="all" 			hint="all or a comma-separated list of:idMemberCreator,data,type,date" >
		<cfargument name="limit"				type="numeric" 	required="true" default="50" 			hint="Valid Values: a number from 1 to 1000">
		<cfargument name="format"				type="string"	required="true" default="list" 			hint="Valid Values: One of:count,list">
		<cfargument name="since"				type="any"		required="true" default="null"			hint="Valid Values: A date, null or lastView">
		<cfargument name="page"					type="numeric" 	required="true" default="0" 			hint="Valid Values: a number from 0 to 100">
		<cfargument name="idModels"				type="string"	required="false"			 			hint="Valid Values: Only return actions related to these model ids">
		<cfset var uriFilter = "members/#arguments.idOrg#/actions">
		<cfif ISDefined("arguments.idOrg")>
			<cfreturn callMember(uriFilter=uriFilter, filter=arguments.filter, fields=arguments.fields, limit=arguments.limit,format=arguments.format,since=arguments.since,page=arguments.page,idmodels=arguments.idmodels )>
		</cfif>
		<cfreturn callMember(uriFilter=uriFilter, filter=arguments.filter, fields=arguments.fields, limit=arguments.limit,format=arguments.format,since=arguments.since,page=arguments.page)>
	</cffunction>
	
	<cffunction name="getBoards">
		<cfargument name="idOrg" 				type="string" 	required="true" >
		<cfargument name="filter"				type="string" 	required="true"	default="all"			hint="One of:none,members,organization,public,open,closed,pinned,unpinned,all">
		<cfargument name="fields"	 			type="string" 	required="true"	default="all"			hint="all or a comma-separated list of:name,desc,closed,idOrg,invited,pinned,url,prefs,invitations,memberships,subscribed,labelNames">	
		<cfargument name="actions"				type="string"	required="true"	default="all"			hint="all or a comma-seperated list of valid actions. See: Trello Docs" >
		<cfargument name="actions_limit"		type="numeric" 	required="true" default="50"			hint="a number from 1 to 1000">
		<cfargument name="actions_format"		type="string" 	required="true"	default="list"			hint="One of count, list">
		<cfargument name="actions_since"		type="any"		required="true" default="null"			hint="Valid Values: A date, null or lastView">	
		<cfargument name="action_fields"		type="string"	required="true" default="all"			hint="all or a comma-separated list of:idMemberCreator,data,type,date">
		<cfargument name="organization"			type="string"	required="true" default="false"			hint="true or false">
		<cfargument name="organization_fields"	type="string"	required="true"	default="all"			hint="all or a comma-separated list of:name,displayName,desc,idBoards,invited,invitations,memberships,prefs,powerUps,url,website,logoHash">
		<cfargument name="lists"				type="string"	required="true" default="none"			hint="One of:none,open,closed,all">
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/boards">
		<cfreturn callOrganization(	uriFilter=uriFilter,filter=arguments.filter,fields=arguments.fields,actions=arguments.actions,actions_limit=arguments.actions_limit,
									actions_format=arguments.actions_format,actions_since=arguments.actions_since,action_fields=arguments.action_fields,organization=arguments.organization,
									organization_fields=arguments.organization_fields,lists=arguments.lists)>
	</cffunction>
	
	<cffunction name="getBoardsField">
		<cfargument name="idOrg" 				type="string" 	required="true" >
		<cfargument name="filter"				type="string" 	required="true"	default="all"			hint="One of:none,members,organization,public,open,closed,pinned,unpinned,all">	

		<cfset var uriFilter = "Organizations/#arguments.idOrg#/board/#arguments.filter#">
		<cfreturn callOrganization(	uriFilter=uriFilter,filter=arguments.filter)>
	</cffunction>
	
	<cffunction name="getMembers" >
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="filter"			type="string"	required="true" 	default="all"			hint="One of: none,normal,admins,owners,all">
		<cfargument name="fields"			type="string"	required="true" 	default="true"			hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">
		<cfargument name="activity"			type="string"	required="false"	default="false"			hint="true or false; works for premium organizations only." >
		

		<cfset var uriFilter = "Organizations/#arguments.idOrg#/members">
		<cfreturn callOrganization(uriFilter=uriFilter,fields=arguments.fields)>
	</cffunction>
	
	<cffunction name="getMembersField">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="field"			type="string"	required="true" default="true"			hint="One of:none,normal,admins,owners,all">
	
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/members/#arguments.field#">
		<cfreturn callOrganization(	uriFilter=uriFilter,field=arguments.field)>
	</cffunction>
	
	<cffunction name="getMemberCards" >
		<cfargument name="idOrg" 				type="string" 	required="true" >
		<cfargument name="idMember"				type="string" 	required="true" >
		<cfargument name="actions"				type="string"	required="true" default="all"		hint="all or a comma-separated list of valid actions">
		<cfargument name="attachments"			type="string"	required="true"	default="false"		hint="true or false">
		<cfargument name="attachment_fields"	type="string"	required="true"	default="all"		hint="all or a comma-separated list of: bytes,date,idMember,isUpload,mimeType,name,previews,url" >
		<cfargument name="members"				type="string" 	required="true"	default="false"		hint="true or false">
		<cfargument name="member_fields"		type="string" 	required="true" default="all"		hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">
		<cfargument name="checkItemStates"		type="string"	required="true"	default="false"		hint="true or false">
		<cfargument name="checkLists"			type="string"	required="true"	default="none"		hint="One of none or all" >
		<cfargument name="board"				type="string"	required="true"	default="false"		hint="true or false">
		<cfargument name="board_fields"			type="string"	required="true"	default="all"		hint="all or a comma-separated list of:name,desc,closed,idOrganization,invited,pinned,url,prefs,invitations,memberships,subscribed,labelNames" >
		<cfargument name="list"					type="string" 	required="true"	default="false"		hint="true or false">
		<cfargument name="filter"				type="string"	required="true"	default="visible"	hint="One of:none,visible,open,closed,all" >
		<cfargument name="fields"				type="string"	required="true"	default="all"		hint="all or a comma-separated list of:badges,checkItemStates,closed,desc,due,idBoard,idChecklists,idList,idMembers,idShort,idAttachmentCover,manualCoverAttachment,labels,name,pos,subscribed,url">
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/members/#arguments.idMember#/cards">
		<cfreturn callOrganization(	uriFilter=uriFilter,actions=arguments.actions,attachments=arguments.attachments,attachment_fields=arguments.attachment_fields,members=arguments.members,
									member_fields=arguments.member_fields,checkItemStates=arguments.checkItemStates, checkLists=arguments.checkLists,board=arguments.board,
									board_fields=arguments.board_fields,list=arguments.list,filter=arguments.filter,fields=arguments.fields)>
	</cffunction>
	
	<cffunction name="getMembersInvited" >
		<cfargument name="idOrg" 				type="string" 	required="true" >
		<cfargument name="fields"				type="string"	required="true" default="all"		hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username,avatarSource,confirmed,email,gravatarHash,idBoards,idBoardsInvited,idBoardsPinned,idOrganizations,idOrganizationsInvited,idPremOrgsAdmin,loginTypes,prefs,status,trophies,uploadedAvatarHash">
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/membersInvited">
		<cfreturn callOrganization(uriFilter=uriFilter,fields=arguments.fields)>
	</cffunction>
	
	<cffunction name="getMembersInvitedField">
		<cfargument name="idOrg" 					type="string" 	required="true" >
		<cfargument name="field" 					type="string" 	required="true" 					hint="one of:avatarHash,bio,fullName,initials,status,url,username,avatarSource,confirmed,email,gravatarHash,idBoards,idBoardsInvited,idBoardsPinned,idOrganizations,idOrganizationsInvited,idPremOrgsAdmin,loginTypes,prefs,status,trophies,uploadedAvatarHash">
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/membersInvited/#arguments.field#">
		<cfreturn callOrganization(	uriFilter=uriFilter,field=arguments.field)>
	</cffunction>
	
	<!---	***************************************************************************************	--->
	<!---	***************************************************************************************	--->
	<!---	********************************  PUT Methods 	**************************************	--->
	<!---	***************************************************************************************	--->	
	<!---	***************************************************************************************	--->
	<!--- 	Most PUT Methods require that you have write access to requested board.  This is controlled	
			in login.cfc with the getTrelloLogin method.  The scope argument for that method is 		
			read,write,account which is the highest level of permission granted via the API.  If you	
			change the scope to read, these PUT methods will error.									--->
	<cffunction name="setOrganizationByID" >
		<cfargument name="idOrg"		 			type="string" 	required="true" >
		<cfargument name="name"						type="string"	required="false"					hint="A string with a length of at least 3. Only lowercase letters, underscores, and numbers are allowed. Must be unique.">
		<cfargument name="displayName"				type="string"	required="false"					hint="A string with a length of at least 1. Cannot begin or end with a space." >
		<cfargument name="website"					type="string"	required="false"					hint="A URL starting with http:// or https:// or null" >

		<cfset arguments.uriFilter = "Organizations/#arguments.idOrg#">
		<cfset arguments.verbs 		= "PUT">
		<cfinvoke method="callLists" returnvariable="local.return" argumentcollection="#arguments#"/>
	</cffunction>

	
	<cffunction name="setDesc">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="value"					type="string"	required="true"					hint="A user ID or name">
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/desc">
		<cfreturn callOrganization(	uriFilter=uriFilter, verb="PUT", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setDisplayName">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="value"			type="string"	required="true"					hint="A string with a length of at least 1. Cannot begin or end with a space.">
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/displayName">
		<cfreturn callOrganization(	uriFilter=uriFilter, verb="PUT", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setMember">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="idMember" 		type="string" 	required="true" >
		<cfargument name="type"				type="string"	required="true"					hint="One of:normal,observer,admin">
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/members/#arguments.idMember#">
		<cfreturn callOrganization(	uriFilter=uriFilter, verb="PUT", idMember=arguments.idMember,type=arguments.type)>
	</cffunction>
	
	<cffunction name="setMemberDeactivated">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="idMember" 		type="string" 	required="true"					hint="A board id, organization id, or organization name" >
		<cfargument name="value"			type="string"	required="true"					hint="true or false">
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/members/#arguments.idMember#/deactivated">
		<cfreturn callOrganization(	uriFilter=uriFilter, verb="PUT", idMember=arguments.idMember,value=arguments.value)>
	</cffunction>
	
	<cffunction name="setName">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="value"			type="string"	required="true"					hint="A string with a length of at least 3. Only lowercase letters, underscores, and numbers are allowed. Must be unique.">
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/name">
		<cfreturn callOrganization(	uriFilter=uriFilter, verb="PUT", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setBoardVisibiltyOrg">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="value"			type="string"	required="true"					hint="One of:none,admin,org">
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/prefs/boardVisibilityRestrict/org">
		<cfreturn callOrganization(	uriFilter=uriFilter, verb="PUT", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setBoardVisibiltyPrivate">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="value"			type="string"	required="true"					hint="One of:none,admin,org">
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/prefs/boardVisibilityRestrict/private">
		<cfreturn callOrganization(	uriFilter=uriFilter, verb="PUT", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setBoardVisibiltyPublic">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="value"			type="string"	required="true"					hint="One of:none,admin,org">
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/prefs/boardVisibilityRestrict/public">
		<cfreturn callOrganization(	uriFilter=uriFilter, verb="PUT", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setExternalMembersDisabled">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="value"			type="string"	required="true"					hint="true or false">
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/prefs/externalMembersDisabled">
		<cfreturn callOrganization(	uriFilter=uriFilter, verb="PUT", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setInviteRestrict">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="value"			type="string"	required="true"					hint="An email address with optional expansion tokens">
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/prefs/orgInviteRestrict">
		<cfreturn callOrganization(	uriFilter=uriFilter, verb="PUT", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setPermissionLevel">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="value"			type="string"	required="true"					hint="public or private">
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/prefs/permissionLevel">
		<cfreturn callOrganization(	uriFilter=uriFilter, verb="PUT", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setWebsite">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="value"			type="string"	required="true"					hint="A URL starting with http:// or https:// or null">
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/website">
		<cfreturn callOrganization(	uriFilter=uriFilter, verb="PUT", value=arguments.value)>
	</cffunction>
	
	<!---	***************************************************************************************	--->
	<!---	***************************************************************************************	--->
	<!---	********************************  POST Methods 	**************************************	--->
	<!---	***************************************************************************************	--->	
	<!---	***************************************************************************************	--->
	<!--- 	Most PUT methods require that you have write access to requested board.  This is controlled
			in login.cfc with the getTrelloLogin method.  The scope argument for that method is 
			read,write,account which is the highest level of permission granted via the API.  If you
			change the scope to read, these POST methods will error.									--->
	<cffunction name="setOrganization">
		<cfargument name="name"				type="string"	required="true"					hint=" A user ID or name">
		<cfargument name="displayName"		type="string"	required="true"					hint=" A string with a length of at least 1. Cannot begin or end with a space.">
		<cfargument name="desc"				type="string"	required="true"					hint=" A user ID or name">
		<cfargument name="website"			type="string"	required="true"					hint="  A URL starting with http:// or https:// or null">
		
		<cfset arguments.uriFilter = "Organizations">
		<cfset arguments.verbs 		= "POST">
		<cfinvoke method="callLists" returnvariable="local.return" argumentcollection="#arguments#"/>
		<cfreturn local.return>
	</cffunction>
	
	<cffunction name="setInvitation">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="idMember" 		type="string" 	required="false"				hint="A board id, organization id, or organization name" >
		<cfargument name="email"			type="string"	required="false"				hint="An email address">
		<cfargument name="type"				type="string"	required="false"				hint="One of:normal,observer,admin">
		
		<cfset arguments.uriFilter = "Organizations/#arguments.idOrg#/invitations">
		<cfset arguments.verbs 		= "POST">
		<cfinvoke method="callLists" returnvariable="local.return" argumentcollection="#arguments#"/>
		<cfreturn local.return>
	</cffunction>
	
	<cffunction name="setInvitationResponse">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="response"			type="string"	required="true"					hint="accept or reject" >
		<cfargument name="invitationTokens"	type="string"	required="true"					hint="A comma-separated list of unique identifier tokens" >
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/invitations/#arguments.response#">
		<cfreturn callOrganization(	uriFilter=uriFilter, verb="POST", response=arguments.response, invitationTokens=arguments.invitationTokens)>		
	</cffunction>
	
	<cffunction name="setLogo">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="file"				type="any"		required="true"					hint="a file" >
		
		<cfset var uriFilter = "Organizations/#arguments.idOrg#/logo">
		<cfreturn callOrganization(	uriFilter=uriFilter, verb="POST", file=arguments.file)>		
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
	<cffunction name="deleteOrganization">
		<cfargument name="idOrg" 			type="string" 	required="true" >
			
		<cfset var uriFilter = "organizations/#arguments.idOrg#">
		<cfreturn callCards(	uriFilter=uriFilter, verb="delete", idMember=arguments.idMember)>
	</cffunction>
	
	<cffunction name="deleteInvitation">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="idInvitation" 	type="string" 	required="true" >	
		
		<cfset var uriFilter = "organizations/#arguments.idOrg#/invitations/#arguments.idInvitation#">
		<cfreturn callCards(	uriFilter=uriFilter, verb="delete", idInvitation=arguments.idInvitation)>
	</cffunction>
	
	<cffunction name="deleteLogo">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		
		<cfset var uriFilter = "organizations/#arguments.idOrg#/logo">
		<cfreturn callCards(	uriFilter=uriFilter, verb="delete")>
	</cffunction>
	
	<cffunction name="deleteMember" >
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="idMember" 		type="string" 	required="true" 		hint="A board id, organization id, or organization name" >
		
		<cfset var uriFilter = "organizations/#arguments.idOrg#/members/#arguments.idMember#">
		<cfreturn callCards(	uriFilter=uriFilter, verb="delete")>		
	</cffunction>
	
	<cffunction name="deleteMemberAll" >
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="idMember" 		type="string" 	required="true"			hint="A board id, organization id, or organization name" >
		
		<cfset var uriFilter = "organizations/#arguments.idOrg#/members/#arguments.idMember#/all">
		<cfreturn callCards(	uriFilter=uriFilter, verb="delete")>		
	</cffunction>
	
	<cffunction name="deleteOrgInviteRestrict">
		<cfargument name="idOrg" 			type="string" 	required="true" >
		<cfargument name="value" 			type="string" 	required="true" 		hint=" An email address with optional expansion tokens">	
		
		<cfset var uriFilter = "organizations/#arguments.idOrg#/prefs/orgInviteRestrict">
		<cfreturn callCards(	uriFilter=uriFilter, verb="delete", idInvitation=arguments.idInvitation)>
	</cffunction>
	
	

</cfcomponent>