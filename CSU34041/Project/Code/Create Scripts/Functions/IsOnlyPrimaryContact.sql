use energycrm;
#drop function if exists IsOnlyPrimaryContact;

delimiter //
create function IsOnlyPrimaryContact(customerId int, isPrimaryContact bool) returns bool
deterministic
begin
	return
		(not isPrimaryContact) or (select exists (
			select 1
			from Contact c
			where c.CustomerId = customerId and isPrimaryContact = true
		));
end//
delimiter ;
