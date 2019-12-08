use energycrm;
#drop view if exists MeterInvoiceIdPairs;

create view MeterInvoiceIdPairs as
    select distinct b.Id `BillingRunId`, m.Id `MeterId`, i.Id `InvoiceId`
    from MeterReading mr
    join Meter m on m.Id = mr.MeterId
    join MeterReading
    join Customer c on c.Id = m.CustomerId
    join Invoice i on i.CustomerId = c.Id
    join BillingRun b on b.Id = i.BillingRunId
	where
		(mr.`Timestamp` between b.StartDate and b.EndDate) and
        i.InvoiceStatusId = 4 and
        c.CustomerStatusId = 1 and
        m.MeterStatusId = 1
;
