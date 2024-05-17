with top_collision as(
	select zip_code, count(*) as collision_count, rank() over (order by count(*) desc) AS collision_rank from CSE532.collision where zip_code is not null group by zip_code ),
	
top_population as(
	select zip, population, rank() over(order by population desc) as population_rank from cse532.zipcensus)

select t2.zip_code as zip_code,t2.collision_count as collision_count, t1.population as population from top_population t1 join top_collision t2 on t1.zip=t2.zip_code where t1.population_rank <=10 and t2.collision_rank<=10;


