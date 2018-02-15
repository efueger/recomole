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
-- Name: pid_loancount_test; Type: TABLE; Schema: public; Owner: lowell
--

CREATE TABLE pid_loancount_test (
    pid text NOT NULL,
    loancount integer
);


ALTER TABLE pid_loancount_test OWNER TO lowell;

--
-- Data for Name: pid_loancount_test; Type: TABLE DATA; Schema: public; Owner: lowell
--

COPY pid_loancount_test (pid, loancount) FROM stdin;
870970-basis:27925715	20287
870970-basis:51268172	28313
870970-basis:29705119	31916
870970-basis:44985292	5344
870970-basis:29758522	4336
870970-basis:51418298	2789
870970-basis:28511663	30033
870970-basis:28014228	4613
870970-basis:28044348	2693
870970-basis:27006051	3837
870970-basis:29213496	691
870970-basis:51139461	294
870970-basis:51139534	291
870970-basis:51139410	336
870970-basis:28075480	6440
870970-basis:28382782	3038
870970-basis:50710521	1018
870970-basis:24626989	844
870970-basis:29861811	841
870970-basis:50682471	334
870970-basis:29401691	3670
870970-basis:50710483	415
870970-basis:50682390	367
870970-basis:50953521	96
870970-basis:50790649	34
870970-basis:28243790	68
870970-basis:29440670	1026
870970-basis:28797869	930
870970-basis:29028877	512
870970-basis:28797826	1114
870970-basis:50682447	331
870970-basis:44829851	941
870970-basis:29213569	628
870970-basis:50741397	62
870970-basis:25246284	445
870970-basis:21936324	971
870970-basis:23481561	164
870970-basis:51562054	297
870970-basis:28578024	30
870970-basis:28507712	26
870970-basis:25225880	33
870970-basis:28554354	2
870970-basis:28685610	105
870970-basis:25225856	36
870970-basis:25225872	34
870970-basis:52236797	81
870970-basis:51920031	190
870970-basis:51920309	170
870970-basis:51920317	160
870970-basis:51588754	14
870970-basis:50953475	86
870970-basis:51565606	27
870970-basis:52024277	76
870970-basis:29872155	23
870970-basis:51728742	174
870970-basis:45662128	74
870970-basis:52088968	26
870970-basis:51581393	7
870970-basis:52770831	6
870970-basis:52932858	1
870970-basis:52932319	6
870970-basis:52602815	13
870970-basis:29949239	1
\.


--
-- Name: pid_loancount_test pid_loancount_test_pkey; Type: CONSTRAINT; Schema: public; Owner: lowell
--

ALTER TABLE ONLY pid_loancount_test
    ADD CONSTRAINT pid_loancount_test_pkey PRIMARY KEY (pid);


--
-- PostgreSQL database dump complete
--

