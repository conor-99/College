use energycrm;
#drop view if exists InvoiceEmailContent;

create view InvoiceEmailContent as
	select
		i.Id `InvoiceId`,
        i.BillingRunId,
        mu.Customer,
        mu.ExternalIdentifier,
        mu.MeterType,
        mu.UnitSymbol,
        i.Amount `InvoiceAmount`,
        round(GetMarketPrice(), 4)  `MarketPrice`,
        round(sum(mu.OriginalValue), 4) `OriginalValue`,
        round(sum(mu.ConvertedValue), 4) `ConvertedValue`,
        round(sum(mu.ConvertedValue) * GetMarketPrice(), 4) `MeterAmount`
	from MeterUsageOverview mu
	join InvoiceMeter im on im.MeterId = mu.MeterId
	join Invoice i on i.Id = im.InvoiceId
    join BillingRun b on b.Id = i.BillingRunId
    where mu.`Timestamp` between b.StartDate and b.EndDate
    group by i.Id, i.BillingRunId, mu.Customer, mu.ExternalIdentifier, mu.MeterType, mu.UnitSymbol, i.Amount
;
