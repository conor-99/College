use energycrm;
#drop function if exists VerifyExternalIdentifier;

delimiter //
create function VerifyExternalIdentifier(meterTypeId int, externalIdentifier varchar(255)) returns bool
deterministic
begin
	return true;
end//
delimiter ;
