--
-- PostgreSQL database dump
--

-- Dumped from database version 11.3
-- Dumped by pg_dump version 11.3

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
-- Name: trace_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trace_id_seq OWNED BY public.trace.id;


--
-- Name: trace id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trace ALTER COLUMN id SET DEFAULT nextval('public.trace_id_seq'::regclass);


--
-- Data for Name: trace; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.trace (filedate, id, epoch_time, camera_id, company_id, site_id, uuid, confidence, plate, processing_time_ms, data_type, img_height, img_width, regions_of_interest, version) VALUES ('2019-07-30 15:11:12.053982', 1, 1.56449466e+12, 1, 'craos', 'p1', 'p1-cam1-1564494609196', 84.4809647, '3OD5O82', 220.492783, 'alpr_results', 720, 1280, '{}', '2');
INSERT INTO public.trace (filedate, id, epoch_time, camera_id, company_id, site_id, uuid, confidence, plate, processing_time_ms, data_type, img_height, img_width, regions_of_interest, version) VALUES ('2019-07-30 15:12:26.971836', 2, 1.56449466e+12, 1, 'craos', 'p1', 'p1-cam1-1564494609196', 84.4809647, '3OD5O82', 220.492783, 'alpr_results', 720, 1280, '{}', '2');
INSERT INTO public.trace (filedate, id, epoch_time, camera_id, company_id, site_id, uuid, confidence, plate, processing_time_ms, data_type, img_height, img_width, regions_of_interest, version) VALUES ('2019-07-30 15:14:19.325446', 3, 1.56449466e+12, 1, 'craos', 'p1', 'p1-cam1-1564494609196', 84.4809647, '3OD5O82', 220.492783, 'alpr_results', 720, 1280, '{}', '2');
INSERT INTO public.trace (filedate, id, epoch_time, camera_id, company_id, site_id, uuid, confidence, plate, processing_time_ms, data_type, img_height, img_width, regions_of_interest, version) VALUES ('2019-07-30 15:14:45.912201', 4, 1.56449466e+12, 1, 'craos', 'p1', 'p1-cam1-1564494609196', 84.4809647, '3OD5O82', 220.492783, 'alpr_results', 720, 1280, '{}', '2');


--
-- Name: trace_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trace_id_seq', 4, true);


--
-- PostgreSQL database dump complete
--

