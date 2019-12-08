use energycrm;
#drop table if exists InvoiceStatus;

create table if not exists InvoiceStatus (
	Id int auto_increment primary key,
    `Name` varchar(255) not null unique,
    DateCreated timestamp not null,
	DateModified timestamp null
);
