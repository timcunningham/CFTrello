<cfcomponent extends="root">
	<!--- Put the Private Request Scope into the variables scope for this CFC --->
	<cfset structAppend(variables,getPRC(),"true")>

	<!--- 	All calls can be done using the getLists method by passing the proper URI filter 	
			and keypairs that go in the URL.  "Helper Methods" can be written below to simplify	
			commonly used calls																	
	--->
			
	<cffunction name="callLists" >
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
	
	<cffunction name="getList">
		<cfargument name="idList" 		type="string" 	required="true" >
		<cfargument name="cards"		type="string"	required="true"	default="none"	hint="One of: name,closed,idBoard,pos,subscribed">
		<cfargument name="card_fields"	type="string" 	required="false"default="all"	hint="all or a comma-separated list of:badges,checkItemStates,closed,desc,due,idBoard,idChecklists,idList,idMembers,idShort,idAttachmentCover,manualCoverAttachment,labels,name,pos,subscribed,url">
		<cfargument name="fields"		type="string" 	required="false"default="all"	hint="all or a comma-separated list of:name,closed,idBoard,pos,subscribed">
		
		<cfset var uriFilter = "lists/#arguments.idList#">
		<cfreturn callLists(	uriFilter=uriFilter, cards=arguments.cards, card_fields=arguments.card_fields,fields=arguments.fields )>
	</cffunction>
	
	<cffunction name="getField">
		<cfargument name="idList" 		type="string" 	required="true" >
		<cfargument name="field" 		type="string" 	required="true" 				hint="name,closed,idBoard,pos,subscribed">
		
		<cfset var uriFilter = "lists/#arguments.idList#/#arguments.field#">
		<cfreturn callLists(	uriFilter=uriFilter,field=arguments.field )>
	</cffunction>
	
	
	<!---	***************************************************************************************	--->	
	<!---	******************************** 	 Actions	 **************************************	--->
	<!---	***************************************************************************************	--->
	<cffunction name="getActions" hint="Actions return a history of when actions have taken place on the board">
		<cfargument name="idList" 	type="string" 	required="true" >
		<cfargument name="filter"	type="string"	required="true" default="all" 		hint="all or a comma-separated list of actions">
		<cfargument name="fields"	type="string"	required="true"	default="all" 		hint="all or a comma-separated list of:idMemberCreator,data,type,date" >
		<cfargument name="limit"	type="numeric" 	required="true" default="50" 		hint="Valid Values: a number from 1 to 1000">
		<cfargument name="format"	type="string"	required="true" default="list" 		hint="Valid Values: One of:count,list">
		<cfargument name="since"	type="any"		required="true" default="null"		hint="Valid Values: A date, null or lastView">
		<cfargument name="page"		type="numeric" 	required="true" default="0" 		hint="Valid Values: a number from 0 to 100">
		<cfargument name="idModels"	type="string"	required="false"			 		hint="Valid Values: Only return actions related to these model ids">
		
		<cfset var uriFilter = "lists/#arguments.idList#/actions">
		<cfif ISDefined("arguments.idModels")>
			<cfreturn callLists(uriFilter=uriFilter, filter=arguments.filter, fields=arguments.fields, limit=arguments.limit,format=arguments.format,since=arguments.since,page=arguments.page,idmodels=arguments.idmodels )>
		</cfif>
		<cfreturn callLists(uriFilter=uriFilter, filter=arguments.filter, fields=arguments.fields, limit=arguments.limit,format=arguments.format,since=arguments.since,page=arguments.page)>
	</cffunction>
	<!---	***************************************************************************************	--->
	
	<cffunction name="getBoard" >
		<cfargument name="idList" 					type="string" 	required="true" >
		<cfargument name="fields"					type="string"	required="true"	default="all"		hint="all or a comma-separated list of:name,desc,closed,idOrganization,invited,pinned,url,prefs,invitations,memberships,subscribed,labelNames">
		
		<cfset var uriFilter = "lists/#arguments.idList#/board">
		<cfreturn callCheckList(	uriFilter=uriFilter,fields=arguments.fields)>
	</cffunction>
	
	<cffunction name="getBoardField" >
		<cfargument name="idList" 				type="string" 	required="true" >
		<cfargument name="field"					type="string"	required="true"	default="all"		hint="one of:name,desc,closed,idOrganization,invited,pinned,url,prefs,invitations,memberships,subscribed,labelNames">
		
		<cfset var uriFilter = "lists/#arguments.idList#/board/#arguments.field#">
		<cfreturn callCheckList(	uriFilter=uriFilter,field=arguments.field)>
	</cffunction>
	
	<cffunction name="getCards" >
		<cfargument name="idList" 					type="string" 	required="true" >
		<cfargument name="actions"					type="string"	required="false"					hint="one of: a long list of actions, see trello docs for GET /1/lists/[idChecklist]/cards">
		<cfargument name="attachments"				type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="attachment_fields"		type="string"	required="true" default="all"		hint="all or a comma-separated list of:bytes,date,idMember,isUpload,mimeType,name,previews,url">>
		<cfargument name="members"					type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="member_fields"			type="string"	required="true" default="all"		hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">
		<cfargument name="checkItemStates"			type="string"	required="true" default="false"		hint="true or false">
		<cfargument name="checklists"				type="string"	required="true" default="none"		hint="none or all">
		<cfargument name="filter"					type="string"	required="true" default="visible"	hint="One of:none,visible,open,closed,all">
		<cfargument name="fields"					type="string"	required="true" default="all"		hint="all or a comma-separated list of:badges,checkItemStates,closed,desc,due,idBoard,idChecklists,idList,idMembers,idShort,idAttachmentCover,manualCoverAttachment,labels,name,pos,subscribed,url">

		<cfset var uriFilter = "lists/#arguments.idList#/cards">
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
	
	
	<!---	***************************************************************************************	--->
	<!---	***************************************************************************************	--->
	<!---	********************************  PUT Methods 	**************************************	--->
	<!---	***************************************************************************************	--->
	<!---	***************************************************************************************	--->
	<!--- 	Most PUT Methods require that you have write access to requested board.  This is controlled	
			in login.cfc with the getTrelloLogin method.  The scope argument for that method is 		
			read,write,account which is the highest level of permission granted via the API.  If you	
			change the scope to read, these PUT methods will error.									--->
	<cffunction name="setListByID" >
		<cfargument name="idList" 				type="string" 	required="true" >
		<cfargument name="name"					type="string"	required="false"			hint=" a string with a length from 1 to 16384">
		<cfargument name="closed"				type="string"	required="false"			hint="true or false">
		<cfargument name="idboard"				type="string"	required="false"			hint="id of the board the list should be moved to">
		<cfargument name="pos"					type="string"	required="false"			hint="A position. top, bottom, or a positive number">
		<cfargument name="subscribed"			type="string"	required="false"			hint="true or false">
		
		<cfset arguments.uriFilter 	= "lists/#arguments.idList#">
		<cfset arguments.verbs 		= "put">
		<cfinvoke method="callLists" returnvariable="local.return" argumentcollection="#arguments#"/>
		<cfreturn local.return>
	</cffunction>
	
	<cffunction name="setClosed">
		<cfargument name="idList" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="false"			hint="true or false">
		
		<cfset arguments.uriFilter 	= "lists/#arguments.idList#/closed">
		<cfset arguments.verb 		= "put">
		<cfinvoke method="callLists" returnvariable="local.return" argumentcollection="#arguments#"/>
		<cfreturn local.return>
	</cffunction>
	<cffunction name="setIdBoard" >
		<cfargument name="idList" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"					hint="id of the board the list should be moved to">
		<cfargument name="pos"					type="string"	required="true" default="top"	hint="position of the list on the new board">
		
		<cfset var uriFilter = "lists/#arguments.idList#/idBoard">
		<cfreturn callLists(	uriFilter=uriFilter, verb="put", value=arguments.value, pos="#arguments.pos#")>
	</cffunction>
	
	<cffunction name="setName" >
		<cfargument name="idList" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"					hint="a string with a length from 1 to 16384. Requires own,write permission">
		
		<cfset var uriFilter = "lists/#arguments.idList#/name">
		<cfreturn callLists(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setPos" >
		<cfargument name="idList" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"					hint="A position. top, bottom, or a positive number.">
		
		<cfset var uriFilter = "lists/#arguments.idList#/pos">
		<cfreturn callLists(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setSubscribed" >
		<cfargument name="idList" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"					hint="true or false">
		
		<cfset var uriFilter = "lists/#arguments.idList#/subscribed">
		<cfreturn callLists(	uriFilter=uriFilter, verb="put", value=arguments.value)>
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
	
	<cffunction name="setList" >
		<cfargument name="name"					type="string"	required="true"						hint="a string with a length from 1 to 16384">
		<cfargument name="idBoard"				type="string"	required="true"						hint="id of the board that the checklist should be added to">
		<cfargument name="idListSource"			type="string"	required="false"					hint="The id of the list to copy into a new list.">
		<cfargument name="pos"					type="string"	required="true" default="top"		hint="position of the list on the new board">
		
		<cfset arguments.uriFilter = "lists">
		<cfset arguments.verbs 		= "POST">
		<cfinvoke method="callLists" returnvariable="local.return" argumentcollection="#arguments#"/>
		<cfreturn local.return>
	</cffunction>
	
	<cffunction name="setCard" >
		<cfargument name="idList" 				type="string" 	required="true" >
		<cfargument name="name"					type="string"	required="true"						hint="a string with a length from 1 to 16384">
		<cfargument name="desc"					type="string"	required="false"					hint="A user ID or name">
		
		<cfset arguments.uriFilter = "lists/#arguments.idList#/cards">
		<cfset arguments.verbs 		= "POST">
		<cfinvoke method="callLists" returnvariable="local.return" argumentcollection="#arguments#"/>
		<cfreturn local.return>
	</cffunction>
	
</cfcomponent>