--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.2

-- Started on 2020-06-30 18:36:23 EEST

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
-- TOC entry 204 (class 1259 OID 24948)
-- Name: account; Type: TABLE; Schema: public; Owner: victors
--

CREATE TABLE public.account (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    name character varying(50) NOT NULL,
    avatar character varying(255),
    created timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.account OWNER TO victors;

--
-- TOC entry 206 (class 1259 OID 24966)
-- Name: account_seq; Type: SEQUENCE; Schema: public; Owner: victors
--

CREATE SEQUENCE public.account_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_seq OWNER TO victors;

--
-- TOC entry 203 (class 1259 OID 24929)
-- Name: article; Type: TABLE; Schema: public; Owner: victors
--

CREATE TABLE public.article (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    logo character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    content text NOT NULL,
    id_category bigint NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    views integer DEFAULT 0 NOT NULL,
    comments integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.article OWNER TO victors;

--
-- TOC entry 202 (class 1259 OID 24917)
-- Name: category; Type: TABLE; Schema: public; Owner: victors
--

CREATE TABLE public.category (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    url character varying(50) NOT NULL,
    articles integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.category OWNER TO victors;

--
-- TOC entry 205 (class 1259 OID 24957)
-- Name: comment; Type: TABLE; Schema: public; Owner: victors
--

CREATE TABLE public.comment (
    id bigint NOT NULL,
    id_account bigint NOT NULL,
    id_article bigint NOT NULL,
    content text NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.comment OWNER TO victors;

--
-- TOC entry 207 (class 1259 OID 24968)
-- Name: comment_seq; Type: SEQUENCE; Schema: public; Owner: victors
--

CREATE SEQUENCE public.comment_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_seq OWNER TO victors;

--
-- TOC entry 3224 (class 0 OID 24948)
-- Dependencies: 204
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: victors
--

COPY public.account (id, email, name, avatar, created) FROM stdin;
\.


--
-- TOC entry 3223 (class 0 OID 24929)
-- Dependencies: 203
-- Data for Name: article; Type: TABLE DATA; Schema: public; Owner: victors
--

COPY public.article (id, title, url, logo, description, content, id_category, created, views, comments) FROM stdin;
\.


--
-- TOC entry 3222 (class 0 OID 24917)
-- Dependencies: 202
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: victors
--

COPY public.category (id, name, url, articles) FROM stdin;
\.


--
-- TOC entry 3225 (class 0 OID 24957)
-- Dependencies: 205
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: victors
--

COPY public.comment (id, id_account, id_article, content, created) FROM stdin;
\.


--
-- TOC entry 3233 (class 0 OID 0)
-- Dependencies: 206
-- Name: account_seq; Type: SEQUENCE SET; Schema: public; Owner: victors
--

SELECT pg_catalog.setval('public.account_seq', 1, false);


--
-- TOC entry 3234 (class 0 OID 0)
-- Dependencies: 207
-- Name: comment_seq; Type: SEQUENCE SET; Schema: public; Owner: victors
--

SELECT pg_catalog.setval('public.comment_seq', 1, false);


--
-- TOC entry 3088 (class 2606 OID 24952)
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: victors
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- TOC entry 3086 (class 2606 OID 24933)
-- Name: article article_pkey; Type: CONSTRAINT; Schema: public; Owner: victors
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_pkey PRIMARY KEY (id);


--
-- TOC entry 3083 (class 2606 OID 24923)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: victors
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- TOC entry 3092 (class 2606 OID 24964)
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: victors
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- TOC entry 3084 (class 1259 OID 24986)
-- Name: article_indx; Type: INDEX; Schema: public; Owner: victors
--

CREATE INDEX article_indx ON public.article USING btree (id_category);


--
-- TOC entry 3089 (class 1259 OID 24985)
-- Name: comment_indx; Type: INDEX; Schema: public; Owner: victors
--

CREATE INDEX comment_indx ON public.comment USING btree (id_article);


--
-- TOC entry 3090 (class 1259 OID 24987)
-- Name: comment_indx1; Type: INDEX; Schema: public; Owner: victors
--

CREATE INDEX comment_indx1 ON public.comment USING btree (id_account);


--
-- TOC entry 3095 (class 2606 OID 24980)
-- Name: comment id_account; Type: FK CONSTRAINT; Schema: public; Owner: victors
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT id_account FOREIGN KEY (id_account) REFERENCES public.account(id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3094 (class 2606 OID 24975)
-- Name: comment id_article; Type: FK CONSTRAINT; Schema: public; Owner: victors
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT id_article FOREIGN KEY (id_article) REFERENCES public.article(id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3093 (class 2606 OID 24970)
-- Name: article id_category; Type: FK CONSTRAINT; Schema: public; Owner: victors
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT id_category FOREIGN KEY (id_category) REFERENCES public.category(id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;


-- Completed on 2020-06-30 18:36:23 EEST

--
-- PostgreSQL database dump complete
--

