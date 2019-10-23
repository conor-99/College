select module_name
from cs_course_modules
where module_id like 'CS1%'
order by module_name desc;

select module_name, module_id
from cs_course_modules
where lecture_hours < 33;

select sum(lecture_hours)
from cs_course_modules
where module_id like 'CS2%';

select module_name
from cs_course_modules
where lecture_hours = (
	select min(lecture_hours)
	from cs_course_modules
);
