component name="calendar"
{
	/*
	********************************************************************************
	Open CFC Calendar
	www.lacdesign.net | www.luisarielcamilo.com
	********************************************************************************

	Author      :	Luis Camilo
	Date        :	08/04/2011
	Description :
		ALPHA VERSION FOR CFC CALENDAR. LETS SEE HOW FAR I CAN TAKE THIS PROJECT IN THE
		FUTURE
	-----------------------------------------------------------------------
	*/

	import calendar.utils*;

	public function init(
		numberOfMonths = 3,
		numberOfRows = 4,
		rendering = "default"
	)
	{
		variables.numberOfMonths = arguments.numberOfMonths;
		variables.numberOfRows = arguments.numberOfRows;
		return this;
	}

	public function getCalendar(
		scheduleData = {},
		numberOfMonths = variables.numberOfMonths,
		numberOfRows = variables.numberOfRows,
		rendering = "default"
	)
	{
		local.rendering = CreateObject("component", "renderings.#arguments.rendering#").init();

		local.calendar = new calendar(
			rendering = local.rendering,
			scheduleData = arguments.scheduleData,
			numberOfMonths = arguments.numberOfMonths
		);

		return local.calendar;
	}

}