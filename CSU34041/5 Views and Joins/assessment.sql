create view shared_modules as
select c.module_name, c.module_id
from cs_course_modules c
inner join eng_course_modules e on e.module_name = c.module_name and e.module_id = c.module_id;

select c.module_name, c.module_id
from cs_course_modules c
inner join eng_course_modules e on e.module_name = c.module_name and e.module_id = c.module_id;
