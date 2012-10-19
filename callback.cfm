<cfset session.login.setTokens(url)>
<cflocation url="#getTargetPage()#">
<cfoutput>Callback completed at: #now()#</cfoutput>
<cfabort>