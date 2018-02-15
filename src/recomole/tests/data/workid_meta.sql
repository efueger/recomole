--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: workid_meta; Type: TABLE; Schema: public; Owner: lowell
--

CREATE TABLE workid_meta (
    workid text NOT NULL,
    creator text,
    title text
);


ALTER TABLE workid_meta OWNER TO lowell;

--
-- Data for Name: workid_meta; Type: TABLE DATA; Schema: public; Owner: lowell
--

COPY workid_meta (workid, creator, title) FROM stdin;
work:10602093	Niklas Ekstedt	Food from the fire
work:1000042	George R. R. Martin	Kongernes kamp
work:4813157	Joel Schumacher	Batman forever
work:962083	Jussi Adler-Olsen	Journal 64
work:12601817		Just sing it!
work:677935	Jussi Adler-Olsen	Alfabethuset
work:1412991	Jussi Adler-Olsen	Den grænseløse
work:1011808	Jussi Adler-Olsen	Marco effekten
work:12601842	Jakob Høgsbro	Runeskrift
work:935152	Jussi Adler-Olsen	Flaskepost fra P
\.


--
-- Name: workid_meta workid_meta_pkey; Type: CONSTRAINT; Schema: public; Owner: lowell
--

ALTER TABLE ONLY workid_meta
    ADD CONSTRAINT workid_meta_pkey PRIMARY KEY (workid);


--
-- PostgreSQL database dump complete
--

