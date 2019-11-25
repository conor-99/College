use energycrm;
#drop function if exists GetMarketPrice;

delimiter //
create function GetMarketPrice() returns real
begin
    return (select `Value` from MarketPrice order by `Timestamp` desc limit 1);
end //
delimiter ;
