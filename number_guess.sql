--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: records; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.records (
    player_id integer NOT NULL,
    username character varying(50) NOT NULL,
    games_played integer DEFAULT 0,
    best_game integer DEFAULT 0
);


ALTER TABLE public.records OWNER TO freecodecamp;

--
-- Name: records_player_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.records_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.records_player_id_seq OWNER TO freecodecamp;

--
-- Name: records_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.records_player_id_seq OWNED BY public.records.player_id;


--
-- Name: records player_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.records ALTER COLUMN player_id SET DEFAULT nextval('public.records_player_id_seq'::regclass);


--
-- Data for Name: records; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.records VALUES (56, 'bruce', 0, 0);
INSERT INTO public.records VALUES (57, 'fsd', 0, 0);
INSERT INTO public.records VALUES (59, 'user_1717179992969', 2, 923);
INSERT INTO public.records VALUES (58, 'user_1717179992970', 5, 56);
INSERT INTO public.records VALUES (61, 'user_1717180090014', 2, 269);
INSERT INTO public.records VALUES (60, 'user_1717180090015', 5, 79);
INSERT INTO public.records VALUES (63, 'user_1717180105619', 2, 534);
INSERT INTO public.records VALUES (62, 'user_1717180105620', 5, 324);
INSERT INTO public.records VALUES (65, 'user_1717180144208', 2, 605);
INSERT INTO public.records VALUES (64, 'user_1717180144209', 5, 48);


--
-- Name: records_player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.records_player_id_seq', 65, true);


--
-- Name: records records_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT records_pkey PRIMARY KEY (player_id);


--
-- PostgreSQL database dump complete
--

