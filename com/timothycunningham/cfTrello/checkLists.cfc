<cfcomponent extends="root">
	<!--- Put the Private Request Scope into the variables scope for this CFC --->
	<cfset structAppend(variables,getPRC(),"true")>
	
	<!--- 	All calls can be done using the callCheckList method by passing the proper URI filter 	
			and keypairs that go in the URL.  "Helper Methods" can be written below to simplify	
			commonly used calls																	
	--->
			
	<cffunction name="callCheckList" >
		<cfargument name="verb" 		type="string" 	required="true" 	default="get">
		<cfargument name="uriFilter" 	type="string" 	required="true" 	default="">
		
		<cfset var	call	= "">
		<cfinvoke method="doApicall" returnvariable="call" argumentcollection="#arguments#"/>
		<cfreturn call>
	</cffunction>
	
	
	

	<cffunction name="getChecklists" >
		<cfargument name="cards" 				type="string" 	required="false"default="none"			hint=" One of:none,visible,open,closed,all">
		<cfargument name="card_fields"			type="string" 	required="false"default="all"			hint="all or a comma-separated list of:badges,checkItemStates,closed,desc,due,idBoard,idChecklists,idList,idMembers,idShort,idAttachmentCover,manualCoverAttachment,labels,name,pos,subscribed,url">
		<cfargument name="checkItems"			type="string"	required="true" default="all"			hint="none or all">
		<cfargument name="checkItem_fields"		type="string"	required="true" default="all"			hint="all or a comma-separated list of:name,type,pos">
		<cfargument name="fields"				type="string"	required="true" default="all"			hint="all or a comma-separated list of:name,idBoard">
		
		<cfset var uriFilter = "checkLists/#arguments.checkListID#">
		<cfreturn callCheckList(	uriFilter=uriFilter,cards=arguments.cards,card_fields=arguments.card_fields,checkItems=arguments.checkItems,
								checkItem_fields=arguments.checkItem_fields,fields=arguments.fields)>
	</cffunction>
	
	<cffunction name="getField" >
		<cfargument name="checkListID" 				type="string" 	required="true" >
		<cfargument name="field"					type="string"	required="true" 					hint="one of:name,idBoard">
		
		<cfset var uriFilter = "checkLists/#arguments.checkListID#/#arguments.field#">
		<cfreturn callCheckList(	uriFilter=uriFilter,field=arguments.field)>
	</cffunction>
	
	<cffunction name="getBoard" >
		<cfargument name="checkListID" 				type="string" 	required="true" >
		<cfargument name="fields"					type="string"	required="true"	default="all"		hint="all or a comma-separated list of:name,desc,closed,idOrganization,invited,pinned,url,prefs,invitations,memberships,subscribed,labelNames">
		
		<cfset var uriFilter = "checkLists/#arguments.checkListID#/board">
		<cfreturn callCheckList(	uriFilter=uriFilter,fields=arguments.fields)>
	</cffunction>
	
	<cffunction name="getBoardField" >
		<cfargument name="checkListID" 				type="string" 	required="true" >
		<cfargument name="field"					type="string"	required="true"	default="all"		hint="one of:name,desc,closed,idOrganization,invited,pinned,url,prefs,invitations,memberships,subscribed,labelNames">
		
		<cfset var uriFilter = "checkLists/#arguments.checkListID#/board/#arguments.field#">
		<cfreturn callCheckList(	uriFilter=uriFilter,field=arguments.field)>
	</cffunction>
	
	<cffunction name="getCards" >
		<cfargument name="checkListID" 				type="string" 	required="true" >
		<cfargument name="actions"					type="string"	required="false"					hint="one of: a long list of actions, see trello docs for GET /1/checklists/[idChecklist]/cards">
		<cfargument name="attachments"				type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="attachment_fields"		type="string"	required="true" default="all"		hint="all or a comma-separated list of:bytes,date,idMember,isUpload,mimeType,name,previews,url">>
		<cfargument name="members"					type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="member_fields"			type="string"	required="true" default="all"		hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">
		<cfargument name="checkItemStates"			type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="checklists"				type="string"	required="true" default="none"		hint="none or all">
		<cfargument name="filter"					type="string"	required="true" default="visible"	hint="One of:none,visible,open,closed,all">
		<cfargument name="fields"					type="string"	required="true" default="all"		hint="all or a comma-separated list of:badges,checkItemStates,closed,desc,due,idBoard,idChecklists,idList,idMembers,idShort,idAttachmentCover,manualCoverAttachment,labels,name,pos,subscribed,url">

		<cfset var uriFilter = "checkLists/#arguments.checkListID#/cards">
		<cfreturn callCheckList(uriFilter=uriFilter, actions=arguments.actions, attachments=arguments.attachments, attachment_fields=arguments.attachment_fields,
							 	members=arguments.members,member_fields=arguments.member_fields,checkItemStates=arguments.checkItemStates,checklists=arguments.checklists,
								filter=arguments.filter, fields=arguments.fields)>
	</cffunction>
	
	<cffunction name="getCardsFilter">
		<cfargument name="checkListID" 				type="string" 	required="true" >
		<cfargument name="filter" 					type="string" 	required="true" 					hint="One of:none,open,closed,all">
		
		<cfset var uriFilter = "checkLists/#arguments.checkListID#/cards/#arguments.filter#">
		<cfreturn callCheckList(	uriFilter=uriFilter,filter=arguments.filter)>
	</cffunction>
	
	<cffunction name="getCheckItems" >
		<cfargument name="checkListID" 				type="string" 	required="true">
		<cfargument name="filter" 					type="string" 	required="true" default="all"		hint="One of:none,all">
		<cfargument name="fields" 					type="string" 	required="true" default="all"		hint="all or a comma-separated list of:name,type,pos">
		
		<cfset var uriFilter = "checkLists/#arguments.checkListID#/checkItems">
		<cfreturn callCheckList(	uriFilter=uriFilter,filter=arguments.filter)>
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
	<cffunction name="setCheckListByID" >
		<cfargument name="checkListID" 				type="string" 	required="true" >
		<cfargument name="name"						type="string"	required="true"					hint="a string with a length from 1 to 16384">
		
		<cfset var uriFilter = "checkLists/#arguments.checkListID#">
		<cfreturn callCheckList(	uriFilter=uriFilter, verb="PUT", name=arguments.name)>
		<cfreturn local.return>
	</cffunction>
	
	<cffunction name="setName" >
		<cfargument name="checkListID" 				type="string" 	required="true" >
		<cfargument name="name"						type="string"	required="true"					hint="a string with a length from 1 to 16384">
		
		<cfset var uriFilter = "checkLists/#arguments.checkListID#/name">
		<cfreturn callCheckList(	uriFilter=uriFilter, verb="PUT", name=arguments.name)>
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
	
	<cffunction name="setCheckList" >
		<cfargument name="name"					type="string"	required="true"						hint=" a string with a length from 1 to 16384">
		<cfargument name="idBoard"				type="string"	required="true"						hint=" id of the board that the checklist should be added to">
		<cfargument name="idChecklistSource"	type="string"	required="false"					hint="The id of the source checklist to copy into a new checklist.">
			
		<cfset arguments.uriFilter = "checkLists">
		<cfset arguments.verbs 		= "POST">
		<cfinvoke method="callLists" returnvariable="local.return" argumentcollection="#arguments#"/>
		<cfreturn local.return>
	</cffunction>
	
	<cffunction name="setCheckItem">
		<cfargument name="name"					type="string"	required="true"						hint=" a string with a length from 1 to 16384">
		<cfargument name="pos"					type="string"	required="true"	default="bottom"	hint="A position. top, bottom, or a positive number.">
		
		<cfset var uriFilter = "checkLists/#arguments.checkListID#/checkItems">
		<cfreturn callCheckList(	uriFilter=uriFilter, verb="post", text=arguments.text)>
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
			
	<cffunction name="deleteCheckItem" >
		<cfargument name="checkListID" 			type="string" 	required="true" >
		<cfargument name="idCheckItem"			type="string"	required="true"						hint="the id of the check item to remove">
	
		<cfset var uriFilter = "checkLists/#arguments.checkListID#/checkItems/#arguments.idCheckItem#">
		<cfreturn callCheckList(	uriFilter=uriFilter, verb="delete",idCheckItem=#arguments.idCheckItem#)>
	</cffunction>
	

	
</cfcomponent>