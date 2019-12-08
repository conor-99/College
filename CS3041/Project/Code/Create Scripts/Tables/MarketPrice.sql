use energycrm;
#drop table if exists MarketPrice;

create table if not exists MarketPrice (
	Id int auto_increment primary key,
    MarketPriceTypeId int,
    `Timestamp` timestamp not null,
    `Value` real not null,
    DateCreated timestamp not null,
	DateModified timestamp null,
    constraint FK_MarketPrice_MarketPriceType foreign key (MarketPriceTypeId) references MarketPriceType(Id),
    constraint CR_MarketPrice_Value check (`Value` > 0)
);
