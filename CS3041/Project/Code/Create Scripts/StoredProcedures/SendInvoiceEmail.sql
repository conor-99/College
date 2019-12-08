use energycrm;
drop procedure if exists SendInvoiceEmail;

delimiter //
create procedure SendInvoiceEmail(in InvoiceId int)
begin
	
    # Variables we'll fetch from the cursor
    declare externalId varchar(20);
    declare meterType, unitSymbol varchar(255);
    declare originalValue, convertedValue, meterAmount, marketPrice real;
    
    # Meter cursor and flag
    declare done bool default false;
	declare meterCursor cursor for (
		select ic.ExternalIdentifier, ic.MeterType, ic.OriginalValue, ic.UnitSymbol, ic.ConvertedValue, ic.MeterAmount, ic.MarketPrice
        from InvoiceEmailContent ic
        where ic.InvoiceId = InvoiceId
	);
    declare continue handler for not found set done = true;
    
	# Get some key information:
	set @customerName = (select Customer from InvoiceEmailContent ic where ic.InvoiceId = InvoiceId limit 1);
	set @invoiceAmount = (select InvoiceAmount from InvoiceEmailContent ic where ic.InvoiceId = InvoiceId limit 1);
    set @billingRunId = (select BillingRunId from InvoiceEmailContent ic where ic.InvoiceId = InvoiceId limit 1);
    set @emailRecipient = (select co.Email from Contact co join Customer c on c.Id = co.CustomerId where c.`Name` = @customerName and co.IsPrimaryContact);
    call GetBillingRunDates(@billingRunId, @startDate, @endDate);
    
    # Format some important dates
    set @invoiceDate = date_format(current_date(), '%d/%m/%Y');
    set @formatStartDate = date_format(@startDate, '%d/%m/%Y');
    set @formatEndDate = date_format(@endDate, '%d/%m/%Y');
    
    # Generate email subject
    set @emailSubject = concat('Invoice for ', @customerName, ' (', @invoiceDate, ')');
    
    # Generate start of email body
    set @emailBody = concat(
		'Dear ', @customerName, ',\n',
        'You are being charged €', @invoiceAmount, ' for energy used from ', @formatStartDate, ' to ', @formatEndDate, '.\n\n'
	);
    
    # Generate invoice breakdown for email body
    open meterCursor;
    meterLoop: loop
		fetch meterCursor into externalId, meterType, originalValue, unitSymbol, convertedValue, meterAmount, marketPrice;
        if done then leave meterLoop; end if;
        set @emailBody = concat(
			@emailBody,
            externalId, ' (', meterType, '): ', originalValue, ' (', unitSymbol, ') => ', convertedValue, ' (kWh) => €', meterAmount, ' (at ', marketPrice, ' € per kWh)\n'
		);
    end loop;
    close meterCursor;
    
    # Insert the email into the queue
    insert into EmailQueue (IsSent, Recipient, `Subject`, Body)
    select 0, @emailRecipient, @emailSubject, @emailBody;
    
    # Set the invoice to sent
    update Invoice set InvoiceStatusId = 1 where Id = InvoiceId;
    
end //
delimiter ;
