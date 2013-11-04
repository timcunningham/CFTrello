<cfcomponent output="false" extends="com.timothyCunningham.cfTrello.root">
<cfset this.name="CFTrello">
<cfset this.sessionManagement = "yes">
<cffunction name="onApplicationStart" >
	<cfset application.apiURL					= "https://api.trello.com/1/">
	<cfset application.sConsumerKey 			= "be33e6711c3b217f0ded7349dc88633c">
	<cfset application.sConsumerkeysecret 		= "f01dd950d49e8d457989a4ee1e6b82a130849068e2f9704a1434ce2b31b34a5b">
	<cfset application.sTokenEndpoint			= "https://trello.com/1/OAuthGetRequestToken"> 		
	<cfset application.sAccessTokenEndpoint 	= "https://trello.com/1/OAuthGetAccessToken"> 	
	<cfset application.sAuthorizationEndpoint 	= "https://trello.com/1/OAuthAuthorizeToken"> 
	<cfset application.sCallbackURL 			= "#getHttpType()##cgi.server_name#/#listFirst(cgi.script_name, "/")#/callback.cfm"> 
	<cfreturn>	
</cffunction>

<cffunction name="onSessionStart">
	<cfset sessionInit()>
	<cfset session.login = createObject("component","com.timothycunningham.cftrello.login")>
</cffunction>

<cffunction name="onRequestStart">
	<cfif ISDefined("session") is false>
		<cfset onSessionStart()>
	</cfif>
	<cfif ISDefined("url.restart")>
		<cfset onSessionStart()>
		<cfset onApplicationStart()>
	</cfif>
	<cfif ISDefined("url.clearMeCookies")>
		<cfset clearTokenStorage()>
	</cfif>
	<cfreturn>	
</cffunction>

<cffunction name="onRequest" >
	<cfargument name="targetPage" type="string" required="true" hint="The requested ColdFusion Template">
	<cfif arguments.targetPage NEQ replaceNoCase(application.sCallbackURL, "#getHttpType()##cgi.server_name#", "")>
		<cfset session.login.getTrelloLogin(targetPage=arguments.targetPage)>
	</cfif>
	<cfset var prc = getPRC()>
	<cfinclude template="#arguments.targetPage#">
</cffunction>


</cfcomponent>