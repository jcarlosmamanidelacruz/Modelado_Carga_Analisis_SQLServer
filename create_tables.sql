IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Importaciones_db')
	BEGIN
		CREATE DATABASE Importaciones_db
		 ON  PRIMARY 
		( NAME = N'Importaciones_db', FILENAME = 'D:\Modelado SQL Server\Importaciones_db.mdf')
		 LOG ON 
		( NAME = N'Importaciones_db_log', FILENAME = 'D:\Modelado SQL Server\Importaciones_db.ldf');
	END
ELSE
	BEGIN
		delete from importacion;
		delete from pais_aduana;
		delete from aduana_ingreso;
		delete from pais_aduana;
		delete from tipo_vehiculo;
		delete from tipo_importador;
		delete from tipo_combustible;
		delete from linea_modelo;
		delete from modelo_lanzamiento;
		delete from marca;
		delete from linea;
	END

USE Importaciones_db;
GO


-- TABLE tablatemporal ********************************************************************************************

IF OBJECT_ID('tablatemporal', 'U') IS NULL
BEGIN
	
	CREATE TABLE tablatemporal
	(
		id_registro INT IDENTITY(1,1),
		pais_de_proveniencia VARCHAR(100),
		aduana_de_ingreso VARCHAR(100),
		fecha_de_la_poliza VARCHAR(100),
		partida_arancelaria VARCHAR(100),
		modelo_del_vehiculo VARCHAR(100),
		marca VARCHAR(100),
		linea VARCHAR(100),
		centimetros_cubicos VARCHAR(100),
		distintivo VARCHAR(100),
		tipo_de_vehiculo VARCHAR(100),
		tipo_de_importador VARCHAR(100),
		tipo_combustible VARCHAR(100),
		asientos VARCHAR(100),
		puertas VARCHAR(100),
		tonelaje VARCHAR(100),
		valor_cif VARCHAR(100),
		impuesto VARCHAR(100),
		otro VARCHAR(100),
		CONSTRAINT PK_tablatemporal_id_registro  PRIMARY KEY (id_registro),
	);
END

-- TABLE marca ********************************************************************************************

IF OBJECT_ID('marca', 'U') IS NULL
BEGIN
	CREATE TABLE marca
	(
		id_marca INT IDENTITY(1,1) NOT NULL,
		nombre_marca VARCHAR(45) NOT NULL,
		CONSTRAINT PK_marca PRIMARY KEY (id_marca),
		CONSTRAINT UQ_marca_nombre UNIQUE (nombre_marca)
	);
END

-- TABLE marca ********************************************************************************************

IF OBJECT_ID('tipo_combustible', 'U') IS NULL
BEGIN
	CREATE TABLE tipo_combustible
	(
		id_tipo_combustible INT IDENTITY(1,1) NOT NULL,
		nombre_tipo_combustible VARCHAR(45) NOT NULL,
		CONSTRAINT tipo_combustible_pkey PRIMARY KEY (id_tipo_combustible),
		CONSTRAINT nombretipocombustiblea_key UNIQUE (nombre_tipo_combustible)
	);
END

-- TABLE tipo_vehiculo ********************************************************************************************

IF OBJECT_ID('tipo_vehiculo', 'U') IS NULL
BEGIN
	CREATE TABLE tipo_vehiculo
	(
		id_tipo_vehiculo INT IDENTITY(1,1) NOT NULL,
		nombre_tipo_vehiculo VARCHAR(45) NOT NULL,
		CONSTRAINT tipo_vehiculo_pkey PRIMARY KEY (id_tipo_vehiculo),
		CONSTRAINT nombretipovehiculo_key UNIQUE (nombre_tipo_vehiculo)
	);
END

-- TABLE tipo_importador ********************************************************************************************

IF OBJECT_ID('tipo_importador', 'U') IS NULL
BEGIN
	CREATE TABLE tipo_importador
	(
		id_tipo_importador INT IDENTITY(1,1) NOT NULL,
		nombre_tipo_importador VARCHAR(45) NOT NULL,
		CONSTRAINT tipo_importador_pkey PRIMARY KEY (id_tipo_importador),
		CONSTRAINT nombretipoimportador_key UNIQUE (nombre_tipo_importador)
	);
END

-- TABLE modelo_lanzamiento ********************************************************************************************

IF OBJECT_ID('modelo_lanzamiento', 'U') IS NULL
BEGIN
	CREATE TABLE modelo_lanzamiento
	(
		id_modelo_lanzamiento INT IDENTITY(1,1) NOT NULL,
		anio VARCHAR(45) NOT NULL,
		CONSTRAINT modelo_lanzamiento_pkey PRIMARY KEY (id_modelo_lanzamiento),
		CONSTRAINT anio_key UNIQUE (anio)
	);
END

-- TABLE linea ********************************************************************************************

IF OBJECT_ID('linea', 'U') IS NULL
BEGIN
	CREATE TABLE linea
	(
		id_linea INT IDENTITY(1,1) NOT NULL,
		nombre_linea VARCHAR(45) NOT NULL,
		CONSTRAINT linea_pkey PRIMARY KEY (id_linea),
		CONSTRAINT nombre_linea_key UNIQUE (nombre_linea)
	);
END

-- TABLE pais_origen ********************************************************************************************

IF OBJECT_ID('pais_origen', 'U') IS NULL
BEGIN
	CREATE TABLE pais_origen
	(
		id_pais_origen INT IDENTITY(1,1) NOT NULL,
		nombre_pais_origen VARCHAR(45) NOT NULL,
		CONSTRAINT pais_origen_pkey PRIMARY KEY (id_pais_origen),
		CONSTRAINT nombre_pais_origen_key UNIQUE (nombre_pais_origen)
	);
END

-- TABLE aduana_ingreso ********************************************************************************************

IF OBJECT_ID('aduana_ingreso', 'U') IS NULL
BEGIN
	CREATE TABLE aduana_ingreso
	(
		id_aduana_ingreso INT IDENTITY(1,1) NOT NULL,
		nombre_aduana_ingreso VARCHAR(45) NOT NULL,
		CONSTRAINT aduana_ingreso_pkey PRIMARY KEY (id_aduana_ingreso),
		CONSTRAINT nombre_aduana_ingreso_key UNIQUE (nombre_aduana_ingreso)
	);
END

-- TABLE pais_aduana ********************************************************************************************

IF OBJECT_ID('pais_aduana', 'U') IS NULL
BEGIN
	CREATE TABLE pais_aduana
	(
		id_pais_id_aduana INT IDENTITY(1,1) NOT NULL,
		id_pais_origen INT NOT NULL,
		id_aduana_ingreso INT NOT NULL,
		CONSTRAINT pais_aduana_pkey PRIMARY KEY (id_pais_id_aduana),
		CONSTRAINT pais_aduana_id_aduana_ingreso_fkey FOREIGN KEY (id_aduana_ingreso)
			REFERENCES aduana_ingreso (id_aduana_ingreso),
		CONSTRAINT pais_aduana_id_pais_origen_fkey FOREIGN KEY (id_pais_origen)
			REFERENCES pais_origen (id_pais_origen),
		CONSTRAINT d_pais_id_aduana_key UNIQUE (id_pais_origen, id_aduana_ingreso)
	);
END

-- TABLE linea_modelo ********************************************************************************************

IF OBJECT_ID('linea_modelo', 'U') IS NULL
BEGIN
	CREATE TABLE linea_modelo
	(
		id_linea_modelo INT IDENTITY(1,1) NOT NULL,
		id_linea integer NOT NULL,
		id_modelo_lanzamiento integer NOT NULL,
		id_marca integer NOT NULL,
		CONSTRAINT linea_modelo_pkey PRIMARY KEY (id_linea_modelo),
		CONSTRAINT linea_modelo_id_linea_fkey FOREIGN KEY (id_linea)
			REFERENCES linea (id_linea),
		CONSTRAINT linea_modelo_id_marca_fkey FOREIGN KEY (id_marca)
			REFERENCES marca (id_marca),
		CONSTRAINT linea_modelo_id_modelo_lanzamiento_fkey FOREIGN KEY (id_modelo_lanzamiento)
			REFERENCES modelo_lanzamiento (id_modelo_lanzamiento),
		CONSTRAINT linea_modelo_marca_key UNIQUE (id_linea, id_modelo_lanzamiento, id_marca)
	);
END

-- TABLE importacion ********************************************************************************************

IF OBJECT_ID('importacion', 'U') IS NULL
BEGIN
	CREATE TABLE importacion
	(
		id_importacion  INT IDENTITY(1,1) NOT NULL,
		id_pais_id_aduana integer NOT NULL,
		id_linea_modelo integer NOT NULL,
		id_tipo_vehiculo integer NOT NULL,
		id_tipo_combustible integer NOT NULL,
		id_tipo_importador integer NOT NULL,
		fecha_importacion date NOT NULL,
		valor_cif numeric NOT NULL,
		impuesto numeric NOT NULL,
		puertas integer NOT NULL,
		tonelaje numeric NOT NULL,
		asientos integer NOT NULL,
		CONSTRAINT importacion_pkey PRIMARY KEY (id_importacion),
		CONSTRAINT importacion_id_linea_modelo_fkey FOREIGN KEY (id_linea_modelo)
			REFERENCES linea_modelo (id_linea_modelo),
		CONSTRAINT importacion_id_pais_idaduana_fkey FOREIGN KEY (id_pais_id_aduana)
			REFERENCES pais_aduana (id_pais_id_aduana),
		CONSTRAINT importacion_id_tipo_combustible_fkey FOREIGN KEY (id_tipo_combustible)
			REFERENCES tipo_combustible (id_tipo_combustible),
		CONSTRAINT importacion_id_tipo_importador_fkey FOREIGN KEY (id_tipo_importador)
			REFERENCES tipo_importador (id_tipo_importador),
		CONSTRAINT importacion_id_tipo_vehiculo_fkey FOREIGN KEY (id_tipo_vehiculo)
			REFERENCES tipo_vehiculo (id_tipo_vehiculo)
	);
END