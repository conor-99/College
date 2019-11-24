use energycrm;
#drop table if exists `User`;

create table if not exists `User` (
	Id int auto_increment primary key,
	UserTypeId int,
    UserStatusId int,
    Email varchar(255) not null unique check (Email like '_%@_%._%'),
    Username varchar(255) not null unique,
    `Password` varchar(255) not null,
    PasswordSalt varchar(255) not null,
    DateCreated timestamp not null,
	DateModified timestamp null,
    constraint FK_User_UserType foreign key (UserTypeId) references UserType(Id),
    constraint FK_User_UserStatus foreign key (UserStatusId) references UserStatus(Id)
);
