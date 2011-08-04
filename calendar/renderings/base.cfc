component name="base" accessors="true"
{
	property name="currentMonth" hint="Indicates which month we are iterating on. It should be consistent on every loop even when looping on days for the next month.";
	property name="currentDate";
	property name="scheduleData";
	property name="DateFormat";

	public function init(
		currentDate = now(),
		dateFormat = "mm-dd-yy"
	)
	{
		VARIABLES.currentMonth = Month(arguments.currentDate);
		setDateFormat(arguments.dateFormat);
		setCurrentDate(arguments.currentDate);
		return this;
	}

	public function setScheduleData(scheduleData)
	{
		for(local.date in arguments.scheduleData)
		{
			local.dateData = arguments.scheduleData[local.date];

			if(IsDate(local.date))
			{
				local.date = DateFormat(local.date,  getDateFormat());
			}

			if(StructKeyExists(local.dateData, "to"))
			{
				local.dateData.to = DateFormat(local.dateData.to ,  getDateFormat());
			}

			arguments.scheduleData[local.date] = local.dateData;
		}

		VARIABLES.scheduleData = arguments.scheduleData;
	}

	public function getDayData()
	{
		local.scheduledData = getScheduleData();
		local.currentDate = getCurrentDate();
		local.dayData = {label = "", link="##"};
		/**/

		if(StructKeyExists(local.scheduledData, local.currentDate))
		{
			StructAppend(local.dayData, local.scheduledData[local.currentDate]);

			if(StructKeyExists(local.dayData, "to") AND IsDate(local.dayData.to))
			{
				populateNexDays(local.dayData);
			}
		}

		return local.dayData;
	}

	public function populateNexDays(dayData)
	{
		local.currentDate = getCurrentDate();
		local.numberOfDays = DateDiff("d", local.currentDate, arguments.dayData.to) + 1;

		if(local.numberOfDays)
		{
			while(--local.numberOfDays)
			{
				local.currentDate = DateFormat(DateAdd("d", 1, local.currentDate), getDateFormat());
				variables.scheduleData[local.currentDate] = arguments.dayData;
			}
		}
	}

	public function isPreviousMonth()
	{
		return getMonth() < getCurrentMonth();
	}

	public function isNextMonth()
	{
		return getMonth() > getCurrentMonth();
	}

	public function isCurrentMonth()
	{
		return getMonth() == getCurrentMonth();
	}

	public function setNextDay()
	{
		setCurrentDate(DateAdd("d", 1, getCurrentDate()));
		return this;
	}

	public function setNextMonth()
	{
		setCurrentDate(DateAdd("m", 1, getCurrentDate()));
		return this;
	}

	public function getMonth()
	{
		return VARIABLES.month;
	}

	public function setFirstOfMonth()
	{
		setCurrentDate(Createdate(Year(getCurrentDate()), Month(getCurrentDate()), 1));
		VARIABLES.currentMonth = Month(getCurrentDate());
		return this;
	}

	public function setCurrentDate(currentDate)
	{
		VARIABLES.currentDate = DateFormat(arguments.currentDate, getDateFormat());
		VARIABLES.month = Month(getCurrentDate());
	}

	public function setFirstweek()
	{
		setFirstOfMonth();
		local.firstDay = getFirstDayOfWeek() - 1;
		setCurrentDate(DateAdd("d", local.firstDay * -1, getCurrentDate()));
		return this;
	}

	public function getFirstDayOfWeek()
	{
		return DayOfWeek(getCurrentDate());
	}

	public function getDay()
	{
		return day(getCurrentDate());
	}

}