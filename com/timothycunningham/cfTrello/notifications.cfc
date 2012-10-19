<cfcomponent extends="root">
	<!--- Put the Private Request Scope into the variables scope for this CFC --->
	<cfset structAppend(variables,getPRC(),"true")>
	
	<!--- 	All calls can be done using the callCheckList method by passing the proper URI filter 	
			and keypairs that go in the URL.  "Helper Methods" can be written below to simplify	
			commonly used calls																	
	--->
			
	<cffunction name="callNotification" >
		<cfargument name="verb" 		type="string" 	required="true" 	default="get">
		<cfargument name="uriFilter" 	type="string" 	required="true" 	default="">
		
		<cfset var	call	= "">
		<cfinvoke method="doApicall" returnvariable="call" argumentcollection="#arguments#"/>
		<cfreturn call>
	</cffunction>	

	<cffunction name="getNotificationByID" >
		<cfargument name="fields"				type="string"	required="true" default="all"			hint="all or a comma-separated list of:unread,type,date,data,idMemberCreator">
		<cfargument name="memberCreator"		type="string"	required="true" default="true"			hint="true or false">
		<cfargument name="memberCreator_fields"	type="string"	required="true" default="true"			hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">
		<cfargument name="board" 				type="string" 	required="true"	default="false"			hint="true or false">	
		<cfargument name="board_fields"			type="string"	required="true" default="all"			hint="all or a comma-separated list of:name,desc,closed,idOrganization,invited,pinned,url,prefs,invitations,notificationships,subscribed,labelNames">
		<cfargument name="list" 				type="string" 	required="true"	default="false"			hint="true or false">
		<cfargument name="card" 				type="string" 	required="true"	default="false"			hint="true or false">
		<cfargument name="card_fields"			type="string" 	required="true"	default="all"			hint="all or a comma-separated list of:badges,checkItemStates,closed,desc,due,idBoard,idChecklists,idList,idNotifications,idShort,idAttachmentCover,manualCoverAttachment,labels,name,pos,subscribed,url">
		<cfargument name="organization" 		type="string" 	required="true"	default="false"			hint="true or false">
		<cfargument name="organization_fields"	type="string"	required="true"default="all"			hint="all or a comma-separated list of:name,displayName,desc,idBoards,invited,invitations,notificationships,prefs,powerUps,url,website,logoHash">
		<cfargument name="member" 				type="string" 	required="true"	default="false"			hint="true or false">
		<cfargument name="member_fields"		type="string"	required="true" default="true"			hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">
	
		<cfset var uriFilter = "notifications/#arguments.idNotification#">
		<cfreturn callnotification(	uriFilter=uriFilter,fields=arguments.fields,memberCreator=arguments.memberCreator,memberCreator_fields=arguments.memberCreator_fields,board=arguments.board,
									board_fields=arguments.board_fields,list=arguments.list,card=arguments.card,card_fields=arguments.card_fields,organization=arguments.organization,
									organization_fields=arguments.organization_fields,member=arguments.member,member_fields=arguments.member_fields)>
	</cffunction>

	
	<cffunction name="getField" >
		<cfargument name="idNotification" 			type="string" 	required="true" >
		<cfargument name="field"					type="string"	required="true" 					hint="one of: unread,type,date,data,idMemberCreator">

		<cfset var uriFilter = "notifications/#arguments.idNotification#/#arguments.field#">
		<cfreturn callnotification(	uriFilter=uriFilter,field=arguments.field)>
	</cffunction>
	
	<cffunction name="getBoard">
		<cfargument name="idNotification" 			type="string" 	required="true" >
		<cfargument name="fields"					type="string"	required="true" default="all"		hint="all or a comma-separated list of:name,desc,closed,idOrganization,invited,pinned,url,prefs,invitations,notificationships,subscribed,labelNames">

		<cfset var uriFilter = "notifications/#arguments.idNotification#/board">
		<cfreturn callnotification(	uriFilter=uriFilter,fields=arguments.fields)>
	</cffunction>
	
	<cffunction name="getBoardField">
		<cfargument name="idNotification" 			type="string" 	required="true" >
		<cfargument name="field"					type="string"	required="true" 					hint="one of:name,desc,closed,idOrganization,invited,pinned,url,prefs,invitations,notificationships,subscribed,labelNames">

		<cfset var uriFilter = "notifications/#arguments.idNotification#/board/#arguments.field#">
		<cfreturn callnotification(	uriFilter=uriFilter,field=arguments.field)>
	</cffunction>
	
	<cffunction name="getCards" >
		<cfargument name="idNotification" 			type="string" 	required="true" >
		<cfargument name="fields"					type="string"	required="true" default="all"		hint="all or a comma-separated list of:badges,checkItemStates,closed,desc,due,idBoard,idNotifications,idList,idNotifications,idShort,idAttachmentCover,manualCoverAttachment,labels,name,pos,subscribed,url">
		
		<cfset var uriFilter = "notifications/#arguments.idNotification#/card">
		<cfreturn callnotification(uriFilter=uriFilter,fields=arguments.fields)>
	</cffunction>
	
	<cffunction name="getCardsField">
		<cfargument name="idNotification" 			type="string" 	required="true" >
		<cfargument name="field" 					type="string" 	required="true" 					hint="one of:badges,checkItemStates,closed,desc,due,idBoard,idNotifications,idList,idNotifications,idShort,idAttachmentCover,manualCoverAttachment,labels,name,pos,subscribed,url">
		
		<cfset var uriFilter = "notifications/#arguments.idNotification#/cards/#arguments.field#">
		<cfreturn callnotification(	uriFilter=uriFilter,field=arguments.field)>
	</cffunction>
	
	<cffunction name="getLists" >
		<cfargument name="idNotification" 			type="string" 	required="true" >
		<cfargument name="fields"					type="string"	required="true" default="all"		hint="all or a comma-separated list of:name,closed,idBoard,pos,subscribed">
		<cfset var uriFilter = "notifications/#arguments.idNotification#/list">
		<cfreturn callnotification(uriFilter=uriFilter,fields=arguments.fields)>
	</cffunction>
	
	<cffunction name="getListsField">
		<cfargument name="idNotification" 			type="string" 	required="true" >
		<cfargument name="field" 					type="string" 	required="true" 					hint="one of:name,closed,idBoard,pos,subscribed">
		
		<cfset var uriFilter = "notifications/#arguments.idNotification#/list/#arguments.field#">
		<cfreturn callnotification(	uriFilter=uriFilter,field=arguments.field)>
	</cffunction>
	
	
	<cffunction name="getMembers" >
		<cfargument name="idNotification" 			type="string" 	required="true" >
		<cfargument name="fields"					type="string"	required="true" default="true"			hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">

		<cfset var uriFilter = "notifications/#arguments.idNotification#/member">
		<cfreturn callnotification(uriFilter=uriFilter,fields=arguments.fields)>
	</cffunction>
	
	<cffunction name="getMembersField">
		<cfargument name="idNotification" 			type="string" 	required="true" >
		<cfargument name="field"					type="string"	required="true" default="true"			hint="one of:avatarHash,bio,fullName,initials,status,url,username">
	
		<cfset var uriFilter = "notifications/#arguments.idNotification#/member/#arguments.field#">
		<cfreturn callnotification(	uriFilter=uriFilter,field=arguments.field)>
	</cffunction>
	
	<cffunction name="getMemberCreators" >
		<cfargument name="idNotification" 			type="string" 	required="true" >
		<cfargument name="fields"					type="string"	required="true" default="true"			hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">

		<cfset var uriFilter = "notifications/#arguments.idNotification#/memberCreator">
		<cfreturn callnotification(uriFilter=uriFilter,fields=arguments.fields)>
	</cffunction>
	
	<cffunction name="getMemberCreatorsField">
		<cfargument name="idNotification" 			type="string" 	required="true" >
		<cfargument name="field"					type="string"	required="true" default="true"			hint="one of:avatarHash,bio,fullName,initials,status,url,username">
	
		<cfset var uriFilter = "notifications/#arguments.idNotification#/memberCreator/#arguments.field#">
		<cfreturn callnotification(	uriFilter=uriFilter,field=arguments.field)>
	</cffunction>
	
	<cffunction name="getOrganization">
		<cfargument name="idNotification" 			type="string" 	required="true" >
		<cfargument name="fields" 					type="string" 	required="true" default="all"		hint="all or a comma-separated list of:name,displayName,desc,idBoards,invited,invitations,notificationships,prefs,powerUps,url,website,logoHash">
		
		<cfset var uriFilter = "notifications/#arguments.idNotification#/organization">
		<cfreturn callnotification(	uriFilter=uriFilter,fields=arguments.fields)>
	</cffunction>
	
	<cffunction name="getOrganizationField">
		<cfargument name="idNotification" 			type="string" 	required="true" >
		<cfargument name="field" 					type="string" 	required="true" 					hint="one of:name,displayName,desc,idBoards,invited,invitations,notificationships,prefs,powerUps,url,website,logoHash">
			
		<cfset var uriFilter = "notifications/#arguments.idNotification#/organization/#arguments.field#">
		<cfreturn callnotification(	uriFilter=uriFilter,field=arguments.field)>
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
	<cffunction name="setNotificationByID" >
		<cfargument name="idNotification" 			type="string" 	required="true" >
		<cfargument name="unread"					type="string"	required="false"					hint="true or false">
			
		<cfset arguments.uriFilter = "notifications/#arguments.idNotification#">
		<cfset arguments.verbs 		= "PUT">
		<cfinvoke method="callLists" returnvariable="local.return" argumentcollection="#arguments#"/>
		<cfreturn local.return>
	</cffunction>

	
	<cffunction name="setUnread">
		<cfargument name="idNotification" 			type="string" 	required="true" >
		<cfargument name="value"					type="string"	required="true"					hint="true or false">
		
		<cfset var uriFilter = "notifications/#arguments.idNotification#/unread">
		<cfreturn callnotification(	uriFilter=uriFilter, verb="PUT", value=arguments.value)>
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
	<cffunction name="setAllRead">
		<cfset var uriFilter = "notifications/all/read">
		<cfreturn callnotification(	uriFilter=uriFilter, verb="POST")>
		<cfreturn local.return>
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
</cfcomponent>