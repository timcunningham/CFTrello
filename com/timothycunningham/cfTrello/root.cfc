<cfcomponent>
	<cffunction name="getPRC">
		<cfset var prc = structNew()>
		<cfset prc.apiURL					= application.apiURL>
		<cfset prc.sConsumerKey 			= application.sConsumerKey>
		<cfset prc.sConsumerkeysecret 		= application.sConsumerkeysecret>
		<cfset prc.sTokenEndpoint			= application.sTokenEndpoint> 		
		<cfset prc.sAccessTokenEndpoint 	= application.sAccessTokenEndpoint> 	
		<cfset prc.sAuthorizationEndpoint 	= application.sAuthorizationEndpoint> 
		<cfset prc.sCallbackURL 			= application.sCallbackURL>
		<cfset structAppend(prc,session, "true")>		
		<cfreturn prc>
	</cffunction>
	
	<cffunction name="sessionInit">
		<cfset session.oauth_token 			= "">
		<cfset session.sAccessToken 		= "">
		<cfset session.sAccessTokenSecret 	= "">
		<cfset session.oauth_verifier 		= "">
		<cfset session.boardID				= "">
		<cfreturn>
	</cffunction>
	
	<cffunction name="getHttpType">
		<cfif cgi.https is "off">
			<cfreturn "http://">
		<cfelse>
			<cfreturn "https://">
		</cfif>
		<cfreturn "http://">
	</cffunction>
	
	<cffunction name="setTargetPage">
		<cfargument name="targetPage" required="true" type="string" default="#getHttpType()##cgi.server_name#">
		<cfset session.targetPage = arguments.targetPage>
		<cfreturn session.targetPage>
	</cffunction>
	
	<cffunction name="getTargetPage">
		<cfreturn session.targetPage>
	</cffunction>
	
		
	<cffunction name="doApiCall" access="public" hint="generic caller to Trello API">
		<cfargument name="verb" 		type="string" 	required="true" 	default="get">
		<cfargument name="uriFilter" 	type="string" 	required="true" >
		
		<!--- Set up needed variables --->
		<cfif ISDefined("arguments.fields") IS False>
			<cfset arguments.fields = structNew()>
		</cfif>
		<cfif ISDefined("arguments.formatType") IS False>
			<cfset arguments.formatType = "Struct">
		</cfif>
		<cfset structAppend(variables,getPRC(),"true")>		
		<cfset var rawReturn = "">
		<cfset var arg = "">
		<cfset var apiCall = "">

		<cfset var apiCall = apiURL  & "#arguments.uriFilter#/">
		<cfset apicall = apiCall & "?key=#sConsumerKey#">
		<!--- Append the other arguments passed in --->

		<cfloop collection="#arguments#" item="arg">	
			<cfif isSimpleValue(arguments[arg]) AND  arg NEQ "urifilter" AND arg NEQ "formatType" AND arg NEQ "Verb">	
			<cfset apiCall = apiCall & "&#arg#=#arguments[arg]#">
			</cfif>
		</cfloop>	
		<cfif saccesstoken NEQ "">
			<cfset apiCall = apiCall & "&token=#saccesstoken#">
		</cfif>
		<cfdump var="#apiCall#">
		<cfif arguments.verb NEQ "post">
			<cfhttp url="#apiCall#" method="#arguments.verb#" result="rawReturn">
		<cfelse>
			<cfhttp url="#apiCall#" method="#arguments.verb#" result="rawReturn">
				<cfhttpparam type="body" value="">
			</cfhttp>
			
		</cfif>
		<cfset  rawReturn= getApiReturn(rawReturn, arguments.formatType)>
		<cfset var return = structNew()>
		<cfset return.apiCall =  apiCall>
		<cfreturn rawReturn>
	</cffunction>
	
	<cffunction name="getAPIReturn" access="public" hint="Formats the return call from Trello">
		<cfargument name="rawReturn"  type="struct" required="true">
		<cfargument name="formatType" type="string" required="true" default="Struct" hint="JSON or Struct (Deserialized JSON)">
		<cfset var errorReturn = structNew()>
		<cfif isObject(rawReturn.fileContent) AND isJsON(rawReturn.fileContent.toString()) AND arguments.formatType IS "Struct">
			<cfreturn deserializeJson(rawReturn.fileContent.toString())>
		</cfif>
		<cfif isObject(rawReturn.fileContent) AND isJsON(rawReturn.fileContent.toString()) AND arguments.formatType IS "JSON">
			<cfreturn rawReturn.fileContent.toString()>
		</cfif>
		<!--- Error checking --->
		<cfif isObject(rawReturn.fileContent) IS false >
			<cfset errorReturn.name			= "Error">
			<cfset errorReturn.error		= rawReturn.fileContent>
			<cfset errorReturn.statusCode 	= rawReturn.statusCode>
			<cfif arguments.formatType IS "JSON">
				<cfset errorReturn= serializeJSON(errorReturn)>
			</cfif>
		</cfif>
		<cfreturn errorReturn>
	</cffunction>
	
	<cffunction name="setTokenStorage">
		<cfargument name="accessToken" 					required="true" >
		<cfargument name="length"		type="numeric"	required="true"	default=30>
		
		<cfcookie name="sAccessToken" value="#arguments.accessToken#" expires="#arguments.length#">
		
		<cfreturn>
	</cffunction>
	
	<cffunction name="getTokenStorage">
		<cfif ISDefined("cookie.sAccessToken") AND cookie.sAccessToken NEQ "">
			<cfset session.sAccessToken = cookie.sAccessToken>
			<cfreturn cookie.sAccessToken>
		</cfif>
		<cfreturn "">
	</cffunction>
	
	<cffunction name="clearTokenStorage">
		<cfset cookie.sAccessToken = "">
		<cfreturn>
	</cffunction>
	
	
</cfcomponent>