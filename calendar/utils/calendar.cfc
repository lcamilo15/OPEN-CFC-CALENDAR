component name="calendar"
{
	public function init(
		rendering,
		scheduleData,
		numberOfMonths
	)
	{
		VARIABLES.rendering = rendering;
		VARIABLES.rendering.setScheduleData(arguments.scheduleData);
		VARIABLES.numberOfMonths = arguments.numberOfMonths;
		return this;
	}

	public function render()
	{
		VARIABLES.rendering.renderCalendarStartWrapper();

		for(i = 1; i < 4; ++i)
		{
			renderMonthRows();
		}

		VARIABLES.rendering.renderCalendarEndWrapper();
	}

	public function renderMonthRows()
	{
		savecontent variable="renderedMonths"
		{
			renderMonths();
		}

		VARIABLES.rendering.renderMonthRow(renderedMonths);
	}

	public function renderMonths()
	{
		for(local.currentMonth = 0; local.currentMonth < VARIABLES.numberOfMonths; ++local.currentMonth)
		{
			local.renderingCurrentMonth = VARIABLES.rendering.getMonth();

			renderMonth();

			if(local.renderingCurrentMonth == VARIABLES.rendering.getMonth())
			{
				VARIABLES.rendering.setNextMonth();
			}
		}
	}

	public function renderMonth()
	{

		if(StructKeyExists(VARIABLES.rendering, "renderMonthWrapperStart"))
		{
			VARIABLES.rendering.renderMonthWrapperStart();
		}

		if(StructKeyExists(VARIABLES.rendering, "renderMonthHeader"))
		{
			VARIABLES.rendering.renderMonthHeader();
		}

		if(StructKeyExists(VARIABLES.rendering, "renderWeekHeader"))
		{
			VARIABLES.rendering.renderWeekHeader();
		}

		if(StructKeyExists(VARIABLES.rendering, "renderWeek"))
		{
			VARIABLES.rendering.setFirstweek();
			for(local.currentWeek = 1; local.currentWeek <= 5; ++local.currentWeek)
			{
				VARIABLES.rendering.renderWeek(renderDays());
			}
		}

		if(StructKeyExists(VARIABLES.rendering, "renderMonthWrapperEnd"))
		{
			VARIABLES.rendering.renderMonthWrapperEnd();
		}
	}

	public function renderDays()
	{
		savecontent variable="renderedDays"
		{
			for(local.currentDay = 1; local.currentDay <= 7; ++local.currentDay)
			{
				VARIABLES.rendering.renderDay(VARIABLES.rendering.getDayData());
				VARIABLES.rendering.setNextDay();
			}
		}
		return renderedDays;
	}

}