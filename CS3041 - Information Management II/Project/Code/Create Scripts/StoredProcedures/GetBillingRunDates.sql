use energycrm;
#drop procedure if exists GetBillingRunDates;

delimiter //
create procedure GetBillingRunDates(
	in BillingRunId int,
    out StartDate timestamp,
    out EndDate timestamp
)
begin
    select br.StartDate into StartDate from BillingRun br where br.Id = BillingRunId;
    select br.EndDate into EndDate from BillingRun br where br.Id = BillingRunId;
end //
delimiter ;
