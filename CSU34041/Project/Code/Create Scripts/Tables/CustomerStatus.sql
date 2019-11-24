use energycrm;
#drop table if exists CustomerStatus;

create table if not exists CustomerStatus (
	Id int auto_increment primary key,
    `Name` varchar(255) not null unique,
    DateCreated timestamp not null,
	DateModified timestamp null
);
