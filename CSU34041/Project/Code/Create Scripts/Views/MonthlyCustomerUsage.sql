use energycrm;
#drop view if exists MonthlyCustomerUsage;

create view MonthlyCustomerUsage as
	select c.Id `CustomerId`, c.`Name` `CustomerName`, round(sum(cv.ConvertedValue), 4) `TotalUsage`, month(r.`Timestamp`) `ReadingMonth`, year(r.`Timestamp`) `ReadingYear`
	from Customer c
	join Meter m on m.CustomerId = c.Id
	join MeterReading r on r.MeterId = m.Id
    join ConvertedMeterReadingValue cv on cv.MeterReadingId = r.Id
    group by c.`Name`, month(r.`Timestamp`), year(r.`Timestamp`)
;
