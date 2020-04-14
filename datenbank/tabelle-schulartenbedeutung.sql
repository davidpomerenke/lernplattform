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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: schulartenbedeutung; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schulartenbedeutung (
    bundesland public.bundesland NOT NULL,
    schulart character varying(500) NOT NULL,
    schulart_intern public.schulart NOT NULL
);


--
-- Data for Name: schulartenbedeutung; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.schulartenbedeutung (bundesland, schulart, schulart_intern) FROM stdin;
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
-- Name: schulartenbedeutung schulartenbedeutung_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schulartenbedeutung
    ADD CONSTRAINT schulartenbedeutung_pkey PRIMARY KEY (bundesland, schulart);


--
-- PostgreSQL database dump complete
--

