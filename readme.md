# CFTrello
#A ColdFusion wrapper for the Trello API

_by Tim Cunningham (@timcunningham71)_

Thanks to:

* <a href="http://oauth.riaforge.org/">Harry Klein for his Oauth library</a>
* <a href="http://taffy.riaforge.org">Adam Tuttle for helping with some REST functionality</a>
* <a href="https://twitter.com/TimCunningham71/status/256425485553238016">The Twitters for ignoring my rants about the evils of the OAuth 1.0 3-legged dance.</a>

Trello describes itself as "a collaboration tool that organizes your projects into boards. In one glance, Trello tells you what's being worked on, who's working on what, and where something is in a process."

This wrapper handles all the OAuth requirements, and has helper calls for every REST command in Trello API documentation.  It can be useful if you wish to integrate Trello functionality into your ColdFusion apps, services or internal processes.

## REQUIREMENTS

* You need a working ColdFusion server, this has been tested on ColdFusion 9.0.1 & ColdFusion 10.
* A active user account from Trello.com
* A Trello Developer API key & secret available here: <a href="https://trello.com/1/appKey/generate">https://trello.com/1/appKey/generate</a>
* A boardID of one of your Trello boards found at the end of the url when viewing the board. https://trello.com/board/welcome-board/50856097d4f128181b007fb2 (the 50856.. number is the board ID)

### SETUP

* Once you have all of the above, put the Trello files in the web root.
* In application.cfc set application.sConsumerKey  =  your Trello Developer API key 
* In application.cfc set application.sConsumerkeysecret = the secret (for Oauth Signing)
* In test.cfm set myBoardID to be the boardID of one of your Trello Boards. 

Call test.cfm from your browser, it should take you to the Trello Oauth authorization page and then return back to test.cfm.  If you see getOpenLists - struct dumping out your open lists, you have successfully connected. 

Helpful tips: 

The request token for each user is stored in a cookie, if that token becomes invalid you may need to clear that cookie for your user. pass clearmecookies in the url to do that.

If you need to restart the application (due to making changes to something stored in application scope) pass restart to the URL.
