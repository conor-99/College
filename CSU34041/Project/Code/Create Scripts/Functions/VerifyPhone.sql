use energycrm;
#drop function if exists VerifyPhone;

delimiter //
create function VerifyPhone(phone varchar(20)) returns bool
deterministic
begin
	return phone like '%';
end//
delimiter ;
