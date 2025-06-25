USE BancoCL

-- PRIMERAS 10 CONSULTAS - CONSULTAS BASICAS DE CLIENTES

-- 1era consulta: obtener los datos de los clientes y a su vez ordenandolo alfabeticamente por su apellido (A-Z)
SELECT cliente_id, numero_documento, nombres, apellidos, email, telefono, fecha_registro
FROM clientes
ORDER BY apellidos ASC;

-- 2da consulta: mostrar unicamente los clientes activos con su informacion de contacto (email y telefono)
SELECT cliente_id, email, telefono
FROM clientes
WHERE estado = 'Activo';

-- 3ra consulta: encontrar un cliente especifico usando su numero de documento
SELECT cliente_id, numero_documento, nombres, apellidos, email, telefono, fecha_registro
FROM clientes
WHERE numero_documento = '1023456789';

-- 4ta consulta: listar clientes que tengan entre 25 a 45 años de edad
SELECT cliente_id, numero_documento, nombres, apellidos, email, telefono, fecha_registro, fecha_nacimiento
FROM clientes
WHERE fecha_nacimiento BETWEEN '1976-01-01' AND '1999-01-01'

-- 5ta consula: mostrar clientes con ingresos mayores a 5 millones
SELECT cliente_id, numero_documento, nombres, apellidos, email, telefono, fecha_registro, ingresos_mensuales
FROM clientes
WHERE ingresos_mensuales >= '5000000'

-- 6ta consulta: mostrar los clientes que se registraron en los ultimos 6 meses
SELECT cliente_id, numero_documento, nombres, apellidos, email, telefono, fecha_registro
FROM clientes
WHERE fecha_registro >= '2025-01-01';

-- 7ta consulta: mostrar los clientes que tienen una inactividad de 3 meses
SELECT cliente_id, numero_documento, nombres, apellidos, email, telefono, fecha_registro, ultimo_acceso
FROM clientes
WHERE ultimo_acceso <= DATE_SUB(CURDATE(), INTERVAL 3 MONTH);

-- 8va consulta: listar todas las ocupaciones distintas y contrar cuantos clientes hay por cada una
SELECT  ocupacion,  COUNT(*) AS cantidad_clientes  
FROM clientes  
GROUP BY ocupacion  
ORDER BY cantidad_clientes DESC;

-- 9na consulta: mostrar clientes q tengan alguna observacion registrada
SELECT cliente_id, nombres, apellidos, observaciones
FROM clientes
WHERE observaciones IS NOT NULL

-- 10ma consulta: listar los 5 clientes con mayores ingresos mensuales
SELECT cliente_id, numero_documento, nombres, apellidos, email, telefono, ingresos_mensuales
FROM clientes
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

-- 31-40 Consultas - CONSULTAS DE HISTORIAL DE PAGOS



-- 41-50 Consultas - CONSULTAS DE TARJETAS CONSULTAS DE DESCUENTOS Y BENEFICIOS
-- consulta 41: listar todos los niveles de descuento vigentes con sus caracteristicas
SELECT *
FROM niveles_descuento
WHERE estado = '1';

-- consulta 42: consultar el total de dinero descontado al usuario por cada nivel de tarjeta
SELECT nd.nombre_descuento AS nivel_descuento, COUNT(cm.cuota_id) AS total_cuotas, SUM(cm.valor_descuento) AS total_valor_descontado
FROM cuotas_manejo cm
JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
JOIN niveles_descuento nd ON t.descuento_id = nd.descuento_id
GROUP BY nd.nombre_descuento ORDER BY total_valor_descontado DESC;

-- consulta 43: contar cuanto clientes unicos han recibido un descuento
SELECT COUNT(DISTINCT t.cliente_id) AS clientes_con_descuento
FROM tarjetas t
WHERE t.descuento_id IS NOT NULL;

-- consutla 44: analizar que rango de descuento es mas utilizados
SELECT nd.nombre_descuento, nd.porcentaje_descuento, COUNT(*) AS total_uso
FROM tarjetas t
JOIN niveles_descuento nd ON t.descuento_id = nd.descuento_id
GROUP BY nd.nombre_descuento, nd.porcentaje_descuento
ORDER BY total_uso DESC;

-- consulta 45: comparar pagos de cuotas con descuento y sin descuento
SELECT cm.porcentaje_descuento, COUNT(*) AS total_pagos, SUM(hp.monto_pagado) AS monto_total_pagado
FROM historial_pagos hp
JOIN cuotas_manejo cm ON hp.cuota_id = cm.cuota_id
WHERE hp.estado_transaccion = 'Exitoso'
GROUP BY cm.porcentaje_descuento
ORDER BY cm.porcentaje_descuento;

-- consulta 46: identificar descuentos que estan por expirar en 30 dias                 -- aqui todos los niveles de descuento tecnicamente no tienen fecha de vencimiento,
select nd.nombre_descuento, nd.porcentaje_descuento, nd.fecha_inicio, nd.fecha_fin      -- pero igual hicimos la consulta
from niveles_descuento nd
where nd.fecha_fin <= DATE_ADD(CURDATE(), INTERVAL 30 DAY);

-- consulta 47: encontrar el cliente que que mas ahorrado con los descuentos
SELECT c.cliente_id, c.nombres, c.apellidos, SUM(cm.valor_descuento) AS total_ahorrado
FROM cuotas_manejo cm
JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
JOIN clientes c ON t.cliente_id = c.cliente_id
GROUP BY c.cliente_id
ORDER BY total_ahorrado DESC
LIMIT 1;

-- consulta 48: calcular el impacto de descuentos en los ingresos totales
SELECT
  SUM(cm.monto_base) AS ingresos_brutos,
  SUM(cm.monto_final) AS ingresos_netos,
  SUM(cm.valor_descuento) AS total_descuento,
  ROUND((SUM(cm.valor_descuento) / SUM(cm.monto_base)) * 100, 2) AS porcentaje_impacto_descuento
FROM cuotas_manejo cm;

-- consulta 49: identificar descuentos activos que no han sido aplicados
SELECT nd.descuento_id, nd.nombre_descuento, nd.porcentaje_descuento, nd.estado       -- como tal todos los descuentos estan siendo aplicado en este momento
FROM niveles_descuento nd                                                             -- entonces hacemos la consulta pero es normal que no se refleje nada
LEFT JOIN tarjetas t ON nd.descuento_id = t.descuento_id
WHERE t.descuento_id IS NULL AND nd.estado = TRUE;

-- consulta 50: mostrar la tendencia de uso de descuentos por trimestre
SELECT YEAR(cm.fecha_generacion) AS año, QUARTER(cm.fecha_generacion) AS trimestre, nd.nombre_descuento, COUNT(*) AS total_aplicaciones
FROM cuotas_manejo cm
JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
JOIN niveles_descuento nd ON t.descuento_id = nd.descuento_id
GROUP BY año, trimestre, nd.nombre_descuento
ORDER BY año, trimestre, total_aplicaciones DESC;
