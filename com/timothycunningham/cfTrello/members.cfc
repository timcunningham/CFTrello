<cfcomponent extends="root">
	<!--- Put the Private Request Scope into the variables scope for this CFC --->
	<cfset structAppend(variables,getPRC(),"true")>
	
	<!--- 	All calls can be done using the callCheckList method by passing the proper URI filter 	
			and keypairs that go in the URL.  "Helper Methods" can be written below to simplify	
			commonly used calls																	
	--->
			
	<cffunction name="callMember" >
		<cfargument name="verb" 		type="string" 	required="true" 	default="get">
		<cfargument name="uriFilter" 	type="string" 	required="true" 	default="">
		
		<cfset var	call	= "">
		<cfinvoke method="doApicall" returnvariable="call" argumentcollection="#arguments#"/>
		<cfreturn call>
	</cffunction>	

	<cffunction name="getMemberByID" hint="If you specify me as the username, this call will respond as if you had supplied the username associated with the supplied token">
		<cfargument name="actions" 				type="string" 	required="true"default="all"			hint="all or a comma-separated list of valid actions">
		<cfargument name="actions_limit" 		type="string" 	required="true" default="50"			hint="a number from 1 to 1000">
		<cfargument name="action_fields" 		type="string" 	required="true" default="all"			hint="all or a comma-separated list of:idMemberCreator,data,type,date">
		<cfargument name="cards" 				type="string" 	required="true"	default="none"			hint="One of:none,visible,open,closed,all">
		<cfargument name="card_fields"			type="string" 	required="true"	default="all"			hint="all or a comma-separated list of:badges,checkItemStates,closed,desc,due,idBoard,idChecklists,idList,idMembers,idShort,idAttachmentCover,manualCoverAttachment,labels,name,pos,subscribed,url">
		<cfargument name="card_members" 		type="string" 	required="true"	default="false"			hint="true or false">
		<cfargument name="card_member_fields" 	type="string" 	required="true"	default="all"			hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">
		<cfargument name="card_attachments" 	type="string" 	required="true"	default="false"			hint="true or false">
		<cfargument name="card_attachment_fields"type="string"	required="true" default="all"			hint="all or a comma-separated list of:bytes,date,idMember,isUpload,mimeType,name,previews,url">
		<cfargument name="boards"			 	type="string" 	required="false"default="none"			hint="One of:none,members,organization,public,open,closed,pinned,unpinned,all">
		<cfargument name="board_fields"			type="string"	required="true" default="all"			hint="all or a comma-separated list of:name,desc,closed,idOrganization,invited,pinned,url,prefs,invitations,memberships,subscribed,labelNames">
		<cfargument name="board_actions"		type="string" 	required="true"	default="all"			hint="all or a comma-separated list of valid actions">
		<cfargument name="board_actions_format"	type="string"	required="true" default="list" 			hint="Valid Values: One of:count,list">
		<cfargument name="board_actions_since"	type="any"		required="true" default="null"			hint="Valid Values: A date, null or lastView">
		<cfargument name="board_actions_limit"	type="numeric" 	required="true" default="50" 			hint="Valid Values: a number from 1 to 1000">
		<cfargument name="board_actions_fields"	type="string"	required="true"	default="all" 			hint="all or a comma-separated list of:idMemberCreator,data,type,date" >
		<cfargument name="board_lists"			type="string"	required="true" default="none"			hint="One of:none,visible,open,closed,all">
		<cfargument name="board_organization" 	type="string" 	required="true"	default="false"			hint="true or false">
		<cfargument name="board_organization_fields"type="string"required="true"default="all"			hint="all or a comma-separated list of:name,displayName,desc,idBoards,invited,invitations,memberships,prefs,powerUps,url,website,logoHash">
		<cfargument name="boardsInvited" 		type="string" 	required="true"	default="none"			hint="One of:none,members,organization,public,open,closed,pinned,unpinned,all">
		<cfargument name="boardsInvited_fields"	type="string"	required="true" default="all"			hint="all or a comma-separated list of:name,desc,closed,idOrganization,invited,pinned,url,prefs,invitations,memberships,subscribed,labelNames">
		<cfargument name="organizations" 		type="string" 	required="true"	default="none"			hint="one of: none,members,public,all">
		<cfargument name="organization_fields"	type="string"	required="true"	default="all"			hint="all or a comma-separated list of:name,displayName,desc,idBoards,invited,invitations,memberships,prefs,powerUps,url,website,logoHash">
		<cfargument name="organization_paid_account"type="string"required="true"default="false"			hint="true or false">
		<cfargument name="organizationsInvited"	type="string" 	required="true"	default="none"			hint="one of: none,members,public,all">
		<cfargument name="organizationsInvited_fields"
				   								type="string"	required="true"	default="all"			hint="all or a comma-separated list of:name,displayName,desc,idBoards,invited,invitations,memberships,prefs,powerUps,url,website,logoHash">
		<cfargument name="notifications"		type="string"	required="true" default="all"			hint=" all or a comma-separated list of:,addedAttachmentToCard,addedToBoard,addedToCard,addedMemberToCard,addAdminToBoard,addAdminToOrganization,changeCard,
																												closeBoard,commentCard,createdCard,invitedToBoard,invitedToOrganization,removedFromBoard,
																												removedFromCard,removedMemberFromCard,removedFromOrganization,mentionedOnCard,updateCheckItemStateOnCard,
																												makeAdminOfBoard,makeAdminOfOrganization,cardDueSoon" >
		<cfargument name="notifications_limit"	type="string"	required="true" default="50"			hint="a number from 1 to 1000">
		<cfargument name="notification_fields"	type="string"	required="true" default="all"			hint="all or a comma-separated list of:unread,type,date,data,idMemberCreator">
		<cfargument name="tokens"				type="string"	required="true" default="none"			hint="one of: none,all">
		<cfargument name="fields"				type="string"	required="true" default="all"			hint="one of: all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username,avatarSource,confirmed,email,gravatarHash,idBoards,idBoardsInvited,idBoardsPinned,idOrganizations,idOrganizationsInvited,idPremOrgsAdmin,loginTypes,prefs,status,trophies,uploadedAvatarHash">
	
		<cfset var uriFilter = "members/#arguments.idMember#">
		<cfreturn callMember(	uriFilter=uriFilter,actions=arguments.actions,actions_limit=arguments.actions_limit,action_fields=arguments.action_fields,cards=arguments.cards,
								card_fields=arguments.card_fields,card_members=arguments.card_members,card_member_fields=arguments.card_member_fields,
								card_attachments=arguments.card_attachments,card_attachment_fields=arguments.card_attachment_fields,boards=arguments.boards,
								board_fields=arguments.board_fields,board_actions=arguments.board_actions,board_actions_format=arguments.board_actions_format,
								board_actions_since=arguments.board_actions_since,board_actions_limit=arguments.board_actions_limit,board_actions_fields=arguments.board_actions_fields,
								board_lists=arguments.board_lists,board_organization=arguments.board_organization,board_organization_fields=arguments.board_organization_fields,
								boardsInvited=arguments.boardsInvited,boardsInvited_fields=arguments.boardsInvited_fields,organizations=arguments.organizations,
								organization_fields=arguments.organization_fields,organization_paid_account=arguments.organization_paid_account,
								organizationsInvited=arguments.organizationsInvited,organizationsInvited_fields=arguments.organizationsInvited_fields)>
	</cffunction>

	
	<cffunction name="getField" >
		<cfargument name="idMember" 				type="string" 	required="true" >
		<cfargument name="field"					type="string"	required="true" 					hint="one of: all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username,avatarSource,confirmed,email,gravatarHash,idBoards,idBoardsInvited,idBoardsPinned,idOrganizations,idOrganizationsInvited,idPremOrgsAdmin,loginTypes,prefs,status,trophies,uploadedAvatarHash">

		
		<cfset var uriFilter = "members/#arguments.idMember#/#arguments.field#">
		<cfreturn callMember(	uriFilter=uriFilter,field=arguments.field)>
	</cffunction>
	
	<cffunction name="getActions" hint="Actions return a history of when actions have taken place on the member">
		<cfargument name="idMember" 			type="string" 	required="true" >
		<cfargument name="filter"				type="string"	required="true" default="all" 		hint="all or a comma-separated list of actions">
		<cfargument name="fields"				type="string"	required="true"	default="all" 		hint="all or a comma-separated list of:idMemberCreator,data,type,date" >
		<cfargument name="limit"				type="numeric" 	required="true" default="50" 		hint="Valid Values: a number from 1 to 1000">
		<cfargument name="format"				type="string"	required="true" default="list" 		hint="Valid Values: One of:count,list">
		<cfargument name="since"				type="any"		required="true" default="null"		hint="Valid Values: A date, null or lastView">
		<cfargument name="page"					type="numeric" 	required="true" default="0" 		hint="Valid Values: a number from 0 to 100">
		<cfargument name="idModels"				type="string"	required="false"			 		hint="Valid Values: Only return actions related to these model ids">
		<cfset var uriFilter = "members/#arguments.idMember#/actions">
		<cfif ISDefined("arguments.idModels")>
			<cfreturn callMember(uriFilter=uriFilter, filter=arguments.filter, fields=arguments.fields, limit=arguments.limit,format=arguments.format,since=arguments.since,page=arguments.page,idmodels=arguments.idmodels )>
		</cfif>
		<cfreturn callMember(uriFilter=uriFilter, filter=arguments.filter, fields=arguments.fields, limit=arguments.limit,format=arguments.format,since=arguments.since,page=arguments.page)>
	</cffunction>
	
	
	<cffunction name="getBoard" >
		<cfargument name="idMember" 			type="string" 	required="true" >
		<cfargument name="filter"				type="string"	required="true" default="all" 			hint=" One of:none,members,organization,public,open,closed,pinned,unpinned,all">
		<cfargument name="fields"				type="string"	required="true"	default="all"			hint="all or a comma-separated list of:name,desc,closed,idOrganization,invited,pinned,url,prefs,invitations,memberships,subscribed,labelNames">
		<cfargument name="actions"				type="string" 	required="true"	default="all"			hint="all or a comma-separated list of valid actions">
		<cfargument name="actions_limit"		type="numeric" 	required="true" default="50" 			hint="Valid Values: a number from 1 to 1000">
		<cfargument name="actions_format"		type="string"	required="true" default="list" 			hint="Valid Values: One of:count,list">
		<cfargument name="actions_since"		type="any"		required="true" default="null"			hint="Valid Values: A date, null or lastView">
		<cfargument name="actions_fields"		type="string"	required="true"	default="all" 			hint="all or a comma-separated list of:idMemberCreator,data,type,date" >
		<cfargument name="organization" 		type="string" 	required="true"	default="false"			hint="true or false">
		<cfargument name="organization_fields"	type="string"	required="true"	default="all"			hint="all or a comma-separated list of:name,displayName,desc,idBoards,invited,invitations,memberships,prefs,powerUps,url,website,logoHash">
		<cfargument name="list"					type="string"	required="true" default="none" 			hint="One of:none,open,closed,all">
			
		<cfset var uriFilter = "members/#arguments.idMember#/board">
		<cfreturn callMember(	uriFilter=uriFilter,filter=arguments.filter,fields=arguments.fields,actions=arguments.actions,actions_limit=arguments.actions_limit,
								actions_format=arguments.actions_format,actions_since=arguments.actions_since,actions_fields=arguments.actions_fields,
								organization=arguments.organization,organization_fields=arguments.organization_fields,list=arguments.list)>
	</cffunction>
	
	<cffunction name="getBoardFilter" >
		<cfargument name="idMember" 				type="string" 	required="true" >
		<cfargument name="filter"					type="string"	required="true"	default="all"		hint="One of:none,members,organization,public,open,closed,pinned,unpinned,all">
		
		<cfset var uriFilter = "members/#arguments.idMember#/boards/#arguments.filter#">
		<cfreturn callMember(	uriFilter=uriFilter,filter=arguments.filter)>
	</cffunction>
	
	<cffunction name="getInvited" >
		<cfargument name="idMember" 				type="string" 	required="true" >
		<cfargument name="fields"					type="string"	required="true"	default="all"		hint="all or a comma-separated list of:name,desc,closed,idOrganization,invited,pinned,url,prefs,invitations,memberships,subscribed,labelNames">
		
		<cfset var uriFilter = "members/#arguments.idMember#/boards/boardsInvited">
		<cfreturn callMember(	uriFilter=uriFilter,fields=arguments.fields)>
	</cffunction>
	
	<cffunction name="getInvitedField" >
		<cfargument name="idMember" 				type="string" 	required="true" >
		<cfargument name="field"					type="string"	required="true"						hint="one of:name,desc,closed,idOrganization,invited,pinned,url,prefs,invitations,memberships,subscribed,labelNames">
		
		<cfset var uriFilter = "members/#arguments.idMember#/boards/boardsInvited/#arguments.field#">
		<cfreturn callMember(	uriFilter=uriFilter,field=arguments.field)>
	</cffunction>
	
	<cffunction name="getCards" >
		<cfargument name="idMember" 				type="string" 	required="true" >
		<cfargument name="actions"					type="string"	required="false"					hint="one of: a long list of actions, see trello docs for GET /1/members/[idChecklist]/cards">
		<cfargument name="attachments"				type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="attachment_fields"		type="string"	required="true" default="all"		hint="all or a comma-separated list of:bytes,date,idMember,isUpload,mimeType,name,previews,url">>
		<cfargument name="members"					type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="member_fields"			type="string"	required="true" default="all"		hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">
		<cfargument name="checkItemStates"			type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="checkLists"				type="string"	required="true" default="none"		hint="One of:none,all">
		<cfargument name="filter"					type="string"	required="true" default="visible"	hint="One of:none,visible,open,closed,all">
		<cfargument name="fields"					type="string"	required="true" default="all"		hint="all or a comma-separated list of:badges,checkItemStates,closed,desc,due,idBoard,idmembers,idList,idMembers,idShort,idAttachmentCover,manualCoverAttachment,labels,name,pos,subscribed,url">
		<cfargument name="page"						type="numeric" 	required="true" default="0" 		hint="Valid Values: a number from 0 to 100">
		<cfargument name="before"					type="string" 	required="true" default="null" 		hint="an id or null">
		<cfargument name="since"					type="string" 	required="true" default="null" 		hint="an id or null">
		
		<cfset var uriFilter = "members/#arguments.idMember#/notifications">
		<cfreturn callMember(uriFilter=uriFilter, actions=arguments.actions, attachments=arguments.attachments, attachment_fields=arguments.attachment_fields,
							 	members=arguments.members,member_fields=arguments.member_fields,checkItemStates=arguments.checkItemStates,checkLists=arguments.checkLists,
								filter=arguments.filter, fields=arguments.fields)>
	</cffunction>

	<cffunction name="getCardsFilter">
		<cfargument name="idMember" 				type="string" 	required="true" >
		<cfargument name="filter" 					type="string" 	required="true" 					hint="One of:none,open,closed,all">
		
		<cfset var uriFilter = "members/#arguments.idMember#/cards/#arguments.filter#">
		<cfreturn callMember(	uriFilter=uriFilter,filter=arguments.filter)>
	</cffunction>
	
	<cffunction name="getNotifications" hint="You can only read the notifications for the member associated with the supplied token.Required permissions: read, own">
		<cfargument name="idMember" 				type="string" 	required="true">
		<cfargument name="filter" 					type="string" 	required="true" default="all"		hint="all or a comma-separated list of:,addedAttachmentToCard,addedToBoard,addedToCard,
				   																						addedMemberToCard,addAdminToBoard,addAdminToOrganization,changeCard,closeBoard,commentCard,
				   																						createdCard,invitedToBoard,invitedToOrganization,removedFromBoard,removedFromCard,
				   																						removedMemberFromCard,removedFromOrganization,mentionedOnCard,updateCheckItemStateOnCard,
				   																						makeAdminOfBoard,makeAdminOfOrganization,cardDueSoon">
		<cfargument name="read_filter"				type="string"	required="true" default="all"		hint="One of:read,unread,all">
		<cfargument name="fields" 					type="string" 	required="true" default="all"		hint="all or a comma-separated list of:unread,type,date,data,idMemberCreator">
		<cfargument name="limit"					type="string"	required="true"	default="50"		hint="a number from 1 to 1000">
		<cfargument name="page"						type="numeric" 	required="true" default="0" 		hint="Valid Values: a number from 0 to 100">
		<cfargument name="before"					type="string" 	required="true" default="null" 		hint="an id or null">
		<cfargument name="since"					type="string" 	required="true" default="null" 		hint="an id or null">
		
		<cfset var uriFilter = "members/#arguments.idMember#/notifications">
		<cfreturn callMember(	uriFilter=uriFilter,filter=arguments.filter,read_filter=arguments.read_filter,fields=arguments.fields,limit=arguments.limit,page=arguments.page,
								before=arguments.before, since=arguments.since)>
	</cffunction>
	
	<cffunction name="getOrganization">
		<cfargument name="idMember" 				type="string" 	required="true" >
		<cfargument name="filter" 					type="string" 	required="true" default="all"		hint="One of:none,members,public,all">
		<cfargument name="fields" 					type="string" 	required="true" default="all"		hint="all or a comma-separated list of:name,displayName,desc,idBoards,invited,invitations,memberships,prefs,powerUps,url,website,logoHash">
		<cfargument name="paid_account"				type="string"	required="true" default="false"		hint="true or false" >
		
		<cfset var uriFilter = "members/#arguments.idMember#/organizations">
		<cfreturn callMember(	uriFilter=uriFilter,filter=arguments.filter,fields=arguments.fields,paid_account=arguments.paid_account)>
	</cffunction>
	
	<cffunction name="getOrganizationFilter">
		<cfargument name="idMember" 				type="string" 	required="true" >
		<cfargument name="filter" 					type="string" 	required="true" default="all"		hint="One of:none,members,public,all">
			
		<cfset var uriFilter = "members/#arguments.idMember#/organizations/#arguments.filter#">
		<cfreturn callMember(	uriFilter=uriFilter,filter=arguments.filter)>
	</cffunction>
	
	<cffunction name="getOrganizationsInvited">
		<cfargument name="idMember" 				type="string" 	required="true" >
		<cfargument name="fields" 					type="string" 	required="true" default="all"		hint="all or a comma-separated list of:name,displayName,desc,idBoards,invited,invitations,memberships,prefs,powerUps,url,website,logoHash">
			
		<cfset var uriFilter = "members/#arguments.idMember#/organizationsInvited">
		<cfreturn callMember(	uriFilter=uriFilter,fields=arguments.fields)>
	</cffunction>
	
	<cffunction name="getOrganizationsInvitedField">
		<cfargument name="idMember" 				type="string" 	required="true" >
		<cfargument name="field" 					type="string" 	required="true" default="all"		hint="One of:name,displayName,desc,idBoards,invited,invitations,memberships,prefs,powerUps,url,website,logoHash">
			
		<cfset var uriFilter = "members/#arguments.idMember#/organizationsInvited/#arguments.field#">
		<cfreturn callMember(	uriFilter=uriFilter,field=arguments.field)>
	</cffunction>
	
	<cffunction name="getToken">
		<cfargument name="filter" 					type="string" 	required="true" default="all"		hint="One of:none,all">
			
		<cfset var uriFilter = "members/#arguments.idMember#/token">
		<cfreturn callMember(	uriFilter=uriFilter,filter=arguments.filter)>
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
	<cffunction name="setMemberByID" >
		<cfargument name="idMember" 				type="string" 	required="true" >
		<cfargument name="fullname"					type="string"	required="false"					hint="A string with a length of at least 4. Cannot begin or end with a space.">
		<cfargument name="initials"					type="string"	required="false"					hint="A string with a length from 1 to 4. Cannot begin or end with a space">
		<cfargument name="bio"						type="string"	required="false"					hint="A user ID or name">
			
		<cfset arguments.uriFilter = "members/#arguments.idMember#">
		<cfset arguments.verbs 		= "PUT">
		<cfinvoke method="callLists" returnvariable="local.return" argumentcollection="#arguments#"/>
		<cfreturn local.return>
	</cffunction>
	
	<cffunction name="setBio">
		<cfargument name="idMember" 				type="string" 	required="true" >
		<cfargument name="value"					type="string"	required="true"					hint="A user ID or name">
		
		<cfset var uriFilter = "members/#arguments.idMember#/bio">
		<cfreturn callMember(	uriFilter=uriFilter, verb="PUT", value=arguments.value)>
		<cfreturn local.return>
	</cffunction>
	
	<cffunction name="setFullName">
		<cfargument name="idMember" 				type="string" 	required="true" >
		<cfargument name="value"					type="string"	required="true"					hint="A string with a length of at least 4. Cannot begin or end with a space.">
		
		<cfset var uriFilter = "members/#arguments.idMember#/fullName">
		<cfreturn callMember(	uriFilter=uriFilter, verb="PUT", value=arguments.value)>
		<cfreturn local.return>
	</cffunction>
	
	<cffunction name="setInitials">
		<cfargument name="idMember" 				type="string" 	required="true" >
		<cfargument name="value"					type="string"	required="true"					hint="A string with a length from 1 to 4. Cannot begin or end with a space">
		
		<cfset var uriFilter = "members/#arguments.idMember#/initials">
		<cfreturn callMember(	uriFilter=uriFilter, verb="PUT", value=arguments.value)>
		<cfreturn local.return>
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
	
	
	<!---	***************************************************************************************	--->
	<!---	***************************************************************************************	--->
	<!---	********************************  DELETE Methods 	***********************************	--->
	<!---	***************************************************************************************	--->	
	<!---	***************************************************************************************	--->
	<!--- 	Most DELETE methods require that you have write access to requested board.This is controlled
			in login.cfc with the getTrelloLogin method.  The scope argument for that method is 		
			read,write,account which is the highest level of permission granted via the API.  If you	
			change the scope to read, these DELETE methods will error.								--->	
</cfcomponent>