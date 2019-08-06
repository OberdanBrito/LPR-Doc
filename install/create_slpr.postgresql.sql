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
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 207 (class 1259 OID 33056)
-- Name: candidates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.candidates (
    id integer NOT NULL,
    results bigint,
    plate character varying(20),
    confidence double precision,
    matches_template integer
);


ALTER TABLE public.candidates OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 33054)
-- Name: candidates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.candidates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidates_id_seq OWNER TO postgres;

--
-- TOC entry 3182 (class 0 OID 0)
-- Dependencies: 206
-- Name: candidates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.candidates_id_seq OWNED BY public.candidates.id;


--
-- TOC entry 205 (class 1259 OID 33043)
-- Name: coordinates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coordinates (
    id integer NOT NULL,
    results bigint,
    x integer,
    y integer
);


ALTER TABLE public.coordinates OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 33041)
-- Name: coordinates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.coordinates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coordinates_id_seq OWNER TO postgres;

--
-- TOC entry 3183 (class 0 OID 0)
-- Dependencies: 204
-- Name: coordinates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.coordinates_id_seq OWNED BY public.coordinates.id;


--
-- TOC entry 201 (class 1259 OID 32988)
-- Name: job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job (
    filedate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id bigint NOT NULL,
    version character varying(50),
    data_type character varying(50),
    epoch_time real,
    img_width integer,
    img_height integer,
    processing_time_ms real,
    uuid character varying(50),
    camera_id integer,
    site_id character varying(50),
    company_id character varying(50)
);


ALTER TABLE public.job OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 32986)
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jobs_id_seq OWNER TO postgres;

--
-- TOC entry 3184 (class 0 OID 0)
-- Dependencies: 200
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.job.id;


--
-- TOC entry 203 (class 1259 OID 33021)
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regions (
    id integer NOT NULL,
    job bigint,
    x integer,
    y integer,
    width integer,
    weight integer
);


ALTER TABLE public.regions OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 33019)
-- Name: regions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.regions_id_seq OWNER TO postgres;

--
-- TOC entry 3185 (class 0 OID 0)
-- Dependencies: 202
-- Name: regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regions_id_seq OWNED BY public.regions.id;


--
-- TOC entry 199 (class 1259 OID 32974)
-- Name: results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.results (
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


ALTER TABLE public.results OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 32972)
-- Name: results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.results_id_seq OWNER TO postgres;

--
-- TOC entry 3186 (class 0 OID 0)
-- Dependencies: 198
-- Name: results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.results_id_seq OWNED BY public.results.id;


--
-- TOC entry 197 (class 1259 OID 32956)
-- Name: trace; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trace (
    filedate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id integer NOT NULL,
    epoch_time real,
    camera_id integer,
    company_id character varying(50),
    site_id character varying(50),
    uuid character varying(50),
    confidence real,
    plate character varying,
    processing_time_ms real,
    data_type character varying(50),
    img_height integer,
    img_width integer,
    regions_of_interest character varying,
    version character varying(50)
);


ALTER TABLE public.trace OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 32954)
-- Name: trace_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trace_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trace_id_seq OWNER TO postgres;

--
-- TOC entry 3187 (class 0 OID 0)
-- Dependencies: 196
-- Name: trace_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trace_id_seq OWNED BY public.trace.id;


--
-- TOC entry 3041 (class 2604 OID 33059)
-- Name: candidates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidates ALTER COLUMN id SET DEFAULT nextval('public.candidates_id_seq'::regclass);


--
-- TOC entry 3040 (class 2604 OID 33046)
-- Name: coordinates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coordinates ALTER COLUMN id SET DEFAULT nextval('public.coordinates_id_seq'::regclass);


--
-- TOC entry 3038 (class 2604 OID 32992)
-- Name: job id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- TOC entry 3039 (class 2604 OID 33024)
-- Name: regions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions ALTER COLUMN id SET DEFAULT nextval('public.regions_id_seq'::regclass);


--
-- TOC entry 3036 (class 2604 OID 32978)
-- Name: results id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results ALTER COLUMN id SET DEFAULT nextval('public.results_id_seq'::regclass);


--
-- TOC entry 3034 (class 2604 OID 32960)
-- Name: trace id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trace ALTER COLUMN id SET DEFAULT nextval('public.trace_id_seq'::regclass);


--
-- TOC entry 3051 (class 2606 OID 33061)
-- Name: candidates candidates_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidates
    ADD CONSTRAINT candidates_pk PRIMARY KEY (id);


--
-- TOC entry 3049 (class 2606 OID 33048)
-- Name: coordinates coordinates_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coordinates
    ADD CONSTRAINT coordinates_pk PRIMARY KEY (id);


--
-- TOC entry 3045 (class 2606 OID 33012)
-- Name: job jobs_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT jobs_pk PRIMARY KEY (id);


--
-- TOC entry 3047 (class 2606 OID 33026)
-- Name: regions regions_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pk PRIMARY KEY (id);


--
-- TOC entry 3043 (class 2606 OID 33016)
-- Name: results results_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_pk PRIMARY KEY (id);


--
-- TOC entry 3055 (class 2606 OID 33062)
-- Name: candidates foreignkey_candidates_results; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidates
    ADD CONSTRAINT foreignkey_candidates_results FOREIGN KEY (results) REFERENCES public.results(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3054 (class 2606 OID 33049)
-- Name: coordinates foreignkey_coordinates_results; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coordinates
    ADD CONSTRAINT foreignkey_coordinates_results FOREIGN KEY (results) REFERENCES public.results(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3053 (class 2606 OID 33027)
-- Name: regions foreignkey_regions_jobs; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT foreignkey_regions_jobs FOREIGN KEY (job) REFERENCES public.job(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3052 (class 2606 OID 33036)
-- Name: results foreignkey_results_jobs; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT foreignkey_results_jobs FOREIGN KEY (job) REFERENCES public.job(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2019-08-04 10:28:39 -03

--
-- PostgreSQL database dump complete
--
