with get_location as(select latitude as latitude ,longitude as longitude, COUNT(*) AS collision_count from cse532.collision where zip_code is not null and latitude is not null and longitude is not null group by latitude,longitude order by collision_count desc fetch first 10 rows only)

select distinct t2.zip_code,t1.latitude, t1.longitude, t1.collision_count from get_location t1 join cse532.collision t2 on t1.latitude = t2.latitude and t1.longitude = t2.longitude where t1.latitude is not null and t1.longitude is not null and t2.zip_code is not null  order by collision_count desc;







   

