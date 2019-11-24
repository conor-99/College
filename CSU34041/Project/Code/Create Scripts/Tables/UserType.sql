use energycrm;
#drop table if exists UserType;

create table if not exists UserType (
	Id int auto_increment primary key,
    `Name` varchar(255) not null unique,
    DateCreated timestamp not null,
	DateModified timestamp null
);
