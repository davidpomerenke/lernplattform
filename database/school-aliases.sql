--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.2 (Ubuntu 12.2-4)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: school_aliases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.school_aliases (
    region public.bundesland NOT NULL,
    school character varying(500) NOT NULL,
    school_internal character varying(500) NOT NULL
);


--
-- Data for Name: school_aliases; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.school_aliases (region, school, school_internal) FROM stdin;
Baden-Württemberg	Werkrealschule	Hauptschule
Baden-Württemberg	Realschule (Grundlegendes Niveau)	Hauptschule
Baden-Württemberg	Realschule (Mittleres Niveau)	Realschule
Baden-Württemberg	Gemeinschaftsschule (Grundlegendes Niveau)	Hauptschule
Baden-Württemberg	Gemeinschaftsschule (Mittleres Niveau)	Realschule
Baden-Württemberg	Gemeinschaftsschule (Erweitertes Niveau)	Gemeinschaftsschule
Baden-Württemberg	Gemeinschaftsschule (Oberstufe)	Gemeinschaftsschule
Bayern	Mittelschule	Hauptschule
\.


--
-- Name: school_aliases schulartenbedeutung_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.school_aliases
    ADD CONSTRAINT schulartenbedeutung_pkey PRIMARY KEY (region, school);


--
-- PostgreSQL database dump complete
--

