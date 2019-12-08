create table cs_course_modules (
	module_name varchar(50) not null,
	module_id varchar(10) not null primary key,
	etc int not null,
	lecture_hours int not null
);

alter table cs_course_modules add semester_taught varchar(15) not null;

drop table cs_course_modules;
