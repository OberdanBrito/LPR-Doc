--
-- PostgreSQL database dump
--

-- Dumped from database version 11.3
-- Dumped by pg_dump version 11.3

-- Started on 2019-08-04 10:28:38 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;


create table client.info
(
    filedate timestamp default CURRENT_TIMESTAMP not null,
    id serial not null
        constraint info_pk
            primary key,
    nome varchar(255) not null
);

alter table client.info owner to postgres;

create unique index info_id_uindex
    on client.info (id);



create table client.site
(
    clientid integer
        constraint site_info_fk
            references client.info
            on update cascade on delete cascade,
    id serial not null
        constraint site_pk
            primary key
);

alter table client.site owner to postgres;

create unique index site_id_uindex
    on client.site (id);




CREATE TABLE jobs.candidates (
    id integer NOT NULL,
    results bigint,
    plate character varying(20),
    confidence double precision,
    matches_template integer
);


ALTER TABLE jobs.candidates OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 33054)
-- Name: candidates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE jobs.candidates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE jobs.candidates_id_seq OWNER TO postgres;

--
-- TOC entry 3182 (class 0 OID 0)
-- Dependencies: 206
-- Name: candidates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE jobs.candidates_id_seq OWNED BY jobs.candidates.id;


--
-- TOC entry 205 (class 1259 OID 33043)
-- Name: coordinates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE jobs.coordinates (
    id integer NOT NULL,
    results bigint,
    x integer,
    y integer
);


ALTER TABLE jobs.coordinates OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 33041)
-- Name: coordinates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE jobs.coordinates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE jobs.coordinates_id_seq OWNER TO postgres;

--
-- TOC entry 3183 (class 0 OID 0)
-- Dependencies: 204
-- Name: coordinates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE jobs.coordinates_id_seq OWNED BY jobs.coordinates.id;


--
-- TOC entry 201 (class 1259 OID 32988)
-- Name: job; Type: TABLE; Schema: public; Owner: postgres
--

create table jobs.job
(
    filedate timestamp default CURRENT_TIMESTAMP not null,
    id bigserial not null
        constraint jobs_pk
            primary key,
    version varchar(50),
    data_type varchar(50),
    epoch_time real,
    img_width integer,
    img_height integer,
    processing_time_ms real,
    uuid varchar(50),
    camera_id integer,
    site_id integer
        constraint job_site__fk
            references client.site
            on update cascade on delete cascade,
    company_id integer
);

alter table jobs.job owner to postgres;

ALTER TABLE jobs.job OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 32986)
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE jobs.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE jobs.jobs_id_seq OWNER TO postgres;

--
-- TOC entry 3184 (class 0 OID 0)
-- Dependencies: 200
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE jobs.jobs_id_seq OWNED BY jobs.job.id;


--
-- TOC entry 203 (class 1259 OID 33021)
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE jobs.regions (
    id integer NOT NULL,
    job bigint,
    x integer,
    y integer,
    width integer,
    weight integer
);


ALTER TABLE jobs.regions OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 33019)
-- Name: regions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE jobs.regions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE jobs.regions_id_seq OWNER TO postgres;

--
-- TOC entry 3185 (class 0 OID 0)
-- Dependencies: 202
-- Name: regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE jobs.regions_id_seq OWNED BY jobs.regions.id;


--
-- TOC entry 199 (class 1259 OID 32974)
-- Name: results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE jobs.results (
    filedate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id integer NOT NULL,
    job bigint,
    plate character varying(20),
    confidence double precision,
    matches_template double precision,
    plate_index integer,
    region character varying(5),
    region_confidence integer,
    processing_time_ms double precision,
    requested_topn integer
);


ALTER TABLE jobs.results OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 32972)
-- Name: results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE jobs.results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE jobs.results_id_seq OWNER TO postgres;

--
-- TOC entry 3186 (class 0 OID 0)
-- Dependencies: 198
-- Name: results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE jobs.results_id_seq OWNED BY jobs.results.id;


--
-- TOC entry 3041 (class 2604 OID 33059)
-- Name: candidates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jobs.candidates ALTER COLUMN id SET DEFAULT nextval('jobs.candidates_id_seq'::regclass);


--
-- TOC entry 3040 (class 2604 OID 33046)
-- Name: coordinates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jobs.coordinates ALTER COLUMN id SET DEFAULT nextval('jobs.coordinates_id_seq'::regclass);


--
-- TOC entry 3038 (class 2604 OID 32992)
-- Name: job id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jobs.job ALTER COLUMN id SET DEFAULT nextval('jobs.jobs_id_seq'::regclass);


--
-- TOC entry 3039 (class 2604 OID 33024)
-- Name: regions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jobs.regions ALTER COLUMN id SET DEFAULT nextval('jobs.regions_id_seq'::regclass);


--
-- TOC entry 3036 (class 2604 OID 32978)
-- Name: results id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jobs.results ALTER COLUMN id SET DEFAULT nextval('jobs.results_id_seq'::regclass);


--
-- TOC entry 3051 (class 2606 OID 33061)
-- Name: candidates candidates_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jobs.candidates
    ADD CONSTRAINT candidates_pk PRIMARY KEY (id);


--
-- TOC entry 3049 (class 2606 OID 33048)
-- Name: coordinates coordinates_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jobs.coordinates
    ADD CONSTRAINT coordinates_pk PRIMARY KEY (id);


--
-- TOC entry 3045 (class 2606 OID 33012)
-- Name: job jobs_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jobs.job
    ADD CONSTRAINT jobs_pk PRIMARY KEY (id);


--
-- TOC entry 3047 (class 2606 OID 33026)
-- Name: regions regions_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jobs.regions
    ADD CONSTRAINT regions_pk PRIMARY KEY (id);


--
-- TOC entry 3043 (class 2606 OID 33016)
-- Name: results results_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jobs.results
    ADD CONSTRAINT results_pk PRIMARY KEY (id);


--
-- TOC entry 3055 (class 2606 OID 33062)
-- Name: candidates foreignkey_candidates_results; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jobs.candidates
    ADD CONSTRAINT foreignkey_candidates_results FOREIGN KEY (results) REFERENCES jobs.results(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3054 (class 2606 OID 33049)
-- Name: coordinates foreignkey_coordinates_results; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jobs.coordinates
    ADD CONSTRAINT foreignkey_coordinates_results FOREIGN KEY (results) REFERENCES jobs.results(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3053 (class 2606 OID 33027)
-- Name: regions foreignkey_regions_jobs; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jobs.regions
    ADD CONSTRAINT foreignkey_regions_jobs FOREIGN KEY (job) REFERENCES jobs.job(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3052 (class 2606 OID 33036)
-- Name: results foreignkey_results_jobs; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jobs.results
    ADD CONSTRAINT foreignkey_results_jobs FOREIGN KEY (job) REFERENCES jobs.job(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2019-08-04 10:28:39 -03

--
-- PostgreSQL database dump complete
--

