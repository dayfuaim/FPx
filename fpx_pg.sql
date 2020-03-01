--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

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

DROP DATABASE IF EXISTS fpx;
--
-- Name: fpx; Type: DATABASE; Schema: -; Owner: dayfuaim
--

CREATE DATABASE fpx WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';


ALTER DATABASE fpx OWNER TO dayfuaim;

\connect fpx

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
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: dayfuaim
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO dayfuaim;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: dayfuaim
--

CREATE TABLE public.categories (
    id integer DEFAULT nextval('public.categories_id_seq'::regclass) NOT NULL,
    name text NOT NULL,
    sum_planned real NOT NULL,
    sort_order integer DEFAULT 0
);


ALTER TABLE public.categories OWNER TO dayfuaim;

--
-- Name: fp_categories; Type: TABLE; Schema: public; Owner: dayfuaim
--

CREATE TABLE public.fp_categories (
    id integer NOT NULL,
    fp_id integer NOT NULL,
    category_id integer NOT NULL,
    sum real DEFAULT 0.0 NOT NULL,
    comment character varying(64)
);


ALTER TABLE public.fp_categories OWNER TO dayfuaim;

--
-- Name: fp_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: dayfuaim
--

CREATE SEQUENCE public.fp_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fp_categories_id_seq OWNER TO dayfuaim;

--
-- Name: fp_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dayfuaim
--

ALTER SEQUENCE public.fp_categories_id_seq OWNED BY public.fp_categories.id;


--
-- Name: fp_incomes; Type: TABLE; Schema: public; Owner: dayfuaim
--

CREATE TABLE public.fp_incomes (
    id integer NOT NULL,
    fp_id integer NOT NULL,
    income_id integer NOT NULL,
    date_in timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    comment character varying(64)
);


ALTER TABLE public.fp_incomes OWNER TO dayfuaim;

--
-- Name: fp_incomes_id_seq; Type: SEQUENCE; Schema: public; Owner: dayfuaim
--

CREATE SEQUENCE public.fp_incomes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fp_incomes_id_seq OWNER TO dayfuaim;

--
-- Name: fp_incomes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dayfuaim
--

ALTER SEQUENCE public.fp_incomes_id_seq OWNED BY public.fp_incomes.id;


--
-- Name: fp_payments; Type: TABLE; Schema: public; Owner: dayfuaim
--

CREATE TABLE public.fp_payments (
    id integer NOT NULL,
    fp_id integer NOT NULL,
    category_id integer NOT NULL,
    payment_id integer NOT NULL,
    pocket_id integer DEFAULT 0,
    date_in timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    comment character varying(64)
);


ALTER TABLE public.fp_payments OWNER TO dayfuaim;

--
-- Name: fp_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: dayfuaim
--

CREATE SEQUENCE public.fp_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fp_payments_id_seq OWNER TO dayfuaim;

--
-- Name: fp_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dayfuaim
--

ALTER SEQUENCE public.fp_payments_id_seq OWNED BY public.fp_payments.id;


--
-- Name: fps; Type: TABLE; Schema: public; Owner: dayfuaim
--

CREATE TABLE public.fps (
    id integer NOT NULL,
    date_in timestamp without time zone NOT NULL,
    date_out timestamp without time zone,
    sum_total real DEFAULT 0 NOT NULL
);


ALTER TABLE public.fps OWNER TO dayfuaim;

--
-- Name: fps_id_seq; Type: SEQUENCE; Schema: public; Owner: dayfuaim
--

CREATE SEQUENCE public.fps_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fps_id_seq OWNER TO dayfuaim;

--
-- Name: fps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dayfuaim
--

ALTER SEQUENCE public.fps_id_seq OWNED BY public.fps.id;


--
-- Name: incomes_id_seq; Type: SEQUENCE; Schema: public; Owner: dayfuaim
--

CREATE SEQUENCE public.incomes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.incomes_id_seq OWNER TO dayfuaim;

--
-- Name: incomes; Type: TABLE; Schema: public; Owner: dayfuaim
--

CREATE TABLE public.incomes (
    id integer DEFAULT nextval('public.incomes_id_seq'::regclass) NOT NULL,
    date timestamp without time zone NOT NULL,
    sum real NOT NULL,
    comment character varying(128)
);


ALTER TABLE public.incomes OWNER TO dayfuaim;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: dayfuaim
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_id_seq OWNER TO dayfuaim;

--
-- Name: payments; Type: TABLE; Schema: public; Owner: dayfuaim
--

CREATE TABLE public.payments (
    id integer DEFAULT nextval('public.payments_id_seq'::regclass) NOT NULL,
    date timestamp without time zone NOT NULL,
    sum real,
    comment character varying(128)
);


ALTER TABLE public.payments OWNER TO dayfuaim;

--
-- Name: pockets_id_seq; Type: SEQUENCE; Schema: public; Owner: dayfuaim
--

CREATE SEQUENCE public.pockets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pockets_id_seq OWNER TO dayfuaim;

--
-- Name: pockets; Type: TABLE; Schema: public; Owner: dayfuaim
--

CREATE TABLE public.pockets (
    id integer DEFAULT nextval('public.pockets_id_seq'::regclass) NOT NULL,
    name character varying(64) NOT NULL,
    sum real NOT NULL,
    goal real DEFAULT 0.00 NOT NULL,
    accum boolean DEFAULT false NOT NULL,
    to_date timestamp without time zone
);


ALTER TABLE public.pockets OWNER TO dayfuaim;

--
-- Name: fp_categories id; Type: DEFAULT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.fp_categories ALTER COLUMN id SET DEFAULT nextval('public.fp_categories_id_seq'::regclass);


--
-- Name: fp_incomes id; Type: DEFAULT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.fp_incomes ALTER COLUMN id SET DEFAULT nextval('public.fp_incomes_id_seq'::regclass);


--
-- Name: fp_payments id; Type: DEFAULT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.fp_payments ALTER COLUMN id SET DEFAULT nextval('public.fp_payments_id_seq'::regclass);


--
-- Name: fps id; Type: DEFAULT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.fps ALTER COLUMN id SET DEFAULT nextval('public.fps_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: dayfuaim
--

INSERT INTO public.categories VALUES (1, 'Коммуналка', 0, 0);
INSERT INTO public.categories VALUES (2, 'Гигиена и парфюмерия', 0, 0);
INSERT INTO public.categories VALUES (3, 'Развлечения', 0, 0);
INSERT INTO public.categories VALUES (4, 'Уход за домом', 0, 0);
INSERT INTO public.categories VALUES (5, 'Долг', 1, 0);
INSERT INTO public.categories VALUES (6, 'Зарплата', 0, 0);
INSERT INTO public.categories VALUES (7, 'Транспорт', 0, 0);
INSERT INTO public.categories VALUES (8, 'Прочее', 0, 0);
INSERT INTO public.categories VALUES (9, 'Отложенные (родители)', 1, 0);
INSERT INTO public.categories VALUES (10, 'Техника', 1, 0);


--
-- Data for Name: fp_categories; Type: TABLE DATA; Schema: public; Owner: dayfuaim
--

INSERT INTO public.fp_categories VALUES (22, 4, 1, 0, NULL);
INSERT INTO public.fp_categories VALUES (23, 4, 2, 0, NULL);
INSERT INTO public.fp_categories VALUES (24, 4, 3, 0, NULL);
INSERT INTO public.fp_categories VALUES (25, 4, 4, 0, NULL);
INSERT INTO public.fp_categories VALUES (26, 4, 5, 0, NULL);
INSERT INTO public.fp_categories VALUES (27, 4, 6, 0, NULL);
INSERT INTO public.fp_categories VALUES (28, 4, 7, 0, NULL);
INSERT INTO public.fp_categories VALUES (29, 4, 8, 0, NULL);
INSERT INTO public.fp_categories VALUES (30, 4, 9, 0, NULL);
INSERT INTO public.fp_categories VALUES (31, 4, 10, 0, NULL);


--
-- Data for Name: fp_incomes; Type: TABLE DATA; Schema: public; Owner: dayfuaim
--



--
-- Data for Name: fp_payments; Type: TABLE DATA; Schema: public; Owner: dayfuaim
--

INSERT INTO public.fp_payments VALUES (1, 4, 1, 1, 0, '2020-03-01 19:08:01.30457', NULL);
INSERT INTO public.fp_payments VALUES (2, 4, 2, 2, 0, '2020-03-01 19:13:23.094633', NULL);
INSERT INTO public.fp_payments VALUES (3, 4, 4, 3, 0, '2020-03-01 19:17:15.137432', NULL);
INSERT INTO public.fp_payments VALUES (4, 4, 1, 4, 0, '2020-03-01 19:18:31.905936', NULL);


--
-- Data for Name: fps; Type: TABLE DATA; Schema: public; Owner: dayfuaim
--

INSERT INTO public.fps VALUES (1, '2020-01-16 00:00:00', '2020-01-29 00:00:00', 0);
INSERT INTO public.fps VALUES (2, '2020-01-30 00:00:00', '2020-02-12 00:00:00', 0);
INSERT INTO public.fps VALUES (3, '2020-02-13 00:00:00', '2020-02-26 00:00:00', 0);
INSERT INTO public.fps VALUES (4, '2020-02-27 00:00:00', '2020-03-11 00:00:00', 0);


--
-- Data for Name: incomes; Type: TABLE DATA; Schema: public; Owner: dayfuaim
--



--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: dayfuaim
--

INSERT INTO public.payments VALUES (1, '2020-03-01 00:00:00', 5231.56, 'Some stuff');
INSERT INTO public.payments VALUES (2, '2020-03-01 00:00:00', 900, 'Some stuff #1');
INSERT INTO public.payments VALUES (3, '2020-01-05 00:00:00', 900, 'Some stuff #1');
INSERT INTO public.payments VALUES (4, '2020-03-01 00:00:00', 985, '');


--
-- Data for Name: pockets; Type: TABLE DATA; Schema: public; Owner: dayfuaim
--

INSERT INTO public.pockets VALUES (1, 'Долг', 50000, 0, false, NULL);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dayfuaim
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- Name: fp_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dayfuaim
--

SELECT pg_catalog.setval('public.fp_categories_id_seq', 31, true);


--
-- Name: fp_incomes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dayfuaim
--

SELECT pg_catalog.setval('public.fp_incomes_id_seq', 1, false);


--
-- Name: fp_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dayfuaim
--

SELECT pg_catalog.setval('public.fp_payments_id_seq', 4, true);


--
-- Name: fps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dayfuaim
--

SELECT pg_catalog.setval('public.fps_id_seq', 4, true);


--
-- Name: incomes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dayfuaim
--

SELECT pg_catalog.setval('public.incomes_id_seq', 1, false);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dayfuaim
--

SELECT pg_catalog.setval('public.payments_id_seq', 4, true);


--
-- Name: pockets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dayfuaim
--

SELECT pg_catalog.setval('public.pockets_id_seq', 1, false);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: fp_categories fp_categories_pk; Type: CONSTRAINT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.fp_categories
    ADD CONSTRAINT fp_categories_pk PRIMARY KEY (id);


--
-- Name: fp_incomes fp_incomes_pk; Type: CONSTRAINT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.fp_incomes
    ADD CONSTRAINT fp_incomes_pk PRIMARY KEY (id);


--
-- Name: fp_payments fp_payments_pk; Type: CONSTRAINT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.fp_payments
    ADD CONSTRAINT fp_payments_pk PRIMARY KEY (id);


--
-- Name: fps fps_pkey; Type: CONSTRAINT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.fps
    ADD CONSTRAINT fps_pkey PRIMARY KEY (id);


--
-- Name: incomes incomes_pkey; Type: CONSTRAINT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.incomes
    ADD CONSTRAINT incomes_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: pockets pockets_pkey; Type: CONSTRAINT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.pockets
    ADD CONSTRAINT pockets_pkey PRIMARY KEY (id);


--
-- Name: fp_categories fp_categories_fk; Type: FK CONSTRAINT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.fp_categories
    ADD CONSTRAINT fp_categories_fk FOREIGN KEY (fp_id) REFERENCES public.fps(id);


--
-- Name: fp_categories fp_categories_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.fp_categories
    ADD CONSTRAINT fp_categories_fk_1 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: fp_incomes fp_incomes_fk; Type: FK CONSTRAINT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.fp_incomes
    ADD CONSTRAINT fp_incomes_fk FOREIGN KEY (fp_id) REFERENCES public.fps(id);


--
-- Name: fp_incomes fp_incomes_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.fp_incomes
    ADD CONSTRAINT fp_incomes_fk_1 FOREIGN KEY (income_id) REFERENCES public.incomes(id);


--
-- Name: fp_payments fp_payments_fk; Type: FK CONSTRAINT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.fp_payments
    ADD CONSTRAINT fp_payments_fk FOREIGN KEY (fp_id) REFERENCES public.fps(id);


--
-- Name: fp_payments fp_payments_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.fp_payments
    ADD CONSTRAINT fp_payments_fk_1 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: fp_payments fp_payments_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: dayfuaim
--

ALTER TABLE ONLY public.fp_payments
    ADD CONSTRAINT fp_payments_fk_2 FOREIGN KEY (payment_id) REFERENCES public.payments(id);


--
-- PostgreSQL database dump complete
--

