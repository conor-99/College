use energycrm;
#drop table if exists Meter;

create table if not exists Meter (
	Id int auto_increment primary key,
    MeterTypeId int,
    MeterStatusId int,
    CustomerId int,
    ExternalIdentifier varchar(20) not null unique check (VerifyExternalIdentifier(MeterTypeId, ExternalIdentifier)),
    AddressId int,
    DateCreated timestamp not null,
	DateModified timestamp null,
    constraint FK_Meter_MeterType foreign key (MeterTypeId) references MeterType(Id),
    constraint FK_Meter_MeterStatus foreign key (MeterStatusId) references MeterStatus(Id),
    constraint FK_Meter_Customer foreign key (CustomerId) references Customer(Id),
    constraint FK_Meter_Address foreign key (AddressId) references Address(Id)
);
