create table cse532.collision_all (
    date date,
    time TIME,
    zip_code varchar(10),
    latitude decimal(10,8),
    longitude decimal(11,8),
    contributing_factor_vehicle1 varchar(255),
    contributing_factor_vehicle2 varchar(255),
    unique_key BIGINT not null primary key,
    vehicle_type_code_1 varchar(255),
    vehicle_type_code_2 varchar(255)
);
create index idx_zipcode ON cse532.collision_all1 (zip_code);
create index idx_latitude ON cse532.collision_all1 (latitude);
create index idx_longitude ON cse532.collision_all1 (longitude);
create index idx_datetime ON cse532.collision_all1 (date);


