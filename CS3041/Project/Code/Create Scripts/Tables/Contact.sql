use energycrm;
#drop table if exists Contact;

create table if not exists Contact (
	Id int auto_increment primary key,
    CustomerId int,
    IsPrimaryContact bool,
    Email varchar(255) not null unique,
    FirstName varchar(255) not null,
    LastName varchar(255) not null,
    Phone varchar(20) not null,
    AddressId int,
    DateCreated timestamp not null,
	DateModified timestamp null,
    constraint FK_Contact_Customer foreign key (CustomerId) references Customer(Id),
    constraint FK_Contact_Address foreign key (AddressId) references Address(Id),
    constraint CR_Contact_Email check (Email like '_%@_%.__%'),
    constraint CR_Contact_Phone check (Phone regexp '^[0-9]{10}$')
);
