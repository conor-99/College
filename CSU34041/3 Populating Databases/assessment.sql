insert into cs_course_modules (module_name, module_id, etc, lecture_hours, semester_taught)
values ('Information Management II', 'CS3041', 5, 33, 'first semester');

update cs_course_modules
set
	module_id = 'CS4D2A',
	lecture_hours = 27
where module_id = 'CS3041';

delete
from cs_course_modules
where module_id = 'CS4D2A';
