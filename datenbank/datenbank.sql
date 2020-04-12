$ /home/davidp/Repositories/lernplattform/node_modules/.bin/heroku run 'pg_dump $DATABASE_URL --exclude-table lehrplan --exclude-table lehrplandetails' -a lernplattform-api
--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2 (Ubuntu 12.2-2.pgdg16.04+1)
-- Dumped by pg_dump version 12.2 (Ubuntu 12.2-2.pgdg18.04+1)

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

--
-- Name: bundesland; Type: TYPE; Schema: public; Owner: uxeykolcfjodyp
--

CREATE TYPE public.bundesland AS ENUM (
    'Baden-Württemberg',
    'Bayern',
    'Berlin',
    'Brandenburg',
    'Bremen',
    'Hamburg',
    'Hessen',
    'Mecklenburg-Vorpommern',
    'Niedersachsen',
    'Nordrhein-Westfalen',
    'Rheinland-Pfalz',
    'Saarland',
    'Sachsen',
    'Sachsen-Anhalt',
    'Schleswig-Holstein',
    'Thüringen'
);


ALTER TYPE public.bundesland OWNER TO uxeykolcfjodyp;

--
-- Name: ressourcenart; Type: TYPE; Schema: public; Owner: uxeykolcfjodyp
--

CREATE TYPE public.ressourcenart AS ENUM (
    'vExperiment',
    'Sammlung',
    'Wettbewerb',
    'Nachschlageseite',
    'Tutorial',
    'Aufgaben',
    'Lerneinheit',
    'Lerntext',
    'Animation',
    'Erklärvideo',
    'Podcast',
    'Reportage',
    'Bericht',
    'Interview',
    'Originaltext',
    'Übersetzung',
    'Fachartikel',
    'Interpretation',
    'Vortrag',
    'Musik',
    'App',
    'Tool',
    'Code',
    'Klassenarbeit',
    'Musterlösung',
    'Community',
    'Q&A'
);


ALTER TYPE public.ressourcenart OWNER TO uxeykolcfjodyp;

--
-- Name: schulart; Type: TYPE; Schema: public; Owner: uxeykolcfjodyp
--

CREATE TYPE public.schulart AS ENUM (
    'Grundschule',
    'Gemeinschaftsschule',
    'Realschule',
    'Gymnasium',
    'Hauptschule'
);


ALTER TYPE public.schulart OWNER TO uxeykolcfjodyp;

--
-- Name: lehrplan_id_seq; Type: SEQUENCE; Schema: public; Owner: uxeykolcfjodyp
--

CREATE SEQUENCE public.lehrplan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lehrplan_id_seq OWNER TO uxeykolcfjodyp;

--
-- Name: lehrplandetails_id_seq; Type: SEQUENCE; Schema: public; Owner: uxeykolcfjodyp
--

CREATE SEQUENCE public.lehrplandetails_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lehrplandetails_id_seq OWNER TO uxeykolcfjodyp;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: linkzuordnung; Type: TABLE; Schema: public; Owner: uxeykolcfjodyp
--

CREATE TABLE public.linkzuordnung (
    modul character varying(500) NOT NULL,
    link character varying(500) NOT NULL
);


ALTER TABLE public.linkzuordnung OWNER TO uxeykolcfjodyp;

--
-- Name: module; Type: TABLE; Schema: public; Owner: uxeykolcfjodyp
--

CREATE TABLE public.module (
    modul character varying(500) NOT NULL
);


ALTER TABLE public.module OWNER TO uxeykolcfjodyp;

--
-- Name: modulhierarchie; Type: TABLE; Schema: public; Owner: uxeykolcfjodyp
--

CREATE TABLE public.modulhierarchie (
    untermodul character varying(500),
    "Übermodul" character varying(500)
);


ALTER TABLE public.modulhierarchie OWNER TO uxeykolcfjodyp;

--
-- Name: modulzuordnung; Type: TABLE; Schema: public; Owner: uxeykolcfjodyp
--

CREATE TABLE public.modulzuordnung (
    lehrplanid integer NOT NULL,
    modul character varying(500) NOT NULL
);


ALTER TABLE public.modulzuordnung OWNER TO uxeykolcfjodyp;

--
-- Name: schulartenbedeutung; Type: TABLE; Schema: public; Owner: uxeykolcfjodyp
--

CREATE TABLE public.schulartenbedeutung (
    bundesland public.bundesland NOT NULL,
    schulname character varying(500) NOT NULL,
    schulbedeutung public.schulart NOT NULL
);


ALTER TABLE public.schulartenbedeutung OWNER TO uxeykolcfjodyp;

--
-- Name: selbstlernressource; Type: TABLE; Schema: public; Owner: uxeykolcfjodyp
--

CREATE TABLE public.selbstlernressource (
    link character varying(500) NOT NULL,
    art public.ressourcenart NOT NULL,
    titel character varying(500) NOT NULL,
    beschreibung text DEFAULT ''::text,
    upvotes integer DEFAULT 0,
    downvotes integer DEFAULT 0,
    eintragsdatum date DEFAULT CURRENT_DATE,
    "Überprüfungsdatum" date DEFAULT CURRENT_DATE
);


ALTER TABLE public.selbstlernressource OWNER TO uxeykolcfjodyp;

--
-- Data for Name: linkzuordnung; Type: TABLE DATA; Schema: public; Owner: uxeykolcfjodyp
--

COPY public.linkzuordnung (modul, link) FROM stdin;
Keplersche Gesetze	https://amazondating.co/
Politisches System Deutschlands	https://amazondating.co/
Intransitive Verben	https://amazondating.co/
Autokatalyse	https://amazondating.co/
Baumarten	https://wikipedia.org
Grundgrößen der Elektrizitätslehre	https://wiki.zum.de/wiki/Gymnasium_Feuchtwangen/Physik/7._Klasse/Gr%c3%b6%c3%9fen_zur_Beschreibung_des_Stromkreises/Die_elektrische_Spannung/Aufgaben_zur_elektrischen_Spannung
Quantenobjekte	https://www.didaktik.physik.uni-muenchen.de/elektronenbahnen/schattenkreuz/ausbreitung/aufbau.php
Physik	https://www.schule-bw.de/faecher-und-schularten/mathematisch-naturwissenschaftliche-faecher/physik/pruefungen-und-wettbewerbe/physikproblem_des_monats
Griechisches Alphabet	https://alphabetify.js.org/de
\.


--
-- Data for Name: module; Type: TABLE DATA; Schema: public; Owner: uxeykolcfjodyp
--

COPY public.module (modul) FROM stdin;
Denk- und Arbeitsweisen der Physik
Optik
Akustik
Energie
Magnetismus
Elektromagnetismus
Grundgrößen der Elektrizitätslehre
Kinematik
Dynamik
Griechisches Alphabet
Keplersche Gesetze
Politisches System Deutschlands
Intransitive Verben
Autokatalyse
Baumarten
Physik
Quantenobjekte
\.


--
-- Data for Name: modulhierarchie; Type: TABLE DATA; Schema: public; Owner: uxeykolcfjodyp
--

COPY public.modulhierarchie (untermodul, "Übermodul") FROM stdin;
Grundgrößen der Elektrizitätslehre	Elektromagnetismus
\.


--
-- Data for Name: modulzuordnung; Type: TABLE DATA; Schema: public; Owner: uxeykolcfjodyp
--

COPY public.modulzuordnung (lehrplanid, modul) FROM stdin;
\.


--
-- Data for Name: schulartenbedeutung; Type: TABLE DATA; Schema: public; Owner: uxeykolcfjodyp
--

COPY public.schulartenbedeutung (bundesland, schulname, schulbedeutung) FROM stdin;
Baden-Württemberg	Grundschule	Grundschule
Baden-Württemberg	Hauptschule	Hauptschule
Baden-Württemberg	Werkrealschule	Hauptschule
Baden-Württemberg	Gemeinschaftsschule (Grundlegendes Niveau)	Hauptschule
Baden-Württemberg	Realschule (Grundlegendes Niveau)	Hauptschule
Baden-Württemberg	Gemeinschaftsschule (Mittleres Niveau)	Realschule
Baden-Württemberg	Realschule (Mittleres Niveau)	Realschule
Baden-Württemberg	Gymnasium	Gymnasium
Baden-Württemberg	Gemeinschaftsschule (Erweitertes Niveau)	Gemeinschaftsschule
Baden-Württemberg	Gemeinschaftsschule (Oberstufe)	Gemeinschaftsschule
\.


--
-- Data for Name: selbstlernressource; Type: TABLE DATA; Schema: public; Owner: uxeykolcfjodyp
--

COPY public.selbstlernressource (link, art, titel, beschreibung, upvotes, downvotes, eintragsdatum, "Überprüfungsdatum") FROM stdin;
https://amazondating.co/	Tutorial	Keplersche Gesetze selbst modifizieren	Hier lernt ihr, wie ihr das politische System der Erdumlaufbahn beschleunigen könnt, indem ihr Backpulver in intransitiven Autokatalysatoren auflöst.	0	0	2020-04-08	2020-04-08
https://wikipedia.org	Lerneinheit	Baumarten von A bis Z auswendig lernen	Nicht für Katzen und Erwachsene unter 18 Jahren geeignet.	0	0	2020-04-08	2020-04-08
https://wiki.zum.de/wiki/Gymnasium_Feuchtwangen/Physik/7._Klasse/Gr%c3%b6%c3%9fen_zur_Beschreibung_des_Stromkreises/Die_elektrische_Spannung/Aufgaben_zur_elektrischen_Spannung	Aufgaben	Größen zur Beschreibung des Stromkreises	Die Aufgaben zur elektrischen Spannung beinhalten Lückentexte, Umrechnungsaufgaben und Zuordnungsübungen.	0	0	2020-04-08	2020-04-08
https://www.didaktik.physik.uni-muenchen.de/elektronenbahnen/schattenkreuz/ausbreitung/aufbau.php	vExperiment	Fokussierung von Elektronen durch eine magnetische Linse	Wie breiten sich Elektronenstrahlen im Raum aus? Die Antwort auf diese Frage kann man mithilfe der Schattenkreuzröhre (auch Malteserkreuzröhre) herausfinden.	0	0	2020-04-08	2020-04-08
https://www.schule-bw.de/faecher-und-schularten/mathematisch-naturwissenschaftliche-faecher/physik/pruefungen-und-wettbewerbe/physikproblem_des_monats	Wettbewerb	Physik-Problem des Monats		0	0	2020-04-08	2020-04-08
https://alphabetify.js.org/de	Tool	Alphabetify	Ganz einfach das griechische / russische / japanische Alphabet lernen.	0	0	2020-04-08	2020-04-08
\.


--
-- Name: lehrplan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: uxeykolcfjodyp
--

SELECT pg_catalog.setval('public.lehrplan_id_seq', 35, true);


--
-- Name: lehrplandetails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: uxeykolcfjodyp
--

SELECT pg_catalog.setval('public.lehrplandetails_id_seq', 44634, true);


--
-- Name: module module_pkey; Type: CONSTRAINT; Schema: public; Owner: uxeykolcfjodyp
--

ALTER TABLE ONLY public.module
    ADD CONSTRAINT module_pkey PRIMARY KEY (modul);


--
-- Name: modulzuordnung modulzuordnung_pkey; Type: CONSTRAINT; Schema: public; Owner: uxeykolcfjodyp
--

ALTER TABLE ONLY public.modulzuordnung
    ADD CONSTRAINT modulzuordnung_pkey PRIMARY KEY (lehrplanid, modul);


--
-- Name: schulartenbedeutung schulartenbedeutung_pkey; Type: CONSTRAINT; Schema: public; Owner: uxeykolcfjodyp
--

ALTER TABLE ONLY public.schulartenbedeutung
    ADD CONSTRAINT schulartenbedeutung_pkey PRIMARY KEY (bundesland, schulname);


--
-- Name: selbstlernressource selbstlernressource_pkey; Type: CONSTRAINT; Schema: public; Owner: uxeykolcfjodyp
--

ALTER TABLE ONLY public.selbstlernressource
    ADD CONSTRAINT selbstlernressource_pkey PRIMARY KEY (link);


--
-- Name: linkzuordnung zuordnung_pkey; Type: CONSTRAINT; Schema: public; Owner: uxeykolcfjodyp
--

ALTER TABLE ONLY public.linkzuordnung
    ADD CONSTRAINT zuordnung_pkey PRIMARY KEY (modul, link);


--
-- Name: modulhierarchie modulhierarchie_untermodul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: uxeykolcfjodyp
--

ALTER TABLE ONLY public.modulhierarchie
    ADD CONSTRAINT modulhierarchie_untermodul_fkey FOREIGN KEY (untermodul) REFERENCES public.module(modul);


--
-- Name: modulhierarchie modulhierarchie_Übermodul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: uxeykolcfjodyp
--

ALTER TABLE ONLY public.modulhierarchie
    ADD CONSTRAINT "modulhierarchie_Übermodul_fkey" FOREIGN KEY ("Übermodul") REFERENCES public.module(modul);


--
-- Name: modulzuordnung modulzuordnung_lehrplanid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: uxeykolcfjodyp
--

ALTER TABLE ONLY public.modulzuordnung
    ADD CONSTRAINT modulzuordnung_lehrplanid_fkey FOREIGN KEY (lehrplanid) REFERENCES public.lehrplandetails(id);


--
-- Name: modulzuordnung modulzuordnung_modul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: uxeykolcfjodyp
--

ALTER TABLE ONLY public.modulzuordnung
    ADD CONSTRAINT modulzuordnung_modul_fkey FOREIGN KEY (modul) REFERENCES public.module(modul);


--
-- Name: linkzuordnung zuordnung_link_fkey; Type: FK CONSTRAINT; Schema: public; Owner: uxeykolcfjodyp
--

ALTER TABLE ONLY public.linkzuordnung
    ADD CONSTRAINT zuordnung_link_fkey FOREIGN KEY (link) REFERENCES public.selbstlernressource(link) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: linkzuordnung zuordnung_modul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: uxeykolcfjodyp
--

ALTER TABLE ONLY public.linkzuordnung
    ADD CONSTRAINT zuordnung_modul_fkey FOREIGN KEY (modul) REFERENCES public.module(modul);


--
-- Name: LANGUAGE plpgsql; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON LANGUAGE plpgsql TO uxeykolcfjodyp;


--
-- PostgreSQL database dump complete
--

