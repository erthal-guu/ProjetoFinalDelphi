--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-10-22 17:29:43

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET escape_string_warning = off;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 227 (class 1259 OID 67379)
-- Name: categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias (
    id integer NOT NULL,
    nome character varying(100)
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 67246)
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    cpf character varying(20) NOT NULL,
    email character varying(150),
    telefone character varying(25),
    nascimento character varying(10),
    endereco character varying(200),
    ativo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 67245)
-- Name: clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clientes_id_seq OWNER TO postgres;

--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 219
-- Name: clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clientes_id_seq OWNED BY public.clientes.id;


--
-- TOC entry 235 (class 1259 OID 75255)
-- Name: fornecedor_pecas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fornecedor_pecas (
    id integer NOT NULL,
    fornecedor_id integer NOT NULL,
    peca_id integer NOT NULL
);


ALTER TABLE public.fornecedor_pecas OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 75254)
-- Name: fornecedor_pecas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fornecedor_pecas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fornecedor_pecas_id_seq OWNER TO postgres;

--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 234
-- Name: fornecedor_pecas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fornecedor_pecas_id_seq OWNED BY public.fornecedor_pecas.id;


--
-- TOC entry 226 (class 1259 OID 67327)
-- Name: fornecedores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fornecedores (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    razao_social character varying(150) NOT NULL,
    cnpj character varying(18) NOT NULL,
    telefone character varying(15),
    cep character varying(9),
    rua character varying(100),
    numero character varying(10),
    bairro character varying(50),
    cidade character varying(50),
    estado character varying(2),
    ativo boolean DEFAULT true
);


ALTER TABLE public.fornecedores OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 67326)
-- Name: fornecedores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fornecedores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fornecedores_id_seq OWNER TO postgres;

--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 225
-- Name: fornecedores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fornecedores_id_seq OWNED BY public.fornecedores.id;


--
-- TOC entry 224 (class 1259 OID 67314)
-- Name: funcionarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.funcionarios (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    cpf character varying(14) NOT NULL,
    rg character varying(20),
    nascimento character varying(15),
    telefone character varying(15),
    cep character varying(9),
    rua character varying(100),
    numero character varying(10),
    bairro character varying(50),
    cidade character varying(50),
    estado character varying(2),
    ativo boolean DEFAULT true
);


ALTER TABLE public.funcionarios OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 67313)
-- Name: funcionarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.funcionarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.funcionarios_id_seq OWNER TO postgres;

--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 223
-- Name: funcionarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.funcionarios_id_seq OWNED BY public.funcionarios.id;


--
-- TOC entry 222 (class 1259 OID 67277)
-- Name: grupo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grupo (
    id integer NOT NULL,
    nome character varying(50) NOT NULL
);


ALTER TABLE public.grupo OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 67276)
-- Name: grupo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grupo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.grupo_id_seq OWNER TO postgres;

--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 221
-- Name: grupo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grupo_id_seq OWNED BY public.grupo.id;


--
-- TOC entry 229 (class 1259 OID 67478)
-- Name: pecas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pecas (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    descricao character varying(255),
    codigo_interno character varying(50) NOT NULL,
    id_categoria integer,
    unidade character varying(20),
    modelo character varying(50),
    ativo boolean DEFAULT true,
    preco_compra numeric(10,2)
);


ALTER TABLE public.pecas OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 67477)
-- Name: pecas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pecas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pecas_id_seq OWNER TO postgres;

--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 228
-- Name: pecas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pecas_id_seq OWNED BY public.pecas.id;


--
-- TOC entry 233 (class 1259 OID 67525)
-- Name: servicos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.servicos (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    categoria integer NOT NULL,
    preco numeric(10,2) NOT NULL,
    observacao character varying(255),
    peca_id integer,
    funcionario_id integer,
    ativo boolean DEFAULT true
);


ALTER TABLE public.servicos OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 67524)
-- Name: servicos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.servicos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.servicos_id_seq OWNER TO postgres;

--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 232
-- Name: servicos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.servicos_id_seq OWNED BY public.servicos.id;


--
-- TOC entry 218 (class 1259 OID 67212)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    cpf character varying(14) NOT NULL,
    senha character varying(255) NOT NULL,
    grupo character varying(50) DEFAULT 'cadastro'::character varying,
    ativo boolean DEFAULT true
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 67211)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 217
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- TOC entry 231 (class 1259 OID 67500)
-- Name: veiculos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.veiculos (
    id integer NOT NULL,
    modelo character varying(100) NOT NULL,
    marca character varying(100) NOT NULL,
    chassi character varying(50) NOT NULL,
    placa character varying(20) NOT NULL,
    cor character varying(50) NOT NULL,
    fabricacao character varying(20) NOT NULL,
    id_cliente integer NOT NULL,
    ativo boolean DEFAULT true
);


ALTER TABLE public.veiculos OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 67499)
-- Name: veiculos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.veiculos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.veiculos_id_seq OWNER TO postgres;

--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 230
-- Name: veiculos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.veiculos_id_seq OWNED BY public.veiculos.id;


--
-- TOC entry 4789 (class 2604 OID 67249)
-- Name: clientes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes ALTER COLUMN id SET DEFAULT nextval('public.clientes_id_seq'::regclass);


--
-- TOC entry 4802 (class 2604 OID 75258)
-- Name: fornecedor_pecas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedor_pecas ALTER COLUMN id SET DEFAULT nextval('public.fornecedor_pecas_id_seq'::regclass);


--
-- TOC entry 4794 (class 2604 OID 67330)
-- Name: fornecedores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedores ALTER COLUMN id SET DEFAULT nextval('public.fornecedores_id_seq'::regclass);


--
-- TOC entry 4792 (class 2604 OID 67317)
-- Name: funcionarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funcionarios ALTER COLUMN id SET DEFAULT nextval('public.funcionarios_id_seq'::regclass);


--
-- TOC entry 4791 (class 2604 OID 67280)
-- Name: grupo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupo ALTER COLUMN id SET DEFAULT nextval('public.grupo_id_seq'::regclass);


--
-- TOC entry 4796 (class 2604 OID 67481)
-- Name: pecas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pecas ALTER COLUMN id SET DEFAULT nextval('public.pecas_id_seq'::regclass);


--
-- TOC entry 4800 (class 2604 OID 75253)
-- Name: servicos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicos ALTER COLUMN id SET DEFAULT nextval('public.servicos_id_seq'::regclass);


--
-- TOC entry 4786 (class 2604 OID 67215)
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- TOC entry 4798 (class 2604 OID 67503)
-- Name: veiculos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.veiculos ALTER COLUMN id SET DEFAULT nextval('public.veiculos_id_seq'::regclass);


--
-- TOC entry 5004 (class 0 OID 67379)
-- Dependencies: 227
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias (id, nome) FROM stdin;
1	Motor
2	Suspensão
3	Freios
4	Transmissão
5	Sistema de Arrefecimento
6	Sistema Elétrico
7	Escape
8	Direção
9	Embreagem
10	Injeção Eletrônica
11	Iluminação
12	Pneus e Rodas
13	Interior
14	Exterior
15	Filtros
16	Correias e Polias
\.


--
-- TOC entry 4997 (class 0 OID 67246)
-- Dependencies: 220
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clientes (id, nome, cpf, email, telefone, nascimento, endereco, ativo) FROM stdin;
1	Ana Martins	111.222.333-00	ana.martins@email.com	(11)98877-1234	1990-01-10	Av. Brasil, 123	t
2	Bruno Souza	222.333.444-11	bruno.souza@email.com	(21)98546-8574	1987-05-22	Rua das Flores, 320	t
5	Eduardo Santos	555.666.777-44	eduardo.santos@email.com	(81)98812-1122	1978-03-17	Alameda das Palmeiras, 12	t
7	Gabriel Silva	777.888.999-66	gabriel.silva@email.com	(51)98123-5467	1989-11-11	Rua Aurora, 31	t
8	Helena Alves	888.999.000-77	helena.alves@email.com	(31)98456-7755	1984-02-02	Travessa das Palmeiras, 7	t
9	Igor Azevedo	999.000.111-88	igor.azevedo@email.com	(71)98490-8787	1991-07-21	Rua Central, 180	t
11	Kevin Ramos	123.456.789-01	kevin.ramos@email.com	(61)98877-1122	1990-08-15	Rua Nova, 21	t
12	Larissa Mendes	124.457.780-12	larissa.mendes@email.com	(11)91345-9012	2000-10-12	Av. Paulista, 2500	t
14	Natália Castro	126.459.782-34	natalia.castro@email.com	(41)98765-4321	1979-12-28	Rua Aurora Boreal, 15	t
15	Otávio Barros	127.460.783-45	otavio.barros@email.com	(51)98822-4499	1996-05-05	Rua das Oliveiras, 100	t
17	Quésia Rocha	129.462.785-67	quesia.rocha@email.com	(67)98745-2145	1983-10-13	Rua Serra Azul, 99	t
18	Rafael Matos	130.463.786-78	rafael.matos@email.com	(12)98233-8957	1984-09-25	Rua Lagoa Seca, 8	t
19	Sandra Oliveira	131.464.787-89	sandra.oliveira@email.com	(62)99129-3344	1999-03-22	Rua das Hortências, 60	t
6	Fernanda Costa	666.777.888-55	fernanda.costa@email.com	(85)99134-0001	1995-12-25	Rua das Pedras, 89	t
10	Julia Farias	000.111.222-99	julia.farias@email.com	(21)99987-8989	1993-04-19	Praça do Sol, 80	t
13	Marcelo Silva	125.458.781-23	marcelo.silva@email.com	(91)98112-9988	1982-06-18	Rua das Magnólias, 6	t
16	Paula Duarte	128.461.784-56	paula.duarte@email.com	(19)99877-5874	1997-07-31	Rua da Paz, 200	t
20	Thiago Nunes	132.465.788-90	thiago.nunes@email.com	(31)98433-2618	1975-06-10	Rua das Sequoias, 13	t
3	Carlos Gay	333.444.555-22	carlos.pereira@email.com	(31)99656-6651	30/  /  	Rua das Laranjeiras, 55	t
4	Gabriel Kuchma	444.555.666-33	daniela.lima@email.com	(11)91234-2323	47/16/74	Rua do Lago, 45	t
\.


--
-- TOC entry 5012 (class 0 OID 75255)
-- Dependencies: 235
-- Data for Name: fornecedor_pecas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fornecedor_pecas (id, fornecedor_id, peca_id) FROM stdin;
\.


--
-- TOC entry 5003 (class 0 OID 67327)
-- Dependencies: 226
-- Data for Name: fornecedores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fornecedores (id, nome, razao_social, cnpj, telefone, cep, rua, numero, bairro, cidade, estado, ativo) FROM stdin;
1	BustaPeças	BustaPeçasLtda	16.647.916/4791-69	(419)879-7073	81560-280	Rua Agostinho Ângelo Trevisan	592	Uberaba	Curitiba	PR	t
2	MaxAuto	Max Auto Peças Ltda	12.345.678/0001-12	(11)3333-1111	02710-000	Rua Autonomistas	800	Lapa	São Paulo	SP	t
3	ComercialParaná	Comercial Paraná Peças	23.456.789/0001-23	(41)1111-2345	82520-100	Av. Paraná	1520	Bacacheri	Curitiba	PR	t
4	SuperPeças	Super Peças do Brasil LTDA	34.567.890/0001-34	(31)2211-8899	30730-480	Rua dos Peças	240	Carlos Prates	Belo Horizonte	MG	t
5	RTAuto	RT Auto Supermercado	45.678.901/0001-45	(61)2050-1123	72120-150	Av. Central	370	Taguatinga	Brasilia	DF	t
6	NipoCar	NipoCar Distribuidora	56.789.012/0001-56	(13)4151-2211	11070-100	Rua Japão	98	Boqueirão	Santos	SP	t
7	PeçaCerta	Peça Certa Distribuição	67.890.123/0001-67	(62)3636-7854	74000-080	Avenida Goiás	900	Centro	Goiânia	GO	t
8	RotaPeças	Rota Peças EIRELI	78.901.234/0001-78	(51)5588-1020	90480-000	Av. Carlos Gomes	1590	Auxiliadora	Porto Alegre	RS	t
9	SulAuto	Sul Auto Center	89.012.345/0001-89	(48)9981-5402	88035-001	Rua Vereador	1452	Itacorubi	Florianópolis	SC	t
10	PneuMaster	PneuMaster Serviços Ltda	90.123.456/0001-90	(21)2111-4321	23085-000	Rua dos Pneus	333	Campo Grande	Rio de Janeiro	RJ	t
11	ParanaDistribuidora	Distribuidora Paraná	20.987.654/0010-98	(41)3321-1010	81060-180	Av. Brasília	1100	Novo Mundo	Curitiba	PR	t
12	CentroPeças	Centro Comercial de Peças	30.876.543/0010-09	(85)99111-2200	60060-010	Rua Major Holanda	112	Aldeota	Fortaleza	CE	t
13	RSDistribuidor	RS Distribuidor de Auto Peças	40.765.432/0010-67	(51)9465-0429	90010-370	Travessa São José	258	Centro	Porto Alegre	RS	t
14	AmazonPeças	Amazonas Auto Peças	50.654.321/0002-45	(92)3234-2121	69059-050	Av. das Torres	740	Parque 10	Manaus	AM	t
15	TecAuto	Tec Auto Importadora	60.543.210/0001-12	(11)9000-4567	06418-120	Alameda Tocantins	200	Alphaville	Barueri	SP	t
16	SPAuto	SP Auto Representações	70.432.109/0002-34	(19)3927-3243	13070-120	Rua Treze de Maio	1182	Centro	Campinas	SP	t
17	FortCar	FortCar Comércio de Peças	80.321.098/0001-23	(85)3433-4123	60540-747	Rua Fortim	689	Carlito Pamplona	Fortaleza	CE	t
18	PontoPeças	Ponto das Peças Ltda	91.234.567/0001-90	(61)3355-8899	72025-705	QE 40	02	Guará	Brasilia	DF	t
20	PrecisionParts	Precision Parts Soluções Ltda	44.321.098/0001-77	(47)9922-7000	89260-430	Rua Joinville	1200	Centro	Joinville	SC	t
19	MegaPeças	Mega Peças do Brasil	12.876.543/0012-09	(31)4312-8700	31744-002	Rua dos Mecânicos	872	Venda Nova	Belo Horizonte	MG	t
\.


--
-- TOC entry 5001 (class 0 OID 67314)
-- Dependencies: 224
-- Data for Name: funcionarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.funcionarios (id, nome, cpf, rg, nascimento, telefone, cep, rua, numero, bairro, cidade, estado, ativo) FROM stdin;
1	Gustavo	139.471.968-89	14.178.467-1	15/02/08	(41)98797-0732	81560280	Rua Agostinho Ângelo Trevisan	582	Uberaba	Curitiba	PR	t
2	Mariana	111.222.333-44	11.222.333-4	10/04/90	(11)99876-1234	04555555	Rua das Flores	100	Centro	São Paulo	SP	t
3	João	222.333.444-55	22.333.444-5	22/05/85	(21)88776-4567	21060001	Avenida dos Andradas	200	Andaraí	Rio de Janeiro	RJ	t
4	Clara	333.444.555-66	33.444.555-6	09/01/92	(31)98888-2552	30140081	Rua Timbiras	370	Barro Preto	Belo Horizonte	MG	t
5	Lucas	444.555.666-77	44.555.666-7	19/11/99	(41)98712-0147	80230010	Rua do Rosário	400	Centro	Curitiba	PR	t
7	Rafael	666.777.888-99	66.777.888-9	03/03/87	(51)97312-0148	90035050	Rua Mostardeiro	1010	Moinhos	Porto Alegre	RS	t
8	Isabela	777.888.999-00	77.888.999-0	18/06/93	(62)98416-0022	74003010	Rua 7	70	Centro	Goiânia	GO	t
9	Pedro	888.999.000-11	88.999.000-1	29/10/91	(67)99123-7758	79003010	Rua Bahia	518	Centro	Campo Grande	MS	t
10	Julia	999.000.111-22	99.000.111-2	12/12/89	(47)99118-4471	88010010	Rua Conselheiro Mafra	85	Centro	Florianópolis	SC	t
11	Felipe	123.123.123-12	12.312.312-3	03/07/95	(79)98877-0065	49010010	Rua José Ramos	107	São José	Aracaju	SE	t
12	Camila	234.234.234-23	23.423.423-4	22/02/96	(16)99674-2093	14010060	Rua Alvares Cabral	208	Centro	Ribeirão Preto	SP	t
13	Henrique	456.456.456-45	45.645.645-6	11/01/88	(27)99583-2033	29090360	Rua Sete	254	Santa Lúcia	Vitória	ES	t
14	Gabriela	567.567.567-56	56.756.756-7	29/09/97	(95)99113-2045	69300000	Av. Jaime Brasil	148	Centro	Boa Vista	RR	t
15	Eduardo	678.678.678-67	67.867.867-8	14/08/94	(27)99963-1097	29101560	Rua das Palmeiras	400	Itapuã	Vila Velha	ES	t
16	Luana	789.789.789-78	78.978.978-9	25/09/93	(96)99144-2035	68900000	Rua Hamilton Silva	100	Centro	Macapá	AP	t
17	Marcelo	890.890.890-89	89.089.089-0	22/11/92	(84)99813-2001	59000000	Rua João Pessoa	303	Cidade Alta	Natal	RN	t
18	Paula	901.901.901-90	90.190.190-1	04/12/90	(82)99344-1010	57020350	Rua do Sol	111	Farol	Maceió	AL	t
19	Bruno	012.012.012-01	01.201.201-2	17/05/98	(92)98856-7789	69000000	Rua José Paranaguá	289	Centro	Manaus	AM	t
20	Larissa	123.321.123-32	32.132.132-1	01/06/99	(21)99198-0771	22790150	Rua dos Jacarandás	52	Barra	Rio de Janeiro	RJ	t
21	kuchma	113.520.000-00	14.617.846-1	16/12/06	(41)64781-4785	81560280	Rua Agostinho Ângelo Trevisan	582	Uberaba	Curitiba	PR	t
22	jota	146.816.479-16	11.111.111-1	11/11/11	(11)11111-1111	81560280	Rua Agostinho Ângelo Trevisan	582	Uberaba	Curitiba	PR	f
6	Ana Banana	555.666.777-88	55.666.777-8	13/08/95	(85)99845-6675	60040000	Rua Senador Pompeu	320	Centro	Fortaleza	CE	t
\.


--
-- TOC entry 4999 (class 0 OID 67277)
-- Dependencies: 222
-- Data for Name: grupo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grupo (id, nome) FROM stdin;
1	Mecânico
2	Gerente
3	Atendente
4	Administrador
\.


--
-- TOC entry 5006 (class 0 OID 67478)
-- Dependencies: 229
-- Data for Name: pecas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pecas (id, nome, descricao, codigo_interno, id_categoria, unidade, modelo, ativo, preco_compra) FROM stdin;
22	Pastilha de Freio Dianteira	Pastilha de freio cerâmica dianteira	PF-001	3	Jogo	Carro	t	89.90
23	Filtro de Óleo	Filtro de óleo motor	FO-002	15	Unidade	Carro	t	25.50
24	Vela de Ignição	Vela de ignição iridium	VI-003	10	Unidade	Carro	t	35.00
25	Correia Dentada	Correia dentada com tensor	CD-004	16	Kit	Carro	t	180.00
26	Amortecedor Dianteiro	Amortecedor dianteiro original	AD-005	2	Par	Carro	t	320.00
27	Bateria 60Ah	Bateria automotiva 60 amperes	BT-006	6	Unidade	Carro	t	380.00
28	Disco de Freio Ventilado	Disco de freio ventilado dianteiro	DF-007	3	Par	Carro	t	150.00
29	Filtro de Ar	Filtro de ar do motor	FA-008	15	Unidade	Carro	t	45.00
30	Bobina de Ignição	Bobina de ignição eletrônica	BI-009	6	Unidade	Carro	t	95.00
31	Bomba de Combustível	Bomba de combustível elétrica	BC-010	10	Unidade	Carro	t	280.00
32	Retrovissor Elétrico	Retrovissor lateral elétrico direito	RE-011	14	Unidade	Carro	t	450.00
33	Lâmpada H4	Lâmpada farol H4 12V 55W	LH-012	11	Unidade	Carro	t	18.00
34	Radiador Completo	Radiador de água completo	RD-013	5	Unidade	Carro	t	420.00
35	Terminal de Direção	Terminal de direção axial	TD-014	8	Unidade	Carro	t	65.00
36	Coxim do Motor	Coxim do motor hidráulico	CM-015	1	Unidade	Carro	t	180.00
37	Sensor de Oxigênio	Sensor lambda/sonda lambda	SO-016	10	Unidade	Carro	t	220.00
38	Filtro de Cabine	Filtro de ar condicionado	FC-017	15	Unidade	Carro	t	55.00
39	Junta do Cabeçote	Junta do cabeçote metálica	JC-018	1	Unidade	Carro	t	120.00
40	Kit Embreagem	Kit embreagem completo com platô	EC-019	9	Kit	Carro	t	550.00
41	Pneu 175/70 R14	Pneu radial aro 14	PN-020	12	Unidade	Carro	t	280.00
\.


--
-- TOC entry 5010 (class 0 OID 67525)
-- Dependencies: 233
-- Data for Name: servicos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.servicos (id, nome, categoria, preco, observacao, peca_id, funcionario_id, ativo) FROM stdin;
4	Troca de Filtro de Ar	9	90.00	Filtro de ar muito sujo	30	7	t
5	Revisão do Sistema de Freio	3	350.00	Verificação de fluido e pastilhas	22	10	t
6	Substituição de Embreagem	5	950.00	Embreagem patinando	30	6	t
7	Troca de Correia Dentada	2	420.00	Correia com desgaste visível	22	9	t
8	Troca de Bateria	7	380.00	Bateria com baixa carga	30	11	t
9	Troca de Velas	9	160.00	Velas com resíduos de óleo	22	13	t
10	Troca de Amortecedores	4	800.00	Amortecedores dianteiros danificados	30	14	t
11	Revisão do Sistema de Arrefecimento	6	270.00	Troca de aditivo e limpeza	22	15	t
12	Troca de Filtro de Combustível	9	130.00	Filtro entupido	30	8	t
13	Troca de Escapamento	8	600.00	Vazamento no cano intermediário	22	16	t
14	Troca de Pneu	10	250.00	Pneus dianteiros carecas	30	12	t
15	Revisão Elétrica	7	400.00	Checagem completa do sistema elétrico	22	14	t
16	Substituição do Radiador	6	500.00	Radiador com vazamento	30	9	t
17	Troca de Faróis	7	220.00	Faróis com lâmpadas queimadas	22	10	t
18	Troca de Óleo de Câmbio	9	250.00	Óleo antigo e escuro	30	11	t
19	Revisão Geral	1	1200.00	Revisão completa de 40 itens	22	13	t
20	Troca de Palhetas do Limpador	7	70.00	Palhetas ressecadas	30	15	t
21	Descarbonização do Motor	1	550.00	Limpeza interna de válvulas e pistões	22	16	t
22	Troca de Fluido de Direção	4	190.00	Fluido escurecido	30	8	t
3	Alinhamento e Balanceamento	13	180.00	Revisão completa das rodas	30	19	t
\.


--
-- TOC entry 4995 (class 0 OID 67212)
-- Dependencies: 218
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, nome, cpf, senha, grupo, ativo) FROM stdin;
5	Pedro Lima	56789012345	$2a$12$efghijklmnopqrstuvwxyz	mecanico	t
11	Fernando Alves	11234567890	$2a$12$klmnopqrstuvwxyzabcde	administrador	t
12	Patrícia Fernandes	12234567890	$2a$12$lmnopqrstuvwxyzabcdef	atendente	t
14	Larissa Ribeiro	14234567890	$2a$12$nopqrstuvwxyzabcdefgh	gerente	t
15	Gustavo Nunes	15234567890	$2a$12$opqrstuvwxyzabcdefghi	administrador	t
16	Amanda Lima	16234567890	$2a$12$pqrstuvwxyzabcdefghij	atendente	t
17	Daniela Freitas	17234567890	$2a$12$qrstuvwxyzabcdefghijk	mecanico	t
18	Eduardo Pinto	18234567890	$2a$12$rstuvwxyzabcdefghijkl	gerente	t
20	Renato Gomes	20234567890	$2a$12$tuvwxyzabcdefghijklmno	atendente	t
24	juninho gamer	112.312.323-23	$2a$11$7N0uGh43d2hG6Yj1h7624.cON5wSeGLgloVbRZC4vO1prypyQVxsi	Mecânico	t
25	 Matheus Fofinho	123.123.123-13	$2a$11$OS2.ztctTk9o7Ixk5nsZE.O0rMnPeXhRm8x8/5Xs08gnJVIoMH9o.	Administrador	t
19	Penis da Silva	192.232.323-23	$2a$11$.B9zObMXAyYJ4KMS5UbdS.YXZwbWT3sWvRZLwxdrV7sQoL9yRWu..	Atendente	t
28	Bruno	164.871.649-81	$2a$11$C1HftVtAXKbbo.xyuNyLN.oMPf7BMblg2fPY4nh.OuJjWBbgIuY5u	Atendente	t
6	Beatriz Costa	67890123456	$2a$12$fghijklmnopqrstuvwxyzab	gerente	t
8	Carla Mendes	89012345678	$2a$12$hijklmnopqrstuvwxyzab	atendente	t
27	Jota	111.111.111-11		Atendente	t
1	Busta	794.672.957-07	$2a$11$YoEaqh5yOEVB1LLPPWWOcOk02huStB/lrs5PF6JmG3zHzt9/rVh5m	Administrador	t
29	AdminMassa	000.000.000-00	$2a$11$1qy2RsrPDkQ3U3oKQovkj.MRV8zZ91f0Akazx23ph05Z1a/Ks7p4S	Administrador	t
13	Bruno Chefon	164.917.408-71		Administrador	t
23	jota	271.461.794-61	$2a$11$JIp5n632/TVZpX0lzri1FOx1C/nyiy05WliaRNOEgEuIozn13niri	Atendente	t
26	jota	012.746.174-61	$2a$11$70tTtodpFoEUVud9U51mde8spLQf2f/khzQblfYrR3QjHC9rwXux6	Atendente	t
22	Kauan	164.816.479-61	$2a$11$mqliDGKZ.Jk0gSi5o.QswOJhinzSAe160AeJnry3xt2oB7Rq6kYv.	Gerente	t
21	Gustavo	139.471.969-89	$2a$11$dizz7yTHgQNjleL0VlshP.RHpHXvT/kgnkpkhxnJqTiz92GszYHly	Administrador	t
7	Rafael Santos	78901234567	$2a$12$ghijklmnopqrstuvwxyzaa	administrador	t
2	Maria Oliveira	23456789012	$2a$12$bcdefghijklmnopqrstuvw	gerente	t
9	Thiago Rocha	174.986.710-98		Administrador	t
4	Ana Souza	45678901234	$2a$12$defghijklmnopqrstuvwxy	atendente	t
10	Juliana Penis	146.197.461-97		Administrador	t
3	Carlos Pereira Santos	148.174.017-40		Administrador	t
30	Luciana	281.496.198-46	$2a$12$pFgWjriUlvg5dV6uGuHcLOJHcGTxOD7w5HkGPLA.YNcq2GdhSCRPS	Atendente	t
\.


--
-- TOC entry 5008 (class 0 OID 67500)
-- Dependencies: 231
-- Data for Name: veiculos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.veiculos (id, modelo, marca, chassi, placa, cor, fabricacao, id_cliente, ativo) FROM stdin;
6	HB20	Hyundai	9BHBH41JPNK456123	JKL0M12	Vermelho	2020	3	t
8	Argo	Fiat	9BD15842LL1234567	PQR6S78	Cinza	2022	4	t
9	Ka	Ford	9BFZE5EJ0M8901234	STU9V01	Verde	2021	1	t
10	Kicks	Nissan	9BRHK53CFNJ567890	VWX2Y34	Laranja	2023	5	t
11	Compass	Jeep	9BD672489NR345678	YZA5B67	Prata	2022	3	t
12	T-Cross	Volkswagen	9BWDB75Z8MT901234	BCD8E90	Branco	2023	2	t
13	Creta	Hyundai	9BHBK45BPPM234567	EFG1H23	Preto	2021	4	t
14	Renegade	Jeep	9BD556249NK678901	HIJ4K56	Vermelho	2020	1	t
15	EcoSport	Ford	9BFZB5EJ9L8345678	JKL7M89	Azul	2019	5	t
16	Duster	Renault	93YZJ4HJ5MJ890123	MNO0P12	Cinza	2022	2	t
17	Tracker	Chevrolet	9BGKL19F0NG456789	PQR3S45	Prata	2023	3	t
18	Pulse	Fiat	9BD272479NK123456	STU6V78	Branco	2022	1	t
19	Strada	Fiat	9BD37388LL1789012	VWX9Y01	Preto	2021	4	t
20	Polo	Volkswagen	9BWAB05Z9RT345678	YZA2B34	Vermelho	2020	2	t
21	Sandero	Renault	93Y4SRD57MJ901234	BCD5E67	Azul	2019	5	t
22	Tucson	Hyundai	9BHTU45EPPM567890	EFG8H90	Cinza	2023	3	t
24	Citroen C3	Citroen	9BWHE21JX7T458392	tyg4u01	Vermelho	2016	7	t
7	Gol	Volkswagen	9BWAA05U8PT789456	MNO3P45	Azul	2019	2	t
3	Civic	Honda	9BWZZZ377VT004251	ABC1D23	Prata	2022	1	t
4	Corolla	Toyota	9BR5Z2AB4M8123456	DEF4E56	Branco	2023	2	t
5	Onix	Chevrolet	9BGKS19F0MG123789	GHI7J89	Preto	2021	1	t
\.


--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 219
-- Name: clientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clientes_id_seq', 20, true);


--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 234
-- Name: fornecedor_pecas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fornecedor_pecas_id_seq', 1, false);


--
-- TOC entry 5029 (class 0 OID 0)
-- Dependencies: 225
-- Name: fornecedores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fornecedores_id_seq', 20, true);


--
-- TOC entry 5030 (class 0 OID 0)
-- Dependencies: 223
-- Name: funcionarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.funcionarios_id_seq', 22, true);


--
-- TOC entry 5031 (class 0 OID 0)
-- Dependencies: 221
-- Name: grupo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grupo_id_seq', 4, true);


--
-- TOC entry 5032 (class 0 OID 0)
-- Dependencies: 228
-- Name: pecas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pecas_id_seq', 41, true);


--
-- TOC entry 5033 (class 0 OID 0)
-- Dependencies: 232
-- Name: servicos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.servicos_id_seq', 24, true);


--
-- TOC entry 5034 (class 0 OID 0)
-- Dependencies: 217
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 30, true);


--
-- TOC entry 5035 (class 0 OID 0)
-- Dependencies: 230
-- Name: veiculos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.veiculos_id_seq', 24, true);


--
-- TOC entry 4824 (class 2606 OID 67383)
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);


--
-- TOC entry 4808 (class 2606 OID 67258)
-- Name: clientes clientes_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_cpf_key UNIQUE (cpf);


--
-- TOC entry 4810 (class 2606 OID 67254)
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);


--
-- TOC entry 4838 (class 2606 OID 75262)
-- Name: fornecedor_pecas fornecedor_pecas_fornecedor_id_peca_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedor_pecas
    ADD CONSTRAINT fornecedor_pecas_fornecedor_id_peca_id_key UNIQUE (fornecedor_id, peca_id);


--
-- TOC entry 4840 (class 2606 OID 75260)
-- Name: fornecedor_pecas fornecedor_pecas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedor_pecas
    ADD CONSTRAINT fornecedor_pecas_pkey PRIMARY KEY (id);


--
-- TOC entry 4820 (class 2606 OID 67337)
-- Name: fornecedores fornecedores_cnpj_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedores
    ADD CONSTRAINT fornecedores_cnpj_key UNIQUE (cnpj);


--
-- TOC entry 4822 (class 2606 OID 67335)
-- Name: fornecedores fornecedores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedores
    ADD CONSTRAINT fornecedores_pkey PRIMARY KEY (id);


--
-- TOC entry 4814 (class 2606 OID 67322)
-- Name: funcionarios funcionarios_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT funcionarios_cpf_key UNIQUE (cpf);


--
-- TOC entry 4816 (class 2606 OID 67320)
-- Name: funcionarios funcionarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT funcionarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4818 (class 2606 OID 67324)
-- Name: funcionarios funcionarios_rg_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT funcionarios_rg_key UNIQUE (rg);


--
-- TOC entry 4812 (class 2606 OID 67282)
-- Name: grupo grupo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupo
    ADD CONSTRAINT grupo_pkey PRIMARY KEY (id);


--
-- TOC entry 4826 (class 2606 OID 67488)
-- Name: pecas pecas_codigo_interno_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pecas
    ADD CONSTRAINT pecas_codigo_interno_key UNIQUE (codigo_interno);


--
-- TOC entry 4828 (class 2606 OID 67486)
-- Name: pecas pecas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pecas
    ADD CONSTRAINT pecas_pkey PRIMARY KEY (id);


--
-- TOC entry 4836 (class 2606 OID 67532)
-- Name: servicos servicos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicos
    ADD CONSTRAINT servicos_pkey PRIMARY KEY (id);


--
-- TOC entry 4804 (class 2606 OID 67221)
-- Name: usuarios usuarios_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_cpf_key UNIQUE (cpf);


--
-- TOC entry 4806 (class 2606 OID 67219)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4830 (class 2606 OID 67508)
-- Name: veiculos veiculos_chassi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.veiculos
    ADD CONSTRAINT veiculos_chassi_key UNIQUE (chassi);


--
-- TOC entry 4832 (class 2606 OID 67506)
-- Name: veiculos veiculos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.veiculos
    ADD CONSTRAINT veiculos_pkey PRIMARY KEY (id);


--
-- TOC entry 4834 (class 2606 OID 67510)
-- Name: veiculos veiculos_placa_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.veiculos
    ADD CONSTRAINT veiculos_placa_key UNIQUE (placa);


--
-- TOC entry 4841 (class 1259 OID 75273)
-- Name: idx_fornecedor_pecas_fornecedor; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fornecedor_pecas_fornecedor ON public.fornecedor_pecas USING btree (fornecedor_id);


--
-- TOC entry 4842 (class 1259 OID 75274)
-- Name: idx_fornecedor_pecas_peca; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fornecedor_pecas_peca ON public.fornecedor_pecas USING btree (peca_id);


--
-- TOC entry 4843 (class 2606 OID 67489)
-- Name: pecas fk_id_categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pecas
    ADD CONSTRAINT fk_id_categoria FOREIGN KEY (id_categoria) REFERENCES public.categorias(id);


--
-- TOC entry 4847 (class 2606 OID 75263)
-- Name: fornecedor_pecas fornecedor_pecas_fornecedor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedor_pecas
    ADD CONSTRAINT fornecedor_pecas_fornecedor_id_fkey FOREIGN KEY (fornecedor_id) REFERENCES public.fornecedores(id) ON DELETE CASCADE;


--
-- TOC entry 4848 (class 2606 OID 75268)
-- Name: fornecedor_pecas fornecedor_pecas_peca_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedor_pecas
    ADD CONSTRAINT fornecedor_pecas_peca_id_fkey FOREIGN KEY (peca_id) REFERENCES public.pecas(id) ON DELETE CASCADE;


--
-- TOC entry 4845 (class 2606 OID 67538)
-- Name: servicos servicos_funcionario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicos
    ADD CONSTRAINT servicos_funcionario_id_fkey FOREIGN KEY (funcionario_id) REFERENCES public.funcionarios(id);


--
-- TOC entry 4846 (class 2606 OID 67533)
-- Name: servicos servicos_peca_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicos
    ADD CONSTRAINT servicos_peca_id_fkey FOREIGN KEY (peca_id) REFERENCES public.pecas(id);


--
-- TOC entry 4844 (class 2606 OID 67516)
-- Name: veiculos veiculos_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.veiculos
    ADD CONSTRAINT veiculos_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES public.clientes(id);


-- Completed on 2025-10-22 17:29:44

--
-- PostgreSQL database dump complete
--

