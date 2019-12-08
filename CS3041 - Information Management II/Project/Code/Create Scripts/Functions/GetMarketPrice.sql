use energycrm;
#drop function if exists GetMarketPrice;

delimiter //
create function GetMarketPrice(MarketPriceTypeId int) returns real
begin
    return (select `Value` from MarketPrice mp where mp.MarketPriceTypeId = MarketPriceTypeId order by mp.`Timestamp` desc limit 1);
end //
delimiter ;
