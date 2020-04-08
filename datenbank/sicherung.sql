$ /home/davidp/Repositories/lernplattform/node_modules/.bin/heroku run 'pg_dump $DATABASE_URL' -a lernplattform-api
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
-- Name: bundesland; Type: TYPE; Schema: public; Owner: zzljtitzdabcjg
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


ALTER TYPE public.bundesland OWNER TO zzljtitzdabcjg;

--
-- Name: schulart; Type: TYPE; Schema: public; Owner: zzljtitzdabcjg
--

CREATE TYPE public.schulart AS ENUM (
    'Grundschule',
    'Gemeinschaftsschule',
    'Realschule',
    'Gymnasium'
);


ALTER TYPE public.schulart OWNER TO zzljtitzdabcjg;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: lehrplan; Type: TABLE; Schema: public; Owner: zzljtitzdabcjg
--

CREATE TABLE public.lehrplan (
    bundesland public.bundesland NOT NULL,
    schulart public.schulart NOT NULL,
    fach character varying(100) NOT NULL,
    klassenstufe smallint NOT NULL,
    modul character varying(500) NOT NULL,
    lehrplantitel character varying(500),
    lehrplanbeschreibung text,
    lehrplanlehrziel text,
    lehrplanquelle character varying(500),
    eintragsdatum date
);


ALTER TABLE public.lehrplan OWNER TO zzljtitzdabcjg;

--
-- Name: module; Type: TABLE; Schema: public; Owner: zzljtitzdabcjg
--

CREATE TABLE public.module (
    modul character varying(500) NOT NULL
);


ALTER TABLE public.module OWNER TO zzljtitzdabcjg;

--
-- Name: modulhierarchie; Type: TABLE; Schema: public; Owner: zzljtitzdabcjg
--

CREATE TABLE public.modulhierarchie (
    untermodul character varying(500),
    "Übermodul" character varying(500)
);


ALTER TABLE public.modulhierarchie OWNER TO zzljtitzdabcjg;

--
-- Name: selbstlernressource; Type: TABLE; Schema: public; Owner: zzljtitzdabcjg
--

CREATE TABLE public.selbstlernressource (
    link character varying(500) NOT NULL,
    beschreibung text DEFAULT ''::text,
    upvotes integer DEFAULT 0,
    downvotes integer DEFAULT 0
);


ALTER TABLE public.selbstlernressource OWNER TO zzljtitzdabcjg;

--
-- Name: zuordnung; Type: TABLE; Schema: public; Owner: zzljtitzdabcjg
--

CREATE TABLE public.zuordnung (
    modul character varying(500) NOT NULL,
    link character varying(500) NOT NULL
);


ALTER TABLE public.zuordnung OWNER TO zzljtitzdabcjg;

--
-- Data for Name: lehrplan; Type: TABLE DATA; Schema: public; Owner: zzljtitzdabcjg
--

COPY public.lehrplan (bundesland, schulart, fach, klassenstufe, modul, lehrplantitel, lehrplanbeschreibung, lehrplanlehrziel, lehrplanquelle, eintragsdatum) FROM stdin;
Baden-Württemberg	Gymnasium	Physik	7	Denk- und Arbeitsweisen der Physik	\N	\N	\N	\N	\N
Baden-Württemberg	Gymnasium	Physik	7	Optik	\N	\N	\N	\N	\N
Baden-Württemberg	Gymnasium	Physik	7	Akustik	\N	\N	\N	\N	\N
Baden-Württemberg	Gymnasium	Physik	7	Energie	\N	\N	\N	\N	\N
Baden-Württemberg	Gymnasium	Physik	7	Magnetismus	\N	\N	\N	\N	\N
Baden-Württemberg	Gymnasium	Physik	7	Elektromagnetismus	\N	\N	\N	\N	\N
Baden-Württemberg	Gymnasium	Physik	7	Grundgrößen der Elektrizitätslehre	\N	\N	\N	\N	\N
Baden-Württemberg	Gymnasium	Physik	7	Kinematik	\N	\N	\N	\N	\N
Baden-Württemberg	Gymnasium	Physik	7	Dynamik	\N	\N	\N	\N	\N
Baden-Württemberg	Gymnasium	Physik	8	Denk- und Arbeitsweisen der Physik	\N	\N	\N	\N	\N
Baden-Württemberg	Gymnasium	Physik	8	Optik	\N	\N	\N	\N	\N
Baden-Württemberg	Gymnasium	Physik	8	Akustik	\N	\N	\N	\N	\N
Baden-Württemberg	Gymnasium	Physik	8	Energie	\N	\N	\N	\N	\N
Baden-Württemberg	Gymnasium	Physik	8	Magnetismus	\N	\N	\N	\N	\N
Baden-Württemberg	Gymnasium	Physik	8	Elektromagnetismus	\N	\N	\N	\N	\N
Baden-Württemberg	Gymnasium	Physik	8	Grundgrößen der Elektrizitätslehre	\N	\N	\N	\N	\N
Baden-Württemberg	Gymnasium	Physik	8	Kinematik	\N	\N	\N	\N	\N
Baden-Württemberg	Gymnasium	Physik	8	Dynamik	\N	\N	\N	\N	\N
\.


--
-- Data for Name: module; Type: TABLE DATA; Schema: public; Owner: zzljtitzdabcjg
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
\.


--
-- Data for Name: modulhierarchie; Type: TABLE DATA; Schema: public; Owner: zzljtitzdabcjg
--

COPY public.modulhierarchie (untermodul, "Übermodul") FROM stdin;
\.


--
-- Data for Name: selbstlernressource; Type: TABLE DATA; Schema: public; Owner: zzljtitzdabcjg
--

COPY public.selbstlernressource (link, beschreibung, upvotes, downvotes) FROM stdin;
\.


--
-- Data for Name: zuordnung; Type: TABLE DATA; Schema: public; Owner: zzljtitzdabcjg
--

COPY public.zuordnung (modul, link) FROM stdin;
\.


--
-- Name: lehrplan lehrplan_pkey; Type: CONSTRAINT; Schema: public; Owner: zzljtitzdabcjg
--

ALTER TABLE ONLY public.lehrplan
    ADD CONSTRAINT lehrplan_pkey PRIMARY KEY (bundesland, schulart, fach, klassenstufe, modul);


--
-- Name: module module_pkey; Type: CONSTRAINT; Schema: public; Owner: zzljtitzdabcjg
--

ALTER TABLE ONLY public.module
    ADD CONSTRAINT module_pkey PRIMARY KEY (modul);


--
-- Name: selbstlernressource selbstlernressource_pkey; Type: CONSTRAINT; Schema: public; Owner: zzljtitzdabcjg
--

ALTER TABLE ONLY public.selbstlernressource
    ADD CONSTRAINT selbstlernressource_pkey PRIMARY KEY (link);


--
-- Name: zuordnung zuordnung_pkey; Type: CONSTRAINT; Schema: public; Owner: zzljtitzdabcjg
--

ALTER TABLE ONLY public.zuordnung
    ADD CONSTRAINT zuordnung_pkey PRIMARY KEY (modul, link);


--
-- Name: lehrplan lehrplan_modul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: zzljtitzdabcjg
--

ALTER TABLE ONLY public.lehrplan
    ADD CONSTRAINT lehrplan_modul_fkey FOREIGN KEY (modul) REFERENCES public.module(modul);


--
-- Name: modulhierarchie modulhierarchie_untermodul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: zzljtitzdabcjg
--

ALTER TABLE ONLY public.modulhierarchie
    ADD CONSTRAINT modulhierarchie_untermodul_fkey FOREIGN KEY (untermodul) REFERENCES public.module(modul);


--
-- Name: modulhierarchie modulhierarchie_Übermodul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: zzljtitzdabcjg
--

ALTER TABLE ONLY public.modulhierarchie
    ADD CONSTRAINT "modulhierarchie_Übermodul_fkey" FOREIGN KEY ("Übermodul") REFERENCES public.module(modul);


--
-- Name: zuordnung zuordnung_link_fkey; Type: FK CONSTRAINT; Schema: public; Owner: zzljtitzdabcjg
--

ALTER TABLE ONLY public.zuordnung
    ADD CONSTRAINT zuordnung_link_fkey FOREIGN KEY (link) REFERENCES public.selbstlernressource(link);


--
-- Name: zuordnung zuordnung_modul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: zzljtitzdabcjg
--

ALTER TABLE ONLY public.zuordnung
    ADD CONSTRAINT zuordnung_modul_fkey FOREIGN KEY (modul) REFERENCES public.module(modul);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: zzljtitzdabcjg
--

REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO zzljtitzdabcjg;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: LANGUAGE plpgsql; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON LANGUAGE plpgsql TO zzljtitzdabcjg;


--
-- PostgreSQL database dump complete
--

