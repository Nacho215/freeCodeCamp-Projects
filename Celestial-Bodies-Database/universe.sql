--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    galaxy_type_id integer NOT NULL,
    age_in_million_years integer,
    radius_in_light_years integer
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.galaxy ALTER COLUMN galaxy_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.galaxy_galaxy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: galaxy_type; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy_type (
    galaxy_type_id integer NOT NULL,
    name character varying(30) NOT NULL,
    general_classification character varying(30)
);


ALTER TABLE public.galaxy_type OWNER TO freecodecamp;

--
-- Name: galaxy_type_galaxy_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.galaxy_type ALTER COLUMN galaxy_type_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.galaxy_type_galaxy_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30) NOT NULL,
    planet_id integer NOT NULL,
    distance_to_planet_in_km integer,
    radius_in_km integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.moon ALTER COLUMN moon_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.moon_moon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    star_id integer NOT NULL,
    has_life boolean,
    is_spherical boolean,
    description text,
    number_of_moons integer,
    number_of_rings integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.planet ALTER COLUMN planet_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.planet_planet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    galaxy_id integer NOT NULL,
    temperature_in_k integer,
    radius_in_m_km numeric,
    gravity_in_ms2 integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.star ALTER COLUMN star_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.star_star_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (1, 'Milky Way', 1, 14, 52850);
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (2, 'Andromeda', 1, 10, 110000);
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (3, 'Backward', 2, NULL, NULL);
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (4, 'Black eye', 1, 13, 26481);
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (5, 'Cigar', 3, 13, 18500);
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (6, 'NGC 4151', 4, 13, NULL);


--
-- Data for Name: galaxy_type; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy_type OVERRIDING SYSTEM VALUE VALUES (1, 'Barred spiral galaxy', 'SB');
INSERT INTO public.galaxy_type OVERRIDING SYSTEM VALUE VALUES (2, 'Unbarred spiral galaxy', 'SA');
INSERT INTO public.galaxy_type OVERRIDING SYSTEM VALUE VALUES (3, 'Irregular galaxy', NULL);
INSERT INTO public.galaxy_type OVERRIDING SYSTEM VALUE VALUES (4, 'Intermediate spiral galaxy', 'SAB');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (1, 'Moon', 1, 384400, 1737);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (2, 'Naiad', 8, 48224, 30);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (3, 'Thalassa', 8, NULL, 41);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (4, 'Despina', 8, NULL, 78);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (5, 'Galatea', 8, NULL, 87);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (6, 'Larissa', 8, NULL, 97);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (7, 'Hippocamp', 8, NULL, 17);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (8, 'Proteus', 8, 117654, 210);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (9, 'Io', 5, 421700, 1822);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (10, 'Europa', 5, 670900, 1561);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (11, 'Ganymede', 5, 1070400, 2634);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (12, 'Callisto', 5, 1880000, 2410);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (13, 'Metis', 5, 128000, 22);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (14, 'Adrastea', 5, 129000, 8);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (15, 'Amalthea', 5, 181365, 84);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (16, 'Thebe', 5, 221889, 49);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (17, 'Mimas', 6, 185539, 198);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (18, 'Enceladus', 6, 237948, 252);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (19, 'Tethys', 6, 294619, 531);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (20, 'Dione', 6, 377396, 561);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (1, 'Earth', 1, true, true, 'Humans home', 1, 0);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (2, 'Mercury', 1, false, true, NULL, 0, 0);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (3, 'Venus', 1, false, true, NULL, 0, 0);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (4, 'Mars', 1, false, true, NULL, 2, 0);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (5, 'Saturn', 1, false, true, NULL, 83, 3);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (6, 'Uranus', 1, false, true, NULL, 27, 13);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (7, 'Neptune', 1, false, true, NULL, 13, 3);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (8, 'Pluto', 1, false, true, NULL, 5, 0);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (9, 'Eris', 1, false, true, NULL, 0, 0);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (10, 'Ceres', 1, false, true, NULL, 0, 0);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (11, 'Chiron', 1, false, true, NULL, 0, 2);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (12, 'Jupiter', 1, false, true, NULL, 80, 3);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (1, 'Stephenson 2-18', 1, 3200, 1495.8, NULL);
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (2, 'UY Scuti', 1, 3365, 1188.3, NULL);
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (3, 'V354 Cephei', 1, 3650, 768.7, NULL);
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (4, 'VY Canis Majoris', 1, 3490, 987.89, NULL);
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (5, 'AH Scorpii', 1, 3682, 981.63, NULL);
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (6, 'Sun', 1, 5778, 696340, NULL);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: galaxy_type_galaxy_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_type_galaxy_type_id_seq', 4, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: galaxy_type galaxy_type_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_type
    ADD CONSTRAINT galaxy_type_pkey PRIMARY KEY (galaxy_type_id);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: galaxy u_galaxy_name; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT u_galaxy_name UNIQUE (name);


--
-- Name: galaxy_type u_galaxy_type_name; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_type
    ADD CONSTRAINT u_galaxy_type_name UNIQUE (name);


--
-- Name: moon u_moon_type_name; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT u_moon_type_name UNIQUE (name);


--
-- Name: planet u_planet_type_name; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT u_planet_type_name UNIQUE (name);


--
-- Name: star u_star_type_name; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT u_star_type_name UNIQUE (name);


--
-- Name: star fk_galaxy; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT fk_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: galaxy fk_galaxy_type; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT fk_galaxy_type FOREIGN KEY (galaxy_type_id) REFERENCES public.galaxy_type(galaxy_type_id);


--
-- Name: moon fk_planet; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fk_planet FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet fk_star; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_star FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- PostgreSQL database dump complete
--

