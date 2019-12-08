use energycrm;
#drop table if exists BillingRun;

create table if not exists BillingRun (
	Id int auto_increment primary key,
    BillingRunStatusId int,
	`Name` varchar(255) not null,
    StartDate timestamp not null,
    EndDate timestamp not null,
    DateCreated timestamp not null,
	DateModified timestamp null,
    constraint FK_BillingRun_BillingRunStatus foreign key (BillingRunStatusId) references BillingRunStatus(Id)
);
