use energycrm;
#drop table if exists Address;

create table if not exists Address (
	Id int auto_increment primary key,
	IsMeter bool not null,
    AddressLine1 varchar(255) not null,
    AddressLine2 varchar(255) null,
	Eircode varchar(7) null check (Eircode is null or VerifyEircode(Eircode)),
    CountyId int,
    DateCreated timestamp not null,
	DateModified timestamp null,
    constraint FK_Address_County foreign key (CountyId) references County(Id)
);
