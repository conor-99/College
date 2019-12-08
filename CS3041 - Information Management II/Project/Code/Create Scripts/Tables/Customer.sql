use energycrm;
#drop table if exists Customer;

create table if not exists Customer (
	Id int auto_increment primary key,
    CustomerStatusId int,
	`Name` varchar(255) not null,
    DateCreated timestamp not null,
	DateModified timestamp null,
    constraint FK_Customer_CustomerStatus foreign key (CustomerStatusId) references CustomerStatus(Id)
);
