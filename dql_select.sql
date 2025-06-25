USE BancoCL

-- PRIMERAS 10 CONSULTAS - CONSULTAS BASICAS DE CLIENTES

-- 1era consulta: obtener los datos de los clientes y a su vez ordenandolo alfabeticamente por su apellido (A-Z)
SELECT cliente_id, numero_documento, nombres, apellidos, email, telefono, fecha_registro
FROM Clientes
ORDER BY apellidos ASC;

-- 2da consulta: mostrar unicamente los clientes activos con su informacion de contacto (email y telefono)
SELECT cliente_id, email, telefono
FROM Clientes
WHERE estado = 'Activo';

-- 3ra consulta: encontrar un cliente especifico usando su numero de documento
SELECT cliente_id, numero_documento, nombres, apellidos, email, telefono, fecha_registro
FROM Clientes
WHERE numero_documento = '1023456789';

-- 4ta consulta: listar clientes que tengan entre 25 a 45 años de edad
SELECT cliente_id, numero_documento, nombres, apellidos, email, telefono, fecha_registro, fecha_nacimiento
FROM Clientes
WHERE fecha_nacimiento BETWEEN '1976-01-01' AND '1999-01-01'

-- 5ta consula: mostrar clientes con ingresos mayores a 5 millones
SELECT cliente_id, numero_documento, nombres, apellidos, email, telefono, fecha_registro, ingresos_mensuales
FROM Clientes
WHERE ingresos_mensuales >= '5000000'

-- 6ta consulta: mostrar los clientes que se registraron en los ultimos 6 meses
SELECT cliente_id, numero_documento, nombres, apellidos, email, telefono, fecha_registro
FROM Clientes
WHERE fecha_registro >= '2025-01-01';

-- 7ta consulta: mostrar los clientes que tienen una inactividad de 3 meses
SELECT cliente_id, numero_documento, nombres, apellidos, email, telefono, fecha_registro, ultimo_acceso
FROM Clientes
WHERE ultimo_acceso <= DATE_SUB(CURDATE(), INTERVAL 3 MONTH);

-- 8va consulta: listar todas las ocupaciones distintas y contrar cuantos clientes hay por cada una
SELECT  ocupacion,  COUNT(*) AS cantidad_clientes  
FROM Clientes  
GROUP BY ocupacion  
ORDER BY cantidad_clientes DESC;

-- 9na consulta: mostrar clientes q tengan alguna observacion registrada
SELECT cliente_id, nombres, apellidos, observaciones
FROM Clientes
WHERE observaciones IS NOT NULL

-- 10ma consulta: listar los 5 clientes con mayores ingresos mensuales
SELECT cliente_id, numero_documento, nombres, apellidos, email, telefono, ingresos_mensuales
FROM Clientes
ORDER BY ingresos_mensuales DESC
LIMIT 5;

-- ignorar esta parte de codigo
SELECT cuota_id FROM cuotas_manejo WHERE tarjeta_id IN (1, 2) AND periodo_mes = 6 AND periodo_año = 2024;

-- 11-20 Consultas - CONSULTAS DE TARJETAS Y TIPOS



-- 21-30 consultas - CONSULTAS DE CUOTAS DE MANEJO
-- 21a consulta: listar todas las cuotas generadas para el mes de junio de 2024
SELECT *
FROM cuotas_manejo
WHERE MONTH(fecha_generacion) = 6 AND YEAR(fecha_generacion) = 2024;

-- consulta 22: mostrar cuotas que esten pendientes por pagar con mas de 5 dias de vencimiento
SELECT *
FROM cuotas_manejo
WHERE estado = 'Pendiente' AND fecha_vencimiento < CURDATE() - INTERVAL 5 DAY;

-- consulta 23: obtener el numero de cuotas pagadas en un mes especifico
-- en este caso vamos a obtener las cuotas pagadas en 2do trimestre de 2024
SELECT *
FROM historial_pagos
WHERE estado_transaccion = 'Exitoso' AND fecha_pago BETWEEN '2024-03-01' AND '2024-06-30';

-- consulta 24: listar cuotas que tienen algun descuento aplicado superior al 10%
SELECT cuota_id, tarjeta_id, porcentaje_descuento
FROM cuotas_manejo
WHERE porcentaje_descuento > 10;

-- consulta 25: mostrar todas las cuotas generadas para una tarjeta especifica
SELECT *
FROM cuotas_manejo
WHERE tarjeta_id = 1;

-- consulta 26: contar cuantas cuotas hay en cada estado
SELECT estado, COUNT(*) AS estado
FROM cuotas_manejo
GROUP BY estado ORDER BY estado DESC;

-- consulta 27: calcular el monto promedio de cuotas por tipo de tarjeta
SELECT tt.nombre_tipo AS Tipo_Tarjeta,
    ROUND(AVG(cm.monto_final), 2) AS promedio_monto_cuota
FROM cuotas_manejo cm
JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
JOIN tipos_tarjeta tt ON t.tipo_tarjeta_id = tt.tipo_tarjeta_id
GROUP BY tt.nombre_tipo;

-- consulta 28: identificar cuotas cuyo metodo de calculo sea automatico
SELECT cuota_id, periodo_año, fecha_generacion, fecha_vencimiento, metodo_calculo
FROM cuotas_manejo
WHERE metodo_calculo = 'Automatico';

-- consulta 29: encontrar las 5 cuotas con mayor valor de descuento aplicado
SELECT cuota_id, porcentaje_descuento
FROM cuotas_manejo
ORDER BY porcentaje_descuento DESC
LIMIT 5;

--consulta 30: calcular el total de ingresos proyectados por cuotas pendientes
SELECT SUM(monto_total_con_mora) AS ingresos_proyectados
FROM cuotas_manejo
WHERE estado = 'Pendiente';
