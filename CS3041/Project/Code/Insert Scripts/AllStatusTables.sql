insert into BillingRunStatus (`Name`)
values ('Completed'), ('In progress'), ('Not started'), ('Cancelled'), ('Deleted');

insert into CustomerStatus (`Name`)
values ('Active'), ('Inactive'), ('Deleted');

insert into InvoiceStatus (`Name`)
values ('Sent'), ('Approved'), ('Rejected'), ('Awaiting approval'), ('Cancelled'), ('Deleted');

insert into MeterStatus (`Name`)
values ('Active'), ('Inactive'), ('Deleted'), ('Awaiting approval');

insert into UserStatus (`Name`)
values ('Active'), ('Inactive'), ('Deleted');
