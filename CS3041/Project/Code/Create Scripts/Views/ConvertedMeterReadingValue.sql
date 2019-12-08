use energycrm;
#drop view if exists ConvertedMeterReadingValue;

create view ConvertedMeterReadingValue as
	select r.Id `MeterReadingId`, r.`Timestamp`, (u.ConversionFactor * r.`Value`) `ConvertedValue`
	from MeterReading r
	join Meter m on m.Id = r.MeterId
	join MeterType t on t.Id = m.MeterTypeId
	join Unit u on u.Id = t.UnitId
;
