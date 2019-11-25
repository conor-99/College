use energycrm;
#drop view if exists MeterUsageOverview

create view MeterUsageOverview as
	select
		# Ids
		c.Id `CustomerId`, m.Id `MeterId`, mr.Id `MeterReadingId`, m.ExternalIdentifier,
        # Names
        c.`Name` `Customer`, mt.`Name` `MeterType`, u.`Name` `Unit`, u.Symbol `UnitSymbol`,
        # Values
        mr.`Value` `OriginalValue`, cr.`ConvertedValue` `ConvertedValue`,
        # Other
        cr.`Timestamp` `Timestamp`
	from Meter m
	join Customer c on c.Id = m.CustomerId
	join MeterReading mr on mr.MeterId = m.Id
	join ConvertedMeterReadingValue cr on cr.MeterReadingId = mr.Id
	join MeterType mt on mt.Id = m.MeterTypeId
	join Unit u on u.Id = mt.UnitId
	where c.CustomerStatusId = 1 and m.MeterStatusId = 1
;
