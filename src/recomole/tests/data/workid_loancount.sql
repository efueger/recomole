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
-- Name: workid_loancount; Type: TABLE; Schema: public; Owner: lowell
--

CREATE TABLE workid_loancount (
    workid text NOT NULL,
    loancount integer
);


ALTER TABLE workid_loancount OWNER TO lowell;

--
-- Data for Name: workid_loancount; Type: TABLE DATA; Schema: public; Owner: lowell
--

COPY workid_loancount (workid, loancount) FROM stdin;
work:10602093	6
work:1000042	4758
work:4813157	305
work:962083	38737
work:12601817	6
work:677935	16737
work:1412991	31946
work:1011808	38201
work:12601842	1
work:935152	31063
\.


--
-- Name: workid_loancount workid_loancount_pkey; Type: CONSTRAINT; Schema: public; Owner: lowell
--

ALTER TABLE ONLY workid_loancount
    ADD CONSTRAINT workid_loancount_pkey PRIMARY KEY (workid);


--
-- PostgreSQL database dump complete
--

