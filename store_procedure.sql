USE [Importaciones_db]
GO
/****** Object:  StoredProcedure [dbo].[sp_proceso_carga]    Script Date: 11/07/2024 11:13:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[sp_proceso_carga] 
AS
BEGIN

	-- exec sp_proceso_carga;
	
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

	-- INSERT INTO TABLE pais_origen;
	
	INSERT INTO pais_origen(nombre_pais_origen)
	SELECT pais_de_proveniencia
	FROM tablatemporal
	WHERE pais_de_proveniencia not in (
		SELECT nombre_pais_origen
		FROM pais_origen
	)
	GROUP BY pais_de_proveniencia
	ORDER BY pais_de_proveniencia;

	-- INSERT INTO TABLE aduana_ingreso

	INSERT INTO aduana_ingreso(nombre_aduana_ingreso)
	SELECT aduana_de_ingreso
	FROM tablatemporal
	WHERE aduana_de_ingreso not in (
		SELECT nombre_aduana_ingreso
		FROM aduana_ingreso
	)
	GROUP BY aduana_de_ingreso
	ORDER BY aduana_de_ingreso;

	-- INSERT INTO TABLE pais_aduana

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
	
	-- INSERT INTO TABLE tipo_vehiculo
	
	INSERT INTO tipo_vehiculo(nombre_tipo_vehiculo)
	SELECT tipo_de_vehiculo
	FROM tablatemporal
	WHERE tipo_de_vehiculo not in (
		SELECT nombre_tipo_vehiculo
		FROM tipo_vehiculo
	)
	GROUP BY tipo_de_vehiculo
	ORDER BY tipo_de_vehiculo;

	-- INSERT INTO TABLE tipo_vehiculo

	INSERT INTO tipo_importador(nombre_tipo_importador)
	SELECT tipo_de_importador
	FROM tablatemporal
	WHERE tipo_de_importador not in (
		SELECT nombre_tipo_importador
		FROM tipo_importador
	)
	GROUP BY tipo_de_importador
	ORDER BY tipo_de_importador;

	-- INSERT INTO TABLE tipo_combustible

	INSERT INTO tipo_combustible(nombre_tipo_combustible)
	SELECT tipo_combustible
	FROM tablatemporal
	WHERE tipo_combustible not in (
		SELECT nombre_tipo_combustible
		FROM tipo_combustible
	)
	GROUP BY tipo_combustible
	ORDER BY tipo_combustible;

	-- INSERT INTO TABLE modelo_lanzamiento

	INSERT INTO modelo_lanzamiento(anio)
	SELECT modelo_del_vehiculo
	FROM tablatemporal
	WHERE modelo_del_vehiculo not in (
		SELECT anio
		FROM modelo_lanzamiento
	)
	GROUP BY modelo_del_vehiculo
	ORDER BY modelo_del_vehiculo;

	-- INSERT INTO TABLE marca

	INSERT INTO marca(nombre_marca)
	SELECT marca
	FROM tablatemporal
	WHERE marca not in (
		SELECT nombre_marca
		FROM marca
	)
	GROUP BY marca
	ORDER BY marca;

	-- INSERT INTO TABLE linea
	
	INSERT INTO linea(nombre_linea)
	SELECT linea
	FROM tablatemporal
	WHERE linea not in (
		SELECT nombre_linea
		FROM linea
	)
	GROUP BY linea
	ORDER BY linea;

	-- INSERT INTO TABLE linea_modelo

	INSERT INTO linea_modelo(id_linea, id_modelo_lanzamiento, id_marca)
	SELECT ta.id_linea, tb.id_modelo_lanzamiento, tc.id_marca
	FROM (
		SELECT modelo_del_vehiculo, marca, linea
		FROM tablatemporal
		GROUP BY modelo_del_vehiculo, marca, linea
	) tx, linea ta, modelo_lanzamiento tb, marca tc
	WHERE tx.linea = ta.nombre_linea
	and tx.modelo_del_vehiculo = tb.anio
	and tx.marca = tc.nombre_marca
	and not exists (
		SELECT id_linea, id_modelo_lanzamiento, id_marca
		FROM linea_modelo li
		WHERE li.id_linea = ta.id_linea
		and li.id_modelo_lanzamiento = tb.id_modelo_lanzamiento
		and li.id_marca = tc.id_marca
	);
	
	
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
			@marca VARCHAR(100),
			@modelo_del_vehiculo VARCHAR(100),
			@linea VARCHAR(100),
			@tipo_de_vehiculo VARCHAR(100),
			@tipo_combustible VARCHAR(100),
			@tipo_de_importador VARCHAR(100),
			@fecha_de_la_poliza date,
			@valor_cif numeric,
			@impuesto numeric,
			@puertas integer,
			@tonelaje integer,
			@asientos integer,

			@v_id_pais_origen INTEGER,
			@v_id_aduana_ingreso INTEGER,
			@v_id_pais_id_aduana INTEGER,
			@v_id_marca INTEGER,
			@V_id_modelo_lanzamiento INTEGER,
			@v_id_linea INTEGER,
			@v_id_linea_modelo INTEGER,
			@v_id_tipo_vehiculo INTEGER,
			@v_id_tipo_combustible INTEGER,
			@v_id_tipo_importador INTEGER;
		SELECT
			@pais_de_proveniencia = pais_de_proveniencia,
			@aduana_de_ingreso = aduana_de_ingreso,
			@marca =  marca,
			@modelo_del_vehiculo = modelo_del_vehiculo,
			@linea = linea,
			@tipo_de_vehiculo = tipo_de_vehiculo,
			@tipo_combustible = tipo_combustible,
			@tipo_de_importador = tipo_de_importador,
			@fecha_de_la_poliza = CAST(fecha_de_la_poliza AS DATE),
			@valor_cif = CAST(valor_cif AS NUMERIC(10,3)),
			@impuesto = CAST(impuesto AS NUMERIC(10,3)),
			@puertas = CAST(puertas AS INT),
			@tonelaje = CAST(CAST(tonelaje AS DECIMAL(10,3)) AS INT),
			@asientos = CAST(asientos AS INT)
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
		
		SELECT @v_id_marca = id_marca
		FROM marca
		WHERE nombre_marca = @marca;
		
		SELECT @V_id_modelo_lanzamiento = id_modelo_lanzamiento
		FROM modelo_lanzamiento
		WHERE anio = @modelo_del_vehiculo;
		
		SELECT @v_id_linea = id_linea
		FROM linea
		WHERE nombre_linea = @linea;
		
		SELECT @v_id_linea_modelo = id_linea_modelo
		FROM linea_modelo
		WHERE id_marca = @v_id_marca
		and id_modelo_lanzamiento = @v_id_modelo_lanzamiento
		and id_linea = @v_id_linea;
		
		SELECT @v_id_tipo_vehiculo = id_tipo_vehiculo
		FROM tipo_vehiculo
		WHERE nombre_tipo_vehiculo = @tipo_de_vehiculo;
		
		SELECT @v_id_tipo_combustible = id_tipo_combustible
		FROM tipo_combustible
		WHERE nombre_tipo_combustible = @tipo_combustible;
		
		SELECT @v_id_tipo_importador = id_tipo_importador
		FROM tipo_importador
		WHERE nombre_tipo_importador = @tipo_de_importador;
		
		INSERT INTO importacion (
			id_pais_id_aduana,
			id_linea_modelo,
			id_tipo_vehiculo,
			id_tipo_combustible,
			id_tipo_importador,
			fecha_importacion,
			valor_cif,
			impuesto,
			puertas,
			tonelaje,
			asientos
		)
		SELECT
			@v_id_pais_id_aduana,
			@v_id_linea_modelo,
			@v_id_tipo_vehiculo,
			@v_id_tipo_combustible,
			@v_id_tipo_importador,
			@fecha_de_la_poliza,
			@valor_cif,
			@impuesto,
			@puertas,
			@tonelaje,
			@asientos
		;
		
		SET @MaxID = @MaxID - 1;
	END
	
END