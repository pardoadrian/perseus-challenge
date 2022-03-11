-- average complete time of a course
select date_part('day', avg("completedDate" - "startDate" )) as avg_days_spent
from stg_certificates ;


-- average amount of users time spent in a course
-- 65 days
with avg_time_spent_by_user as (
			select "user",
					avg("completedDate" - "startDate") as avg_time_spent
			from stg_certificates
			group by 1
			order by 2 desc)
select date_part('day',avg(avg_time_spent)) as avg_user_time_on_a_course
from avg_time_spent_by_user;


--average amount of users time spent for each course individually
select title
		,date_part('day' ,avg("completedDate" - "startDate" )) as days_spent
from stg_certificates ce
left join stg_courses c on c.id = ce.course 
group by title 
order by 2 desc;


--report of the 5 fastest vs. 5 slowest users completing a course
with fastest_users as (
	select u."firstName",
			u."lastName",
			c.title, 
			min("completedDate" - "startDate") as time_spent
	from stg_certificates cer
	left join stg_users u on u.id = cer."user" 
	left join stg_courses c on c.id = cer.course 
	group by 1,2,3
	order by 4
	limit 5
),
slowest_users as (
	select u."firstName",
			u."lastName",
			c.title, 
			max("completedDate" - "startDate") as time_spent
	from stg_certificates cer
	left join stg_users u on u.id = cer."user" 
	left join stg_courses c on c.id = cer.course 
	group by 1,2,3
	order by 4 desc
	limit 5
)
select * from fastest_users
union all
select *from slowest_users
;


--amount of certificates per customer
-- keep in mind that an user could have taken the same course more than once
select u."firstName",
		u."lastName", 
		count(course)
from stg_certificates ce
left join stg_users u on u.id = ce."user" 
group by 1,2 
order by 3 desc;


--amount of different certificates per customer
select u."firstName",
		u."lastName",
		u.id, 
		count(distinct course)
from stg_certificates ce
left join stg_users_2 u on u.id = ce."user" 
group by 1,2,3 
order by 4 desc;


-- Bonus: courses taken more than 4 times by the same user
select u."firstName",
		u."lastName", 
		c.title,
		count(course)
from stg_users_2 u 
left join stg_certificates ce on u.id = ce."user"
left join stg_courses c on c.id = ce.course 
group by 1,2,3
having count(course)>4;