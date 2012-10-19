<cfcomponent extends="root">
	<!--- Put the Private Request Scope into the variables scope for this CFC --->
	<cfset structAppend(variables,getPRC(),"true")>
	<cfset restAction 			= "cards/">
	
	<!--- 	All calls can be done using the getcards method by passing the proper URI filter 	
			and keypairs that go in the URL.  "Helper Methods" can be written below to simplify	
			commonly used calls																	
	--->
			
	<cffunction name="callCards" >
		<cfargument name="verb" 		type="string" 	required="true" 	default="get">
		<cfargument name="uriFilter" 	type="string" 	required="true" 	default="">
		
		<cfset var	call	= "">
		<cfinvoke method="doApicall" returnvariable="call" argumentcollection="#arguments#"/>
		<cfreturn call>
	</cffunction>
	
	<cffunction name="getCards" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="field"				type="string"	required="true" default="name"		hint="one of:badges,checkItemStates,closed,desc,due,idBoard,idChecklists,idList,idMembers,idShort,ididAttachmentCover,manualCoverAttachment,labels,name,pos,subscribed,url">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/#arguments.field#">
		<cfreturn callCards(	uriFilter=uriFilter, fields=arguments.field)> 
	</cffunction>
	
	
	<!---	***************************************************************************************	--->	
	<!---	******************************** 	 Actions	 **************************************	--->
	<!---	***************************************************************************************	--->
	<cffunction name="getActions" hint="Actions return a history of when actions have taken place on the card">
		<cfargument name="cardID" 	type="string" 	required="true" >
		<cfargument name="filter"	type="string"	required="true" default="all" 		hint="all or a comma-separated list of actions (see https://trello.com/docs/api/card/index.html )">
		<cfargument name="fields"	type="string"	required="true"	default="all" 		hint="all or a comma-separated list of:idMemberCreator,data,type,date" >
		<cfargument name="limit"	type="numeric" 	required="true" default="50" 		hint="Valid Values: a number from 1 to 1000">
		<cfargument name="format"	type="string"	required="true" default="list" 		hint="Valid Values: One of:count,list">
		<cfargument name="since"	type="any"		required="true" default="null"		hint="Valid Values: A date, null or lastView">
		<cfargument name="page"		type="numeric" 	required="true" default="0" 		hint="Valid Values: a number from 0 to 100">
		<cfargument name="idModels"	type="string"	required="false"			 		hint="Valid Values: Only return actions related to these model ids">
		<cfset var uriFilter = "cards/#arguments.cardID#/actions">
		<cfif ISDefined("arguments.idModels")>
			<cfreturn callCards(uriFilter=uriFilter, filter=arguments.filter, fields=arguments.fields, limit=arguments.limit,format=arguments.format,since=arguments.since,page=arguments.page,idmodels=arguments.idmodels )>
		</cfif>
		<cfreturn callCards(uriFilter=uriFilter, filter=arguments.filter, fields=arguments.fields, limit=arguments.limit,format=arguments.format,since=arguments.since,page=arguments.page)>
	</cffunction>
	
	<!---	***************************************************************************************	--->	
	<!---	******************************** 	 Attachments	***********************************	--->
	<!---	***************************************************************************************	--->	
	<cffunction name="getAttachments">
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="fields"				type="string"	required="true" default="all"		hint="all or a comma-separated list of:bytes,date,idMember,isUpload,mimeType,name,previews,url">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/attachments">
		<cfreturn callCards(	uriFilter=uriFilter,fields=arguments.fields)> 
	</cffunction>
	
	<!---	***************************************************************************************	--->	
	<!---	******************************** 	 Board	*******************************************	--->
	<!---	***************************************************************************************	--->	
	<cffunction name="getBoard">
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="fields"				type="string"	required="true" default="all"		hint="all or a comma-separated list of:name,desc,closed,idOrganization,invited,pinned,url,prefs,invitations,memberships,subscribed,labelNames">		
		
		<cfset var uriFilter = "cards/#arguments.cardID#/board">
		<cfreturn callCards(	uriFilter=uriFilter,fields=arguments.fields)> 
	</cffunction>
	
	<!---	***************************************************************************************	--->	
	<!---	******************************** 	 CheckLists	***************************************	--->
	<!---	***************************************************************************************	--->
	<cffunction name="getcheckItemStates">
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="fields"				type="string"	required="true" default="all"		hint="all or a comma-separated list of:idCheckItem,state">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/checkItemStates">
		<cfreturn callCards(	uriFilter=uriFilter,fields=arguments.fields)> 
	</cffunction>
	
	<cffunction name="getChecklists" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="cards"				type="string"	required="true" default="none"		hint="One of:none,visible,open,closed,all">
		<cfargument name="card_fields"			type="string"	required="true" default="all"		hint="all or a comma-separated list of:badges,checkItemStates,closed,desc,due,idBoard,idChecklists,idList,idMembers,idShort,idAttachmentCover,manualCoverAttachment,labels,name,pos,subscribed,url">
		<cfargument name="checkItems"			type="string"	required="true" default="all"		hint="none or all">
		<cfargument name="checkItem_fields"		type="string"	required="true" default="all"		hint="all or a comma-separated list of:name,type,pos">
		<cfargument name="filter"				type="string"	required="true" default="all"		hint="One of:none,all">
		<cfargument name="fields"				type="string"	required="true" default="all"		hint="all or a comma-separated list of:name,idBoard">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/checkLists">
		<cfreturn callCards(	uriFilter=uriFilter,cards=arguments.cards,card_fields=arguments.card_fields,checkItems=arguments.checkItems,
								checkItem_fields=arguments.checkItem_fields,filter=arguments.filter,fields=arguments.fields)>
	</cffunction>
	
	<!---	***************************************************************************************	--->	
	<!---	******************************** 	 Lists		***************************************	--->
	<!---	***************************************************************************************	--->
	<cffunction name="getLists" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="fields"				type="string"	required="true" default="all"		hint="all or a comma-separated list of:name,closed,idBoard,pos,subscribed">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/lists">
		<cfreturn callCards(	uriFilter=uriFilter,fields=arguments.fields)>
	</cffunction>
	
	<!---	***************************************************************************************	--->	
	<!---	******************************** 	 Members	***************************************	--->
	<!---	***************************************************************************************	--->
	<cffunction name="getMembers" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="fields"				type="string"	required="true" default="all"		hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">
			
		<cfset var uriFilter = "cards/#arguments.cardID#/members">
		<cfreturn callCards(	uriFilter=uriFilter,fields=arguments.fields)>
	</cffunction>
	
	<cffunction name="getMembersVoted" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="fields"				type="string"	required="true" default="all"		hint="all or a comma-separated list of:avatarHash,bio,fullName,initials,status,url,username">
			
		<cfset var uriFilter = "cards/#arguments.cardID#/membersVoted">
		<cfreturn callCards(	uriFilter=uriFilter,fields=arguments.fields)>
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
	<cffunction name="setCardByID" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="name"					type="string"	required="false"					hint="a string with a length from 1 to 16384">
		<cfargument name="desc"					type="string"	required="false"					hint="A user ID or name">
		<cfargument name="closed"				type="string"	required="false"					hint="true or false">
		<cfargument name="idAttachmentCover"	type="string"	required="false"					hint="Id of the image attachment of this card to use as its cover, or null for no cover">
		<cfargument name="idList"				type="string"	required="false"					hint="id of the list the card should be moved to">
		<cfargument name="idBoard"				type="string"	required="false"					hint="id of the board the card should be moved to">
		<cfargument name="pos"					type="string"	required="false"					hint="A position. top, bottom, or a positive number.">
		<cfargument name="due"					type="string"	required="false"					hint="A date, or null">
		<cfargument name="warnWhenUpcoming"		type="string"	required="false"					hint="true or false">
		<cfargument name="subscribed"			type="string"	required="false"					hint="true or false">
		<cfargument name="suppressActions"		type="string"	required="false"					hint="true or false">
		
		<cfset arguments.uriFilter = "cards/#arguments.cardID#">
		<cfset arguments.verbs 		= "put">
		<cfinvoke method="callLists" returnvariable="local.return" argumentcollection="#arguments#"/>
		<cfreturn local.return>
	</cffunction>
	
	<cffunction name="setCommentByID" hint="This can only be done by the original author of the comment">
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="idAction"				type="string" 	required="true" 					hint="the id of the action">
		<cfargument name="text"					type="string" 	required="true" 					hint="a string with a length from 1 to 16384">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/actions/#arguments.idAction#/comments">
		<cfreturn callCards(	uriFilter=uriFilter,verb="put",text=arguments.text)>
	</cffunction>
	
	<cffunction name="setCheckItemName">
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="idCheckList"			type="string" 	required="true" 					hint="the id of the checklist">
		<cfargument name="idCheckItem"			type="string" 	required="true" 					hint="The id of the checkitem to modify.">
		<cfargument name="value"				type="string" 	required="true" 					hint="a string with a length from 1 to 16384">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/checklist/#arguments.idCheckList#/checkItem/#arguments.idCheckItem#/name">
		<cfreturn callCards(	uriFilter=uriFilter,verb="put",value=arguments.value)>
	</cffunction>
	
	<cffunction name="setCheckItemPos">
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="idCheckList"			type="string" 	required="true" 					hint="the id of the checklist">
		<cfargument name="idCheckItem"			type="string" 	required="true" 					hint="The id of the checkitem to modify.">
		<cfargument name="value"				type="string" 	required="true" 					hint="A position. top, bottom, or a positive number">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/checklist/#arguments.idCheckList#/checkItem/#arguments.idCheckItem#/pos">
		<cfreturn callCards(	uriFilter=uriFilter,verb="put",value=arguments.value)>
	</cffunction>
	
	<cffunction name="setCheckItemState">
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="idCheckList"			type="string" 	required="true" 					hint="the id of the checklist">
		<cfargument name="idCheckItem"			type="string" 	required="true" 					hint="The id of the checkitem to modify.">
		<cfargument name="value"				type="string" 	required="true" 					hint="true or false">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/checklist/#arguments.idCheckList#/checkItem/#arguments.idCheckItem#/state">
		<cfreturn callCards(	uriFilter=uriFilter,verb="put",value=arguments.value)>
	</cffunction>

	<cffunction name="setClosed" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"						hint="true or false">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/closed">
		<cfreturn callCards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setDesc" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"						hint="A user ID or name">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/desc">
		<cfreturn callCards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setDue" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"						hint="A date, or null">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/due">
		<cfreturn callCards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setIDAttachmentCover" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"						hint="Id of the image attachment of this card to use as its cover, or null for no cover">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/idAttachmentCover">
		<cfreturn callCards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setBoardID" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"						hint="Id of the image attachment of this card to use as its cover, or null for no cover">
		<cfargument name="idList"				type="string"	required="true"						hint=" id of the list that the card should be moved to on the new board">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/idAttachmentCover">
		<cfreturn callCards(	uriFilter=uriFilter, verb="put", value=arguments.value, idList=arguments.idList)>
	</cffunction>
	
	<cffunction name="setidList" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"						hint="Id of the image attachment of this card to use as its cover, or null for no cover">
		<cfargument name="idList"				type="string"	required="true"						hint=" id of the list that the card should be moved to on the new board">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/idList">
		<cfreturn callCards(	uriFilter=uriFilter, verb="put", value=arguments.value, idList=arguments.idList)>
	</cffunction>
	
	<cffunction name="setName" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"					hint="a string with a length from 1 to 16384. Requires own,write permission">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/name">
		<cfreturn callCards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setPos" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"					hint="A position. top, bottom, or a positive number.">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/name">
		<cfreturn callCards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setSubscribed" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"					hint="true or false">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/subscribed">
		<cfreturn callCards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setWarnWhenUpcoming" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="true"					hint="true or false">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/warnWhenUpcoming">
		<cfreturn callCards(	uriFilter=uriFilter, verb="put", value=arguments.value)>
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
	
	<cffunction name="setCard" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="name"					type="string"	required="true"						hint=" a string with a length from 1 to 16384">
		<cfargument name="idList"				type="string"	required="true"						hint="id of the list that the card should be added to">
		<cfargument name="desc"					type="string"	required="false"					hint="A user ID or name">
		<cfargument name="pos"					type="string"	required="false"	default="bottom"hint="A position. top, bottom, or a positive number.">
		<cfargument name="cardSourceID"			type="string"	required="false" 					hint="The id of the card to copy into a new card.">
		<cfargument name="keepFromSource "		type="string"	required="false" 					hint="all or Properties of the card to copy over from the source.">
			
		<cfset arguments.uriFilter = "cards">
		<cfset arguments.verbs 		= "POST">
		<cfinvoke method="callLists" returnvariable="local.return" argumentcollection="#arguments#"/>
		<cfreturn local.return>
	</cffunction>
	
	<cffunction name="setComment" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="text"					type="string"	required="true"					hint="a string with a length from 1 to 16384">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/actions/comments">
		<cfreturn callCards(	uriFilter=uriFilter, verb="post", text=arguments.text)>
	</cffunction>
	
	<cffunction name="setAttachment" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="file"					type="string"	required="false"					hint="A file">
		<cfargument name="url"					type="string"	required="false"					hint="URL starting with http:// or https:// or null">
		<cfargument name="name"					type="string"	required="false"					hint="string with a length from 0 to 256">
		<cfargument name="mimeType"				type="string"	required="false"					hint="string with a length from 0 to 256">
		
		<cfset arguments.uriFilter = "cards/#arguments.cardID#/attachments">
		<cfset arguments.verbs 		= "POST">
		<cfinvoke method="callLists" returnvariable="local.return" argumentcollection="#arguments#"/>
		<cfreturn local.return>
	</cffunction>
	
	<cffunction name="setChecklist" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="value"				type="string"	required="false"					hint="The id of the checklist to add to the card, or null to create a new one.">
		<cfargument name="name"					type="string"	required="false"					hint=" A user ID or name">
		<cfargument name="checklistSourceID"	type="string"	required="false"					hint="The id of the source checklist to copy into a new checklist.">
		
		<cfset arguments.uriFilter = "cards/#arguments.cardID#/checklists">
		<cfset arguments.verbs 		= "POST">
		<cfinvoke method="callLists" returnvariable="local.return" argumentcollection="#arguments#"/>
		<cfreturn local.return>
	</cffunction>
	
	<cffunction name="setLabel" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="value" 				type="string" 	required="true" 					hint="One of:green,yellow,orange,red,purple,blue">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/labels">
		<cfreturn callCards(	uriFilter=uriFilter, verb="post", value=arguments.value)>
	</cffunction>
	
	<cffunction name="setMember" >
		<cfargument name="cardID" 				type="string" 	required="true" >
		<cfargument name="value" 				type="string" 	required="true" 					hint="The id of the member to add to the card">
		
		<cfset var uriFilter = "cards/#arguments.cardID#/memberes">
		<cfreturn callCards(	uriFilter=uriFilter, verb="post", value=arguments.value)>
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
			
	<cffunction name="deleteCard" >
		<cfargument name="cardID" 			type="string" 	required="true" >
			
		<cfset var uriFilter = "cards/#arguments.cardID#">
		<cfreturn callCards(	uriFilter=uriFilter, verb="delete")>
	</cffunction>
	
	<cffunction name="deleteComment" hint="This can only be done by the original author of the comment, or someone with higher permissions than the original author." >
		<cfargument name="cardID" 			type="string" 	required="true" >
		<cfargument name="idAction"			type="string"	required="true"						hint="The id of the action.">
			
		<cfset var uriFilter = "cards/#arguments.cardID#/actions/#arguments.idAction#/comments">
		<cfreturn callCards(	uriFilter=uriFilter, verb="delete", idAction=arguments.idAction)>
	</cffunction>
	
	<cffunction name="deleteAttachment">
		<cfargument name="cardID" 			type="string" 	required="true" >
		<cfargument name="idAttachment"		type="string"	required="true"						hint="The id of the attachment to remove from the card.">
			
		<cfset var uriFilter = "cards/#arguments.cardID#/attachments/#arguments.idAttachment#">
		<cfreturn callCards(	uriFilter=uriFilter, verb="delete", idAttachment=arguments.idAttachment)>
	</cffunction>
	
	<cffunction name="deleteChecklist">
		<cfargument name="cardID" 			type="string" 	required="true" >
		<cfargument name="idCheckList"		type="string"	required="true"						hint="The id of the checklist to remove from the card.">
			
		<cfset var uriFilter = "cards/#arguments.cardID#/checklists/#arguments.idCheckList#">
		<cfreturn callCards(	uriFilter=uriFilter, verb="delete", idCheckList=arguments.idCheckList)>
	</cffunction>
	
	<cffunction name="deleteLabel">
		<cfargument name="cardID" 			type="string" 	required="true" >
		<cfargument name="color"			type="string"	required="true"						hint="One of:green,yellow,orange,red,purple,blue">
			
		<cfset var uriFilter = "cards/#arguments.cardID#/labels/#arguments.color#">
		<cfreturn callCards(	uriFilter=uriFilter, verb="delete", color=arguments.color)>
	</cffunction>
	
	<cffunction name="deleteMember">
		<cfargument name="cardID" 			type="string" 	required="true" >
		<cfargument name="idMember"			type="string"	required="true"						hint="The id of the member to remove from the card">
			
		<cfset var uriFilter = "cards/#arguments.cardID#/members/#arguments.idMember#">
		<cfreturn callCards(	uriFilter=uriFilter, verb="delete", idMember=arguments.idMember)>
	</cffunction>
	
	<cffunction name="deleteMemberVoted">
		<cfargument name="cardID" 			type="string" 	required="true" >
		<cfargument name="idMember"			type="string"	required="true"						hint="The id of the member to remove from the card">
			
		<cfset var uriFilter = "cards/#arguments.cardID#/membersVoted/#arguments.idMember#">
		<cfreturn callCards(	uriFilter=uriFilter, verb="delete", idMember=arguments.idMember)>
	</cffunction>

	
</cfcomponent>