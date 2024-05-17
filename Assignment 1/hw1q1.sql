select MONTH (date) AS month, HOUR(time) AS hour, COUNT(*) AS collision_count from cse532.collision group by cube (HOUR(time), MONTH(date)) order by collision_count DESC;
