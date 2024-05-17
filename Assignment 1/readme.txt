A) Based on all days, 16 hour has the highest collision and the collision count is 16973

B) Zip codes with Top 10 Population and collision count are 11385,11226,11236,11234                

C) Among 10 dangerous locations, for(40.76082200  -73.99832000) there are two zip codes 10036 and 11226. From https://www.gps-coordinates.net/ we can verify that 10036 is the correct one.



------------------------------------------------EXTRA-----------------------------------------------------------------

a) Among all days in the year, 16 hour has the highest collision and the collision count is 146453.

b) Zip codes with Top 10 Population and collision count are 11385,11236,11234. So, If we query against whole data , result almost remain similar , only 11226 is not present in top 10.

C) Here , the location results are different from the previous result.
with this dataset, the most dangerous locations are (0,0) which has 3205 count and we get 179 Zip codes for this location. We can consider this as null value and discard them.
Among other top 10, 2 zip codes for both (40.69603300  -73.98453000) and  (40.82030500  -73.89083000) are available. From the source we could identify their correct zip codes which are 11201 and 10459.
