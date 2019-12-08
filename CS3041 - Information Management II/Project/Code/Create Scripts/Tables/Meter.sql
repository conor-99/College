use energycrm;
#drop table if exists Meter;

create table if not exists Meter (
	Id int auto_increment primary key,
    MeterTypeId int,
    MeterStatusId int,
    CustomerId int,
    ExternalIdentifier varchar(20) not null unique,
    AddressId int,
    DateCreated timestamp not null,
	DateModified timestamp null,
    constraint FK_Meter_MeterType foreign key (MeterTypeId) references MeterType(Id),
    constraint FK_Meter_MeterStatus foreign key (MeterStatusId) references MeterStatus(Id),
    constraint FK_Meter_Customer foreign key (CustomerId) references Customer(Id),
    constraint FK_Meter_Address foreign key (AddressId) references Address(Id),
    constraint CR_Meter_ExternalIdentifier check ((MeterTypeId = 1 and ExternalIdentifier regexp '^10[0-9]{9}$') or (MeterTypeId = 2 and ExternalIdentifier regexp '^[0-9]{7}$'))
);
