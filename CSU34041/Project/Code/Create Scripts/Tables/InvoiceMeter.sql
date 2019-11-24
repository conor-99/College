use energycrm;
#drop table if exists InvoiceMeter;

create table if not exists InvoiceMeter (
	Id int auto_increment primary key,
    InvoiceId int,
    MeterId int,
    DateCreated timestamp not null,
	DateModified timestamp null,
    constraint FK_InvoiceMeter_Invoice foreign key (InvoiceId) references Invoice(Id),
    constraint FK_InvoiceMeter_Meter foreign key (MeterId) references Meter(Id)
);
