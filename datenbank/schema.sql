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
-- Name: bundesland; Type: TYPE; Schema: public; Owner: -
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


--
-- Name: ressourcenart; Type: TYPE; Schema: public; Owner: -
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


--
-- Name: schulart; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.schulart AS ENUM (
    'Grundschule',
    'Gemeinschaftsschule',
    'Realschule',
    'Gymnasium',
    'Hauptschule'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: lehrplan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lehrplan (
    bundesland public.bundesland,
    schulart public.schulart,
    klassenstufe smallint,
    fach character varying(500),
    lehrplanid integer
);


--
-- Name: lehrplan_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lehrplan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lehrplandetails; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lehrplandetails (
    id integer NOT NULL,
    titel character varying(3000),
    beschreibung character varying(3000),
    quelle character varying(500),
    eintragsdatum date DEFAULT CURRENT_DATE,
    elternid integer,
    hierarchie character varying(20)
);


--
-- Name: lehrplandetails_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lehrplandetails_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lehrplandetails_id_seq1; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lehrplandetails_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lehrplandetails_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lehrplandetails_id_seq1 OWNED BY public.lehrplandetails.id;


--
-- Name: linkzuordnung; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.linkzuordnung (
    modul character varying(500) NOT NULL,
    link character varying(500) NOT NULL
);


--
-- Name: module; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.module (
    modul character varying(500) NOT NULL
);


--
-- Name: modulhierarchie; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.modulhierarchie (
    untermodul character varying(500),
    "Übermodul" character varying(500)
);


--
-- Name: modulzuordnung; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.modulzuordnung (
    lehrplanid integer NOT NULL,
    modul character varying(500) NOT NULL
);


--
-- Name: schulartenbedeutung; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schulartenbedeutung (
    bundesland public.bundesland NOT NULL,
    schulname character varying(500) NOT NULL,
    schulbedeutung public.schulart NOT NULL
);


--
-- Name: selbstlernressource; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: lehrplandetails id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lehrplandetails ALTER COLUMN id SET DEFAULT nextval('public.lehrplandetails_id_seq1'::regclass);


--
-- Name: lehrplandetails lehrplandetails_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lehrplandetails
    ADD CONSTRAINT lehrplandetails_pkey PRIMARY KEY (id);


--
-- Name: module module_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.module
    ADD CONSTRAINT module_pkey PRIMARY KEY (modul);


--
-- Name: modulzuordnung modulzuordnung_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modulzuordnung
    ADD CONSTRAINT modulzuordnung_pkey PRIMARY KEY (lehrplanid, modul);


--
-- Name: schulartenbedeutung schulartenbedeutung_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schulartenbedeutung
    ADD CONSTRAINT schulartenbedeutung_pkey PRIMARY KEY (bundesland, schulname);


--
-- Name: selbstlernressource selbstlernressource_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.selbstlernressource
    ADD CONSTRAINT selbstlernressource_pkey PRIMARY KEY (link);


--
-- Name: linkzuordnung zuordnung_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.linkzuordnung
    ADD CONSTRAINT zuordnung_pkey PRIMARY KEY (modul, link);


--
-- Name: lehrplan lehrplan_lehrplanid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lehrplan
    ADD CONSTRAINT lehrplan_lehrplanid_fkey FOREIGN KEY (lehrplanid) REFERENCES public.lehrplandetails(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lehrplandetails lehrplandetails_elternid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lehrplandetails
    ADD CONSTRAINT lehrplandetails_elternid_fkey FOREIGN KEY (elternid) REFERENCES public.lehrplandetails(id);


--
-- Name: modulhierarchie modulhierarchie_untermodul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modulhierarchie
    ADD CONSTRAINT modulhierarchie_untermodul_fkey FOREIGN KEY (untermodul) REFERENCES public.module(modul);


--
-- Name: modulhierarchie modulhierarchie_Übermodul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modulhierarchie
    ADD CONSTRAINT "modulhierarchie_Übermodul_fkey" FOREIGN KEY ("Übermodul") REFERENCES public.module(modul);


--
-- Name: modulzuordnung modulzuordnung_lehrplanid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modulzuordnung
    ADD CONSTRAINT modulzuordnung_lehrplanid_fkey FOREIGN KEY (lehrplanid) REFERENCES public.lehrplandetails(id);


--
-- Name: modulzuordnung modulzuordnung_modul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modulzuordnung
    ADD CONSTRAINT modulzuordnung_modul_fkey FOREIGN KEY (modul) REFERENCES public.module(modul);


--
-- Name: linkzuordnung zuordnung_link_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.linkzuordnung
    ADD CONSTRAINT zuordnung_link_fkey FOREIGN KEY (link) REFERENCES public.selbstlernressource(link) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: linkzuordnung zuordnung_modul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.linkzuordnung
    ADD CONSTRAINT zuordnung_modul_fkey FOREIGN KEY (modul) REFERENCES public.module(modul);


--
-- PostgreSQL database dump complete
--
