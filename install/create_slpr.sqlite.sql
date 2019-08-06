create table job
(
    filedate timestamp default CURRENT_TIMESTAMP not null,
    id integer not null constraint primary_key_job primary key autoincrement,
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

create unique index job_id_uindex
    on job (id);

create table results
(
    filedate timestamp default CURRENT_TIMESTAMP not null,
    id integer not null constraint primary_key_results primary key autoincrement,
    job integer constraint foreignkey_results_jobs references job on update cascade on delete cascade,
    plate varchar(20),
    confidence double precision,
    matches_template double precision,
    plate_index integer,
    region varchar(5),
    region_confidence integer,
    processing_time_ms double precision,
    requested_topn integer
);

create unique index results_id_uindex
    on results (id);

create table regions
(
    id integer not null constraint primary_key_regions primary key autoincrement,
    job integer constraint foreignkey_regions_jobs references job on update cascade on delete cascade,
    x integer,
    y integer,
    width integer,
    weight integer
);

create unique index regions_id_uindex
    on regions (id);

create table candidates
(
    id integer not null constraint primary_key_candidates primary key autoincrement,
    results integer constraint foreignkey_candidates_results references results on update cascade on delete cascade,
    plate varchar(20),
    confidence double precision,
    matches_template integer
);

create unique index candidates_id_uindex
    on candidates (id);

create table coordinates
(
    id integer not null constraint primary_key_coordinates primary key autoincrement,
    results integer constraint foreignkey_coordinates_results references results on update cascade on delete cascade,
    x integer,
    y integer
);

create unique index coordinates_id_uindex
    on coordinates (id);

