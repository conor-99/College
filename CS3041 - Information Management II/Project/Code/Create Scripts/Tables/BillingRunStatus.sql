use energycrm;
#drop table if exists BillingRunStatus;

create table if not exists BillingRunStatus (
	Id int auto_increment primary key,
    `Name` varchar(255) not null unique,
    DateCreated timestamp not null,
	DateModified timestamp null
);
