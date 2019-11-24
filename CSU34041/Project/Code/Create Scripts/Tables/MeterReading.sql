use energycrm;
#drop table if exists MeterReading;

create table if not exists MeterReading (
	Id int auto_increment primary key,
    MeterId int,
    `Timestamp` timestamp not null,
    `Value` real not null check (`Value` >= 0),
    DateCreated timestamp not null,
	DateModified timestamp null,
    constraint FK_MeterReading_Meter foreign key (MeterId) references Meter(Id)
);
