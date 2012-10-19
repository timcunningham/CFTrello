<cfdump var="#form#">
<cfdump var="#url#">
<cfabort>
<cfparam name="form.commethod" default="get">
<cfset boardID = "5072ed2a6f46cc9a38ac9b98">
<cfset appKey = "be33e6711c3b217f0ded7349dc88633c">
<cfset sAccessTokenEndpoint = "https://trello.com/1/OAuthGetAccessToken">
<cfset token=url.oauth_token>
<cfhttp url="https://api.trello.com/1/board/#boardID#?key=#url.Key#&token=#token#">
<cfdump var="#cfhttp#">
<cfdump var="https://api.trello.com/1/board/#boardID#?key=#url.Key#&token=#token#">


	<cfset sConsumerKey = url.key> 					<!--- the consumer key you got from twitter when registering you app  --->
	<cfset sConsumerSecret = url.secret> 			<!--- the consumer secret you got from twitter --->
	<cfset sRequestToken = url.oauth_token> 		<!--- returned after an access token call --->
	<cfset sRequestTokenSecret = url.token_secret>	<!--- returned after an access token call --->
	<cfset oReqSigMethodSHA = CreateObject("component", "oauth.oauthsignaturemethod_hmac_sha1")>
	<cfset oToken = CreateObject("component", "oauth.oauthtoken").init(sKey= sRequestToken,sSecret=sRequestTokenSecret)>
	<cfset oConsumer = CreateObject("component", "oauth.oauthconsumer").init(sKey = sConsumerKey, sSecret = sConsumerSecret)>

	<cfset Parameters = structNew()>
	<cfset parameters.oauth_verifier = url.oauth_verifier>
	<cfset oReq = CreateObject("component", "oauth.oauthrequest").fromConsumerAndToken(
		oConsumer = oConsumer,
		oToken = oToken,
		sHttpMethod = form.commethod,
		sHttpURL = sAccessTokenEndpoint,
		stparameters= Parameters )>
	<cfset oReq.signRequest(
		oSignatureMethod = oReqSigMethodSHA,
		oConsumer = oConsumer,
		oToken = oToken)>
	
	<cfhttp url="#oREQ.getString()#" method="get" result="tokenResponse"/>
	
	<cfif findNoCase("oauth_token",tokenresponse.filecontent)>
		<cfset sAccessToken = listlast(listfirst(tokenResponse.filecontent,"&"),"=")>
		<cfset sAccessTokenSecret = listlast(listgetAt(tokenResponse.filecontent,2,"&"),"=")>
	</cfif>
	
	<cfdump var="#tokenResponse#" label="3rd leg">
	<cfdump var="#oREQ.getString()#">