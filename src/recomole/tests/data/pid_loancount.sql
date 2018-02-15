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
-- Name: pid_loancount; Type: TABLE; Schema: public; Owner: lowell
--

CREATE TABLE pid_loancount (
    pid text NOT NULL,
    loancount integer
);


ALTER TABLE pid_loancount OWNER TO lowell;

--
-- Data for Name: pid_loancount; Type: TABLE DATA; Schema: public; Owner: lowell
--

COPY pid_loancount (pid, loancount) FROM stdin;
870970-basis:23481561	164
870970-basis:28685610	105
870970-basis:29401691	3670
870970-basis:29440670	1026
870970-basis:29872155	23
870970-basis:50741397	62
870970-basis:52602815	13
870970-basis:52770831	6
870970-basis:52932319	6
870970-basis:52932858	1
\.


--
-- Name: pid_loancount pid_loancount_pkey; Type: CONSTRAINT; Schema: public; Owner: lowell
--

ALTER TABLE ONLY pid_loancount
    ADD CONSTRAINT pid_loancount_pkey PRIMARY KEY (pid);


--
-- PostgreSQL database dump complete
--

