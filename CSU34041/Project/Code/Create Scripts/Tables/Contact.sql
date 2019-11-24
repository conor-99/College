use energycrm;
#drop table if exists Contact;

create table if not exists Contact (
	Id int auto_increment primary key,
    CustomerId int,
    IsPrimaryContact bool check (IsOnlyPrimaryContact(CustomerId, IsPrimaryContact)),
    Email varchar(255) not null unique check (VerifyEmail(Email)),
    FirstName varchar(255) not null,
    LastName varchar(255) not null,
    Phone varchar(20) not null check (VerifyPhone(Phone)),
    AddressId int,
    DateCreated timestamp not null,
	DateModified timestamp null,
    constraint FK_Contact_Customer foreign key (CustomerId) references Customer(Id),
    constraint FK_Contact_Address foreign key (AddressId) references Address(Id)
);
