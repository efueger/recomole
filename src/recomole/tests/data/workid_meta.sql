--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: workid_meta_test; Type: TABLE; Schema: public; Owner: lowell
--

CREATE TABLE workid_meta_test (
    workid text NOT NULL,
    creator text,
    title text
);


ALTER TABLE workid_meta_test OWNER TO lowell;

--
-- Data for Name: workid_meta_test; Type: TABLE DATA; Schema: public; Owner: lowell
--

COPY workid_meta_test (workid, creator, title) FROM stdin;
work:10602093	Niklas Ekstedt	Food from the fire
work:12601817		Just sing it!
work:4813157	Joel Schumacher	Batman forever
work:1000042	George R. R. Martin	Kongernes kamp
work:12601842	Jakob Høgsbro	Runeskrift
\.


--
-- Name: workid_meta_test workid_meta_test_pkey; Type: CONSTRAINT; Schema: public; Owner: lowell
--

ALTER TABLE ONLY workid_meta_test
    ADD CONSTRAINT workid_meta_test_pkey PRIMARY KEY (workid);


--
-- PostgreSQL database dump complete
--
