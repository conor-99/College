use energycrm;
drop trigger if exists TR_Invoice_Approved;

delimiter //
create trigger TR_Invoice_Approved
	after update
	on Invoice for each row
begin
	if new.InvoiceStatusId = 2 then call SendInvoiceEmail(new.Id);
	end if;
end//
delimiter ;
