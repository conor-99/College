use energycrm;
#drop table if exists Address;

create table if not exists Address (
	Id int auto_increment primary key,
	IsMeter bool not null,
    AddressLine1 varchar(255) not null,
    AddressLine2 varchar(255) null,
	Eircode varchar(7) null,
    CountyId int,
    DateCreated timestamp not null,
	DateModified timestamp null,
    constraint FK_Address_County foreign key (CountyId) references County(Id),
    constraint CR_Address_Eircode check (Eircode is null or Eircode regexp '^([AC-FHKNPRTV-Y][0-9]{2}|D6W)[0-9AC-FHKNPRTV-Y]{4}$')
);
