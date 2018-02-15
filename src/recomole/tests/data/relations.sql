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
-- Name: relations_test; Type: TABLE; Schema: public; Owner: lowell
--

CREATE TABLE relations_test (
    pid text NOT NULL,
    workid text NOT NULL,
    unitid text NOT NULL,
    modified timestamp without time zone NOT NULL,
    deleted boolean NOT NULL
);


ALTER TABLE relations_test OWNER TO lowell;

--
-- Data for Name: relations_test; Type: TABLE DATA; Schema: public; Owner: lowell
--

COPY relations_test (pid, workid, unitid, modified, deleted) FROM stdin;
125610-katalog:28014228	work:935152	unit:1125201	2017-12-19 20:22:50.337	f
125610-katalog:28044348	work:677935	unit:1126823	2017-12-19 20:22:55.143	f
125610-katalog:28075480	work:677935	unit:1128721	2018-01-26 18:44:58.308	f
125610-katalog:28578024	work:935152	unit:1157919	2017-12-19 20:22:53.81	f
125610-katalog:29716560	work:962083	unit:1223518	2017-12-19 20:22:49.05	f
125610-katalog:29758522	work:1011808	unit:1225882	2017-12-19 20:22:50.684	f
125610-katalog:44985292	work:962083	unit:1644388	2017-12-19 20:22:49.54	f
125610-katalog:50710483	work:962083	unit:1737609	2017-12-19 20:22:54.829	f
125610-katalog:50710521	work:935152	unit:1737614	2017-12-19 20:22:54.625	f
125610-katalog:51268172	work:1412991	unit:1769690	2017-12-19 20:22:50.629	f
125610-katalog:51418298	work:1412991	unit:1778442	2017-12-19 20:22:55.538	f
125610-katalog:51565606	work:1011808	unit:1787274	2017-12-19 20:22:55.552	f
300157-katalog:111417105	work:1011808	unit:1236033	2018-01-26 19:52:38.211	f
300787-katalog:104827594	work:1011808	unit:9694811	2017-12-19 20:22:49.413	f
700400-katalog:115037927	work:1011808	unit:27377917	2017-12-19 20:22:54.637	f
778700-katalog:104858635	work:1011808	unit:9694811	2017-12-19 20:22:49.413	f
781000-katalog:105397054	work:677935	unit:938974	2017-12-19 20:22:54.085	f
810010-katalog:007943421	work:935152	unit:1119901	2017-12-19 20:22:54.585	f
810010-katalog:007979189	work:677935	unit:1128721	2018-01-26 18:44:58.308	f
810010-katalog:008051108	work:962083	unit:1154077	2017-12-19 20:22:50.741	f
810010-katalog:008509006	work:1011808	unit:1223019	2017-12-19 20:22:54.533	f
810010-katalog:008894613	work:1412991	unit:1769690	2017-12-19 20:22:50.629	f
810015-katalog:001796045	work:677935	unit:799121	2017-12-19 20:22:53.968	f
810015-katalog:002680383	work:677935	unit:938974	2017-12-19 20:22:54.085	f
810015-katalog:002716346	work:677935	unit:940297	2017-12-19 20:22:50.246	f
810015-katalog:007121321	work:677935	unit:1067836	2017-12-19 20:22:54.273	f
810015-katalog:007942988	work:935152	unit:1119901	2017-12-19 20:22:54.585	f
810015-katalog:007972325	work:935152	unit:1126850	2017-12-19 20:22:49.188	f
810015-katalog:008006404	work:677935	unit:1137938	2017-12-19 20:22:55.396	f
810015-katalog:008006405	work:677935	unit:1138435	2017-12-19 20:22:54.389	f
810015-katalog:008056249	work:935152	unit:1153778	2017-12-19 20:22:50.324	f
810015-katalog:008058391	work:962083	unit:1154077	2017-12-19 20:22:50.741	f
810015-katalog:008064081	work:935152	unit:1157919	2017-12-19 20:22:53.81	f
810015-katalog:008065054	work:677935	unit:1156592	2017-12-19 20:22:50.266	f
810015-katalog:008082426	work:962083	unit:1161374	2017-12-19 20:22:54.556	f
810015-katalog:008152305	work:935152	unit:1165886	2017-12-19 20:22:53.849	f
810015-katalog:008153306	work:677935	unit:1128721	2018-01-26 18:44:58.308	f
810015-katalog:008154828	work:935152	unit:1146309	2017-12-19 20:22:54.942	f
810015-katalog:008211273	work:962083	unit:1187417	2017-12-19 20:22:53.947	f
810015-katalog:008292949	work:962083	unit:1185526	2017-12-19 20:22:55.132	f
810015-katalog:008310866	work:962083	unit:1191327	2017-12-19 20:22:54.111	f
810015-katalog:008310867	work:962083	unit:1191843	2017-12-19 20:22:49.093	f
810015-katalog:008334090__1	work:962083	unit:5492221	2017-12-19 20:22:50.71	f
810015-katalog:008334091__1	work:962083	unit:5492221	2017-12-19 20:22:50.71	f
810015-katalog:008532390	work:1011808	unit:1223019	2017-12-19 20:22:54.533	f
810015-katalog:008533981	work:962083	unit:1223518	2017-12-19 20:22:49.05	f
810015-katalog:008536807	work:962083	unit:1224026	2017-12-19 20:22:55.633	f
810015-katalog:008542029	work:1011808	unit:1226859	2017-12-19 20:22:50.722	f
810015-katalog:008570978	work:1011808	unit:1225369	2017-12-19 20:22:55.43	f
810015-katalog:008574122	work:1011808	unit:1236033	2018-01-26 19:52:38.211	f
810015-katalog:008669496__1	work:1011808	unit:5567057	2017-12-19 20:22:54.462	f
810015-katalog:008669497__1	work:1011808	unit:5567057	2017-12-19 20:22:54.462	f
810015-katalog:008669498__1	work:1011808	unit:5567057	2017-12-19 20:22:54.462	f
810015-katalog:008809359	work:962083	unit:1737609	2017-12-19 20:22:54.829	f
810015-katalog:008809360	work:935152	unit:1737614	2017-12-19 20:22:54.625	f
810015-katalog:008854296__1	work:935152	unit:5505566	2017-12-19 20:22:55.689	f
810015-katalog:008854297__1	work:935152	unit:5505566	2017-12-19 20:22:55.689	f
810015-katalog:008854298__1	work:935152	unit:5505566	2017-12-19 20:22:55.689	f
810015-katalog:008893878	work:1412991	unit:1769690	2017-12-19 20:22:50.629	f
810015-katalog:008939871	work:1412991	unit:1783807	2017-12-19 20:22:55.228	f
810015-katalog:009127441	work:677935	unit:1786953	2017-12-19 20:22:49.353	f
810015-katalog:009127449	work:1011808	unit:1787274	2017-12-19 20:22:55.552	f
810015-katalog:009160224__1	work:1412991	unit:5461388	2017-12-19 20:22:55.3	f
810015-katalog:009160225__1	work:1412991	unit:5461388	2017-12-19 20:22:55.3	f
810015-katalog:009160226__1	work:1412991	unit:5461388	2017-12-19 20:22:55.3	f
810015-katalog:009180921	work:962083	unit:4467585	2017-12-19 20:22:54.176	f
810015-katalog:009180922	work:935152	unit:4467587	2017-12-19 20:22:53.996	f
810015-katalog:009180947	work:1011808	unit:4468635	2017-12-19 20:22:50.135	f
810015-katalog:009187976	work:935152	unit:5041960	2017-12-19 20:22:55.463	f
810015-katalog:009197450	work:677935	unit:5072878	2017-12-19 20:22:55.109	f
810015-katalog:009269633	work:1412991	unit:4424736	2017-12-19 20:22:54.06	f
810015-katalog:009270974	work:935152	unit:5080306	2017-12-19 20:22:50.065	f
810015-katalog:009286094	work:1412991	unit:11398509	2017-12-19 20:22:49.647	f
820010-katalog:2537469	work:677935	unit:940297	2017-12-19 20:22:50.246	f
820010-katalog:2564790	work:677935	unit:938974	2017-12-19 20:22:54.085	f
820010-katalog:3215940	work:677935	unit:1067836	2017-12-19 20:22:54.273	f
820010-katalog:3546292	work:935152	unit:1119901	2017-12-19 20:22:54.585	f
820010-katalog:3660568	work:935152	unit:1126850	2017-12-19 20:22:49.188	f
820010-katalog:3764425	work:935152	unit:1125201	2017-12-19 20:22:50.337	f
820010-katalog:3764477	work:677935	unit:1630877	2017-12-19 20:22:55.704	f
820010-katalog:3801087	work:962083	unit:1154077	2017-12-19 20:22:50.741	f
820010-katalog:4428885	work:935152	unit:1153778	2017-12-19 20:22:50.324	f
820010-katalog:4430719	work:935152	unit:1157919	2017-12-19 20:22:53.81	f
820010-katalog:4431574	work:677935	unit:1156592	2017-12-19 20:22:50.266	f
820010-katalog:4445735	work:962083	unit:1161374	2017-12-19 20:22:54.556	f
820010-katalog:4466213	work:935152	unit:1165886	2017-12-19 20:22:53.849	f
820010-katalog:4476405	work:677935	unit:1128721	2018-01-26 18:44:58.308	f
820010-katalog:5247324	work:935152	unit:1146309	2017-12-19 20:22:54.942	f
820010-katalog:542540	work:677935	unit:799121	2017-12-19 20:22:53.968	f
820010-katalog:5458939	work:962083	unit:1187417	2017-12-19 20:22:53.947	f
820010-katalog:5467066	work:962083	unit:1185526	2017-12-19 20:22:55.132	f
820010-katalog:5467067	work:962083	unit:1191327	2017-12-19 20:22:54.111	f
820010-katalog:5497468__1	work:962083	unit:5492221	2017-12-19 20:22:50.71	f
820010-katalog:5497468__2	work:962083	unit:5492221	2017-12-19 20:22:50.71	f
820010-katalog:5559696	work:1011808	unit:1223019	2017-12-19 20:22:54.533	f
820010-katalog:5566570	work:962083	unit:1223518	2017-12-19 20:22:49.05	f
820010-katalog:5578504	work:1011808	unit:1225882	2017-12-19 20:22:50.684	f
820010-katalog:5578905	work:962083	unit:1224026	2017-12-19 20:22:55.633	f
820010-katalog:5584855	work:1011808	unit:1226859	2017-12-19 20:22:50.722	f
820010-katalog:5930438	work:1011808	unit:1225369	2017-12-19 20:22:55.43	f
820010-katalog:6038156__1	work:1011808	unit:5567057	2017-12-19 20:22:54.462	f
820010-katalog:6038156__2	work:1011808	unit:5567057	2017-12-19 20:22:54.462	f
820010-katalog:6038156__3	work:1011808	unit:5567057	2017-12-19 20:22:54.462	f
820010-katalog:6098721__1	work:935152	unit:5505566	2017-12-19 20:22:55.689	f
820010-katalog:6098721__2	work:935152	unit:5505566	2017-12-19 20:22:55.689	f
820010-katalog:6098721__3	work:935152	unit:5505566	2017-12-19 20:22:55.689	f
820010-katalog:6102174	work:935152	unit:1737614	2017-12-19 20:22:54.625	f
820010-katalog:6102175	work:962083	unit:1737609	2017-12-19 20:22:54.829	f
820010-katalog:6102781	work:1412991	unit:1769690	2017-12-19 20:22:50.629	f
820010-katalog:6124273	work:1412991	unit:1778442	2017-12-19 20:22:55.538	f
820010-katalog:6139595	work:1412991	unit:1783807	2017-12-19 20:22:55.228	f
820010-katalog:6199400__1	work:1412991	unit:5461388	2017-12-19 20:22:55.3	f
820010-katalog:6199400__2	work:1412991	unit:5461388	2017-12-19 20:22:55.3	f
820010-katalog:6199400__3	work:1412991	unit:5461388	2017-12-19 20:22:55.3	f
820010-katalog:6212636	work:962083	unit:4467585	2017-12-19 20:22:54.176	f
820010-katalog:6212646	work:935152	unit:4467587	2017-12-19 20:22:53.996	f
820010-katalog:6212649	work:1011808	unit:4468635	2017-12-19 20:22:50.135	f
820010-katalog:6214023	work:677935	unit:1786953	2017-12-19 20:22:49.353	f
820010-katalog:6214024	work:1011808	unit:1787274	2017-12-19 20:22:55.552	f
820010-katalog:6215641	work:935152	unit:5041960	2017-12-19 20:22:55.463	f
820010-katalog:6230166	work:677935	unit:5072878	2017-12-19 20:22:55.109	f
820010-katalog:6241095	work:677935	unit:1126823	2017-12-19 20:22:55.143	f
820010-katalog:6283843	work:1412991	unit:11398509	2017-12-19 20:22:49.647	f
820010-katalog:6306343	work:935152	unit:5080306	2017-12-19 20:22:50.065	f
820030-katalog:1199299	work:962083	unit:1154077	2017-12-19 20:22:50.741	f
820030-katalog:1226035	work:677935	unit:1128721	2018-01-26 18:44:58.308	f
820030-katalog:1226038	work:935152	unit:1146309	2017-12-19 20:22:54.942	f
820030-katalog:1938701	work:1412991	unit:1769690	2017-12-19 20:22:50.629	f
820030-katalog:1938702	work:1011808	unit:1223019	2017-12-19 20:22:54.533	f
820050-katalog:001323673	work:677935	unit:938974	2017-12-19 20:22:54.085	f
820050-katalog:001616413	work:935152	unit:1119901	2017-12-19 20:22:54.585	f
820050-katalog:001682175	work:962083	unit:1154077	2017-12-19 20:22:50.741	f
820050-katalog:001772799	work:1011808	unit:1223019	2017-12-19 20:22:54.533	f
820050-katalog:001863500	work:1412991	unit:1769690	2017-12-19 20:22:50.629	f
861060-katalog:27006051	work:677935	unit:1067836	2017-12-19 20:22:54.273	f
870970-basis:21936324	work:677935	unit:799121	2017-12-19 20:22:53.968	f
870970-basis:23481561	work:4813157	unit:885811	2016-09-21 00:30:54.945	f
870970-basis:24626989	work:677935	unit:938974	2017-12-19 20:22:54.085	f
870970-basis:24654397	work:677935	unit:940297	2017-12-19 20:22:50.246	f
870970-basis:25225856	work:677935	unit:5477789	2017-12-19 20:22:50.753	f
870970-basis:25225872	work:677935	unit:5478445	2017-12-19 20:22:54.413	f
870970-basis:25225880	work:677935	unit:5478454	2017-12-19 20:22:54.189	f
870970-basis:25246284	work:677935	unit:970418	2017-12-19 20:22:49.677	f
870970-basis:27006051	work:677935	unit:1067836	2017-12-19 20:22:54.273	f
870970-basis:27925715	work:935152	unit:1119901	2017-12-19 20:22:54.585	f
870970-basis:28014228	work:935152	unit:1125201	2017-12-19 20:22:50.337	f
870970-basis:28043872	work:935152	unit:1126850	2017-12-19 20:22:49.188	f
870970-basis:28044348	work:677935	unit:1126823	2017-12-19 20:22:55.143	f
870970-basis:28075480	work:677935	unit:1128721	2018-01-26 18:44:58.308	f
870970-basis:28243790	work:677935	unit:1137938	2017-12-19 20:22:55.396	f
870970-basis:28245106	work:677935	unit:1138435	2017-12-19 20:22:54.389	f
870970-basis:28382782	work:935152	unit:1146309	2017-12-19 20:22:54.942	f
870970-basis:28507712	work:935152	unit:1153778	2017-12-19 20:22:50.324	f
870970-basis:28511663	work:962083	unit:1154077	2017-12-19 20:22:50.741	f
870970-basis:28554354	work:677935	unit:1156592	2017-12-19 20:22:50.266	f
870970-basis:28578024	work:935152	unit:1157919	2017-12-19 20:22:53.81	f
870970-basis:28634560	work:962083	unit:1161374	2017-12-19 20:22:54.556	f
870970-basis:28685610	work:4813157	unit:1164913	2017-06-19 08:19:08.095	f
870970-basis:28713614	work:935152	unit:1165886	2017-12-19 20:22:53.849	f
870970-basis:28797826	work:962083	unit:1171267	2017-12-19 20:22:54.246	f
870970-basis:28797869	work:935152	unit:1171268	2017-12-19 20:22:54.257	f
870970-basis:29028877	work:962083	unit:1185526	2017-12-19 20:22:55.132	f
870970-basis:29060649	work:962083	unit:1187417	2017-12-19 20:22:53.947	f
870970-basis:29145075	work:962083	unit:1191327	2017-12-19 20:22:54.111	f
870970-basis:29145083	work:962083	unit:1191843	2017-12-19 20:22:49.093	f
870970-basis:29213496	work:962083	unit:25054445	2017-12-19 20:22:50.477	f
870970-basis:29213569	work:962083	unit:5709955	2017-12-19 20:22:50.697	f
870970-basis:29401691	work:1000042	unit:1206132	2017-12-19 19:14:19.097	f
870970-basis:29440670	work:1000042	unit:1208674	2017-12-19 19:14:19.064	f
870970-basis:29705119	work:1011808	unit:1223019	2017-12-19 20:22:54.533	f
870970-basis:29716560	work:962083	unit:1223518	2017-12-19 20:22:49.05	f
870970-basis:29726795	work:962083	unit:1224026	2017-12-19 20:22:55.633	f
870970-basis:29754519	work:1011808	unit:1225369	2017-12-19 20:22:55.43	f
870970-basis:29758522	work:1011808	unit:1225882	2017-12-19 20:22:50.684	f
870970-basis:29785090	work:1011808	unit:1226859	2017-12-19 20:22:50.722	f
870970-basis:29861811	work:1011808	unit:1231019	2017-12-19 20:22:49.472	f
870970-basis:29872155	work:4813157	unit:5594360	2016-09-21 00:30:56.899	f
870970-basis:29949239	work:1011808	unit:1236033	2018-01-26 19:52:38.211	f
870970-basis:44829851	work:677935	unit:1630877	2017-12-19 20:22:55.704	f
870970-basis:44985292	work:962083	unit:1644388	2017-12-19 20:22:49.54	f
870970-basis:45662128	work:1412991	unit:1702369	2017-12-19 20:22:49.8	f
870970-basis:50682390	work:1011808	unit:25054444	2017-12-19 20:22:50.513	f
870970-basis:50682447	work:1011808	unit:5583479	2017-12-19 20:22:55.476	f
870970-basis:50682471	work:1011808	unit:5651033	2017-12-19 20:22:49.87	f
870970-basis:50710483	work:962083	unit:1737609	2017-12-19 20:22:54.829	f
870970-basis:50710521	work:935152	unit:1737614	2017-12-19 20:22:54.625	f
870970-basis:50741397	work:1000042	unit:1739516	2017-12-19 19:14:19.081	f
870970-basis:50790649	work:1011808	unit:1742549	2017-12-19 20:22:53.874	f
870970-basis:50953475	work:935152	unit:1751434	2017-12-19 20:22:55.191	f
870970-basis:50953521	work:677935	unit:1751438	2017-12-19 20:22:55.201	f
870970-basis:51139410	work:935152	unit:5803326	2017-12-19 20:22:55.348	f
870970-basis:51139461	work:935152	unit:5524345	2017-12-19 20:22:53.93	f
870970-basis:51139534	work:935152	unit:5505566	2017-12-19 20:22:55.689	f
870970-basis:51268172	work:1412991	unit:1769690	2017-12-19 20:22:50.629	f
870970-basis:51418298	work:1412991	unit:1778442	2017-12-19 20:22:55.538	f
870970-basis:51418328	work:1412991	unit:1778555	2017-12-19 20:22:55.745	f
870970-basis:51488539	work:1011808	unit:1782831	2017-12-19 20:22:55.289	f
870970-basis:51515765	work:1412991	unit:1783807	2017-12-19 20:22:55.228	f
870970-basis:51562054	work:677935	unit:1786953	2017-12-19 20:22:49.353	f
870970-basis:51565606	work:1011808	unit:1787274	2017-12-19 20:22:55.552	f
870970-basis:51581393	work:935152	unit:1788156	2017-12-19 20:22:54.886	f
870970-basis:51581415	work:935152	unit:1788173	2017-12-19 20:22:54.43	f
870970-basis:51588754	work:1011808	unit:1788615	2017-12-19 20:22:54.367	f
870970-basis:51728742	work:1412991	unit:1797444	2017-12-19 20:22:50.597	f
870970-basis:51920031	work:1412991	unit:5461416	2017-12-19 20:22:50.149	f
870970-basis:51920309	work:1412991	unit:5461410	2017-12-19 20:22:50.224	f
870970-basis:51920317	work:1412991	unit:5461388	2017-12-19 20:22:55.3	f
870970-basis:52024277	work:1412991	unit:4424736	2017-12-19 20:22:54.06	f
870970-basis:52088941	work:962083	unit:4467585	2017-12-19 20:22:54.176	f
870970-basis:52088968	work:935152	unit:4467587	2017-12-19 20:22:53.996	f
870970-basis:52093716	work:1011808	unit:4468635	2017-12-19 20:22:50.135	f
870970-basis:52184541	work:935152	unit:5041960	2017-12-19 20:22:55.463	f
870970-basis:52229316	work:677935	unit:5072878	2017-12-19 20:22:55.109	f
870970-basis:52236797	work:935152	unit:5080306	2017-12-19 20:22:50.065	f
870970-basis:52602815	work:4813157	unit:9535793	2016-10-05 16:36:26.768	f
870970-basis:52741017	work:1412991	unit:11398509	2017-12-19 20:22:49.647	f
870970-basis:52770831	work:10602093	unit:12040753	2016-12-13 14:14:03.411	f
870970-basis:52932319	work:12601817	unit:14262292	2017-06-19 13:42:11.382	f
870970-basis:52932858	work:12601842	unit:14262326	2017-06-19 13:42:05.46	f
870970-basis:53575749	work:1412991	unit:27585087	2018-01-27 04:33:03.865	f
873310-katalog:28382782	work:935152	unit:1146309	2017-12-19 20:22:54.942	f
873310-katalog:28511663	work:962083	unit:1154077	2017-12-19 20:22:50.741	f
873310-katalog:28554354	work:677935	unit:1156592	2017-12-19 20:22:50.266	f
873310-katalog:28634560	work:962083	unit:1161374	2017-12-19 20:22:54.556	f
873310-katalog:29705119	work:1011808	unit:1223019	2017-12-19 20:22:54.533	f
873310-katalog:29726795	work:962083	unit:1224026	2017-12-19 20:22:55.633	f
873310-katalog:50710483	work:962083	unit:1737609	2017-12-19 20:22:54.829	f
873310-katalog:50710521	work:935152	unit:1737614	2017-12-19 20:22:54.625	f
873310-katalog:51268172	work:1412991	unit:1769690	2017-12-19 20:22:50.629	f
873310-katalog:51488539	work:1011808	unit:1782831	2017-12-19 20:22:55.289	f
873310-katalog:51565606	work:1011808	unit:1787274	2017-12-19 20:22:55.552	f
873310-katalog:90331019	work:935152	unit:9751646	2017-12-19 20:22:54.161	f
873310-katalog:90344501	work:962083	unit:1187417	2017-12-19 20:22:53.947	f
874310-katalog:DBB0018900	work:677935	unit:9988904	2017-12-19 20:22:55.178	f
874310-katalog:DBB0019189	work:935152	unit:9987843	2017-12-19 20:22:54.099	f
874310-katalog:DBB0036015	work:962083	unit:9986937	2017-12-19 20:22:49.585	f
874310-katalog:DBB0039506	work:1011808	unit:9694811	2017-12-19 20:22:49.413	f
874310-katalog:DBB0041514	work:1412991	unit:1778555	2017-12-19 20:22:55.745	f
874310-katalog:DBB0410203	work:962083	unit:10012116	2017-12-19 20:22:50.078	f
874310-katalog:DBB0411158	work:935152	unit:10012160	2017-12-19 20:22:54.344	f
874310-katalog:DBB0412495	work:1011808	unit:10012750	2017-12-19 20:22:54.964	f
874310-katalog:DBB0415007	work:1412991	unit:10013404	2017-12-19 20:22:48.964	f
874310-katalog:DBB0417302	work:677935	unit:24450657	2017-12-19 20:22:55.576	f
874310-katalog:DBB0710203	work:962083	unit:10058934	2017-12-19 20:22:54.502	f
874310-katalog:DBB0711158	work:935152	unit:10059168	2017-12-19 20:22:55.06	f
874310-katalog:DBB0712495	work:1011808	unit:10059388	2017-12-19 20:22:55.442	f
875710-katalog:104864236	work:1011808	unit:9694811	2017-12-19 20:22:49.413	f
\.


--
-- Name: relations_test relations_test_pkey; Type: CONSTRAINT; Schema: public; Owner: lowell
--

ALTER TABLE ONLY relations_test
    ADD CONSTRAINT relations_test_pkey PRIMARY KEY (pid);


--
-- Name: relations_test_modified_index; Type: INDEX; Schema: public; Owner: lowell
--

CREATE INDEX relations_test_modified_index ON relations_test USING btree (modified);


--
-- Name: relations_test_unitid_index; Type: INDEX; Schema: public; Owner: lowell
--

CREATE INDEX relations_test_unitid_index ON relations_test USING btree (unitid);


--
-- Name: relations_test_workid_index; Type: INDEX; Schema: public; Owner: lowell
--

CREATE INDEX relations_test_workid_index ON relations_test USING btree (workid);


--
-- PostgreSQL database dump complete
--

