use energycrm;
#drop table if exists Invoice;

create table if not exists Invoice (
	Id int auto_increment primary key,
    InvoiceStatusId int,
    BillingRunId int,
    CustomerId int,
	Amount real not null check (Amount >= 0),
    DateCreated timestamp not null,
	DateModified timestamp null,
    constraint FK_Invoice_InvoiceStatus foreign key (InvoiceStatusId) references InvoiceStatus(Id),
    constraint FK_Invoice_BillingRun foreign key (BillingRunId) references BillingRun(Id),
    constraint FK_Invoice_Customer foreign key (CustomerId) references Customer(Id)
);
