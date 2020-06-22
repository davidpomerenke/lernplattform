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
-- Name: content; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.content (
    link character varying(500) NOT NULL,
    type public.ressourcenart NOT NULL,
    title character varying(500) NOT NULL,
    description text DEFAULT ''::text,
    upvotes integer DEFAULT 0 NOT NULL,
    downvotes integer DEFAULT 0 NOT NULL,
    entry_date date DEFAULT CURRENT_DATE NOT NULL,
    validation_date date DEFAULT CURRENT_DATE
);


--
-- Name: curriculum_internal; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.curriculum_internal (
    region public.bundesland NOT NULL,
    school_internal character varying(500) NOT NULL,
    class integer NOT NULL,
    subject character varying(500) NOT NULL,
    id integer NOT NULL
);


--
-- Name: school_aliases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.school_aliases (
    region public.bundesland NOT NULL,
    school character varying(500) NOT NULL,
    school_internal character varying(500) NOT NULL
);


--
-- Name: curriculum; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.curriculum AS
 SELECT curriculum_internal.region,
    COALESCE(school_aliases.school, curriculum_internal.school_internal) AS school,
    curriculum_internal.class,
    curriculum_internal.subject
   FROM (public.school_aliases
     RIGHT JOIN public.curriculum_internal USING (region, school_internal))
  WITH NO DATA;


--
-- Name: curriculum_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.curriculum_details (
    id integer NOT NULL,
    title character varying(3000),
    description character varying(3000),
    source character varying(500) NOT NULL,
    entry_date date DEFAULT CURRENT_DATE NOT NULL,
    parent_id integer,
    hierarchy character varying(20)
);


--
-- Name: matching_content_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.matching_content_modules (
    module character varying(500) NOT NULL,
    link character varying(500) NOT NULL
);


--
-- Name: matching_curriculum_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.matching_curriculum_modules (
    id integer NOT NULL,
    module character varying(500) NOT NULL
);


--
-- Name: modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.modules (
    module character varying(500) NOT NULL
);


--
-- Name: modules_hierarchy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.modules_hierarchy (
    child_module character varying(500) NOT NULL,
    parent_module character varying(500) NOT NULL
);


--
-- Name: curriculum_details lehrplandetails_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_details
    ADD CONSTRAINT lehrplandetails_pkey PRIMARY KEY (id);


--
-- Name: modules module_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT module_pkey PRIMARY KEY (module);


--
-- Name: matching_curriculum_modules modulzuordnung_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matching_curriculum_modules
    ADD CONSTRAINT modulzuordnung_pkey PRIMARY KEY (id, module);


--
-- Name: school_aliases schulartenbedeutung_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.school_aliases
    ADD CONSTRAINT schulartenbedeutung_pkey PRIMARY KEY (region, school);


--
-- Name: content selbstlernressource_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content
    ADD CONSTRAINT selbstlernressource_pkey PRIMARY KEY (link);


--
-- Name: matching_content_modules zuordnung_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matching_content_modules
    ADD CONSTRAINT zuordnung_pkey PRIMARY KEY (module, link);


--
-- Name: curriculum_internal lehrplan_lehrplanid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_internal
    ADD CONSTRAINT lehrplan_lehrplanid_fkey FOREIGN KEY (id) REFERENCES public.curriculum_details(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: curriculum_details lehrplandetails_elternid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_details
    ADD CONSTRAINT lehrplandetails_elternid_fkey FOREIGN KEY (parent_id) REFERENCES public.curriculum_details(id);


--
-- Name: modules_hierarchy modulhierarchie_untermodul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modules_hierarchy
    ADD CONSTRAINT modulhierarchie_untermodul_fkey FOREIGN KEY (child_module) REFERENCES public.modules(module);


--
-- Name: modules_hierarchy modulhierarchie_Übermodul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modules_hierarchy
    ADD CONSTRAINT "modulhierarchie_Übermodul_fkey" FOREIGN KEY (parent_module) REFERENCES public.modules(module);


--
-- Name: matching_curriculum_modules modulzuordnung_lehrplanid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matching_curriculum_modules
    ADD CONSTRAINT modulzuordnung_lehrplanid_fkey FOREIGN KEY (id) REFERENCES public.curriculum_details(id);


--
-- Name: matching_curriculum_modules modulzuordnung_modul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matching_curriculum_modules
    ADD CONSTRAINT modulzuordnung_modul_fkey FOREIGN KEY (module) REFERENCES public.modules(module);


--
-- Name: matching_content_modules zuordnung_link_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matching_content_modules
    ADD CONSTRAINT zuordnung_link_fkey FOREIGN KEY (link) REFERENCES public.content(link) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: matching_content_modules zuordnung_modul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matching_content_modules
    ADD CONSTRAINT zuordnung_modul_fkey FOREIGN KEY (module) REFERENCES public.modules(module);


--
-- PostgreSQL database dump complete
--

