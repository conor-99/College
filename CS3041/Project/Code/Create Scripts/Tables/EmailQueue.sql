use energycrm;
#drop table if exists EmailQueue;

create table if not exists EmailQueue (
	Id int auto_increment primary key,
    IsSent bool,
    Recipient varchar(255) not null,
    `Subject` varchar(255) not null,
    Body text not null,
    DateCreated timestamp not null,
	DateModified timestamp null,
    constraint CR_EmailQueue_Recipient check (Recipient like '_%@_%.__%')
);
