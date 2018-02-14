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
-- Name: metadata_test; Type: TABLE; Schema: public; Owner: lowell
--

CREATE TABLE metadata_test (
    pid text NOT NULL,
    nid integer NOT NULL,
    modified timestamp without time zone NOT NULL,
    metadata jsonb NOT NULL,
    deleted boolean NOT NULL
);


ALTER TABLE metadata_test OWNER TO lowell;

--
-- Data for Name: metadata_test; Type: TABLE DATA; Schema: public; Owner: lowell
--

COPY metadata_test (pid, nid, modified, metadata, deleted) FROM stdin;
870970-basis:23481561	1254247	2016-09-17 01:02:27.229	{"dk5": ["77.7"], "date": ["2001"], "type": ["Dvd"], "title": ["Batman forever"], "creator": ["Joel Schumacher"], "subject": ["Spillefilm", "det onde", "adventurefilm", "det gode", "helte"], "language": ["eng", "mul"], "contributor": ["Stephen Goldblatt", "Akiva Goldsman", "Joel Schumacher", "Janet Scott Batchler", "Nicole Kidman", "Chris O'Donnell", "Bob Kane", "Lee Batchler", "Val Kilmer", "Tommy Lee Jones", "Jim Carrey"], "subject_dbc": ["det onde", "adventurefilm", "det gode", "helte"]}	f
870970-basis:28685610	12736715	2017-05-10 17:53:11.966	{"dk5": ["77.7"], "date": ["2009"], "type": ["Blu-ray"], "title": ["Batman forever"], "creator": ["Joel Schumacher"], "subject": ["det onde", "Spillefilm", "det gode", "adventurefilm", "helte"], "language": ["mul", "eng"], "contributor": ["Chris O'Donnell", "Tommy Lee Jones", "Lee Batchler", "Akiva Goldsman", "Bob Kane", "Val Kilmer", "Jim Carrey", "Stephen Goldblatt", "Nicole Kidman", "Janet Scott Batchler", "Joel Schumacher"], "subject_dbc": ["det onde", "adventurefilm", "det gode", "helte"]}	f
870970-basis:29401691	20600641	2017-09-13 13:11:56.141	{"dk5": ["sk"], "date": ["2012"], "type": ["Bog"], "title": ["Kongernes kamp"], "creator": ["George R. R. Martin"], "subject": ["fantasy", "Skønlitteratur"], "language": ["dan"], "contributor": ["Steen Frimodt", "Anders Juel Michelsen"], "subject_dbc": ["fantasy"]}	f
870970-basis:29440670	5626007	2017-02-22 13:35:45.619	{"dk5": ["sk"], "date": ["2012"], "type": ["Lydbog (cd-mp3)"], "title": ["Kongernes kamp"], "creator": ["George R. R. Martin"], "subject": ["fantasy", "Skønlitteratur"], "language": ["dan"], "contributor": ["Anders Juel Michelsen", "Martin Greis"], "subject_dbc": ["fantasy"]}	f
870970-basis:29872155	1626370	2016-09-17 02:15:03.014	{"dk5": ["77.7"], "date": ["2013"], "type": ["Dvd"], "title": ["Batman forever"], "creator": ["Joel Schumacher"], "subject": ["Spillefilm"], "language": ["mul", "eng"], "contributor": ["Chris O'Donnell", "Tommy Lee Jones", "Lee Batchler", "Akiva Goldsman", "Bob Kane", "Val Kilmer", "Jim Carrey", "Stephen Goldblatt", "Nicole Kidman", "Janet Scott Batchler"]}	f
870970-basis:50741397	20600456	2018-02-13 09:54:38.056	{"dk5": ["sk"], "date": ["2013"], "type": ["Bog"], "title": ["Kongernes kamp"], "creator": ["George R. R. Martin"], "subject": ["Skønlitteratur", "fantasy"], "language": ["dan"], "contributor": ["Anders Juel Michelsen", "Steen Frimodt"], "subject_dbc": ["fantasy"]}	f
870970-basis:52602815	3112102	2016-10-05 16:10:31.332	{"dk5": ["77.7"], "date": ["2016"], "type": ["Blu-ray"], "title": ["Batman forever"], "creator": ["Joel Schumacher"], "subject": ["Spillefilm", "superhelte", "det onde", "amerikanske film", "det gode", "spillefilm"], "language": ["eng", "mul"], "contributor": ["Stephen Goldblatt", "Akiva Goldsman", "Janet Scott Batchler", "Nicole Kidman", "Chris O'Donnell", "Bob Kane", "Lee Batchler", "Val Kilmer", "Tommy Lee Jones", "Jim Carrey"], "subject_dbc": ["superhelte", "det onde", "amerikanske film", "det gode", "spillefilm"], "subject_dbc_o": ["spillefilm", "amerikanske film"]}	f
870970-basis:52770831	7625	2016-12-13 14:14:03.411	{"dk5": ["64.11"], "date": ["2016"], "type": ["Bog"], "title": ["Food from the fire"], "creator": ["Niklas Ekstedt"], "subject": ["bål", "Outdoor cooking", "kogebøger", "bålmad", "Cooking, Scandinavian", "madlavning", "Madlavning i alm. for særligt apparatur", "Food and Drink", "opskrifter"], "language": ["eng"], "contributor": ["Liz Haarala Hamilton", "Max Haarala Hamilton"], "subject_dbc": ["bål", "madlavning", "kogebøger", "opskrifter", "bålmad"], "subject_dbc_f": ["bål", "madlavning", "bålmad"], "subject_dbc_o": ["kogebøger", "opskrifter"]}	f
870970-basis:52932319	6394635	2017-03-15 16:25:16.211	{"dk5": ["78.7941"], "date": ["2016"], "type": ["Node"], "title": ["Just sing it!"], "subject": ["Danmark", "vokal", "2010-2019", "kor", "Antologier af rock og moderne folkemusik", "rock", "pop", "rytmisk kor"], "language": ["dan"], "contributor": ["Line Groth"], "subject_dbc": ["vokal", "kor", "rock", "pop", "rytmisk kor"], "subject_spat": ["Danmark"], "subject_temp": ["2010-2019"], "subject_dbc_m": ["vokal", "kor", "rock", "pop", "rytmisk kor"]}	f
870970-basis:52932858	5555493	2017-02-15 17:15:28.183	{"dk5": ["78.652"], "date": ["2017"], "type": ["Node"], "title": ["Runeskrift"], "creator": ["Jakob Høgsbro"], "subject": ["kor", "2010-2019", "vokal", "Danmark", "Musik for blandet kor", "rytmisk kor"], "language": ["dan"], "contributor": ["Rune T. Kidde", "Jakob Høgsbro", "Danske Folkekor"], "subject_dbc": ["kor", "rytmisk kor", "vokal"], "subject_spat": ["Danmark"], "subject_temp": ["2010-2019"], "subject_dbc_m": ["kor", "rytmisk kor", "vokal"]}	f
\.


--
-- Name: metadata_test metadata_test_pkey; Type: CONSTRAINT; Schema: public; Owner: lowell
--

ALTER TABLE ONLY metadata_test
    ADD CONSTRAINT metadata_test_pkey PRIMARY KEY (pid);


--
-- Name: metadata_test_doc_index; Type: INDEX; Schema: public; Owner: lowell
--

CREATE INDEX metadata_test_doc_index ON metadata_test USING gin (metadata);


--
-- Name: metadata_test_modified_index; Type: INDEX; Schema: public; Owner: lowell
--

CREATE INDEX metadata_test_modified_index ON metadata_test USING btree (modified);


--
-- Name: metadata_test_nid_index; Type: INDEX; Schema: public; Owner: lowell
--

CREATE INDEX metadata_test_nid_index ON metadata_test USING btree (nid);


--
-- PostgreSQL database dump complete
--

