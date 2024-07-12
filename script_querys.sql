﻿-- ¿Cuál es el total de valor del Costo, Seguro y Flete (CIF) de las importaciones por país en un año específico, , ordenado por el total de CIF en orden descendente?

select tc.nombre_pais_origen, FORMAT(SUM(valor_cif), 'N2') AS valor_cif
from importacion ta
	left join pais_aduana tb on ta.id_pais_id_aduana = tb.id_pais_id_aduana
	left join pais_origen tc on tb.id_pais_origen = tc.id_pais_origen
where year(fecha_importacion)  = 2019
group by tc.nombre_pais_origen
order by 2 desc;

-- ¿Cuál es el valor total y el valor promedio de impuestos recaudados por años de las importaciones vehiculares?

select
	year(fecha_importacion) as año,
	FORMAT(SUM(impuesto), 'N2') total,
	FORMAT(AVG(impuesto), 'N2') promedio
from importacion ta
group by year(fecha_importacion)
order by 1 desc;

-- ¿Cuál es el total de impuestos recaudados por tipo de importador en un año específico?

select
	tb.nombre_tipo_importador,
	FORMAT(SUM(impuesto), 'N2') total
from importacion ta
	left join tipo_importador tb on ta.id_tipo_importador = tb.id_tipo_importador
where year(fecha_importacion)  = 2019
group by tb.nombre_tipo_importador
order by 1;

-- ¿Cuál es la aduana que ha recaudado más ingresos en un año determinado, ordenado por el total de ingresos en orden descendente?

select tc.nombre_aduana_ingreso, SUM(valor_cif) AS valor_cif
from importacion ta
	left join pais_aduana tb on ta.id_pais_id_aduana = tb.id_pais_id_aduana
	left join aduana_ingreso tc on tb.id_aduana_ingreso = tc.id_aduana_ingreso
where year(fecha_importacion)  = 2019
group by tc.nombre_aduana_ingreso
order by 2 desc;

-- ¿Cuáles son las 5 aduanas con el mayor número de importaciones de BUSES en términos de cantidad de vehículos?

select top(5) tc.nombre_aduana_ingreso, count(*) cantidad_importaciones
from importacion ta
	left join pais_aduana tb on ta.id_pais_id_aduana = tb.id_pais_id_aduana
	left join aduana_ingreso tc on tb.id_aduana_ingreso = tc.id_aduana_ingreso
	left join tipo_vehiculo td on ta.id_tipo_vehiculo = td.id_tipo_vehiculo
where td.nombre_tipo_vehiculo = 'BUS'
group by tc.nombre_aduana_ingreso
order by 2 desc;

-- ¿Cuál es el total de impuestos registrados para cada período de tiempo en un año determinado, ordenado por el total de impuestos de forma descendente?

select
	FORMAT(fecha_importacion, 'yyyy-MM') AS periodo,
	sum(impuesto) total
from importacion ta
where year(fecha_importacion)  = 2017
group by FORMAT(fecha_importacion, 'yyyy-MM')
order by 2 desc;

-- ¿Cuál es el total de impuestos registrados por año y cuánto fue en el año siguiente?

select
	year(fecha_importacion) as año,
	sum(impuesto) total,
	LEAD(SUM(impuesto), 1) OVER (ORDER BY YEAR(fecha_importacion)) AS importacion_siguiente_anio
from importacion ta
group by year(fecha_importacion)
order by 2 desc;

-- ¿Cuál es el total de impuestos por país para la aduana que ha tenido el mayor cantidad de importaciones durante el año 2019, ordenado por el total de impuestos de forma descendente?

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