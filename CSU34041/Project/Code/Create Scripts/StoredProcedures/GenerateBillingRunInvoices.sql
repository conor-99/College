use energycrm;
#drop procedure if exists GenerateBillingRunInvoices;

delimiter //
create procedure GenerateBillingRunInvoices(in BillingRunId int)
begin

    # Get the start and end dates of the billing run:
    call GetBillingRunDates(BillingRunId, @startDate, @endDate);
    # Get the latest market price (€ per kWh)
    set @marketPrice = GetMarketPrice(3);
    
    # Insert data into the Invoice table
    insert into Invoice (InvoiceStatusId, BillingRunId, CustomerId, Amount)
    select 4, BillingRunId, mu.CustomerId, round(sum(mu.ConvertedValue) * @marketPrice, 2)
    from MeterUsageOverview mu
    where mu.`Timestamp` between @startDate and @endDate
    group by mu.CustomerId;
    
    # Insert data into the InvoiceMeter table
    insert into InvoiceMeter (MeterId, InvoiceId)
    select MeterId, InvoiceId
    from MeterInvoiceIdPairs mi
    where mi.BillingRunId = BillingRunId;
    
end //
delimiter ;
