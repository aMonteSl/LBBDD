-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.1.0-beta1
-- PostgreSQL version: 16.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE new_database;
-- ddl-end --


-- object: public."Cliente" | type: TABLE --
-- DROP TABLE IF EXISTS public."Cliente" CASCADE;
CREATE TABLE public."Cliente" (
	"NIF" varchar(13) NOT NULL,
	"Nombre" varchar(64),
	"Direccion" varchar(64),
	CONSTRAINT "NIF_pk" PRIMARY KEY ("NIF")
);
-- ddl-end --
ALTER TABLE public."Cliente" OWNER TO postgres;
-- ddl-end --

-- object: public."Coche" | type: TABLE --
-- DROP TABLE IF EXISTS public."Coche" CASCADE;
CREATE TABLE public."Coche" (
	"N_Bastidor" varchar(64) NOT NULL,
	"Matricula" varchar(8),
	"Modelo" varchar(64),
	"NIF_Cliente" varchar(13),
	"ID_Poliza_Poliza" integer,
	CONSTRAINT "N_Bastidor_pk" PRIMARY KEY ("N_Bastidor")
);
-- ddl-end --
ALTER TABLE public."Coche" OWNER TO postgres;
-- ddl-end --

-- object: "Cliente_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Coche" DROP CONSTRAINT IF EXISTS "Cliente_fk" CASCADE;
ALTER TABLE public."Coche" ADD CONSTRAINT "Cliente_fk" FOREIGN KEY ("NIF_Cliente")
REFERENCES public."Cliente" ("NIF") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Accidente" | type: TABLE --
-- DROP TABLE IF EXISTS public."Accidente" CASCADE;
CREATE TABLE public."Accidente" (
	"N_Siniestro" serial NOT NULL,
	"Fecha" date,
	"Lugar" varchar(64),
	CONSTRAINT "N_siniestro_pk" PRIMARY KEY ("N_Siniestro")
);
-- ddl-end --
ALTER TABLE public."Accidente" OWNER TO postgres;
-- ddl-end --

-- object: public."Sufre" | type: TABLE --
-- DROP TABLE IF EXISTS public."Sufre" CASCADE;
CREATE TABLE public."Sufre" (
	"NaturalezaAccidente" varchar(64),
	"N_Bastidor_Coche" varchar(64) NOT NULL,
	"N_Siniestro_Accidente" integer NOT NULL,
	CONSTRAINT "Sufre_pk" PRIMARY KEY ("N_Bastidor_Coche","N_Siniestro_Accidente")
);
-- ddl-end --
ALTER TABLE public."Sufre" OWNER TO postgres;
-- ddl-end --

-- object: "Coche_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Sufre" DROP CONSTRAINT IF EXISTS "Coche_fk" CASCADE;
ALTER TABLE public."Sufre" ADD CONSTRAINT "Coche_fk" FOREIGN KEY ("N_Bastidor_Coche")
REFERENCES public."Coche" ("N_Bastidor") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "Accidente_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Sufre" DROP CONSTRAINT IF EXISTS "Accidente_fk" CASCADE;
ALTER TABLE public."Sufre" ADD CONSTRAINT "Accidente_fk" FOREIGN KEY ("N_Siniestro_Accidente")
REFERENCES public."Accidente" ("N_Siniestro") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Poliza" | type: TABLE --
-- DROP TABLE IF EXISTS public."Poliza" CASCADE;
CREATE TABLE public."Poliza" (
	"ID_Poliza" serial NOT NULL,
	"Cobertura" varchar(64),
	CONSTRAINT "ID_Poliza_pk" PRIMARY KEY ("ID_Poliza")
);
-- ddl-end --
ALTER TABLE public."Poliza" OWNER TO postgres;
-- ddl-end --

-- object: "Poliza_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Coche" DROP CONSTRAINT IF EXISTS "Poliza_fk" CASCADE;
ALTER TABLE public."Coche" ADD CONSTRAINT "Poliza_fk" FOREIGN KEY ("ID_Poliza_Poliza")
REFERENCES public."Poliza" ("ID_Poliza") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Pago" | type: TABLE --
-- DROP TABLE IF EXISTS public."Pago" CASCADE;
CREATE TABLE public."Pago" (
	"Periodo_Pago" smallint,
	"Cantidad" smallint,
	"Confirmacionpago" boolean,
	"ID_Poliza_Poliza" integer NOT NULL,
	CONSTRAINT "Pago_pk" PRIMARY KEY ("ID_Poliza_Poliza")
);
-- ddl-end --
ALTER TABLE public."Pago" OWNER TO postgres;
-- ddl-end --

-- object: "Poliza_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Pago" DROP CONSTRAINT IF EXISTS "Poliza_fk" CASCADE;
ALTER TABLE public."Pago" ADD CONSTRAINT "Poliza_fk" FOREIGN KEY ("ID_Poliza_Poliza")
REFERENCES public."Poliza" ("ID_Poliza") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


