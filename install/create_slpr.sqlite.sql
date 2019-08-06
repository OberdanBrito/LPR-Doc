create table job
(
    filedate timestamp default CURRENT_TIMESTAMP not null,
    id bigserial not null constraint primary_key_job primary key,
    version varchar(50),
    data_type varchar(50),
    epoch_time real,
    img_width integer,
    img_height integer,
    processing_time_ms real,
    uuid varchar(50),
    camera_id integer,
    site_id varchar(50),
    company_id varchar(50)
);

create table results
(
    filedate timestamp default CURRENT_TIMESTAMP not null,
    id bigserial not null constraint primary_key_results primary key,
    job bigint constraint foreignkey_results_jobs references job on update cascade on delete cascade,
    plate varchar(20),
    confidence double precision,
    matches_template double precision,
    plate_index integer,
    region varchar(5),
    region_confidence integer,
    processing_time_ms double precision,
    requested_topn integer
);

create table regions
(
    id serial not null constraint primary_key_regions primary key,
    job bigint constraint foreignkey_regions_jobs references job on update cascade on delete cascade,
    x integer,
    y integer,
    width integer,
    weight integer
);

create table coordinates
(
    id serial not null constraint primary_key_coordinates primary key,
    results bigint constraint foreignkey_coordinates_results references results on update cascade on delete cascade,
    x integer,
    y integer
);

create table candidates
(
    id serial not null constraint primary_key_candidates primary key,
    results bigint constraint foreignkey_candidates_results references results on update cascade on delete cascade,
    plate varchar(20),
    confidence double precision,
    matches_template integer
);