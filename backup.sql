--
-- PostgreSQL database dump
--

-- Dumped from database version 14.15 (Ubuntu 14.15-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.15 (Ubuntu 14.15-0ubuntu0.22.04.1)

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
-- Name: ubercuba; Type: SCHEMA; Schema: -; Owner: erito
--

CREATE SCHEMA ubercuba;


ALTER SCHEMA ubercuba OWNER TO erito;

--
-- Name: usuarios_rol_enum; Type: TYPE; Schema: ubercuba; Owner: erito
--

CREATE TYPE ubercuba.usuarios_rol_enum AS ENUM (
    'admin',
    'chofer',
    'cliente',
    'turista'
);


ALTER TYPE ubercuba.usuarios_rol_enum OWNER TO erito;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: choferes; Type: TABLE; Schema: ubercuba; Owner: erito
--

CREATE TABLE ubercuba.choferes (
    id_chofer integer NOT NULL,
    id_usuario integer,
    licencia_conduccion character varying(50) NOT NULL,
    licencia_operativa character varying(50),
    annos_experiencia integer DEFAULT 0 NOT NULL,
    direccion character varying(255),
    puntacion integer DEFAULT 100 NOT NULL,
    estado character varying(15) DEFAULT 'en linea'::character varying NOT NULL
);


ALTER TABLE ubercuba.choferes OWNER TO erito;

--
-- Name: choferes_id_chofer_seq; Type: SEQUENCE; Schema: ubercuba; Owner: erito
--

CREATE SEQUENCE ubercuba.choferes_id_chofer_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ubercuba.choferes_id_chofer_seq OWNER TO erito;

--
-- Name: choferes_id_chofer_seq; Type: SEQUENCE OWNED BY; Schema: ubercuba; Owner: erito
--

ALTER SEQUENCE ubercuba.choferes_id_chofer_seq OWNED BY ubercuba.choferes.id_chofer;


--
-- Name: historial_solicitudes; Type: TABLE; Schema: ubercuba; Owner: erito
--

CREATE TABLE ubercuba.historial_solicitudes (
    id_historial integer NOT NULL,
    id_usuario integer,
    id_solicitud integer,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE ubercuba.historial_solicitudes OWNER TO erito;

--
-- Name: historial_solicitudes_id_historial_seq; Type: SEQUENCE; Schema: ubercuba; Owner: erito
--

CREATE SEQUENCE ubercuba.historial_solicitudes_id_historial_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ubercuba.historial_solicitudes_id_historial_seq OWNER TO erito;

--
-- Name: historial_solicitudes_id_historial_seq; Type: SEQUENCE OWNED BY; Schema: ubercuba; Owner: erito
--

ALTER SEQUENCE ubercuba.historial_solicitudes_id_historial_seq OWNED BY ubercuba.historial_solicitudes.id_historial;


--
-- Name: solicitudes; Type: TABLE; Schema: ubercuba; Owner: erito
--

CREATE TABLE ubercuba.solicitudes (
    id_solicitud integer NOT NULL,
    fecha_hora timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    lugar_origen character varying(255) NOT NULL,
    lugar_destino character varying(255) NOT NULL,
    tipo_solicitud character varying(10),
    clase_vehiculo character varying(50) NOT NULL,
    capacidad_requerida integer NOT NULL,
    precio numeric(10,2) NOT NULL,
    CONSTRAINT solicitudes_tipo_solicitud_check CHECK (((tipo_solicitud)::text = ANY ((ARRAY['al momento'::character varying, 'reservar'::character varying])::text[])))
);


ALTER TABLE ubercuba.solicitudes OWNER TO erito;

--
-- Name: solicitudes_id_solicitud_seq; Type: SEQUENCE; Schema: ubercuba; Owner: erito
--

CREATE SEQUENCE ubercuba.solicitudes_id_solicitud_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ubercuba.solicitudes_id_solicitud_seq OWNER TO erito;

--
-- Name: solicitudes_id_solicitud_seq; Type: SEQUENCE OWNED BY; Schema: ubercuba; Owner: erito
--

ALTER SEQUENCE ubercuba.solicitudes_id_solicitud_seq OWNED BY ubercuba.solicitudes.id_solicitud;


--
-- Name: usuarios; Type: TABLE; Schema: ubercuba; Owner: erito
--

CREATE TABLE ubercuba.usuarios (
    id_usuario integer NOT NULL,
    usuario character varying(50) NOT NULL,
    foto_perfil character varying(255),
    email character varying(100),
    numero_telefono character varying(15),
    fecha_creacion timestamp without time zone DEFAULT now() NOT NULL,
    contrasena character varying(255) NOT NULL,
    rol ubercuba.usuarios_rol_enum NOT NULL
);


ALTER TABLE ubercuba.usuarios OWNER TO erito;

--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: ubercuba; Owner: erito
--

CREATE SEQUENCE ubercuba.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ubercuba.usuarios_id_usuario_seq OWNER TO erito;

--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: ubercuba; Owner: erito
--

ALTER SEQUENCE ubercuba.usuarios_id_usuario_seq OWNED BY ubercuba.usuarios.id_usuario;


--
-- Name: vehicle; Type: TABLE; Schema: ubercuba; Owner: erito
--

CREATE TABLE ubercuba.vehicle (
    id_vehiculo integer NOT NULL,
    matricula character varying(20) NOT NULL,
    modelo character varying(50) NOT NULL,
    capacidad integer NOT NULL,
    foto_vehiculo character varying(255),
    climatizado boolean,
    musica boolean,
    comodidad_asientos boolean,
    id_chofer integer
);


ALTER TABLE ubercuba.vehicle OWNER TO erito;

--
-- Name: vehicle_id_vehiculo_seq; Type: SEQUENCE; Schema: ubercuba; Owner: erito
--

CREATE SEQUENCE ubercuba.vehicle_id_vehiculo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ubercuba.vehicle_id_vehiculo_seq OWNER TO erito;

--
-- Name: vehicle_id_vehiculo_seq; Type: SEQUENCE OWNED BY; Schema: ubercuba; Owner: erito
--

ALTER SEQUENCE ubercuba.vehicle_id_vehiculo_seq OWNED BY ubercuba.vehicle.id_vehiculo;


--
-- Name: choferes id_chofer; Type: DEFAULT; Schema: ubercuba; Owner: erito
--

ALTER TABLE ONLY ubercuba.choferes ALTER COLUMN id_chofer SET DEFAULT nextval('ubercuba.choferes_id_chofer_seq'::regclass);


--
-- Name: historial_solicitudes id_historial; Type: DEFAULT; Schema: ubercuba; Owner: erito
--

ALTER TABLE ONLY ubercuba.historial_solicitudes ALTER COLUMN id_historial SET DEFAULT nextval('ubercuba.historial_solicitudes_id_historial_seq'::regclass);


--
-- Name: solicitudes id_solicitud; Type: DEFAULT; Schema: ubercuba; Owner: erito
--

ALTER TABLE ONLY ubercuba.solicitudes ALTER COLUMN id_solicitud SET DEFAULT nextval('ubercuba.solicitudes_id_solicitud_seq'::regclass);


--
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: ubercuba; Owner: erito
--

ALTER TABLE ONLY ubercuba.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('ubercuba.usuarios_id_usuario_seq'::regclass);


--
-- Name: vehicle id_vehiculo; Type: DEFAULT; Schema: ubercuba; Owner: erito
--

ALTER TABLE ONLY ubercuba.vehicle ALTER COLUMN id_vehiculo SET DEFAULT nextval('ubercuba.vehicle_id_vehiculo_seq'::regclass);


--
-- Data for Name: choferes; Type: TABLE DATA; Schema: ubercuba; Owner: erito
--

COPY ubercuba.choferes (id_chofer, id_usuario, licencia_conduccion, licencia_operativa, annos_experiencia, direccion, puntacion, estado) FROM stdin;
1	2	eqweqweqw	dqdq	1	string	100	desconectado
\.


--
-- Data for Name: historial_solicitudes; Type: TABLE DATA; Schema: ubercuba; Owner: erito
--

COPY ubercuba.historial_solicitudes (id_historial, id_usuario, id_solicitud, fecha) FROM stdin;
\.


--
-- Data for Name: solicitudes; Type: TABLE DATA; Schema: ubercuba; Owner: erito
--

COPY ubercuba.solicitudes (id_solicitud, fecha_hora, lugar_origen, lugar_destino, tipo_solicitud, clase_vehiculo, capacidad_requerida, precio) FROM stdin;
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: ubercuba; Owner: erito
--

COPY ubercuba.usuarios (id_usuario, usuario, foto_perfil, email, numero_telefono, fecha_creacion, contrasena, rol) FROM stdin;
2	everdecia	\N	cccc@gmail.cooomm	56217803	2025-01-31 23:25:40.452839	$2b$10$YGvZImyoFtSbryVfD.4LieSpckcZogUqI9iFf6gepYwh5bl7eGKTu	chofer
\.


--
-- Data for Name: vehicle; Type: TABLE DATA; Schema: ubercuba; Owner: erito
--

COPY ubercuba.vehicle (id_vehiculo, matricula, modelo, capacidad, foto_vehiculo, climatizado, musica, comodidad_asientos, id_chofer) FROM stdin;
4	S143654	Lamborjiny	4	string	t	t	t	1
\.


--
-- Name: choferes_id_chofer_seq; Type: SEQUENCE SET; Schema: ubercuba; Owner: erito
--

SELECT pg_catalog.setval('ubercuba.choferes_id_chofer_seq', 2, true);


--
-- Name: historial_solicitudes_id_historial_seq; Type: SEQUENCE SET; Schema: ubercuba; Owner: erito
--

SELECT pg_catalog.setval('ubercuba.historial_solicitudes_id_historial_seq', 1, false);


--
-- Name: solicitudes_id_solicitud_seq; Type: SEQUENCE SET; Schema: ubercuba; Owner: erito
--

SELECT pg_catalog.setval('ubercuba.solicitudes_id_solicitud_seq', 1, false);


--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: ubercuba; Owner: erito
--

SELECT pg_catalog.setval('ubercuba.usuarios_id_usuario_seq', 2, true);


--
-- Name: vehicle_id_vehiculo_seq; Type: SEQUENCE SET; Schema: ubercuba; Owner: erito
--

SELECT pg_catalog.setval('ubercuba.vehicle_id_vehiculo_seq', 4, true);


--
-- Name: vehicle PK_285216f356842cf93fd9ee7e15b; Type: CONSTRAINT; Schema: ubercuba; Owner: erito
--

ALTER TABLE ONLY ubercuba.vehicle
    ADD CONSTRAINT "PK_285216f356842cf93fd9ee7e15b" PRIMARY KEY (id_vehiculo);


--
-- Name: vehicle UQ_2288c15783127e39a71c4f7034d; Type: CONSTRAINT; Schema: ubercuba; Owner: erito
--

ALTER TABLE ONLY ubercuba.vehicle
    ADD CONSTRAINT "UQ_2288c15783127e39a71c4f7034d" UNIQUE (id_chofer);


--
-- Name: choferes choferes_id_usuario_key; Type: CONSTRAINT; Schema: ubercuba; Owner: erito
--

ALTER TABLE ONLY ubercuba.choferes
    ADD CONSTRAINT choferes_id_usuario_key UNIQUE (id_usuario);


--
-- Name: choferes choferes_pkey; Type: CONSTRAINT; Schema: ubercuba; Owner: erito
--

ALTER TABLE ONLY ubercuba.choferes
    ADD CONSTRAINT choferes_pkey PRIMARY KEY (id_chofer);


--
-- Name: historial_solicitudes historial_solicitudes_pkey; Type: CONSTRAINT; Schema: ubercuba; Owner: erito
--

ALTER TABLE ONLY ubercuba.historial_solicitudes
    ADD CONSTRAINT historial_solicitudes_pkey PRIMARY KEY (id_historial);


--
-- Name: solicitudes solicitudes_pkey; Type: CONSTRAINT; Schema: ubercuba; Owner: erito
--

ALTER TABLE ONLY ubercuba.solicitudes
    ADD CONSTRAINT solicitudes_pkey PRIMARY KEY (id_solicitud);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: ubercuba; Owner: erito
--

ALTER TABLE ONLY ubercuba.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- Name: vehicle FK_2288c15783127e39a71c4f7034d; Type: FK CONSTRAINT; Schema: ubercuba; Owner: erito
--

ALTER TABLE ONLY ubercuba.vehicle
    ADD CONSTRAINT "FK_2288c15783127e39a71c4f7034d" FOREIGN KEY (id_chofer) REFERENCES ubercuba.choferes(id_chofer);


--
-- Name: choferes FK_fb7bdac92f3f3b6e736583cdca0; Type: FK CONSTRAINT; Schema: ubercuba; Owner: erito
--

ALTER TABLE ONLY ubercuba.choferes
    ADD CONSTRAINT "FK_fb7bdac92f3f3b6e736583cdca0" FOREIGN KEY (id_usuario) REFERENCES ubercuba.usuarios(id_usuario);


--
-- Name: historial_solicitudes historial_solicitudes_id_solicitud_fkey; Type: FK CONSTRAINT; Schema: ubercuba; Owner: erito
--

ALTER TABLE ONLY ubercuba.historial_solicitudes
    ADD CONSTRAINT historial_solicitudes_id_solicitud_fkey FOREIGN KEY (id_solicitud) REFERENCES ubercuba.solicitudes(id_solicitud);


--
-- Name: historial_solicitudes historial_solicitudes_id_solicitud_fkey1; Type: FK CONSTRAINT; Schema: ubercuba; Owner: erito
--

ALTER TABLE ONLY ubercuba.historial_solicitudes
    ADD CONSTRAINT historial_solicitudes_id_solicitud_fkey1 FOREIGN KEY (id_solicitud) REFERENCES ubercuba.solicitudes(id_solicitud) ON DELETE CASCADE;


--
-- Name: historial_solicitudes historial_solicitudes_id_usuario_fkey; Type: FK CONSTRAINT; Schema: ubercuba; Owner: erito
--

ALTER TABLE ONLY ubercuba.historial_solicitudes
    ADD CONSTRAINT historial_solicitudes_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES ubercuba.usuarios(id_usuario);


--
-- Name: historial_solicitudes historial_solicitudes_id_usuario_fkey1; Type: FK CONSTRAINT; Schema: ubercuba; Owner: erito
--

ALTER TABLE ONLY ubercuba.historial_solicitudes
    ADD CONSTRAINT historial_solicitudes_id_usuario_fkey1 FOREIGN KEY (id_usuario) REFERENCES ubercuba.usuarios(id_usuario) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

