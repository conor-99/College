use energycrm;
#drop table if exists UserStatus;

create table if not exists UserStatus (
	Id int auto_increment primary key,
    `Name` varchar(255) not null unique,
    DateCreated timestamp not null,
	DateModified timestamp null
);
