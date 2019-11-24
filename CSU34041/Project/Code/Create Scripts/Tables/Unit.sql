use energycrm;
#drop table if exists Unit;

create table if not exists Unit (
	Id int auto_increment primary key,
    Symbol varchar(255) not null,
    `Name` varchar(255) null,
    ConversionFactor real not null check (ConversionFactor >= 0),
    DateCreated timestamp not null,
	DateModified timestamp null,
    unique(Symbol, `Name`)
);
