<cfcomponent extends="root">
	<!--- Put the Private Request Scope into the variables scope for this CFC --->
	<cfset structAppend(variables,getPRC(),"true")>
	<cfset restAction 			= "boards/">
	
	<!--- 	All calls can be done using the getBoards method by passing the proper URI filter 	
			and keypairs that go in the URL.  "Helper Methods" can be written below to simplify	
			commonly used calls																	
	--->
			
	<cffunction name="getBoards" >
		<cfargument name="verb" 		type="string" 	required="true" 	default="get">
		<cfargument name="uriFilter" 	type="string" 	required="true" 	default="">
		
		<cfset var	call	= "">
		<cfinvoke method="doApicall" returnvariable="call" argumentcollection="#arguments#"/>
		<cfreturn call>
	</cffunction>
	
	<!---	***************************************************************************************	--->
	<!---	***************************************************************************************	--->
	<!---	********************************  Helper Methods **************************************	--->
	<!---	***************************************************************************************	--->	
	<!---	***************************************************************************************	--->
	
	<cffunction name="getName" hint="returns the name of the Trello Board">
		<cfargument name="boardID" type="string" required="true" >
		<cfset var uriFilter = "boards/#arguments.boardID#/name">
		<cfreturn getBoards(uriFilter=uriFilter)>
	</cffunction>
	
	<cffunction name="getDesc" hint="returns the description of the Trello Board">
		<cfargument name="boardID" type="string" required="true" >
		<cfset var uriFilter = "boards/#arguments.boardID#/invited">
		<cfreturn getBoards(uriFilter=uriFilter)>
	</cffunction>
	
	<cffunction name="getClosed" hint="returns true if the board is closed">
		<cfargument name="boardID" type="string" required="true" >
		<cfset var uriFilter = "boards/#arguments.boardID#/closed">
		<cfreturn getBoards(uriFilter=uriFilter)>
	</cffunction>
	
	<cffunction name="getIDOrganization" hint="returns the organization ID of the Trello Board">
		<cfargument name="boardID" type="string" required="true" >
		<cfset var uriFilter = "boards/#arguments.boardID#/organization">
		<cfreturn getBoards(uriFilter=uriFilter)>
	</cffunction>
	
	<cffunction name="getInvited">
		<cfargument name="boardID" type="string" required="true" >
		<cfset var uriFilter = "boards/#arguments.boardID#/invited">
		<cfreturn getBoards(uriFilter=uriFilter)>
	</cffunction>
	
	<cffunction name="getPinned" hint="returns the pinned items of the Trello Board">
		<cfargument name="boardID" type="string" required="true" >
		<cfset var uriFilter = "boards/#arguments.boardID#/pinned">
		<cfreturn getBoards(uriFilter=uriFilter)>
	</cffunction>
	
	<cffunction name="getURL" hint="returns the full url of the Trello Board">
		<cfargument name="boardID" type="string" required="true" >
		<cfset var uriFilter = "boards/#arguments.boardID#/url">
		<cfreturn getBoards(uriFilter=uriFilter)>
	</cffunction>
	
	<cffunction name="getPrefs" hint="returns the preferences of the Trello Board">
		<cfargument name="boardID" type="string" required="true" >
		<cfset var uriFilter = "boards/#arguments.boardID#/prefs">
		<cfreturn getBoards(uriFilter=uriFilter)>
	</cffunction>
	
	<cffunction name="getInvitations" hint="returns the invitations of the Trello Board">
		<cfargument name="boardID" type="string" required="true" >
		<cfset var uriFilter = "boards/#arguments.boardID#/invitations">
		<cfreturn getBoards(uriFilter=uriFilter)>
	</cffunction>
	
	<cffunction name="getMemberships" hint="returns the members of the Trello Board and their membertypes">
		<cfargument name="boardID" type="string" required="true" >
		<cfset var uriFilter = "boards/#arguments.boardID#/memberships">
		<cfreturn getBoards(uriFilter=uriFilter)>
	</cffunction>

	<cffunction name="getSubscribed" hint="returns the list of those subscribed to the Trello Board">
		<cfargument name="boardID" type="string" required="true" >
		<cfset var uriFilter = "boards/#arguments.boardID#/subscribed">
		<cfreturn getBoards(uriFilter=uriFilter)>
	</cffunction>
	
	
	<cffunction name="getLabelNames">
		<cfargument name="boardID" type="string" required="true" >
		<cfset var uriFilter = "boards/#arguments.boardID#/labelNames">
		<cfreturn getBoards(uriFilter=uriFilter)>
	</cffunction>
	
	<cffunction name="getOpenLists">
		<cfargument name="boardID" type="string" required="true" >
		<cfset var uriFilter = "boards/#arguments.boardID#">
		<cfreturn getBoards(uriFilter=uriFilter, lists="open", list_fields="name", fields="name,desc")>
	</cffunction>
	
	<!---	***************************************************************************************	--->	
	<!---	******************************** 	 Actions	 **************************************	--->
	<!---	***************************************************************************************	--->
	<cffunction name="getActions" hint="Actions return a history of when actions have taken place on the board">
		<cfargument name="boardID" 	type="string" 	required="true" >
		<cfargument name="filter"	type="string"	required="true" default="all" 		hint="all or a comma-separated list of actions">
		<cfargument name="fields"	type="string"	required="true"	default="all" 		hint="all or a comma-separated list of:idMemberCreator,data,type,date" >
		<cfargument name="limit"	type="numeric" 	required="true" default="50" 		hint="Valid Values: a number from 1 to 1000">
		<cfargument name="format"	type="string"	required="true" default="list" 		hint="Valid Values: One of:count,list">
		<cfargument name="since"	type="any"		required="true" default="null"		hint="Valid Values: A date, null or lastView">
		<cfargument name="page"		type="numeric" 	required="true" default="0" 		hint="Valid Values: a number from 0 to 100">
		<cfargument name="idModels"	type="string"	required="false"			 		hint="Valid Values: Only return actions related to these model ids">
		<cfset var uriFilter = "boards/#arguments.boardID#/actions">
		<cfif ISDefined("arguments.idModels")>
			<cfreturn getBoards(uriFilter=uriFilter, filter=arguments.filter, fields=arguments.fields, limit=arguments.limit,format=arguments.format,since=arguments.since,page=arguments.page,idmodels=arguments.idmodels )>
		</cfif>
		<cfreturn getBoards(uriFilter=uriFilter, filter=arguments.filter, fields=arguments.fields, limit=arguments.limit,format=arguments.format,since=arguments.since,page=arguments.page)>
	</cffunction>
	
	<!---	***************************************************************************************	--->	
	<!---	******************************** 	 Cards		***************************************	--->
	<!---	***************************************************************************************	--->
	<cffunction name="getCards" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="actions"				type="string"	required="true" default="all"		hint="all or comma-seperated list of valid actions">
		<cfargument name="attachments"			type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="attachment_fields"	type="string"	required="true" default="all"		hint="all or a comma-separated list of:bytes,date,idMember,isUpload,mimeType,name,previews,url">
		<cfargument name="members"				type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="member_fields"		type="string"	required="true" default="all"		hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">
		<cfargument name="checkItemStates"		type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="checklists"			type="string"	required="true" default="none"		hint="none or all">
		<cfargument name="filter"				type="string"	required="true" default="visible"	hint="One of:none,visible,open,closed,all">
		<cfargument name="fields"				type="string"	required="true" default="all"		hint="all or a comma-separated list of:badges,checkItemStates,closed,desc,due,idBoard,idChecklists,idList,idMembers,idShort,idAttachmentCover,manualCoverAttachment,labels,name,pos,subscribed,url">
		
		<cfset var uriFilter = "boards/#arguments.boardID#/cards">
		<cfreturn getBoards(	uriFilter=uriFilter, actions=arguments.actions, attachments=arguments.attachments, attachment_fields=arguments.attachment_fields,
							 	members=arguments.members,member_fields=arguments.member_fields,checkItemStates=arguments.checkItemStates,checklists=arguments.checklists,
								filter=arguments.filter, fields=arguments.fields)> 
	</cffunction>
	
	<cffunction name="getCardbyID">
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="cardID"				type="string" 	required="true">
		<cfargument name="attachments"			type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="attachment_fields"	type="string"	required="true" default="all"		hint="all or a comma-separated list of:bytes,date,idMember,isUpload,mimeType,name,previews,url">
		<cfargument name="actions"				type="string"	required="true" default="all"		hint="all or comma-seperated list of valid actions">
		<cfargument name="actions_limit"		type="numeric" 	required="true" default="50"		hint="a number from 1 to 1000">
		<cfargument name="actions_fields"		type="string"	required="true" default="all"		hint="all or a comma-separated list of:idMemberCreator,data,type,date">
		<cfargument name="members"				type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="member_fields"		type="string"	required="true" default="all"		hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">
		<cfargument name="checkItemStates"		type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="checkItemState_fields"type="string"	required="true" default="all"		hint="all or a comma-separated list of:idCheckItem,state">
		<cfargument name="labels"				type="string"	required="true" default="true"		hint="true or false">
		<cfargument name="checklists"			type="string"	required="true" default="none"		hint="none or all">
		<cfargument name="checklist_fields"		type="string"	required="true" default="all"		hint="all or a comma-separated list of:name,idBoard">
		<cfargument name="fields"				type="string"	required="true" default="all"		hint="all or a comma-separated list of:badges,checkItemStates,closed,desc,due,idBoard,idChecklists,idList,idMembers,idShort,idAttachmentCover,manualCoverAttachment,labels,name,pos,subscribed,url">
		
		<cfset var uriFilter = "boards/#arguments.boardID#/cards/#arguments.cardID#">
		<cfreturn getBoards(	uriFilter=uriFilter, attachments=arguments.attachments, attachment_fields=arguments.attachment_fields,actions=arguments.actions,
							 	actions_limit=arguments.actions_limit,actions_fields=arguments.actions_fields,members=arguments.members,member_fields=arguments.member_fields,
								checkItemStates=arguments.checkItemStates,checkItemState_fields=arguments.checkItemState_fields,labels=arguments.labels,checklists=arguments.checklists,
								checklist_fields=arguments.checklist_fields,fields=arguments.fields)> 
	
		
	</cffunction>
	
	<!---	***************************************************************************************	--->	
	<!---	******************************** 	 CheckLists	***************************************	--->
	<!---	***************************************************************************************	--->
	<cffunction name="getChecklists" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="cards"				type="string"	required="true" default="none"		hint="One of:none,visible,open,closed,all">
		<cfargument name="card_fields"			type="string"	required="true" default="all"		hint="all or a comma-separated list of:badges,checkItemStates,closed,desc,due,idBoard,idChecklists,idList,idMembers,idShort,idAttachmentCover,manualCoverAttachment,labels,name,pos,subscribed,url">
		<cfargument name="checkItems"			type="string"	required="true" default="all"		hint="none or all">
		<cfargument name="checkItem_fields"		type="string"	required="true" default="all"		hint="all or a comma-separated list of:name,type,pos">
		<cfargument name="filter"				type="string"	required="true" default="all"		hint="One of:none,all">
		<cfargument name="fields"				type="string"	required="true" default="all"		hint="all or a comma-separated list of:name,idBoard">
		
		<cfset var uriFilter = "boards/#arguments.boardID#/checkLists">
		<cfreturn getBoards(	uriFilter=uriFilter,cards=arguments.cards,card_fields=arguments.card_fields,checkItems=arguments.checkItems,
								checkItem_fields=arguments.checkItem_fields,filter=arguments.filter,fields=arguments.fields)>
	</cffunction>
	
	<!---	***************************************************************************************	--->	
	<!---	******************************** 	 Lists		***************************************	--->
	<!---	***************************************************************************************	--->
	<cffunction name="getLists" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="cards"				type="string"	required="true" default="none"		hint="One of:none,visible,open,closed,all">
		<cfargument name="card_fields"			type="string"	required="true" default="all"		hint="all or a comma-separated list of:badges,checkItemStates,closed,desc,due,idBoard,idChecklists,idList,idMembers,idShort,idAttachmentCover,manualCoverAttachment,labels,name,pos,subscribed,url">
		<cfargument name="filter"				type="string"	required="true" default="open"		hint="One of:none,open,closed,all">
		<cfargument name="fields"				type="string"	required="true" default="all"		hint="all or a comma-separated list of:name,closed,idBoard,pos,subscribed">
		
		<cfset var uriFilter = "boards/#arguments.boardID#/lists">
		<cfreturn getBoards(	uriFilter=uriFilter,cards=arguments.cards,card_fields=arguments.card_fields,filter=arguments.filter,
								fields=arguments.fields)>
	</cffunction>
	
	<!---	***************************************************************************************	--->	
	<!---	******************************** 	 Members	***************************************	--->
	<!---	***************************************************************************************	--->
	<cffunction name="getMembers" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="filter"				type="string"	required="true" default="all"		hint=" One of:none,normal,admins,owners,all">
		<cfargument name="fields"				type="string"	required="true" default="all"		hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">
		<cfargument name="activity"				type="string"	required="true" default="false"		hint=" true or false; works for premium organizations only.">
			
		<cfset var uriFilter = "boards/#arguments.boardID#/members">
		<cfreturn getBoards(	uriFilter=uriFilter,filter=arguments.filter,fields=arguments.fields,activity=arguments.activity)>
	</cffunction>
	
	<!---	***************************************************************************************	--->	
	<!---	******************************** 	 Member Cards	***********************************	--->
	<!---	***************************************************************************************	--->
	<cffunction name="getMemberCards" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="idMember" 			type="string" 	required="true" 					hint="A board id, organization id, or organization name" >
		<cfargument name="actions"				type="string"	required="true" default="all"		hint=" all or a comma-separated list of valid actions">
		<cfargument name="attachments"			type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="attachment_fields"	type="string"	required="true" default="all"		hint="all or a comma-separated list of:bytes,date,idMember,isUpload,mimeType,name,previews,url">
		<cfargument name="members"				type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="member_fields"		type="string"	required="true" default="all"		hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">
		<cfargument name="checkItemStates"		type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="checklists"			type="string"	required="true" default="none"		hint="none or all">
		<cfargument name="board"				type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="board_fields"			type="string"	required="true" default="all"		hint="all or a comma-separated list of:name,desc,closed,idOrganization,invited,pinned,url,prefs,invitations,memberships,subscribed,labelNames">
		<cfargument name="lists"				type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="list_fields"			type="string"	required="true" default="all"		hint="all or a comma-separated list of:name,closed,idBoard,pos,subscribed">
		<cfargument name="filter"				type="string"	required="true" default="visible"	hint="One of:none,visible,open,closed,all">
		<cfargument name="fields"				type="string"	required="true" default="all"		hint="all or a comma-separated list of:badges,checkItemStates,closed,desc,due,idBoard,idChecklists,idList,idMembers,idShort,idAttachmentCover,manualCoverAttachment,labels,name,pos,subscribed,url">
		
			
		<cfset var uriFilter = "boards/#arguments.boardID#/members/#arguments.idMember#/cards">
		<cfreturn getBoards(	uriFilter=uriFilter,actions=arguments.actions,attachments=arguments.attachments,attachment_fields=arguments.attachment_fields,members=arguments.members,
								member_fields=arguments.member_fields,checkItemStates=arguments.checkItemStates,checklists=arguments.checklists,board=arguments.board,
								board_fields=arguments.board_fields,lists=arguments.lists,list_fields=arguments.list_fields,filter=arguments.filter,fields=arguments.fields)>
	</cffunction>
	
	<!---	***************************************************************************************	--->	
	<!---	******************************** 	 Members Invited  	*******************************	--->
	<!---	***************************************************************************************	--->
	<cffunction name="getMembersInvited" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="fields"				type="string"	required="true" default="all"		hint="all or a comma-separated list of valid fields">
			
		<cfset var uriFilter = "boards/#arguments.boardID#/membersInvited">
		<cfreturn getBoards(	uriFilter=uriFilter,fields=arguments.fields)>
	</cffunction>
	
	<!---	***************************************************************************************	--->	
	<!---	******************************** 	 Preferences  *************************************	--->
	<!---	***************************************************************************************	--->
	<cffunction name="getMyPrefs" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		
		<cfset var uriFilter = "boards/#arguments.boardID#/myPrefs">
		<cfreturn getBoards(	uriFilter=uriFilter)>
	</cffunction>
	
	<!---	***************************************************************************************	--->	
	<!---	******************************** 	 Organization  ************************************	--->
	<!---	***************************************************************************************	--->
	<cffunction name="getOrganization" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="fields"				type="string"	required="true"	default="all"		hint="all or a comma-separated list of:name,displayName,desc,idBoards,invited,invitations,memberships,prefs,powerUps,url,website,logoHash">
		
		<cfset var uriFilter = "boards/#arguments.boardID#/organization">
		<cfreturn getBoards(	uriFilter=uriFilter, fields=arguments.fields)>
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
	<cffunction name="setClosed" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"	default="false"		hint="true or false">
		
		<cfset var uriFilter = "boards/#arguments.boardID#/closed">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setDesc" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"	default=""		hint="A user ID or name">
		
		<cfset var uriFilter = "boards/#arguments.boardID#/desc">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setIDOrganization" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"	default=""		hint="A user ID or name">
		
		<cfset var uriFilter = "boards/#arguments.boardID#/idOrganization">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setMember" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="idMember"				type="string"	required="true"					hint="A board id, organization id, or organization name">
		<cfargument name="type"					type="string"	required="true"					hint="One of:normal,observer,admin">
		
		<cfset var uriFilter = "boards/#arguments.boardID#/members/#arguments.idMember#">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="put", type=arguments.value)>
	</cffunction>
	
	<cffunction name="setName" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"					hint="a string with a length from 1 to 16384. Requires own,write permission">
		
		<cfset var uriFilter = "boards/#arguments.boardID#/name">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<!---	***************************************************************************************	--->	
	<!---	******************************** 	SET Preferences  **********************************	--->
	<!---	***************************************************************************************	--->
	<cffunction name="setCardCovers" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"					hint="true or false. Requires own,write permission">
		
		<cfset var uriFilter = "boards/#arguments.boardID#/prefs/cardCovers">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setComments" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"					hint="One of:members,org,public,disabled. Requires own,write permission">
		
		<cfset var uriFilter = "boards/#arguments.boardID#/prefs/comments">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setInvitations" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"					hint="One of:members,admins. Requires own,write permission">
		
		<cfset var uriFilter = "boards/#arguments.boardID#/prefs/invitations">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setPermissionLevel" access="remote" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"					hint="One of:private,org,public. Requires own,write permission">
		
		<cfset var uriFilter = "boards/#arguments.boardID#/prefs/permissionLevel">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setSelfJoin" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"					hint="True or False. Requires own,write permission">
		
		<cfset var uriFilter = "boards/#arguments.boardID#/prefs/selfJoin">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setVoting" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"					hint="One of:members,org,public,disabled. Requires own,write permission">
		
		<cfset var uriFilter = "boards/#arguments.boardID#/prefs/voting">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setSubscribed" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"					hint="True or False. Requires read permission">
		
		<cfset var uriFilter = "boards/#arguments.boardID#/subscribed">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
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
	
	<cffunction name="setCheckLists" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="name"					type="string"	required="true"						hint=" a string with a length from 1 to 16384">
		
		<cfset var uriFilter = "boards/#arguments.boardID#/checklists">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="post", name=arguments.name)>
	</cffunction>
	
	<cffunction name="setInvitation" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="idMember"				type="string"	required="true"		default=""		hint="A user ID or name">
		<cfargument name="email"				type="string"	required="true"		default=""		hint="An email address">
		<cfargument name="type"					type="string"	required="true" 	default="normal"hint="One of:normal,observer,admin">
			
		<cfset var uriFilter = "boards/#arguments.boardID#/invitations">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="post", idMember=arguments.idMember,email=arguments.email,type=arguments.type)>
	</cffunction>
	
	<cffunction name="setInvitationResponse" >
		<cfargument name="boardID" 				type="string" 	required="true" >
		<cfargument name="response"				type="string"	required="true"		default="accept"hint="One of:accept,reject">
		<cfargument name="invitationTokens"		type="string"	required="true"		default=""		hint="A comma-separated list of unique identifier tokens">

		<cfset var uriFilter = "boards/#arguments.boardID#/invitations">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="post", response=arguments.response,invitationTokens=arguments.invitationTokens)>
	</cffunction>
	
	<cffunction name="setList" >
		<cfargument name="boardID" 			type="string" 	required="true" >
		<cfargument name="name"				type="string"	required="true"		default="List"  hint="a string with a length from 1 to 16384">
		<cfargument name="pos"				type="string"	required="true"		default="top"	hint="A position. top, bottom, or a positive number">
			
		<cfset var uriFilter = "boards/#arguments.boardID#/lists">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="post", name=arguments.name,pos=arguments.pos)>
	</cffunction>
	
	<cffunction name="setMarkAsViewed" >
		<cfargument name="boardID" 			type="string" 	required="true" >		
		<cfset var uriFilter = "boards/#arguments.boardID#/markAsViewed">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="post")>
	</cffunction>
	
	<cffunction name="setMyPrefs" >
		<cfargument name="boardID" 			type="string" 	required="true" >
		<cfargument name="name"				type="string"	required="true"						hint="One of:showSidebar,showSidebarMembers,showSidebarBoardActions,showSidebarActivity,showListGuide">
		<cfargument name="value"			type="string"	required="true"						hint="true or false">
			
		<cfset var uriFilter = "boards/#arguments.boardID#/myprefs">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="post", name=arguments.name,value=arguments.value)>
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
			
	<cffunction name="deleteInvitation" >
		<cfargument name="boardID" 			type="string" 	required="true" >
		<cfargument name="inviationID"		type="string"	required="true"						hint="The ID of an invitation">
			
		<cfset var uriFilter = "boards/#arguments.boardID#/invitations/#arguments.inviationID#">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="delete", inviationID=arguments.inviationID)>
	</cffunction>
	
	<cffunction name="deleteMember" >
		<cfargument name="boardID" 			type="string" 	required="true" >
		<cfargument name="idMember"			type="string"	required="true"						hint="A board id, organization id, or organization name">
			
		<cfset var uriFilter = "boards/#arguments.boardID#/members/#arguments.idMember#">
		<cfreturn getBoards(	uriFilter=uriFilter, verb="delete", idMember=arguments.idMember)>
	</cffunction>

	
</cfcomponent>