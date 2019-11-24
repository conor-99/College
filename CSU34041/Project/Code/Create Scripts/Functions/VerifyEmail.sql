use energycrm;
#drop function if exists VerifyEmail;

delimiter //
create function VerifyEmail(email varchar(255)) returns bool
deterministic
begin
	return Email like '_%@_%._%';
end//
delimiter ;
