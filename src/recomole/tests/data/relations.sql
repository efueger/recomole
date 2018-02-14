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
-- Name: relations; Type: TABLE; Schema: public; Owner: lowell
--

CREATE TABLE relations (
    pid text NOT NULL,
    workid text NOT NULL,
    unitid text NOT NULL,
    modified timestamp without time zone NOT NULL,
    deleted boolean NOT NULL
);


ALTER TABLE relations OWNER TO lowell;

--
-- Data for Name: relations; Type: TABLE DATA; Schema: public; Owner: lowell
--

COPY relations (pid, workid, unitid, modified, deleted) FROM stdin;
870970-basis:23481561	work:4813157	unit:885811	2016-09-21 00:30:54.945	f
870970-basis:28685610	work:4813157	unit:1164913	2017-06-19 08:19:08.095	f
870970-basis:29401691	work:1000042	unit:1206132	2017-12-19 19:14:19.097	f
870970-basis:29440670	work:1000042	unit:1208674	2017-12-19 19:14:19.064	f
870970-basis:29872155	work:4813157	unit:5594360	2016-09-21 00:30:56.899	f
870970-basis:50741397	work:1000042	unit:1739516	2017-12-19 19:14:19.081	f
870970-basis:52602815	work:4813157	unit:9535793	2016-10-05 16:36:26.768	f
870970-basis:52770831	work:10602093	unit:12040753	2016-12-13 14:14:03.411	f
870970-basis:52932319	work:12601817	unit:14262292	2017-06-19 13:42:11.382	f
870970-basis:52932858	work:12601842	unit:14262326	2017-06-19 13:42:05.46	f
\.


--
-- Name: relations relations_pkey; Type: CONSTRAINT; Schema: public; Owner: lowell
--

ALTER TABLE ONLY relations
    ADD CONSTRAINT relations_pkey PRIMARY KEY (pid);


--
-- Name: relations_modified_index; Type: INDEX; Schema: public; Owner: lowell
--

CREATE INDEX relations_modified_index ON relations USING btree (modified);


--
-- Name: relations_unitid_index; Type: INDEX; Schema: public; Owner: lowell
--

CREATE INDEX relations_unitid_index ON relations USING btree (unitid);


--
-- Name: relations_workid_index; Type: INDEX; Schema: public; Owner: lowell
--

CREATE INDEX relations_workid_index ON relations USING btree (workid);


--
-- PostgreSQL database dump complete
--

