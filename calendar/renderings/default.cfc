<cfcomponent name="default" extends="base">

	<cffunction name="renderCalendarStartWrapper">
		<table class="calendar" width="600px" cellpadding="10">
	</cffunction>

	<cffunction name="renderCalendarEndWrapper">
		</table>
	</cffunction>

	<cffunction name="renderMonthRow">
		<cfargument name="renderedMonths" />
		<cfoutput>
			<tr>#renderedMonths#</tr>
		</cfoutput>
	</cffunction>

	<cffunction name="renderMonthHeader">
		<cfoutput>
		<tr>
			<th width="100%" height="34" colspan="7" align="center">#DateFormat(getCurrentDate(), "mmmm")#</th>
		</tr>
		</cfoutput>
	</cffunction>

	<cffunction name="renderMonthWrapperStart">
		<td>
		<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber4" height="143">
		<tbody>
	</cffunction>

	<cffunction name="renderMonthWrapperEnd">
		</tbody></table>
		</td>
	</cffunction>

	<cffunction name="renderWeekHeader">
		<tr>
			<th width="14%" align="center" height="29">S</th>
			<th width="14%" align="center" height="29">M</th>
			<th width="14%" align="center" height="29">T</th>
			<th width="14%" align="center" height="29">W</th>
			<th width="14%" align="center" height="29">Th</th>
			<th width="15%" align="center" height="29">F</th>
			<th width="15%" align="center" height="29">S</th>
		</tr>
	</cffunction>

	<cffunction name="renderWeek">
		<cfargument name="weekdays" />
		<tr>
			<cfoutput>#arguments.weekdays#</cfoutput>
		</tr>
	</cffunction>

	<cffunction name="renderDay">
		<cfargument name="dateData">
		<cfoutput>
			<td width="15%" align="center" height="19" class="#isPreviousMonth()?'previous_month':(isCurrentMonth()?'current_month':(isNextMonth()?'next_month':''))#">
				<cfif LEN(arguments.dateData.label) AND isCurrentMonth() >
					<a href="#arguments.dateData.link#" title="#arguments.dateData.label#">#getDay()#</a>
				<cfelse>
					#getDay()#
				</cfif>
			</td>
		</cfoutput>
	</cffunction>

	<cffunction name="renderEmptyDay">
		<cfargument name="day" />
		<td width="15%" align="center" height="19">&nbsp;</td>
	</cffunction>

</cfcomponent>