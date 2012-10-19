<cfcomponent extends="root" >
	<cfset structAppend(variables,getPRC(),"true")>
	<cffunction name="isLoggedIn">
		<cfset var accesstoken = getTokenStorage()>
		<cfdump var="#accesstoken#">
		<cfif session.oauth_token IS "" AND session.saccesstoken IS "">
			<cfreturn false>
		</cfif>
		<cfreturn true>
	</cffunction>
	
	<cffunction name="getTrelloLogin">
		<cfargument name="targetPage" 	required="true" 	type="string" 	default="#getHttpType()##cgi.server_name#">
		<cfargument name="scope" 		required="true" 	type="string"	default="read,write,account">		
		<cfif isLoggedIn() IS true>
			<cfreturn true>
		</cfif>
		<cfset setTargetPage(arguments.targetPage)>
		<cfset var parameters 		= structNew()>
		<cfset parameters.scope 	= "">
		<cfset var oReqSigMethodSHA	= CreateObject("component", "com.oauth.oauthsignaturemethod_hmac_sha1")>
		<cfset var oToken			= CreateObject("component", "com.oauth.oauthtoken").createEmptyToken()>
		<cfset var oConsumer		= CreateObject("component", "com.oauth.oauthconsumer").init(sKey = sConsumerKey, sSecret = sConsumerkeysecret)>
		<cfset var oReq 			= CreateObject("component", "com.oauth.oauthrequest").fromConsumerAndToken(oConsumer = oConsumer,oToken = oToken,sHttpMethod = "get",sHttpURL = sTokenEndpoint, stparameters=parameters)>
		<cfset var sAuthURL 		= "">
		<cfset oReq.signRequest(oSignatureMethod=oReqSigMethodSHA,oConsumer=oConsumer,oToken=oToken)>
		<cfhttp url="#oREQ.getString()#" method="get" result="tokenResponse"/>

		<cfif findNoCase("oauth_token",tokenresponse.filecontent)>
			<cfset var sRequestToken 		= listlast(listfirst(tokenResponse.filecontent,"&"),"=")>
			<cfset var sRequestTokenSecret 	= listlast(listgetat(tokenResponse.filecontent,2,"&"),"=")>
		<cfelse>
	 		<cfdump var="#tokenresponse.filecontent#" label="getTrelloLogin-2">
		</cfif>
		
		<cfset var sCallbackURL	= sCallbackURL & "?" &  "key=" & sConsumerKey & "&" & "secret=" & sConsumerkeysecret & "&" & "token=" & sRequestToken & "&" & "token_secret=" & sRequestTokenSecret & "&" & "endpoint=" & URLEncodedFormat(sAuthorizationEndpoint)>
		<cfset sAuthURL 		= sAuthorizationEndpoint & "?oauth_token=" & sRequestToken & "&" & "oauth_callback=" & URLEncodedFormat(sCallbackURL)>
		<cflocation url="#sAuthUrl#" >	
		<cfreturn>
	</cffunction>
	
	<cffunction name="setTokens">
		<cfargument name="returned" type="struct" required="true" default="structNew()">
		<cfset structAppend(session,returned,"true")>
		<cfset oReqSigMethodSHA 				= CreateObject("component", "com.oauth.oauthsignaturemethod_hmac_sha1")>
		<cfset var oToken 						= CreateObject("component", "com.oauth.oauthtoken").init(sKey=  url.oauth_token,sSecret=url.token_secret)>
		<cfset var oConsumer 					= CreateObject("component", "com.oauth.oauthconsumer").init(sKey = sConsumerKey, sSecret = sConsumerkeysecret)>
		<cfset var Parameters 					= structNew()>
		<cfset var parameters.oauth_verifier	= url.oauth_verifier>
		<cfset var oReq 						= CreateObject("component", "com.oauth.oauthrequest").fromConsumerAndToken(oConsumer = oConsumer,oToken = oToken,sHttpMethod = "GET",sHttpURL = sAccessTokenEndpoint,stparameters= Parameters )>
		<cfset oReq.signRequest(oSignatureMethod = oReqSigMethodSHA,oConsumer = oConsumer,oToken = oToken)>
		
		<cfhttp url="#oREQ.getString()#" method="get" result="tokenResponse"/>
		
		<cfif findNoCase("oauth_token",tokenresponse.filecontent)>
			<cfset sAccessToken = listlast(listfirst(tokenResponse.filecontent,"&"),"=")>
			<cfset sAccessTokenSecret = listlast(listgetAt(tokenResponse.filecontent,2,"&"),"=")>
		</cfif>
		
		<cfset session.sAccessToken 		= sAccessToken>
		<cfset session.sAccessTokenSecret 	= sAccessTokenSecret>
		<cfset setTokenStorage(sAccessToken)>
		<cfreturn true>
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