<cfset myBoardID="50856097d4f128181b007fb2">

<cfdump var="#application#">
<cfdump var="#session#">
<cfabort>

<cfset boards = createObject("component" , "com.timothycunningham.cftrello.boards")>
<cfset lists = createObject("component" , "com.timothycunningham.cftrello.lists")>
<cfset test= boards.getOpenLists(myBoardID)>
<cfdump var="#test#" label="getOpenLists">


<cfset test= boards.setInvitation(boardID=myBoardID, email="foo@bar.com")>
<cfdump var="#test#" label="setInvitation">

<cfset test= boards.setName(boardID=myBoardID, value="My pretty board")>
<cfdump var="#test#" label="setName">

<cfset test= boards.getCardByID(boardID=myBoardID, cardID="5075df548934b4cf11c75fc6")>
<cfdump var="#test#" label="getCardByID">

<cfset test= boards.getActions(boardID=myBoardID,filter="addMemberToCard,removeMemberFromCard,updateBoard")>
<cfdump var="#test#" label="getActions"> 

<cfset test= boards.getCards(boardID=myBoardID,filter="all")>
<cfdump var="#test#" label="getCards"> 

<cfset test= boards.getName(myBoardID)>
<cfdump var="#test#" label="getName">

<cfset test= boards.getDesc(myBoardID)>
<cfdump var="#test#" label="getDesc">

<cfset test= boards.getOpenLists(myBoardID)>
<cfdump var="#test#" label="getOpenLists">



<cfset test= boards.getLabelNames(myBoardID)>
<cfdump var="#test#" label="getLabelNames">

<cfset test= boards.getInvited(myBoardID)>
<cfdump var="#test#" label="getInvited">



