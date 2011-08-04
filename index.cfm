<Cfsetting showdebugoutput="false" />

<!--- CREATE DUMMY DATA --->
<cfscript>
	qry = QueryNew("");
	QueryAddColumn(qry,"houseID",ListToArray("1,2,3"));
	QueryAddColumn(qry,"dateFrom",ListToArray("#now()#,#DateAdd("d", 10, now())#,#DateAdd("d", 35, now())#"));
	QueryAddColumn(qry,"dateTo",ListToArray("#DateAdd("d", 5, now())#,#DateAdd("d", 15, now())#,#DateAdd("d", 35, now())#"));
	QueryAddColumn(qry,"Title",ListToArray("House Rented By Luis, House Rented By Me, House Rented by You"));
</cfscript>

<cfdump var="#qry#" hide="Database Data">

<!--- CALL THE CALENDAR FACTORY --->
<cfset calendars =  CreateObject("component", "calendar.calendars") />

<!--- EXAMPLE OF USING THE DATA ABOVE --->
<cfset scheduleData = {} />
<cfloop query="qry">
	<cfset scheduleData[qry.dateFrom] = {
		to = qry.dateTo,
		label = qry.title
	} />
</cfloop>

<!--- CALL THE DATE OBJECT --->
<cfset calendarFromDB = calendars.getCalendar(
	numberOfMonths = 3,
	numberOfRows = 4,
	scheduleData =  scheduleData
	) />


<!--- USING STATIC DATA --->
<cfset staticData = {
		"08-23-11" =
		{
			to = "08-29-11",
			label =  "Eric's and Erica's Birthday"
		},
		"08-14-11" = {label="test"},
		"09-23-11" =
		{
			to = "09-29-11",
			label= "A month after Eric's and Erica's Brithdat"
		},
		"10-10-11" = {
			label = "test"
		},
		"12-24-11" =
		{
			to = "12-25-11",
			label =  "Holiday"
		}
	} />
<cfset calendarFromDataSet = calendars.getCalendar(
	numberOfMonths = 3,
	numberOfRows = 4,
	scheduleData = staticData
)>

<cfdump var="#staticData#" label="Static Data used for second calendar">

<cfoutput>
	<table cellpadding="10">
		<tr>
			<td>#calendarFromDataSet.render()#</td>
			<td>#calendarFromDB.render()#</td>
		</tr>
	</table>
</cfoutput>

