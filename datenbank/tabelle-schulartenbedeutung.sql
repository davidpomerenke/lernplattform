--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5 (Ubuntu 12.5-1.pgdg16.04+1)
-- Dumped by pg_dump version 12.5 (Ubuntu 12.5-1.pgdg18.04+1)

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
-- Name: schulartenbedeutung; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schulartenbedeutung (
    bundesland public.bundesland NOT NULL,
    schulart character varying(500) NOT NULL,
    schulart_intern character varying(500) NOT NULL,
    sortcode integer
);


--
-- Data for Name: schulartenbedeutung; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.schulartenbedeutung (bundesland, schulart, schulart_intern, sortcode) FROM stdin;
Baden-Württemberg	Grundschule	Grundschule	10
Baden-Württemberg	Hauptschule	Hauptschule	20
Baden-Württemberg	Werkrealschule	Hauptschule	21
Baden-Württemberg	Realschule (Grundlegendes Niveau)	Hauptschule	31
Baden-Württemberg	Realschule (Mittleres Niveau)	Realschule	32
Baden-Württemberg	Gymnasium	Gymnasium	40
Baden-Württemberg	Gemeinschaftsschule (Grundlegendes Niveau)	Hauptschule	51
Baden-Württemberg	Gemeinschaftsschule (Mittleres Niveau)	Realschule	52
Baden-Württemberg	Gemeinschaftsschule (Erweitertes Niveau)	Gemeinschaftsschule	53
Baden-Württemberg	Gemeinschaftsschule (Oberstufe)	Gemeinschaftsschule	54
Bayern	Mittelschule	Hauptschule	30
Bayern	Realschule	Realschule	40
Bayern	Wirtschaftsschule	Wirtschaftsschule	41
Bayern	Fachoberschule	Fachoberschule	50
Bayern	Berufsoberschule	Berufsoberschule	51
Bayern	Gymnasium	Gymnasium	60
Bayern	Förderschule körperliche und motorische Entwicklung	Förderschule körperliche und motorische Entwicklung	73
Bayern	Förderschule Hören	Förderschule Hören	72
Bayern	Förderschule Lernen	Förderschule Lernen	74
Bayern	Förderschule emotionale und soziale Entwicklung	Förderschule emotionale und soziale Entwicklung	70
Bayern	Förderschule geistige Entwicklung	Förderschule geistige Entwicklung	71
Bayern	Förderschule Sehen	Förderschule Sehen	75
Bayern	Förderschule Sprache	Förderschule Sprache	76
Bayern	Grundschule	Grundschule	10
\.


--
-- Name: schulartenbedeutung schulartenbedeutung_bundesland_sortcode_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schulartenbedeutung
    ADD CONSTRAINT schulartenbedeutung_bundesland_sortcode_key UNIQUE (bundesland, sortcode);


--
-- Name: schulartenbedeutung schulartenbedeutung_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schulartenbedeutung
    ADD CONSTRAINT schulartenbedeutung_pkey PRIMARY KEY (bundesland, schulart);


--
-- PostgreSQL database dump complete
--

