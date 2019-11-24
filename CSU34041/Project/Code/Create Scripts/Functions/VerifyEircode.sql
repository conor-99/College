use energycrm;
#drop function if exists VerifyEircode;

delimiter //
create function VerifyEircode(eircode varchar(7)) returns bool
deterministic
begin
	return eircode = 'AAAAAAA';
end//
delimiter ;
