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
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


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


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: lehrplan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lehrplan (
    bundesland public.bundesland NOT NULL,
    schulart_intern character varying(500) NOT NULL,
    klassenstufe integer NOT NULL,
    fach character varying(500) NOT NULL,
    lehrplanid integer NOT NULL
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
    lehrplanid integer NOT NULL,
    titel character varying(3000),
    beschreibung character varying(3000),
    quelle character varying(500) NOT NULL,
    eintragsdatum date DEFAULT CURRENT_DATE NOT NULL,
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

ALTER SEQUENCE public.lehrplandetails_id_seq1 OWNED BY public.lehrplandetails.lehrplanid;


--
-- Name: lehrplanzuordnung; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lehrplanzuordnung (
    lehrplanid integer NOT NULL,
    modul character varying(500) NOT NULL
);


--
-- Name: material; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.material (
    link character varying(500) NOT NULL,
    materialart public.ressourcenart NOT NULL,
    materialtitel character varying(500) NOT NULL,
    materialbeschreibung text DEFAULT ''::text,
    upvotes integer DEFAULT 0 NOT NULL,
    downvotes integer DEFAULT 0 NOT NULL,
    materialeintragsdatum date DEFAULT CURRENT_DATE NOT NULL,
    materialtestdatum date DEFAULT CURRENT_DATE
);


--
-- Name: materialzuordnung; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.materialzuordnung (
    modul character varying(500) NOT NULL,
    link character varying(500) NOT NULL
);


--
-- Name: schulartenbedeutung; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schulartenbedeutung (
    bundesland public.bundesland NOT NULL,
    schulart character varying(500) NOT NULL,
    schulart_intern character varying(500) NOT NULL,
    sortcode integer NOT NULL
);


--
-- Name: lernplattform; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.lernplattform AS
 SELECT lehrplan.lehrplanid,
    schulartenbedeutung.bundesland,
    schulartenbedeutung.schulart_intern,
    schulartenbedeutung.schulart,
    schulartenbedeutung.sortcode,
    lehrplan.klassenstufe,
    lehrplan.fach,
    lehrplandetails.titel,
    lehrplandetails.beschreibung,
    lehrplandetails.quelle,
    lehrplandetails.eintragsdatum,
    lehrplandetails.elternid,
    lehrplandetails.hierarchie,
    materialzuordnung.link,
    lehrplanzuordnung.modul,
    material.materialart,
    material.materialtitel,
    material.materialbeschreibung,
    material.upvotes,
    material.downvotes,
    material.materialeintragsdatum,
    material.materialtestdatum
   FROM (((public.schulartenbedeutung
     JOIN public.lehrplan USING (bundesland, schulart_intern))
     JOIN public.lehrplandetails USING (lehrplanid))
     LEFT JOIN ((public.lehrplanzuordnung
     JOIN public.materialzuordnung USING (modul))
     JOIN public.material USING (link)) USING (lehrplanid));


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
    untermodul character varying(500) NOT NULL,
    "Übermodul" character varying(500) NOT NULL
);


--
-- Name: lehrplandetails lehrplanid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lehrplandetails ALTER COLUMN lehrplanid SET DEFAULT nextval('public.lehrplandetails_id_seq1'::regclass);


--
-- Name: lehrplandetails lehrplandetails_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lehrplandetails
    ADD CONSTRAINT lehrplandetails_pkey PRIMARY KEY (lehrplanid);


--
-- Name: module module_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.module
    ADD CONSTRAINT module_pkey PRIMARY KEY (modul);


--
-- Name: lehrplanzuordnung modulzuordnung_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lehrplanzuordnung
    ADD CONSTRAINT modulzuordnung_pkey PRIMARY KEY (lehrplanid, modul);


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
-- Name: material selbstlernressource_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.material
    ADD CONSTRAINT selbstlernressource_pkey PRIMARY KEY (link);


--
-- Name: materialzuordnung zuordnung_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.materialzuordnung
    ADD CONSTRAINT zuordnung_pkey PRIMARY KEY (modul, link);


--
-- Name: lehrplan lehrplan_lehrplanid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lehrplan
    ADD CONSTRAINT lehrplan_lehrplanid_fkey FOREIGN KEY (lehrplanid) REFERENCES public.lehrplandetails(lehrplanid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lehrplandetails lehrplandetails_elternid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lehrplandetails
    ADD CONSTRAINT lehrplandetails_elternid_fkey FOREIGN KEY (elternid) REFERENCES public.lehrplandetails(lehrplanid);


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
-- Name: lehrplanzuordnung modulzuordnung_lehrplanid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lehrplanzuordnung
    ADD CONSTRAINT modulzuordnung_lehrplanid_fkey FOREIGN KEY (lehrplanid) REFERENCES public.lehrplandetails(lehrplanid);


--
-- Name: lehrplanzuordnung modulzuordnung_modul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lehrplanzuordnung
    ADD CONSTRAINT modulzuordnung_modul_fkey FOREIGN KEY (modul) REFERENCES public.module(modul);


--
-- Name: materialzuordnung zuordnung_link_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.materialzuordnung
    ADD CONSTRAINT zuordnung_link_fkey FOREIGN KEY (link) REFERENCES public.material(link) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: materialzuordnung zuordnung_modul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.materialzuordnung
    ADD CONSTRAINT zuordnung_modul_fkey FOREIGN KEY (modul) REFERENCES public.module(modul);


--
-- PostgreSQL database dump complete
--

