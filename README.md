# Modelado, Carga de Datos con SQL Server y Análisis de Datos con SQL Server

<br><img src="https://i.postimg.cc/WzyjkcFp/1-analisis-cargade-Datos.png" alt="">

Este repositorio contiene el código y los recursos necesarios para modelar una base de datos transaccional utilizando SQL Server. El objetivo principal es estructurar las entidades y relaciones a partir de un archivo de texto descargado de Kaggle, luego poblar las tablas correspondientes mediante un procedimiento almacenado y realizar un análisis de datos con SQL Server. El objetivo es proporcionar una estructura completa para el almacenamiento y análisis de datos.

# Introducción

En este proyecto, se han seguido los siguientes pasos para llevar a cabo el modelado y la carga de datos:

### Recolección de Requisitos

- Identificación de los datos y necesidades del negocio basándonos en el archivo de texto descargado de Kaggle.

### Diseño Conceptual

- Creación del modelo entidad-relación (ER) para definir las entidades y sus relaciones.

### Diseño Lógico

- Transformación del modelo ER en un esquema lógico compatible con SQL Server.

### Diseño Físico

- Implementación del esquema lógico en SQL Server, definiendo tablas, índices y restricciones.

### Implementación

- Desarrollo de scripts SQL para crear las tablas y el procedimiento almacenado necesario para poblarlas.

### Pruebas y Validación

- Ejecución de pruebas unitarias e integradas para asegurar la correcta creación y población de las tablas.

## Recolección y Análisis de Datos

Para modelar una base de datos transaccional basada en los datos de los archivos .txt descargados de Kaggle, podemos seguir un proceso estructurado, desde la recolección y análisis de los datos hasta el diseño y creación de la base de datos.

## Recolección y Análisis de Datos

**Entender los Datos**

**Cabeceras de los Datos:**

- País de Proveniencia
- Aduana de Ingreso
- Fecha de la Poliza
- Partida Arancelaria
- Modelo del Vehiculo
- Marca
- Linea
- Centimetros Cubicos
- Distintivo
- Tipo de Vehiculo
- Tipo de Importador
- Tipo Combustible
- Asientos
- Puertas
- Tonelaje
- Valor CIF
- Impuesto

**Características de los Datos:**

- Datos textuales y numéricos.
- Información relacionada con importaciones de vehículos.

## Descripción de Tablas y Relaciones

#### 1. Tabla: marca

**Descripción:** Contiene información sobre las marcas de los vehículos.

**Columnas:**
- **id_marca: **Identificador único de la marca (Clave primaria).
- **nombre_marca:** Nombre de la marca (Único).

**Relaciones:** Relacionada con linea_modelo.

#### 2. Tabla: tipo_combustible

**Descripción:** Contiene información sobre los tipos de combustible de los vehículos.

**Columnas:**

- **id_tipo_combustible:** Identificador único del tipo de combustible (Clave primaria).
- **nombre_tipo_combustible:** Nombre del tipo de combustible (Único).

**Relaciones:** Relacionada con importacion.

#### 3. Tabla: tipo_vehiculo

**Descripción:** Contiene información sobre los tipos de vehículos.

**Columnas:**
- **id_tipo_vehiculo:** Identificador único del tipo de vehículo (Clave primaria).
- **nombre_tipo_vehiculo:** Nombre del tipo de vehículo (Único).

**Relaciones:** Relacionada con importacion.

#### 4. Tabla: tipo_importador

**Descripción:** Contiene información sobre los tipos de importadores.
Columnas:
- **id_tipo_importador:** Identificador único del tipo de importador (Clave primaria).
- **nombre_tipo_importador:** Nombre del tipo de importador (Único).

**Relaciones:** Relacionada con importacion.

#### 5. Tabla: modelo_lanzamiento

**Descripción:** Contiene información sobre los modelos de lanzamiento de los vehículos.

**Columnas:**
- **id_modelo_lanzamiento:** Identificador único del modelo de lanzamiento (Clave primaria).
- **anio:** Año del modelo de lanzamiento (Único).

**Relaciones:** Relacionada con linea_modelo.

#### 6. Tabla: linea

**Descripción:** Contiene información sobre las líneas de vehículos.

**Columnas:**
- **id_linea:** Identificador único de la línea (Clave primaria).
- **nombre_linea:** Nombre de la línea (Único).

**Relaciones:** Relacionada con linea_modelo

#### 7. Tabla: pais_origen

**Descripción:** Contiene información sobre los países de origen de los vehículos.

**Columnas:**
- **id_pais_origen:** Identificador único del país de origen (Clave primaria).
- **nombre_pais_origen**: Nombre del país de origen (Único).

**Relaciones:** Relacionada con pais_aduana.

#### 8. Tabla: aduana_ingreso

**Descripción**: Contiene información sobre las aduanas de ingreso de los vehículos.

**Columnas:**
- **id_aduana_ingreso:** Identificador único de la aduana de ingreso (Clave primaria).
- **nombre_aduana_ingreso:** Nombre de la aduana de ingreso (Único).

**Relaciones:** Relacionada con pais_aduana.

#### 9. Tabla: pais_aduana

**Descripción:** Relaciona los países de origen con las aduanas de ingreso.

**Columnas:**
- **id_pais_id_aduana: Identificador único de la relación (Clave primaria).
- **id_pais_origen: Identificador del país de origen (Clave foránea).
- **id_aduana_ingreso: Identificador de la aduana de ingreso (Clave foránea).

**Relaciones:**
id_pais_origen referencia a pais_origen(id_pais_origen).
id_aduana_ingreso referencia a aduana_ingreso(id_aduana_ingreso).

#### 10. Tabla: linea_modelo

**Descripción:** Relaciona las líneas de vehículos con los modelos de lanzamiento y las marcas.

**Columnas:**
- **id_linea_modelo:** Identificador único de la relación (Clave primaria).
- **id_linea:** Identificador de la línea (Clave foránea).
- **id_modelo_lanzamiento:** Identificador del modelo de lanzamiento (Clave foránea).
- **id_marca:** Identificador de la marca (Clave foránea).

**Relaciones:**
id_linea referencia a linea(id_linea).
id_modelo_lanzamiento referencia a modelo_lanzamiento(id_modelo_lanzamiento).
id_marca referencia a marca(id_marca).

#### 11. Tabla: importacion

**Descripción:** Contiene información sobre las importaciones de vehículos.

**Columnas:**
- **id_importacion:** Identificador único de la importación (Clave primaria).
- **id_pais_id_aduana:** Identificador de la relación país-aduana (Clave foránea).
- **id_linea_modelo:** Identificador de la relación línea-modelo (Clave foránea).
- **id_tipo_vehiculo:** Identificador del tipo de vehículo (Clave foránea).
- **id_tipo_combustible:** Identificador del tipo de combustible (Clave foránea).
- **id_tipo_importador:** Identificador del tipo de importador (Clave foránea).
- **fecha_importacion:** Fecha de la importación.
- **valor_cif:** Valor CIF de la importación.
- **impuesto:** Impuesto sobre la importación.
- **puertas:** Número de puertas del vehículo.
- **tonelaje:** Tonelaje del vehículo.
- **asientos:** Número de asientos del vehículo.

**Relaciones:**
id_pais_id_aduana referencia a pais_aduana(id_pais_id_aduana).
id_linea_modelo referencia a linea_modelo(id_linea_modelo).
id_tipo_vehiculo referencia a tipo_vehiculo(id_tipo_vehiculo).
id_tipo_combustible referencia a tipo_combustible(id_tipo_combustible).
id_tipo_importador referencia a tipo_importador(id_tipo_importador).


### Modelo Físico OLTP

<br><img src="https://i.postimg.cc/sXrcVjLs/3-Diagrama-BD.png" alt="">

## Creación de la Base de Datos

En esta sección se describen los comandos utilizados para la creación de la base de datos en SQL Server. Estos comandos se aplican a lo largo del desarrollo de la base de datos para definir la creación de la base de datos, tablas, restricciones y otras estructuras necesarias. Esta documentación sirve como referencia para entender y reproducir el proceso de creación de la base de datos.

### Comandos Utilizados

### CREATE DATABASE:

Se utiliza para crear un nuevo esquema en la base de datos, que sirve como un contenedor para las tablas y otros objetos.

Ejemplo:

	IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Importaciones')
	BEGIN
		CREATE DATABASE Importaciones
		 ON  PRIMARY 
		( NAME = N'Importaciones', FILENAME = 'D:\Modelado SQL Server\Importaciones.mdf')
		 LOG ON 
		( NAME = N'Importaciones_log', FILENAME = 'D:\Modelado SQL Server\Importaciones.ldf');
	END

	USE Importaciones;
	GO

#### Explicación:

**IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Importaciones'):**

- Esta línea verifica si ya existe una base de datos llamada 'Importaciones' en el servidor de SQL Server. sys.databases es una vista del sistema que contiene información sobre todas las bases de datos en el servidor.

**BEGIN ... END: **

- Define un bloque de código que se ejecutará si la condición anterior (IF NOT EXISTS ...) es verdadera. En este caso, si no existe la base de datos 'Importaciones', se procederá con la creación de la base de datos.

**CREATE DATABASE Importaciones:**

Este comando crea la base de datos llamada 'Importaciones'.

**ON PRIMARY:**

- Define la ubicación y el nombre del archivo de datos primario (Importaciones.mdf). Esto especifica dónde se almacenarán los datos principales de la base de datos.

**LOG ON:**

- Define la ubicación y el nombre del archivo de registro (Importaciones.ldf). Esto especifica dónde se almacenarán los registros de transacciones de la base de datos.

**USE Importaciones:**

- Cambia el contexto actual de la base de datos al recién creada 'Importaciones'. Todos los comandos SQL que se ejecuten después de esta línea afectarán a la base de datos 'Importaciones'.

**GO:**

- Es un delimitador de lotes en SQL Server. Indica que el bloque de código anterior debe ejecutarse como un solo lote de instrucciones.

Este script asegura que la base de datos **'Importaciones'** se cree solo si no existe previamente en el servidor de SQL Server. Una vez creada, cambia el contexto para que todos los comandos posteriores se ejecuten dentro de esta base de datos.

### CREATE TABLE:

Se utiliza para crear una nueva tabla dentro del esquema especificado. Define la estructura de la tabla, incluyendo las columnas y sus tipos de datos.

Ejemplo:

	IF OBJECT_ID('marca', 'U') IS NOT NULL
	BEGIN
		DELETE FROM marca;
	END
	ELSE

	BEGIN
		CREATE TABLE marca
		(
			id_marca INT IDENTITY(1,1) NOT NULL,
			nombre_marca VARCHAR(45) NOT NULL,
			CONSTRAINT PK_marca PRIMARY KEY (id_marca),
			CONSTRAINT UQ_marca_nombre UNIQUE (nombre_marca)
		);
	END

#### Explicación:

**IF OBJECT_ID('marca', 'U') IS NOT NULL:**

- Verifica si la tabla 'marca' existe en la base de datos. El parámetro 'U' indica que se está buscando una tabla (User Table).

**TRUNCATE TABLE marca;:**

- Si la tabla 'marca' existe, el comando TRUNCATE TABLE elimina todos los registros de la tabla, pero conserva la estructura de la tabla.

**CREATE TABLE marca ...:**

- Si la tabla 'marca' no existe (la condición ELSE), se procede a crearla con las columnas definidas (id_marca y nombre_marca) junto con las restricciones de clave primaria (PK_marca) y unicidad (UQ_marca_nombre).

- Este enfoque garantiza que la tabla 'marca' esté vacía antes de continuar, si ya existe, o que se cree si no existe previamente. Es importante tener en cuenta que TRUNCATE TABLE elimina todos los registros de la tabla sin registrar el cambio en el log de transacciones, por lo que es más rápido que DELETE.

### IDENTITY:

Se utiliza para definir una columna de tipo entero que se auto incrementa automáticamente en SQL Server. Es útil para crear identificadores únicos y autoincrementales para las filas de una tabla. Al especificar IDENTITY, se puede definir el valor inicial y el incremento para la columna.

Ejemplo:

	id_marca INT IDENTITY(1,1) NOT NULL

En este ejemplo:

- **id_marca:** Es el nombre de la columna.
- **INT:** Define que la columna es de tipo entero.
- **IDENTITY(1,1):** Indica que el valor inicial será 1 y el incremento será de 1 para cada nueva fila insertada.
- **NOT NULL: **Indica que la columna no puede contener valores nulos.

La columna **id_marca** se llenará automáticamente con valores únicos y secuenciales a medida que se inserten nuevas filas en la tabla, sin necesidad de especificar manualmente el valor para esta columna.

### PRIMARY KEY:

Se utiliza para definir una clave primaria en una tabla, que asegura la unicidad y no nulidad de los valores en una columna o conjunto de columnas.

- Ejemplo:

			CONSTRAINT marca_pkey PRIMARY KEY (id_marca)

### UNIQUE:

Se utiliza para asegurar que los valores en una columna o conjunto de columnas sean únicos en la tabla.

- Ejemplo:

			CONSTRAINT marca_nombremarca_key UNIQUE (nombre_marca)

### FOREIGN KEY:

Se utiliza para definir una clave foránea en una tabla, que crea una relación entre columnas de diferentes tablas. Asegura la integridad referencial entre las tablas.

### Tipos de Datos Utilizados en el Modelamiento

En el modelamiento de la base de datos, se han utilizado diferentes tipos de datos para representar adecuadamente las características y restricciones de los datos que se van a almacenar. Los tipos de datos seleccionados se basan en un análisis detallado de los datos proporcionados y en las necesidades específicas del sistema. A continuación, se describen algunos de los tipos de datos clave utilizados:

- **INTEGER:** Se utiliza para columnas que almacenan números enteros. Este tipo de datos es adecuado para campos como identificadores, contadores y otros valores que no requieren decimales.

- **NUMERIC:** Se utiliza para columnas que necesitan almacenar valores numéricos con precisión decimal, como precios, cantidades monetarias y otras métricas que requieren un manejo preciso de decimales.::

- **VARCHAR(45):** Se utiliza para columnas que almacenan cadenas de texto de longitud variable, hasta un máximo de 45 caracteres. Este tipo de datos es útil para nombres, descripciones cortas y otros textos que tienen una longitud limitada.

- **DATE:** Se utiliza para columnas que almacenan fechas. Es ideal para campos que requieren almacenamiento de información temporal como fechas de registro, fechas de transacciones, etc.

- **CHAR(1):** Se utiliza para columnas que almacenan un solo carácter, como indicadores o banderas.

El uso adecuado de estos tipos de datos garantiza que los datos se almacenen de manera eficiente y que las operaciones sobre ellos sean rápidas y precisas. Además, se asegura la integridad de los datos al definir restricciones y reglas específicas para cada columna.

<br><img src="https://i.postimg.cc/Bv8dXf0X/4-Script-create-table.png" alt="">

## Store Procedure para la Carga de Información

En el procedimiento almacenado creado para la carga de información, se utilizan diversos comandos y técnicas para asegurar una limpieza y una carga adecuada de los datos. A continuación, se describen los principales elementos y comandos utilizados:

### Comandos Utilizados

### UPPER:

Se utiliza para convertir todos los datos a mayúsculas, asegurando así una homologación de la información.

### LTRIM y RTRIM:

Se utilizan para eliminar espacios en blanco al inicio y al final de los datos.

Ejemplo: UPPER(LTRIM(RTRIM(nombre_columna)))

	UPDATE tablatemporal SET
		pais_de_proveniencia = UPPER(LTRIM(RTRIM(pais_de_proveniencia))),
		aduana_de_ingreso = UPPER(LTRIM(RTRIM(aduana_de_ingreso))),
		fecha_de_la_poliza = UPPER(LTRIM(RTRIM(fecha_de_la_poliza))),
		modelo_del_vehiculo = UPPER(LTRIM(RTRIM(modelo_del_vehiculo))),
		marca = UPPER(LTRIM(RTRIM(marca))),
		linea = UPPER(LTRIM(RTRIM(linea))),
		centimetros_cubicos = UPPER(LTRIM(RTRIM(centimetros_cubicos))),
		tipo_de_vehiculo = UPPER(LTRIM(RTRIM(tipo_de_vehiculo))),
		tipo_de_importador = UPPER(LTRIM(RTRIM(tipo_de_importador))),
		tipo_combustible = UPPER(LTRIM(RTRIM(tipo_combustible))),
		asientos = UPPER(LTRIM(RTRIM(asientos))),
		puertas = UPPER(LTRIM(RTRIM(puertas))),
		tonelaje = UPPER(LTRIM(RTRIM(tonelaje))),
		valor_cif = UPPER(LTRIM(RTRIM(valor_cif))),
		impuesto = UPPER(LTRIM(RTRIM(impuesto)))
	;

### UPDATE:

Se utiliza para realizar una limpieza y actualización de los datos. Por ejemplo, en casos donde se detectó que la marca "GREAT DANE" estaba escrita incorrectamente como "RATE DANE".

Ejemplo:

	UPDATE tablatemporal SET
		marca = 'GREAT DANE'
	WHERE marca = 'GRATE DANE';

	UPDATE tablatemporal SET
	linea = (
		CASE
			WHEN linea IN ('SINLINEA', 'SILINEA', '--') THEN 'SIN LINEA'
			WHEN linea = 'SOUL !' THEN 'SOUL'
			ELSE linea
		END
	);

### DELETE:

Se utiliza para eliminar la información de las tablas antes de la ejecución del stored procedure, evitando así errores al momento de la población.

Ejemplo:

	DELETE FROM importacion;
	DELETE FROM pais_aduana;
	DELETE FROM aduana_ingreso;
	DELETE FROM pais_aduana;
	DELETE FROM tipo_vehiculo;
	DELETE FROM tipo_importador;
	DELETE FROM tipo_combustible;
	DELETE FROM linea_modelo;
	DELETE FROM modelo_lanzamiento;
	DELETE FROM marca;
	DELETE FROM linea;

### DELETE:

Se utiliza para eliminar la información de las tablas antes de la ejecución del stored procedure, evitando así errores al momento de la población.

Ejemplo:

	INSERT INTO pais_origen(nombre_pais_origen)
	SELECT pais_de_proveniencia
	FROM tablatemporal
	WHERE pais_de_proveniencia not in (
		SELECT nombre_pais_origen
		FROM pais_origen
	)
	GROUP BY pais_de_proveniencia
	ORDER BY pais_de_proveniencia;

### LEFT JOIN e INNER JOIN:

Se utilizan para poblar tablas que dependen de otras tablas de catálogo previamente pobladas, de manera que se puedan obtener sus llaves primarias.

Ejemplo:

	INSERT INTO pais_aduana (id_pais_origen, id_aduana_ingreso)
	SELECT tb.id_pais_origen, tc.id_aduana_ingreso
	FROM (
		SELECT ta.pais_de_proveniencia, ta.aduana_de_ingreso
		FROM tablatemporal ta
		GROUP BY ta.pais_de_proveniencia, ta.aduana_de_ingreso
	) tx
		left join pais_origen tb on tx.pais_de_proveniencia = tb.nombre_pais_origen
		left join aduana_ingreso tc on tx.aduana_de_ingreso = tc.nombre_aduana_ingreso
	WHERE NOT EXISTS (
		SELECT 1
		FROM pais_aduana pa
		WHERE pa.id_pais_origen = tb.id_pais_origen
		AND pa.id_aduana_ingreso = tc.id_aduana_ingreso
	);

### Bucle WHILE:

Se utiliza para recorrer los registros de la tabla temporal y, en la recursividad, extraer las llaves de cada catálogo para poblar la tabla base que contiene los registros de las importaciones.

Ejemplo: Esto es solo parte del código

	DECLARE
		@MinID BIGINT = 0,
		@MaxID BIGINT = 0;

	SET @MinID = (SELECT TOP (1) id_registro FROM tablatemporal ORDER BY id_registro);
	SET @MaxID = (SELECT TOP (1) id_registro FROM tablatemporal ORDER BY id_registro DESC);

	WHILE (@MinID <= @MaxID)
	BEGIN

		DECLARE
			@pais_de_proveniencia VARCHAR(100),
			@aduana_de_ingreso VARCHAR(100),
			@v_id_pais_origen INTEGER
		SELECT
			@pais_de_proveniencia = pais_de_proveniencia,
			@aduana_de_ingreso = aduana_de_ingreso
		FROM tablatemporal WHERE id_registro = @MaxID;
		
		SELECT @v_id_pais_origen = id_pais_origen
		FROM pais_origen
		WHERE nombre_pais_origen = @pais_de_proveniencia;
		
		SELECT @v_id_aduana_ingreso = id_aduana_ingreso
		FROM aduana_ingreso
		WHERE nombre_aduana_ingreso = @aduana_de_ingreso;
		
		SELECT @v_id_pais_id_aduana = id_pais_id_aduana
		FROM pais_aduana
		WHERE id_pais_origen = @v_id_pais_origen
		and id_aduana_ingreso = @v_id_aduana_ingreso;
		
		INSERT INTO importacion (
			id_pais_id_aduana
		)
		SELECT
			@v_id_pais_id_aduana
		;
		
		SET @MaxID = @MaxID - 1;
	END

### GROUP BY:

Se utiliza para agrupar los datos de los catálogos al momento de la carga.

Ejemplo:

	INSERT INTO linea(nombre_linea)
	SELECT linea
	FROM tablatemporal
	WHERE linea not in (
		SELECT nombre_linea
		FROM linea
	)
	GROUP BY linea
	ORDER BY linea;

### ORDER BY:

Se utiliza para ordenar los datos al momento de insertarlos, asegurando que las claves automáticas se generen en el orden correcto.

Ejemplo:

	SET @MinID = (SELECT TOP (1) id_registro FROM tablatemporal ORDER BY id_registro);
	SET @MaxID = (SELECT TOP (1) id_registro FROM tablatemporal ORDER BY id_registro DESC);

## Contenido del Repositorio

**web_imp_08012019:** Archivo de texto original descargado de Kaggle.
**create_tables.sql:** Script para crear las tablas en la base de datos.
**script_insert_data:** Script los insert into para la tabla temporal.
 **store_procedure.sql:** Script del stored procedure para poblar las tablas finales.
 **store_querys.sql:** Script con las consultas para cada pregunta de análisis.
**README.md:** Este archivo, que proporciona una guía sobre el proyecto y su estructura.

## Instrucciones para Configurar y Cargar los Datos

Sigue estos pasos para configurar el proyecto y cargar los datos en la tabla temporal:

### 1. Clonar el Repositorio

- Abre una terminal o un cliente de Git en tu máquina local.
- Clona este repositorio en tu máquina local ejecutando el siguiente comando:

  git clone https://github.com/jcarlosmamanidelacruz/Modelado_Carga_Analisis_SQLServer.git

### 2. Editar el Script "create_tables.sql"

- Crea las siguientes carpetas en tu disco local **D:\Modelado SQL Server\ ** o en todo caso edita la ruta donde se creara la base de datos.

		CREATE DATABASE Importaciones_db
		ON  PRIMARY 
		( NAME = N'Importaciones_db', FILENAME = 'D:\Modelado SQL Server\Importaciones_db.mdf')
		LOG ON 
		( NAME = N'Importaciones_db_log', FILENAME = 'D:\Modelado SQL Server\Importaciones_db.ldf');

- Abre el archivo **create_tables.sql**  y ejecutalo en tu editor de SQL Server o IDE de tu preferencia.

- Abre el archivo **script_insert_data.sql**  y ejecutalo en tu editor de SQL Server o IDE de tu preferencia.

- Abre el archivo **store_procedure.sql**  y ejecutalo en tu editor de SQL Server o IDE de tu preferencia.

### 3. Ejecuta el stored procedure

- Ejecuta el siguiente comando para ejecutar el stored procedure y poblar las tablas creadas:

		exec sp_proceso_carga;

# Análisis de Datos con SQL Server

En este proyecto, se ha estructurado un análisis de datos para responder a preguntas específicas relacionadas con las importaciones de vehículos.

### Preguntas Principales de Análisis:

- ¿Cuál es el total de valor del Costo, Seguro y Flete (CIF) de las importaciones por país en un año específico, , ordenado por el total de CIF en orden descendente?

- ¿Cuál es el valor total y el valor promedio de impuestos recaudados por años de las importaciones vehiculares?

- ¿Cuál es el total de impuestos recaudados por tipo de importador en un año específico?

- ¿Cuál es la aduana que ha recaudado más ingresos en un año determinado, ordenado por el total de ingresos en orden descendente?

- ¿Cuáles son las 5 aduanas con el mayor número de importaciones de BUSES en términos de cantidad de vehículos?

- ¿Cuál es el total de impuestos registrados para cada período de tiempo en un año determinado, ordenado por el total de impuestos de forma descendente?

- ¿Cuál es el total de impuestos registrados por año y cuánto fue en el año siguiente?

- ¿Cuál es el total de impuestos por país para la aduana que ha tenido el mayor cantidad de importaciones durante el año 2019, ordenado por el total de impuestos de forma descendente?

### Comandos SQL Utilizados en el Análisis

Para desarrollar y responder las preguntas de análisis planteadas en este proyecto, se han utilizado diversos comandos y técnicas SQL avanzadas. A continuación, se detallan algunos de los comandos más importantes empleados:

**SELECT**

El comando SELECT se utiliza para seleccionar datos de una base de datos. Es uno de los comandos más fundamentales en SQL.

**GROUP BY**

El comando GROUP BY se utiliza para agrupar filas que tienen los mismos valores en columnas especificadas en grupos.

**ORDER BY**

El comando ORDER BY se utiliza para ordenar el conjunto de resultados de una consulta SQL por una o más columnas.

**JOINs (LEFT JOIN, INNER JOIN)**

Los comandos JOIN se utilizan para combinar filas de dos o más tablas, basadas en una columna relacionada entre ellas. En este proyecto, se utilizaron LEFT JOIN e INNER JOIN para combinar tablas.

**YEAR**

La función YEAR se utiliza para extraer el año de una fecha.

**SUM**

La función SUM se utiliza para calcular la suma de un conjunto de valores numéricos.

**AVG**

La función AVG se utiliza para calcular el promedio de un conjunto de valores numéricos.

**TOP**

La cláusula TOP se utiliza para limitar el número de filas devueltas por una consulta.

**LEAD**

La función LEAD se utiliza para acceder a la fila siguiente (en términos de orden) desde la fila actual en un conjunto de resultados.

**WHERE**

El comando WHERE se utiliza para filtrar registros que cumplen una condición especificada.

**SUBCONSULTAS**

Las subconsultas se utilizan para ejecutar una consulta dentro de otra consulta.

**LEAD(SUM(impuesto), 1) OVER (ORDER BY YEAR(fecha_importacion))**

Esta expresión utiliza la función LEAD para obtener el valor de la suma del impuesto en el siguiente año en el conjunto de resultados ordenado por el año de la fecha de importación.

### Análisis de Datos y Capturas de Resultados

- ¿Cuál es el total de valor del Costo, Seguro y Flete (CIF) de las importaciones por país en un año específico, , ordenado por el total de CIF en orden descendente?

		select tc.nombre_pais_origen, FORMAT(SUM(valor_cif), 'N2') AS valor_cif
		from importacion ta
			left join pais_aduana tb on ta.id_pais_id_aduana = tb.id_pais_id_aduana
			left join pais_origen tc on tb.id_pais_origen = tc.id_pais_origen
		where year(fecha_importacion)  = 2019
		group by tc.nombre_pais_origen
		order by 2 desc;

<br><img src="https://i.postimg.cc/nLXLHf7R/5-query1.png" alt="">

- ¿Cuál es el valor total y el valor promedio de impuestos recaudados por años de las importaciones vehiculares?

		select
			year(fecha_importacion) as año,
			FORMAT(SUM(impuesto), 'N2') total,
			FORMAT(AVG(impuesto), 'N2') promedio
		from importacion ta
		group by year(fecha_importacion)
		order by 1 desc;

<br><img src="https://i.postimg.cc/WzC8LdZm/5-query2.png" alt="">

- ¿Cuál es el total de impuestos recaudados por tipo de importador en un año específico?

		select
			tb.nombre_tipo_importador,
			FORMAT(SUM(impuesto), 'N2') total
		from importacion ta
			left join tipo_importador tb on ta.id_tipo_importador = tb.id_tipo_importador
		where year(fecha_importacion)  = 2019
		group by tb.nombre_tipo_importador
		order by 1;

<br><img src="https://i.postimg.cc/y8tDmFHy/5-query3.png" alt="">

- ¿Cuál es la aduana que ha recaudado más ingresos en un año determinado, ordenado por el total de ingresos en orden descendente?

		select tc.nombre_aduana_ingreso, SUM(valor_cif) AS valor_cif
		from importacion ta
			left join pais_aduana tb on ta.id_pais_id_aduana = tb.id_pais_id_aduana
			left join aduana_ingreso tc on tb.id_aduana_ingreso = tc.id_aduana_ingreso
		where year(fecha_importacion)  = 2019
		group by tc.nombre_aduana_ingreso
		order by 2 desc;

<br><img src="https://i.postimg.cc/SNpRxyGD/5-query4.png" alt="">

- ¿Cuáles son las 5 aduanas con el mayor número de importaciones de BUSES en términos de cantidad de vehículos?

		select top(5) tc.nombre_aduana_ingreso, count(*) cantidad_importaciones
		from importacion ta
			left join pais_aduana tb on ta.id_pais_id_aduana = tb.id_pais_id_aduana
			left join aduana_ingreso tc on tb.id_aduana_ingreso = tc.id_aduana_ingreso
			left join tipo_vehiculo td on ta.id_tipo_vehiculo = td.id_tipo_vehiculo
		where td.nombre_tipo_vehiculo = 'BUS'
		group by tc.nombre_aduana_ingreso
		order by 2 desc;

<br><img src="https://i.postimg.cc/cJ8G33xY/5-query5.png" alt="">

- ¿Cuál es el total de impuestos registrados para cada período de tiempo en un año determinado, ordenado por el total de impuestos de forma descendente?

		select
			FORMAT(fecha_importacion, 'yyyy-MM') AS periodo,
			sum(impuesto) total
		from importacion ta
		where year(fecha_importacion)  = 2017
		group by FORMAT(fecha_importacion, 'yyyy-MM')
		order by 2 desc;

<br><img src="https://i.postimg.cc/1zCxbKvL/5-query6.png" alt="">

- ¿Cuál es el total de impuestos registrados por año y cuánto fue en el año siguiente?

		select
			year(fecha_importacion) as año,
			sum(impuesto) total,
			LEAD(SUM(impuesto), 1) OVER (ORDER BY YEAR(fecha_importacion)) AS importacion_siguiente_anio
		from importacion ta
		group by year(fecha_importacion)
		order by 2 desc;

<br><img src="https://i.postimg.cc/VsF9wHqr/5-query7.png" alt="">

- ¿Cuál es el total de impuestos por país para la aduana que ha tenido el mayor cantidad de importaciones durante el año 2019, ordenado por el total de impuestos de forma descendente?

		select tc.nombre_pais_origen, td.nombre_aduana_ingreso, sum(impuesto) total
		from importacion ta
			left join pais_aduana tb on ta.id_pais_id_aduana = tb.id_pais_id_aduana
			left join pais_origen tc on tb.id_pais_origen = tc.id_pais_origen
			left join aduana_ingreso td on tb.id_aduana_ingreso = td.id_aduana_ingreso
		where year(fecha_importacion) = 2019
		and tb.id_aduana_ingreso in (
			select top(1) tc.id_aduana_ingreso
			from importacion ta, pais_aduana tb, aduana_ingreso tc
			where year(fecha_importacion)  = 2019
			and ta.id_pais_id_aduana = tb.id_pais_id_aduana
			and tb.id_aduana_ingreso = tc.id_aduana_ingreso
			group by tc.id_aduana_ingreso
			order by count(*) desc
		)
		group by tc.nombre_pais_origen, td.nombre_aduana_ingreso
		order by sum(impuesto) desc;

<br><img src="https://i.postimg.cc/8zTzStb5/5-query8.png" alt="">
