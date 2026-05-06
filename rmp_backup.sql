--
-- PostgreSQL database dump
--

-- Dumped from database version 14.12
-- Dumped by pg_dump version 14.17 (Homebrew)

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
-- Name: prof_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prof_info (
    prof_id integer NOT NULL,
    link text,
    prof_name text,
    department text,
    rating double precision,
    number_of_ratings integer,
    difficulty double precision,
    would_take_again text,
    top_tags text
);


ALTER TABLE public.prof_info OWNER TO postgres;

--
-- Data for Name: prof_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prof_info (prof_id, link, prof_name, department, rating, number_of_ratings, difficulty, would_take_again, top_tags) FROM stdin;
306651	https://www.ratemyprofessors.com/professor/306651	GarthDavies	Criminal Justice	3.2	0	3.9	57%	{}
52419	https://www.ratemyprofessors.com/professor/52419	IngridNorthwood	Microbiology	3.7	0	2.9	82%	{}
2981436	https://www.ratemyprofessors.com/professor/2981436	DanielVenn	Mathematics	1.7	0	3.9	29%	{}
652851	https://www.ratemyprofessors.com/professor/652851	IvonaMladenovic	Biology	2.9	0	3.6	45%	{}
2487522	https://www.ratemyprofessors.com/professor/2487522	ElizabethSteves	Biology	5	0	2.6	100%	{}
965157	https://www.ratemyprofessors.com/professor/965157	PeterChow-White	Communication	4.2	0	3.3	67%	{}
1059202	https://www.ratemyprofessors.com/professor/1059202	JohnMaxwell	Communication	4.6	0	2	100%	{}
2241421	https://www.ratemyprofessors.com/professor/2241421	XinyingHu	Political Science	3	0	3.2	50%	{}
1239664	https://www.ratemyprofessors.com/professor/1239664	MelekOrtabasi	World Literature	4.1	0	3.4	0%	{}
1600483	https://www.ratemyprofessors.com/professor/1600483	MattLockyer	Computer Science	4.7	0	2.8	N/A	{}
2779499	https://www.ratemyprofessors.com/professor/2779499	Nadishde Silva	Mathematics	1.2	0	4.7	5%	{}
3061807	https://www.ratemyprofessors.com/professor/3061807	JacobSauer	Interactive Media Design	5	0	2.2	100%	{}
89465	https://www.ratemyprofessors.com/professor/89465	NataliaKouzniak	Mathematics	3.4	0	3.5	66%	{}
1360173	https://www.ratemyprofessors.com/professor/1360173	LornaBoschman	Interactive Media Design	4	0	3	N/A	{}
2040941	https://www.ratemyprofessors.com/professor/2040941	StephanieChu	Education	0	0	0	N/A	{}
441674	https://www.ratemyprofessors.com/professor/441674	ClaireTrepanier	Languages	0	0	0	N/A	{}
2576187	https://www.ratemyprofessors.com/professor/2576187	HelenBailey	Engineering	3.2	0	3.7	57%	{}
1221966	https://www.ratemyprofessors.com/professor/1221966	AmandaBidnall	History	5	0	2.6	N/A	{}
1250410	https://www.ratemyprofessors.com/professor/1250410	BarryCartwright	Criminology	4.3	0	2.4	100%	{}
967626	https://www.ratemyprofessors.com/professor/967626	KarynAudet	Education	0	0	0	N/A	{}
1587701	https://www.ratemyprofessors.com/professor/1587701	ShivaGol Tabaghi	Mathematics	1	0	4	0%	{}
1622961	https://www.ratemyprofessors.com/professor/1622961	NadiaGill	Education	5	0	2.3	N/A	{}
1378272	https://www.ratemyprofessors.com/professor/1378272	MattRosen	Interactive Media Design	0	0	0	N/A	{}
1356897	https://www.ratemyprofessors.com/professor/1356897	PeterTingling	Business	2.8	0	4.3	N/A	{}
512644	https://www.ratemyprofessors.com/professor/512644	DianaCukierman	Computer Science	3.8	0	3.1	72%	{}
811765	https://www.ratemyprofessors.com/professor/811765	BenYoussef	Arts & Technology	2.4	0	3.3	N/A	{}
1807207	https://www.ratemyprofessors.com/professor/1807207	AdamAshraf-Abadi	Art & Design	1.5	0	3	N/A	{}
1872258	https://www.ratemyprofessors.com/professor/1872258	RobertPrey	Communication	4.9	0	2.7	N/A	{}
763046	https://www.ratemyprofessors.com/professor/763046	RodPaynter	Education	4	0	2	N/A	{}
864884	https://www.ratemyprofessors.com/professor/864884	VictorChen	Computer Science	3.3	0	2.5	N/A	{}
1827981	https://www.ratemyprofessors.com/professor/1827981	LurendaMastromonaco	Art, Media, & Design	3.6	0	3.7	100%	{}
2038985	https://www.ratemyprofessors.com/professor/2038985	JamesBrown	Database Management	0	0	0	N/A	{}
884976	https://www.ratemyprofessors.com/professor/884976	SeanMarkey	Social Science	3.7	0	2.7	N/A	{}
812635	https://www.ratemyprofessors.com/professor/812635	RobertMenzies	Sociology	4.8	0	1.5	N/A	{}
1787082	https://www.ratemyprofessors.com/professor/1787082	VinuRajus	Interactive Media Design	0	0	0	N/A	{}
1835710	https://www.ratemyprofessors.com/professor/1835710	KrishnaVijayaraghavan	Engineering	1.7	0	3.6	10%	{}
2474082	https://www.ratemyprofessors.com/professor/2474082	HelenWheeler	Criminal Justice	5	0	1	100%	{}
3029725	https://www.ratemyprofessors.com/professor/3029725	XiaoxingZhang	Communication	4	0	2	100%	{}
790650	https://www.ratemyprofessors.com/professor/790650	GarryMund	Chemistry	4.6	0	2.9	100%	{}
1224258	https://www.ratemyprofessors.com/professor/1224258	SinanCaykoylu	Business	3.8	0	1.7	N/A	{}
1425336	https://www.ratemyprofessors.com/professor/1425336	KatherineRegan	Psychology	0	0	0	N/A	{}
759792	https://www.ratemyprofessors.com/professor/759792	ChrisShaw	Interactive Multimedia Product	2.3	0	4	24%	{}
1500856	https://www.ratemyprofessors.com/professor/1500856	BrianFraser	Computer Science	4.6	0	2.7	91%	{}
1290182	https://www.ratemyprofessors.com/professor/1290182	TimRahilly	Education	4.8	0	4	N/A	{}
1889634	https://www.ratemyprofessors.com/professor/1889634	JoannaMansbridge	English	3.5	0	3.5	N/A	{}
279069	https://www.ratemyprofessors.com/professor/279069	BruceKadonoff	Mathematics	4.5	0	2.9	N/A	{}
2245394	https://www.ratemyprofessors.com/professor/2245394	WilliamOdom	Arts  Technology	1.8	0	4.4	20%	{}
2007837	https://www.ratemyprofessors.com/professor/2007837	SimonNantais	History	2.5	0	3.1	32%	{}
1048551	https://www.ratemyprofessors.com/professor/1048551	LudoVisschers	Economics	2.2	0	3.4	N/A	{}
245549	https://www.ratemyprofessors.com/professor/245549	DanielaMarinescue	Mathematics	2.9	0	3.5	0%	{}
1857041	https://www.ratemyprofessors.com/professor/1857041	MichaelPicard	Philosophy	2.5	0	3.7	N/A	{}
1804617	https://www.ratemyprofessors.com/professor/1804617	LeslieTilley	Music	5	0	2	N/A	{}
918551	https://www.ratemyprofessors.com/professor/918551	WarrenHare	Mathematics	2.1	0	4	N/A	{}
2675886	https://www.ratemyprofessors.com/professor/2675886	JohnHughes	Sociology	0	0	0	N/A	{}
826415	https://www.ratemyprofessors.com/professor/826415	SashaColby	English	4	0	2.6	N/A	{}
1314966	https://www.ratemyprofessors.com/professor/1314966	MohamedSulman	Mathematics	0	0	0	N/A	{}
2196123	https://www.ratemyprofessors.com/professor/2196123	CherylYu	Design	0	0	0	N/A	{}
1652222	https://www.ratemyprofessors.com/professor/1652222	JohnBowes	Interactive Media Design	0	0	0	N/A	{}
1301516	https://www.ratemyprofessors.com/professor/1301516	SherylFabian	Criminal Justice	3	0	3.7	0%	{}
3100914	https://www.ratemyprofessors.com/professor/3100914	ElifKilimci	Interactive Media Design	0	0	0	N/A	{}
83951	https://www.ratemyprofessors.com/professor/83951	TobyDonaldson	Computer Science	2.9	0	3.1	67%	{}
1371588	https://www.ratemyprofessors.com/professor/1371588	MaureenFizzell	Business	0	0	0	N/A	{}
1300302	https://www.ratemyprofessors.com/professor/1300302	ZhaosongLu	Mathematics	3.1	0	3	75%	{}
1306489	https://www.ratemyprofessors.com/professor/1306489	AngelaTomizu	Interactive Media Design	4	0	1.5	N/A	{}
1810928	https://www.ratemyprofessors.com/professor/1810928	MathewKurian	Geography	0	0	0	N/A	{}
83961	https://www.ratemyprofessors.com/professor/83961	MarekHatala	Computer Science	2.5	0	3.9	45%	{}
1980564	https://www.ratemyprofessors.com/professor/1980564	MoiraAikenhead	Criminal Justice	4.2	0	2.6	0%	{}
1655171	https://www.ratemyprofessors.com/professor/1655171	ShawnSmith	Business	4.7	0	3.5	N/A	{}
3121951	https://www.ratemyprofessors.com/professor/3121951	HadiMoeinnia	Engineering	3	0	3	100%	{}
780511	https://www.ratemyprofessors.com/professor/780511	AndrewGemino	Business	4.5	0	2.2	N/A	{}
167969	https://www.ratemyprofessors.com/professor/167969	JimBizzocchi	Computer Science	4.4	0	2.5	N/A	{}
1908427	https://www.ratemyprofessors.com/professor/1908427	NiranjanRajah	Art, Media, & Design	4	0	3.1	84%	{}
1895483	https://www.ratemyprofessors.com/professor/1895483	EhsanJozaghi	Criminal Justice	4.5	0	4	N/A	{}
2143766	https://www.ratemyprofessors.com/professor/2143766	AminRasouli	Engineering	4.5	0	4	100%	{}
89398	https://www.ratemyprofessors.com/professor/89398	SusanClements	Information Science	3.1	0	2.8	100%	{}
1696465	https://www.ratemyprofessors.com/professor/1696465	GregCorness	Interactive Media Design	4.5	0	3	N/A	{}
2811600	https://www.ratemyprofessors.com/professor/2811600	CalvinWong	Chemistry	4.9	0	2.4	93%	{}
1432651	https://www.ratemyprofessors.com/professor/1432651	SeanAshley	Sociology	4	0	2.3	0%	{}
457671	https://www.ratemyprofessors.com/professor/457671	Verheyen	Biology	0	0	0	N/A	{}
1730248	https://www.ratemyprofessors.com/professor/1730248	DeannaRexe	Education	4	0	2.5	100%	{}
3085883	https://www.ratemyprofessors.com/professor/3085883	NigareRaheem	Chemistry	3	0	3.6	56%	{}
1390213	https://www.ratemyprofessors.com/professor/1390213	JohnCanal	Chemistry	5	0	1.5	N/A	{}
693220	https://www.ratemyprofessors.com/professor/693220	DianeGromala	Interactive Multimedia Product	2	0	3.2	29%	{}
1360220	https://www.ratemyprofessors.com/professor/1360220	JonathanKatz	Philosophy	5	0	2	N/A	{}
1388118	https://www.ratemyprofessors.com/professor/1388118	NatalieFunk	Arts & Technology	4.6	0	1.5	N/A	{}
2766477	https://www.ratemyprofessors.com/professor/2766477	GregSutherland	Education	3.6	0	3	60%	{}
862678	https://www.ratemyprofessors.com/professor/862678	JillMcIntosh	Philosophy	0	0	0	N/A	{}
1206497	https://www.ratemyprofessors.com/professor/1206497	EdwardPark	Engineering	2.8	0	3	N/A	{}
2073906	https://www.ratemyprofessors.com/professor/2073906	SharkaStuyt	Business	5	0	4	100%	{}
3107746	https://www.ratemyprofessors.com/professor/3107746	sharonhou	Education	1	0	4.5	0%	{}
1389055	https://www.ratemyprofessors.com/professor/1389055	NathalieSchapansky	Linguistics	0	0	0	N/A	{}
2490070	https://www.ratemyprofessors.com/professor/2490070	PersiaSayyari	Criminal Justice	5	0	4	100%	{}
1300301	https://www.ratemyprofessors.com/professor/1300301	RandallPyke	Mathematics	2.1	0	4.2	16%	{}
1375444	https://www.ratemyprofessors.com/professor/1375444	WilliamDow	Humanities	3.7	0	1.6	N/A	{}
2224798	https://www.ratemyprofessors.com/professor/2224798	DenisDogah	Political Science	4.2	0	3.1	78%	{}
2049144	https://www.ratemyprofessors.com/professor/2049144	LiaqatAli	Computer Science	1.8	0	3.5	12%	{}
1890326	https://www.ratemyprofessors.com/professor/1890326	MohamedEl-Hannash	Engineering	0	0	0	N/A	{}
2587892	https://www.ratemyprofessors.com/professor/2587892	AfzalurRahman	Business	3.6	0	3.3	58%	{}
1779761	https://www.ratemyprofessors.com/professor/1779761	TamaraReid	Criminal Justice	0	0	0	N/A	{}
1569441	https://www.ratemyprofessors.com/professor/1569441	KathleenBurke	Criminal Justice	2	0	3	N/A	{}
2677952	https://www.ratemyprofessors.com/professor/2677952	ForoozanDaneshzand	Interactive Media Design	1	0	4.5	0%	{}
1361587	https://www.ratemyprofessors.com/professor/1361587	VeronicaZammitto	Interactive Media Design	3.7	0	2	N/A	{}
1348974	https://www.ratemyprofessors.com/professor/1348974	MichaelKruk	Interactive Media Design	4.5	0	3	N/A	{}
1536225	https://www.ratemyprofessors.com/professor/1536225	CharlesKing	Business	0	0	0	N/A	{}
2167510	https://www.ratemyprofessors.com/professor/2167510	TimothyYusun	Mathematics	0	0	0	N/A	{}
185210	https://www.ratemyprofessors.com/professor/185210	HerbertTsang	Computer Science	2.1	0	3.6	0%	{}
1347735	https://www.ratemyprofessors.com/professor/1347735	MagySeif El-Nasr	Arts & Technology	1.8	0	3.5	N/A	{}
3149710	https://www.ratemyprofessors.com/professor/3149710	JonCorbett	Arts & Technology	0	0	0	N/A	{}
1630469	https://www.ratemyprofessors.com/professor/1630469	LindsayParker	Humanities	3	0	2.5	N/A	{}
2202930	https://www.ratemyprofessors.com/professor/2202930	JeniseBoland	Education	4.7	0	2.3	100%	{}
89462	https://www.ratemyprofessors.com/professor/89462	TraceyLeacock	Business	2.7	0	3.8	N/A	{}
2982041	https://www.ratemyprofessors.com/professor/2982041	AbuFahkri	Sociology	0	0	0	N/A	{}
1651430	https://www.ratemyprofessors.com/professor/1651430	AnabellaCant	Education	3	0	1	N/A	{}
1943977	https://www.ratemyprofessors.com/professor/1943977	GosiaBryja	Geography	4.5	0	2.9	100%	{}
1485054	https://www.ratemyprofessors.com/professor/1485054	AshleyBennington	Business	0	0	0	N/A	{}
89394	https://www.ratemyprofessors.com/professor/89394	DianneCyr	Business	3.4	0	3	N/A	{}
2135249	https://www.ratemyprofessors.com/professor/2135249	AliaSunderji	Business	5	0	2.1	100%	{}
924923	https://www.ratemyprofessors.com/professor/924923	JamesCousins	History	0	0	0	N/A	{}
776941	https://www.ratemyprofessors.com/professor/776941	AlissaAntle	Interactive Multimedia Product	3.4	0	3.7	17%	{}
1211238	https://www.ratemyprofessors.com/professor/1211238	ArsinehGarabedian	Business	3	0	4.2	N/A	{}
234856	https://www.ratemyprofessors.com/professor/234856	KamalMasri	Business	3.1	0	2.8	N/A	{}
1475467	https://www.ratemyprofessors.com/professor/1475467	MelanieCassidy	Art & Design	4.7	0	2.2	100%	{}
1416703	https://www.ratemyprofessors.com/professor/1416703	SusanClements-Vivian	Not Specified	3.7	0	2.6	60%	{}
3155775	https://www.ratemyprofessors.com/professor/3155775	Jenniferde Visser	Business	0	0	0	N/A	{}
1547902	https://www.ratemyprofessors.com/professor/1547902	HilalOzcetin	Sociology	3	0	3.1	N/A	{}
366570	https://www.ratemyprofessors.com/professor/366570	Kallio	Physics	0	0	0	N/A	{}
1049923	https://www.ratemyprofessors.com/professor/1049923	ColinStewart	Computer Science	3.8	0	3.2	N/A	{}
1549236	https://www.ratemyprofessors.com/professor/1549236	RyanProx	Criminal Justice	4.2	0	3.2	80%	{}
2390273	https://www.ratemyprofessors.com/professor/2390273	ZacharyRowan	Criminal Justice	4.5	0	2.4	97%	{}
2941695	https://www.ratemyprofessors.com/professor/2941695	EmrulHasan	Business	0	0	0	N/A	{}
1522658	https://www.ratemyprofessors.com/professor/1522658	PoojaPandey	Mathematics	3.3	0	3.3	38%	{}
2388845	https://www.ratemyprofessors.com/professor/2388845	MarkMinard	Biology	0	0	0	N/A	{}
1622069	https://www.ratemyprofessors.com/professor/1622069	Natalie BinZhao	Business	4.5	0	3	N/A	{}
1335437	https://www.ratemyprofessors.com/professor/1335437	ElliotGoldner	Health Science	0	0	0	N/A	{}
2516616	https://www.ratemyprofessors.com/professor/2516616	OrionKidder	English	2	0	4.2	23%	{}
1599171	https://www.ratemyprofessors.com/professor/1599171	HalilErhan	Interactive Media Design	1.1	0	4.8	0%	{}
1218844	https://www.ratemyprofessors.com/professor/1218844	MarinaJassar	Mathematics	5	0	1	N/A	{}
885103	https://www.ratemyprofessors.com/professor/885103	ScottBriscoe	Biology	2.8	0	4.1	N/A	{}
2321477	https://www.ratemyprofessors.com/professor/2321477	MedhaKumar	Business	3	0	3	48%	{}
1303072	https://www.ratemyprofessors.com/professor/1303072	MichaelBrydon	Business	5	0	1	100%	{}
1040200	https://www.ratemyprofessors.com/professor/1040200	MasoodKamlani	Business	3.1	0	3.5	N/A	{}
1784556	https://www.ratemyprofessors.com/professor/1784556	BenUterman	Art & Design	1.3	0	5	N/A	{}
1421134	https://www.ratemyprofessors.com/professor/1421134	Wing HimYeung	Accounting	4.7	0	2.7	N/A	{}
2072593	https://www.ratemyprofessors.com/professor/2072593	NancyKhalil	Mathematics	5	0	4	N/A	{}
1093085	https://www.ratemyprofessors.com/professor/1093085	DavidNewman	Communication	4.1	0	1.8	N/A	{}
1306799	https://www.ratemyprofessors.com/professor/1306799	ThomasLoughin	Statistics	5	0	1.7	N/A	{}
1946893	https://www.ratemyprofessors.com/professor/1946893	MohammadNarimani	Engineering	3.1	0	3.8	54%	{}
2332633	https://www.ratemyprofessors.com/professor/2332633	GhasemBehfarshad	Engineering	4.8	0	3.2	100%	{}
1081568	https://www.ratemyprofessors.com/professor/1081568	KenZupan	Graphic Arts	3.2	0	2.4	34%	{}
1599573	https://www.ratemyprofessors.com/professor/1599573	KrishnaPendakur	Economics	0	0	0	N/A	{}
1482558	https://www.ratemyprofessors.com/professor/1482558	NedaParnian	Engineering	2	0	4	34%	{}
2173508	https://www.ratemyprofessors.com/professor/2173508	MahsaFaizrahnemoon	Mathematics	4.4	0	3.2	87%	{}
2350346	https://www.ratemyprofessors.com/professor/2350346	SepehrForoushani	Mathematics	2.1	0	4.4	23%	{}
3023044	https://www.ratemyprofessors.com/professor/3023044	CaseyMcConill	Mathematics	0	0	0	N/A	{}
1237856	https://www.ratemyprofessors.com/professor/1237856	RoumianaIlieva	Education	4.7	0	3.3	100%	{}
1826130	https://www.ratemyprofessors.com/professor/1826130	DanielaDaniela Marinescu	Mathematics	3.1	0	3.7	N/A	{}
913782	https://www.ratemyprofessors.com/professor/913782	PauloHorta	English	3.2	0	2.6	N/A	{}
2823693	https://www.ratemyprofessors.com/professor/2823693	FaatimahAli	Chemistry	0	0	0	N/A	{}
1439294	https://www.ratemyprofessors.com/professor/1439294	GuillaumeChapuy	Mathematics	4.5	0	4	N/A	{}
1335995	https://www.ratemyprofessors.com/professor/1335995	BernhardRiecke	Interactive Media Design	2.3	0	3.3	25%	{}
1174152	https://www.ratemyprofessors.com/professor/1174152	KathleenBarnard	English	5	0	1	N/A	{}
2475286	https://www.ratemyprofessors.com/professor/2475286	MichaelFilimowicz	Art & Design	1.5	0	3.6	12%	{}
1551111	https://www.ratemyprofessors.com/professor/1551111	LeoLiu	Political Science	3	0	3	N/A	{}
1269379	https://www.ratemyprofessors.com/professor/1269379	VeraLantinova	Economics	0	0	0	N/A	{}
1923518	https://www.ratemyprofessors.com/professor/1923518	RobertHershorn	Communication	2.9	0	3.6	0%	{}
2345948	https://www.ratemyprofessors.com/professor/2345948	PatriciaCoburn	Psychology	2.5	0	3.6	50%	{}
2496191	https://www.ratemyprofessors.com/professor/2496191	JayTseng	Art amp Design	4.4	0	2.7	86%	{}
443751	https://www.ratemyprofessors.com/professor/443751	DouglasAllen	Economics	4.3	0	3.3	67%	{}
2873415	https://www.ratemyprofessors.com/professor/2873415	SamBarnett	Arts & Technology	0	0	0	N/A	{}
2981596	https://www.ratemyprofessors.com/professor/2981596	JohnShen	Engineering	2.7	0	2.7	67%	{}
2979830	https://www.ratemyprofessors.com/professor/2979830	VivianNeal	Engineering	1.4	0	3.6	0%	{}
1305781	https://www.ratemyprofessors.com/professor/1305781	AndresWanner	Interactive Media Design	2.6	0	2.8	N/A	{}
83953	https://www.ratemyprofessors.com/professor/83953	KaiWiese	Computer Science	4	0	2.9	100%	{}
1712257	https://www.ratemyprofessors.com/professor/1712257	CandaceKnighton	English	3.5	0	3.8	0%	{}
1486082	https://www.ratemyprofessors.com/professor/1486082	AmrMarzouk	Engineering	3.2	0	3.2	66%	{}
3108053	https://www.ratemyprofessors.com/professor/3108053	HaggaiLiu	Mathematics	2.4	0	4.3	34%	{}
1935415	https://www.ratemyprofessors.com/professor/1935415	GabrielaAceves-Sepulveda	Interactive Media Design	1.6	0	3.9	9%	{}
1501309	https://www.ratemyprofessors.com/professor/1501309	NeeluKang	Sociology	3.9	0	2.1	N/A	{}
2448427	https://www.ratemyprofessors.com/professor/2448427	NeginSharafzadeh	Business	2	0	5	0%	{}
2401292	https://www.ratemyprofessors.com/professor/2401292	TrishaCoburn	Psychology	3	0	3.5	50%	{}
2389924	https://www.ratemyprofessors.com/professor/2389924	BillScott	Business	4	0	2.5	50%	{}
1499183	https://www.ratemyprofessors.com/professor/1499183	SaraSmith	Criminal Justice	0	0	0	N/A	{}
2950544	https://www.ratemyprofessors.com/professor/2950544	AhadArmin	Engineering	4	0	2	100%	{}
83963	https://www.ratemyprofessors.com/professor/83963	SteveDipaola	Computer Science	4	0	2.3	58%	{}
1437458	https://www.ratemyprofessors.com/professor/1437458	IgovezIgovez	Business	0	0	0	N/A	{}
2719583	https://www.ratemyprofessors.com/professor/2719583	ParvinderDhariwal	Languages	0	0	0	N/A	{}
1211227	https://www.ratemyprofessors.com/professor/1211227	MarkMoore	Business	3.8	0	5	N/A	{}
2441699	https://www.ratemyprofessors.com/professor/2441699	SarahTrotman	Criminal Justice	1	0	5	0%	{}
2267138	https://www.ratemyprofessors.com/professor/2267138	WolfgangStuerzlinger	Arts  Technology	1.9	0	3.9	15%	{}
1602190	https://www.ratemyprofessors.com/professor/1602190	JohnDill	Engineering	3.8	0	3	N/A	{}
2169102	https://www.ratemyprofessors.com/professor/2169102	YunLi-Reilly	Criminal Justice	4.3	0	3	84%	{}
2476244	https://www.ratemyprofessors.com/professor/2476244	MeganGiroux	Psychology	0	0	0	N/A	{}
1241174	https://www.ratemyprofessors.com/professor/1241174	JohnBogardus	Anthropology	4.7	0	3.3	100%	{}
2030516	https://www.ratemyprofessors.com/professor/2030516	JoyceSchneider	Humanities	3.7	0	3.1	54%	{}
822824	https://www.ratemyprofessors.com/professor/822824	MartinLaba	Communication	4.8	0	2.6	100%	{}
1328845	https://www.ratemyprofessors.com/professor/1328845	DavidCampbell	Statistics	0	0	0	N/A	{}
1531958	https://www.ratemyprofessors.com/professor/1531958	TomaszMajek	Geography	2	0	3.5	N/A	{}
2804767	https://www.ratemyprofessors.com/professor/2804767	JulianWeideman	International Studies	5	0	2.7	100%	{}
566634	https://www.ratemyprofessors.com/professor/566634	DianaCukierman	Computer Science	3.4	0	3.1	54%	{}
362553	https://www.ratemyprofessors.com/professor/362553	IvonaMladenovic	Biology	3	0	3.6	47%	{}
172959	https://www.ratemyprofessors.com/professor/172959	ThomasSpalek	Psychology	2.9	0	3.9	54%	{}
1755166	https://www.ratemyprofessors.com/professor/1755166	KevinOldknow	Engineering	5	0	2.8	100%	{}
3129844	https://www.ratemyprofessors.com/professor/3129844	AhmadMojallal	Mathematics	4.5	0	2.8	100%	{}
1953034	https://www.ratemyprofessors.com/professor/1953034	ChristopherGibson	International Studies	2.1	0	3.9	28%	{}
2836220	https://www.ratemyprofessors.com/professor/2836220	JennesiaPedri	Communication	4.1	0	3	70%	{}
333218	https://www.ratemyprofessors.com/professor/333218	RobWoodbury	Computer Science	1.8	0	3.8	N/A	{}
336032	https://www.ratemyprofessors.com/professor/336032	JamesPhillips	Communication	3.8	0	2.6	100%	{}
1215059	https://www.ratemyprofessors.com/professor/1215059	PhongKuoch	Education	4.1	0	2.9	0%	{}
167966	https://www.ratemyprofessors.com/professor/167966	RonWakkary	Fine Arts	3.2	0	3.8	60%	{}
2264979	https://www.ratemyprofessors.com/professor/2264979	JunweiSun	Arts  Technology	1	0	2.5	0%	{}
1451981	https://www.ratemyprofessors.com/professor/1451981	YolandaCatalina Cruz Contreras	Liberal Arts & Sciences	0	0	0	N/A	{}
167968	https://www.ratemyprofessors.com/professor/167968	TheclaSchiphorst	Fine Arts	2.8	0	2.6	N/A	{}
2527396	https://www.ratemyprofessors.com/professor/2527396	NaghmiShireen	Interactive Media Design	3.8	0	3.3	75%	{}
798398	https://www.ratemyprofessors.com/professor/798398	BobMercer	Communication	3.8	0	2.7	N/A	{}
1972002	https://www.ratemyprofessors.com/professor/1972002	WayneRawcliffe	Business	4.7	0	2.1	91%	{}
1958381	https://www.ratemyprofessors.com/professor/1958381	NatalieGagnon	Graphic Arts	4	0	3.2	79%	{}
1027720	https://www.ratemyprofessors.com/professor/1027720	RondaArab	English	3.4	0	3	56%	{}
2539240	https://www.ratemyprofessors.com/professor/2539240	MoniqueSherrett	Writing	0	0	0	N/A	{}
1933643	https://www.ratemyprofessors.com/professor/1933643	DavidBerrington	Humanities	2.3	0	3.6	34%	{}
971671	https://www.ratemyprofessors.com/professor/971671	MattHern	Education	5	0	2	N/A	{}
2002426	https://www.ratemyprofessors.com/professor/2002426	MaureenKihika	Sociology	3.4	0	2.9	62%	{}
1822484	https://www.ratemyprofessors.com/professor/1822484	AdamHill	History	5	0	2	N/A	{}
1642933	https://www.ratemyprofessors.com/professor/1642933	MortenJerven	International Studies	0	0	0	N/A	{}
1504053	https://www.ratemyprofessors.com/professor/1504053	RadoslavaTrnavac	Linguistics	1	0	4.5	N/A	{}
2662485	https://www.ratemyprofessors.com/professor/2662485	JoshGordon	Political Science	0	0	0	N/A	{}
273355	https://www.ratemyprofessors.com/professor/273355	AndrewWister	Gerontology	3.3	0	3	100%	{}
1742459	https://www.ratemyprofessors.com/professor/1742459	SimonPollon	Philosophy	3.9	0	2.8	34%	{}
2132206	https://www.ratemyprofessors.com/professor/2132206	Mary AnnGillies	English	2.8	0	3.3	47%	{}
1780313	https://www.ratemyprofessors.com/professor/1780313	AdamVaughan	Criminal Justice	5	0	2	N/A	{}
800443	https://www.ratemyprofessors.com/professor/800443	Clarkson	Education	0	0	0	N/A	{}
1816520	https://www.ratemyprofessors.com/professor/1816520	JingChen	Economics	2.8	0	3.5	N/A	{}
2586930	https://www.ratemyprofessors.com/professor/2586930	HeatherCooke	Sociology	1	0	2.5	0%	{}
1057248	https://www.ratemyprofessors.com/professor/1057248	JeanHebert	Communication	0	0	0	N/A	{}
1010686	https://www.ratemyprofessors.com/professor/1010686	MichaelEverton	English	4.5	0	3.5	N/A	{}
1946845	https://www.ratemyprofessors.com/professor/1946845	MattGreaves	Communication	2.5	0	3	N/A	{}
1444564	https://www.ratemyprofessors.com/professor/1444564	LarryDavids	Art Education	5	0	2	N/A	{}
1269378	https://www.ratemyprofessors.com/professor/1269378	VeraLantinova	Economics	4.5	0	3	N/A	{}
1020665	https://www.ratemyprofessors.com/professor/1020665	AlfredKong	Economics	2.4	0	2.8	100%	{}
1258361	https://www.ratemyprofessors.com/professor/1258361	ClementApaak	Archaeology	0	0	0	N/A	{}
2350707	https://www.ratemyprofessors.com/professor/2350707	PreetiHiro	Accounting	0	0	0	N/A	{}
2856162	https://www.ratemyprofessors.com/professor/2856162	AlanaGerecke	Theater	1	0	3	0%	{}
2665594	https://www.ratemyprofessors.com/professor/2665594	NoeRodriguez	Film	0	0	0	N/A	{}
3028130	https://www.ratemyprofessors.com/professor/3028130	JuanHernandez	Political Science	0	0	0	N/A	{}
979787	https://www.ratemyprofessors.com/professor/979787	ItrathSyed	Women's Studies	4.3	0	3.2	100%	{}
1433388	https://www.ratemyprofessors.com/professor/1433388	DavidNewman	Communication	4.8	0	3.3	N/A	{}
2273402	https://www.ratemyprofessors.com/professor/2273402	JuneScudeler	Anthropology	4.2	0	2.7	84%	{}
577334	https://www.ratemyprofessors.com/professor/577334	Sturgeon	Geography	0	0	0	N/A	{}
1000796	https://www.ratemyprofessors.com/professor/1000796	JohnRichards	Economics	2.5	0	3.7	N/A	{}
1195709	https://www.ratemyprofessors.com/professor/1195709	AhmadRad	Engineering	2.7	0	3.5	57%	{}
370561	https://www.ratemyprofessors.com/professor/370561	Hanson	Philosophy	4	0	3	N/A	{}
1781508	https://www.ratemyprofessors.com/professor/1781508	BryanGallagher	Business	4.5	0	2.8	100%	{}
1851676	https://www.ratemyprofessors.com/professor/1851676	LalehSamii	Physics	3.4	0	2	N/A	{}
3061806	https://www.ratemyprofessors.com/professor/3061806	MarisaMuntean	Interactive Media Design	3	0	4	67%	{}
1371751	https://www.ratemyprofessors.com/professor/1371751	StaceyFitzsimmons	Business	0	0	0	N/A	{}
967953	https://www.ratemyprofessors.com/professor/967953	MeguidoZola	Education	4.5	0	2.6	N/A	{}
2044367	https://www.ratemyprofessors.com/professor/2044367	PatriciaNitkin	Education	5	0	2.5	100%	{}
2396403	https://www.ratemyprofessors.com/professor/2396403	FaranakFarzan	Engineering	4.5	0	2.7	84%	{}
2922931	https://www.ratemyprofessors.com/professor/2922931	NavpreetKaur	Mathematics	3	0	3	50%	{}
1109169	https://www.ratemyprofessors.com/professor/1109169	DrewPaulin	Technology	4.8	0	2.8	N/A	{}
2336756	https://www.ratemyprofessors.com/professor/2336756	ShabnamMassah	Health Science	4.6	0	2.9	95%	{}
1798582	https://www.ratemyprofessors.com/professor/1798582	OrenShklarsky	Computer Science	1.8	0	4.3	N/A	{}
2335343	https://www.ratemyprofessors.com/professor/2335343	JamesZhou	Chemistry	4.8	0	2.9	96%	{}
1220134	https://www.ratemyprofessors.com/professor/1220134	GaryWang	Engineering	3.9	0	3.2	84%	{}
2135639	https://www.ratemyprofessors.com/professor/2135639	RyanScrivens	Criminal Justice	4	0	3	100%	{}
451867	https://www.ratemyprofessors.com/professor/451867	GeorgeKirczenow	Physics	0	0	0	N/A	{}
2614082	https://www.ratemyprofessors.com/professor/2614082	AleksBesan	International Studies	5	0	2	100%	{}
2208028	https://www.ratemyprofessors.com/professor/2208028	KambizHaji Hajikolaei	Engineering	2.7	0	3.7	45%	{}
1105880	https://www.ratemyprofessors.com/professor/1105880	GillyMah	Interactive Media Design	2.3	0	2	N/A	{}
3122245	https://www.ratemyprofessors.com/professor/3122245	MohammadShojayian	Engineering	0	0	0	N/A	{}
981451	https://www.ratemyprofessors.com/professor/981451	JanKietzmann	Business	2.5	0	4	0%	{}
1378276	https://www.ratemyprofessors.com/professor/1378276	JeyAristizabal	Interactive Media Design	0	0	0	N/A	{}
820871	https://www.ratemyprofessors.com/professor/820871	SnezanaMitrovic-Minic	Mathematics	3.8	0	1.8	N/A	{}
1629048	https://www.ratemyprofessors.com/professor/1629048	OwenGallupe	Criminal Justice	4.2	0	2.8	100%	{}
315529	https://www.ratemyprofessors.com/professor/315529	Eric YingchenYang	Computer Science	2.4	0	3.3	59%	{}
1360222	https://www.ratemyprofessors.com/professor/1360222	ElizabethMacDonald	Philosophy	0	0	0	N/A	{}
1697722	https://www.ratemyprofessors.com/professor/1697722	MajidBahraami	Engineering	3.8	0	4	0%	{}
3060528	https://www.ratemyprofessors.com/professor/3060528	FreyaZinovieff	Interactive Media Design	3.3	0	2.8	56%	{}
1595520	https://www.ratemyprofessors.com/professor/1595520	MosesZitron	Business	5	0	4	100%	{}
3082150	https://www.ratemyprofessors.com/professor/3082150	ReeseMuntean	Arts & Technology	0	0	0	N/A	{}
1964314	https://www.ratemyprofessors.com/professor/1964314	FlavioFirmani	Engineering	4.7	0	2.9	100%	{}
2852506	https://www.ratemyprofessors.com/professor/2852506	SamBarnett	Art, Media, & Design	5	0	2	100%	{}
1596910	https://www.ratemyprofessors.com/professor/1596910	LakshmanOne	Engineering	3.2	0	3.2	50%	{}
1017775	https://www.ratemyprofessors.com/professor/1017775	TamaraSmyth	Computer Science	3.8	0	2.8	N/A	{}
1276587	https://www.ratemyprofessors.com/professor/1276587	DavidColey	English	5	0	3	100%	{}
1182010	https://www.ratemyprofessors.com/professor/1182010	IrynaDudnyk	Economics	2	0	3	N/A	{}
89970	https://www.ratemyprofessors.com/professor/89970	HelmineSerban	Arts & Technology	3.4	0	3.2	61%	{}
2629112	https://www.ratemyprofessors.com/professor/2629112	KathleenInglis	Anthropology	0	0	0	N/A	{}
508665	https://www.ratemyprofessors.com/professor/508665	JanetMcCracken	Technology	3	0	3.1	N/A	{}
461552	https://www.ratemyprofessors.com/professor/461552	JohnEdgar	Computer Science	4.3	0	2.6	95%	{}
2563712	https://www.ratemyprofessors.com/professor/2563712	DariaGluhareva	Languages	5	0	2	100%	{}
896120	https://www.ratemyprofessors.com/professor/896120	NeilAlberding	Physics	2.1	0	3.2	50%	{}
2670133	https://www.ratemyprofessors.com/professor/2670133	ArshanaLalani	Criminal Justice	3.7	0	4	67%	{}
1849644	https://www.ratemyprofessors.com/professor/1849644	SherrieAtwood	Psychology	3.2	0	3	58%	{}
1886495	https://www.ratemyprofessors.com/professor/1886495	JiachengWang	Engineering	3.4	0	2.5	100%	{}
1698372	https://www.ratemyprofessors.com/professor/1698372	ColinHawes	Law	4.8	0	2	N/A	{}
1792752	https://www.ratemyprofessors.com/professor/1792752	BadishaRay	History	5	0	2.8	N/A	{}
1912765	https://www.ratemyprofessors.com/professor/1912765	MatthewToner	Interactive Media Design	3.4	0	2.6	N/A	{}
363369	https://www.ratemyprofessors.com/professor/363369	LarryWosk	Business	0	0	0	N/A	{}
764092	https://www.ratemyprofessors.com/professor/764092	MohamedHefeeda	Computer Science	3.5	0	4	N/A	{}
1044071	https://www.ratemyprofessors.com/professor/1044071	JackStockholm	Information Technology	3.5	0	3.3	N/A	{}
1840325	https://www.ratemyprofessors.com/professor/1840325	KateThorpe	Management	1.2	0	3.3	N/A	{}
1486651	https://www.ratemyprofessors.com/professor/1486651	ThomasShermer	Computer Science	2.2	0	4.5	21%	{}
2181489	https://www.ratemyprofessors.com/professor/2181489	TaraHolland	Science	4.4	0	2.7	89%	{}
2655550	https://www.ratemyprofessors.com/professor/2655550	PatrickPalmer	Engineering	2.3	0	3.9	20%	{}
2064020	https://www.ratemyprofessors.com/professor/2064020	HarshaPerera	Statistics	4.1	0	2.5	76%	{}
2466756	https://www.ratemyprofessors.com/professor/2466756	CarmenAlmarza	Education	3.6	0	2.3	63%	{}
1619368	https://www.ratemyprofessors.com/professor/1619368	YoussefQranfal	Mathematics	1.3	0	4.4	N/A	{}
377661	https://www.ratemyprofessors.com/professor/377661	RustumChoksi	Mathematics	2.5	0	3	N/A	{}
167970	https://www.ratemyprofessors.com/professor/167970	JoelFlynn	Computer Science	1.7	0	4.2	N/A	{}
2131080	https://www.ratemyprofessors.com/professor/2131080	EdwardLo	Computer Science	2.5	0	4	100%	{}
2466077	https://www.ratemyprofessors.com/professor/2466077	NickDexter	Mathematics	3	0	3	100%	{}
1758577	https://www.ratemyprofessors.com/professor/1758577	SusanBarber	Not Specified	0	0	0	N/A	{}
1704654	https://www.ratemyprofessors.com/professor/1704654	MaureenHindy	Engineering	2.7	0	2.7	20%	{}
2663941	https://www.ratemyprofessors.com/professor/2663941	JulianIliev	Visual Arts	1.5	0	4.1	13%	{}
1991942	https://www.ratemyprofessors.com/professor/1991942	KrystalGuo	Mathematics	0	0	0	N/A	{}
1068895	https://www.ratemyprofessors.com/professor/1068895	DaveCampbell	Statistics	4	0	2	N/A	{}
1276976	https://www.ratemyprofessors.com/professor/1276976	HowardTrotter	Physics	0	0	0	N/A	{}
914036	https://www.ratemyprofessors.com/professor/914036	AbrahamPunnen	Mathematics	3.2	0	3.2	48%	{}
1251746	https://www.ratemyprofessors.com/professor/1251746	JaneGraydon	Business	4.8	0	3.3	N/A	{}
117530	https://www.ratemyprofessors.com/professor/117530	ChantalGibson	English	4.1	0	3.6	80%	{}
776565	https://www.ratemyprofessors.com/professor/776565	HarinderKhangura	Computer Science	3.8	0	3.7	76%	{}
2199543	https://www.ratemyprofessors.com/professor/2199543	EmilyCramer	Information Technology	3	0	3.5	50%	{}
1445758	https://www.ratemyprofessors.com/professor/1445758	DiliaraNasirova	Interactive Media Design	4.3	0	1.5	N/A	{}
1606513	https://www.ratemyprofessors.com/professor/1606513	ZuzanaVasko	Education	4.2	0	2	75%	{}
1933185	https://www.ratemyprofessors.com/professor/1933185	KenSeigneurie	Literature	4.5	0	3	84%	{}
2518009	https://www.ratemyprofessors.com/professor/2518009	ArezouValadkhani	Mathematics	4	0	3.7	60%	{}
2706909	https://www.ratemyprofessors.com/professor/2706909	MahsooSalimi	Interactive Media Design	1	0	3	0%	{}
937217	https://www.ratemyprofessors.com/professor/937217	StephenTamon	Mathematics	3.1	0	3.1	67%	{}
2516847	https://www.ratemyprofessors.com/professor/2516847	CelesteSnowber	Education	0	0	0	N/A	{}
807843	https://www.ratemyprofessors.com/professor/807843	David IdrisMercer	Mathematics	0	0	0	N/A	{}
1628045	https://www.ratemyprofessors.com/professor/1628045	Woo SooKim	Engineering	3	0	2.4	100%	{}
1264582	https://www.ratemyprofessors.com/professor/1264582	StevenPearce	Computer Science	1.4	0	4.8	N/A	{}
2979371	https://www.ratemyprofessors.com/professor/2979371	BruceFingarson	Engineering	4.7	0	2.7	100%	{}
2267142	https://www.ratemyprofessors.com/professor/2267142	PaulBrokenshire	Arts  Technology	3.2	0	3.8	59%	{}
1434776	https://www.ratemyprofessors.com/professor/1434776	BenUnterman	Art & Design	3.7	0	2.6	82%	{}
1433853	https://www.ratemyprofessors.com/professor/1433853	TerryBeech	Business	5	0	3	N/A	{}
1752596	https://www.ratemyprofessors.com/professor/1752596	AndrewHawryshkewich	Design	3.5	0	3.2	88%	{}
1508021	https://www.ratemyprofessors.com/professor/1508021	NatashaGhosh	Psychology	0	0	0	N/A	{}
1809632	https://www.ratemyprofessors.com/professor/1809632	SarahGrant	English	4.5	0	4	N/A	{}
1198855	https://www.ratemyprofessors.com/professor/1198855	PhilippePasquier	Interactive Media Design	3.7	0	2.8	50%	{}
1569958	https://www.ratemyprofessors.com/professor/1569958	KateHennessy	Art & Visual Culture	3.4	0	2.3	100%	{}
3021757	https://www.ratemyprofessors.com/professor/3021757	AlexanderRutherford	Mathematics	4	0	3	50%	{}
1426622	https://www.ratemyprofessors.com/professor/1426622	ChristopherErickson	Political Science	5	0	1	N/A	{}
1224140	https://www.ratemyprofessors.com/professor/1224140	SourabhPaul	Economics	3.6	0	2.6	N/A	{}
1809795	https://www.ratemyprofessors.com/professor/1809795	JeevanjotMann	Not Specified	4.5	0	1	N/A	{}
3100915	https://www.ratemyprofessors.com/professor/3100915	ElifKilimci	Interactive Multimedia Product	5	0	4	100%	{}
1562548	https://www.ratemyprofessors.com/professor/1562548	YujiaJiang	Languages	4.5	0	1	N/A	{}
950502	https://www.ratemyprofessors.com/professor/950502	KarenBrown	Criminal Justice	4.7	0	2.5	100%	{}
2727546	https://www.ratemyprofessors.com/professor/2727546	JinglunZhu	Anthropology	4	0	2	100%	{}
2185901	https://www.ratemyprofessors.com/professor/2185901	ReidStaples	Science	4.3	0	3.5	100%	{}
2772222	https://www.ratemyprofessors.com/professor/2772222	SamiCoteli	Communication	0	0	0	N/A	{}
302078	https://www.ratemyprofessors.com/professor/302078	PeterHorban	Philosophy	3.3	0	4.4	N/A	{}
2795450	https://www.ratemyprofessors.com/professor/2795450	AmirJahanlou	Interactive Multimedia Product	5	0	4	100%	{}
2438613	https://www.ratemyprofessors.com/professor/2438613	AmalHili	Finance	4.3	0	3	86%	{}
2840845	https://www.ratemyprofessors.com/professor/2840845	MollyMcVey	Engineering	5	0	1.8	100%	{}
1451982	https://www.ratemyprofessors.com/professor/1451982	YolandaCruz Contreras	Liberal Arts & Sciences	1	0	5	N/A	{}
776447	https://www.ratemyprofessors.com/professor/776447	BrianFisher	Psychology	1.8	0	3.6	27%	{}
2415702	https://www.ratemyprofessors.com/professor/2415702	SiamakArzanpour	Engineering	3	0	4	100%	{}
1119106	https://www.ratemyprofessors.com/professor/1119106	KumariBeck	Education	3	0	3.1	0%	{}
1365889	https://www.ratemyprofessors.com/professor/1365889	SharonGorski	Molecular Biosciences	0	0	0	N/A	{}
1360164	https://www.ratemyprofessors.com/professor/1360164	NicolasSchmitt	Economics	2.9	0	3.5	63%	{}
1598246	https://www.ratemyprofessors.com/professor/1598246	JaimePalmer-Hague	Psychology	3.8	0	3.1	N/A	{}
3108174	https://www.ratemyprofessors.com/professor/3108174	AbidAli	Engineering	0	0	0	N/A	{}
2072416	https://www.ratemyprofessors.com/professor/2072416	KarolSwietlicki	Computer Science	3.3	0	3.9	54%	{}
2113410	https://www.ratemyprofessors.com/professor/2113410	DanielLaitsch	Education	4	0	2	100%	{}
94121	https://www.ratemyprofessors.com/professor/94121	RussellTaylor	Graphic Arts	3.7	0	4.4	82%	{}
1069073	https://www.ratemyprofessors.com/professor/1069073	LynBartram	Interactive Media Design	1.7	0	2.8	0%	{}
1733396	https://www.ratemyprofessors.com/professor/1733396	JungicVeselin	Mathematics	3.7	0	3.5	60%	{}
3022473	https://www.ratemyprofessors.com/professor/3022473	PeterLeavitt	Psychology	4.2	0	2.1	86%	{}
565620	https://www.ratemyprofessors.com/professor/565620	BehzadSamin	Information Technology	4.7	0	1.7	100%	{}
2787594	https://www.ratemyprofessors.com/professor/2787594	DawnRault	Criminal Justice	4.5	0	2.5	100%	{}
1360165	https://www.ratemyprofessors.com/professor/1360165	VasylGolovetskyy	Economics	3	0	2	50%	{}
89752	https://www.ratemyprofessors.com/professor/89752	ElenaHalmaghi	Mathematics	3.7	0	2.7	53%	{}
2332801	https://www.ratemyprofessors.com/professor/2332801	LaurenHarding	Anthropology	0	0	0	N/A	{}
1569258	https://www.ratemyprofessors.com/professor/1569258	PeterSmith	Criminal Justice	3.5	0	3.5	N/A	{}
1420693	https://www.ratemyprofessors.com/professor/1420693	ColinCampbell	Business	0	0	0	N/A	{}
2655287	https://www.ratemyprofessors.com/professor/2655287	RamtinRakhsha	Engineering	3.9	0	3.9	75%	{}
1754758	https://www.ratemyprofessors.com/professor/1754758	VijaykumarSingh	Mathematics	3.9	0	2.8	71%	{}
1830604	https://www.ratemyprofessors.com/professor/1830604	KristinCarlson	Art, Media, & Design	2.5	0	3	N/A	{}
1655375	https://www.ratemyprofessors.com/professor/1655375	ElizabethWood	Education	0	0	0	N/A	{}
244911	https://www.ratemyprofessors.com/professor/244911	DavidFirman	Communication	3.3	0	3	N/A	{}
747715	https://www.ratemyprofessors.com/professor/747715	NadineFlagel	English	2.5	0	2	0%	{}
1072815	https://www.ratemyprofessors.com/professor/1072815	TajHashmi	History	0	0	0	N/A	{}
1928684	https://www.ratemyprofessors.com/professor/1928684	AgnesMcDonald	Sociology	2	0	4	34%	{}
2783347	https://www.ratemyprofessors.com/professor/2783347	MattGrady	Design	0	0	0	N/A	{}
1513466	https://www.ratemyprofessors.com/professor/1513466	MurrayShaw	Sociology	0	0	0	N/A	{}
1350855	https://www.ratemyprofessors.com/professor/1350855	AndrewFeenberg	Communication	5	0	3	100%	{}
822816	https://www.ratemyprofessors.com/professor/822816	IanChunn	Communication	3.2	0	2.9	N/A	{}
1438356	https://www.ratemyprofessors.com/professor/1438356	JulieMacArthur	Political Science	5	0	3	N/A	{}
1846300	https://www.ratemyprofessors.com/professor/1846300	JuliaLane	Education	4.5	0	2.9	N/A	{}
1642935	https://www.ratemyprofessors.com/professor/1642935	JohnHarris	International Studies	2	0	5	N/A	{}
1915406	https://www.ratemyprofessors.com/professor/1915406	KathleenMillar	Sociology	5	0	2	100%	{}
1857108	https://www.ratemyprofessors.com/professor/1857108	AliciaHorton	Criminal Justice	4.8	0	3	100%	{}
1938187	https://www.ratemyprofessors.com/professor/1938187	JamesRennie	Communication	0	0	0	N/A	{}
2711935	https://www.ratemyprofessors.com/professor/2711935	AshmitaChand	International Studies	5	0	1	100%	{}
628983	https://www.ratemyprofessors.com/professor/628983	PerryThomas	Languages	0	0	0	N/A	{}
1148486	https://www.ratemyprofessors.com/professor/1148486	Vasyl "Basil"Golovetskyy	Economics	2	0	3.4	15%	{}
1891646	https://www.ratemyprofessors.com/professor/1891646	ErikaPenner	Psychology	4.6	0	2.1	N/A	{}
2501449	https://www.ratemyprofessors.com/professor/2501449	ArielVergara	Communication	1	0	3	0%	{}
2754085	https://www.ratemyprofessors.com/professor/2754085	HannahMcGregor	Journalism	0	0	0	N/A	{}
2367404	https://www.ratemyprofessors.com/professor/2367404	GeetanjaliGill	International Studies	4	0	2	100%	{}
809380	https://www.ratemyprofessors.com/professor/809380	MegHolden	Geography	3.9	0	3.3	58%	{}
1539893	https://www.ratemyprofessors.com/professor/1539893	NormO'Rourke	Health Science	2	0	3	N/A	{}
2163368	https://www.ratemyprofessors.com/professor/2163368	YunReilly	Criminal Justice	5	0	2.7	100%	{}
1158111	https://www.ratemyprofessors.com/professor/1158111	HilmarPabel	History	0	0	0	N/A	{}
1951219	https://www.ratemyprofessors.com/professor/1951219	GretchenHernandez	Social Science	3.3	0	3.3	100%	{}
822817	https://www.ratemyprofessors.com/professor/822817	KennethFish	Sociology	3.9	0	3.2	N/A	{}
1263372	https://www.ratemyprofessors.com/professor/1263372	ElliotGoldner	Health Science	0	0	0	N/A	{}
2734738	https://www.ratemyprofessors.com/professor/2734738	KoichiHaseyama	Social Science	4.6	0	2.2	80%	{}
1178489	https://www.ratemyprofessors.com/professor/1178489	RomanOnufrijchuk	Communication	4.3	0	2.6	N/A	{}
2586338	https://www.ratemyprofessors.com/professor/2586338	NatashaFerenczi	Sociology	1.8	0	3.6	23%	{}
2048169	https://www.ratemyprofessors.com/professor/2048169	IzbelaSteflja	International Studies	0	0	0	N/A	{}
1616727	https://www.ratemyprofessors.com/professor/1616727	CristinaMoretti	Anthropology	2.5	0	4	50%	{}
2028383	https://www.ratemyprofessors.com/professor/2028383	ZenaMerali	Business	0	0	0	N/A	{}
\.


--
-- Name: prof_info prof_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prof_info
    ADD CONSTRAINT prof_info_pkey PRIMARY KEY (prof_id);


--
-- PostgreSQL database dump complete
--

