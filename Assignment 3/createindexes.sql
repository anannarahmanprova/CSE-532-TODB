drop index cse532.facilityidx;
drop index cse532.zipidx;
drop index cse532.zipcodeidx;
drop index cse532.facilityzipidx;

drop index cse532.facilityidcertificationx;


create index cse532.facilityidx on cse532.facility(geolocation) extend using db2gse.spatial_index(0.85, 2, 5);

create index cse532.zipidx on cse532.uszip(shape) extend using db2gse.spatial_index(0.85, 2, 5);


create index cse532.zipcodeidx ON cse532.uszip(ZCTA5CE10);
create index cse532.facilityzipidx ON cse532.facility(zipcode);

create index cse532.facilityidcertificationx ON cse532.facilitycertification(facilityid);


runstats on table cse532.facility and indexes all;

runstats on table cse532.uszip and indexes all;
runstats on table cse532.facilitycertification and indexes all;
