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
-- consulta 11: Mostrar todas las tarjetas activas con su número, tipo y fecha de apertura.
SELECT tarjeta_id, numero_tarjeta, cliente_id, tipo_tarjeta_id, descuento_id, monto_apertura, limite_credito, saldo_disponible, fecha_apertura, fecha_vencimiento, fecha_ultimo_uso, pin_encriptado, intentos_fallidos, estado, motivo_bloqueo, observaciones, fecha_creacion, fecha_actualizacion
FROM tarjetas
WHERE estado = 'Activa';

-- consulta 12: Contar cuántas tarjetas hay de cada tipo en el sistema.
SELECT nombre_tipo AS 'Nombre de tarjeta', COUNT(tipo_tarjeta_id) AS 'Número de tarjetas' 
FROM tarjetas AS t
JOIN tipos_tarjeta AS tt USING (tipo_tarjeta_id)
GROUP BY nombre_tipo
ORDER BY nombre_tipo;

-- consulta 13: Identificar tarjetas que vencen en los próximos 60 días.
SELECT c.nombres AS 'Nombre del cliente', t.tarjeta_id AS 'ID de tarjeta', fecha_vencimiento AS 'Fecha de vencimiento'
FROM tarjetas AS t
JOIN clientes AS c USING (cliente_id)
WHERE fecha_vencimiento BETWEEN CURDATE() AND ADDDATE(CURDATE(), INTERVAL 60 DAY);

-- consulta 14: Mostrar todas las tarjetas bloqueadas con su motivo de bloqueo.
SELECT tarjeta_id, motivo_bloqueo
FROM tarjetas
WHERE estado = 'Bloqueada';

-- consulta 15: Calcular el porcentaje de utilización (saldo usado vs límite) para cada tarjeta.
SELECT tarjeta_id, ((saldo_disponible/limite_credito)*100) AS 'Porcentaje de utilización'
FROM tarjetas;

-- consulta 16: Listar tarjetas con límite de crédito superior a $10,000,000.
SELECT tarjeta_id, numero_tarjeta, cliente_id, tipo_tarjeta_id
FROM tarjetas
WHERE limite_credito > 10000000;

-- consulta 17: Mostrar clientes que tienen más de 2 tarjetas activas.
SELECT c.cliente_id, CONCAT(c.nombres, ' ', c.apellidos) AS 'Nombre_completo', SUM(t.tarjeta_id) AS 'Numero de tarjetas'
FROM clientes AS c
JOIN tarjetas AS t USING (cliente_id)
WHERE t.estado = 'Activa'
GROUP BY c.cliente_id, Nombre_completo
HAVING SUM(t.tarjeta_id) > 2;

-- consulta 18: Listar todos los tipos de tarjeta activos con sus características principales.
SELECT
    codigo_tipo AS 'Código',
    nombre_tipo AS 'Nombre del Producto',
    descripcion AS 'Descripción',
    ingresos_minimos AS 'Ingresos Mínimos Requeridos',
    monto_minimo_apertura AS 'Monto Mínimo de Apertura',
    cuota_base_mensual AS 'Cuota Mensual',
    tasa_interes AS 'Tasa de Interés (%)'
FROM tipos_tarjeta
WHERE estado = TRUE
ORDER BY nombre_tipo;

-- consulta 19: Mostrar tarjetas aperturadas en el último mes.
SELECT t.numero_tarjeta AS 'Número de Tarjeta', t.fecha_apertura AS 'Fecha de Apertura', 
    CONCAT(c.nombres, ' ', c.apellidos) AS 'Cliente', tt.nombre_tipo AS 'Tipo de Tarjeta'
FROM tarjetas AS t
JOIN clientes AS c ON t.cliente_id = c.cliente_id
JOIN tipos_tarjeta AS tt ON t.tipo_tarjeta_id = tt.tipo_tarjeta_id
WHERE t.fecha_apertura >= CURDATE() - INTERVAL 1 MONTH
ORDER BY t.fecha_apertura DESC;

-- consulta 20: Obtener el promedio, máximo y mínimo de límites de crédito por tipo de tarjeta.
SELECT
    tt.nombre_tipo AS 'Tipo de Tarjeta', COUNT(t.tarjeta_id) AS 'Cantidad de Tarjetas Activas',
    ROUND(AVG(t.limite_credito), 2) AS 'Límite de Crédito Promedio', MAX(t.limite_credito) AS 'Límite de Crédito Máximo',
    MIN(t.limite_credito) AS 'Límite de Crédito Mínimo'
FROM tarjetas AS t
JOIN tipos_tarjeta AS tt ON t.tipo_tarjeta_id = tt.tipo_tarjeta_id
WHERE t.estado = 'Activa'
GROUP BY tt.nombre_tipo
ORDER BY tt.nombre_tipo;

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
-- consulta 31: Mostrar todos los pagos realizados en los últimos 15 días.
SELECT
    hp.numero_transaccion AS 'Número de Transacción', hp.fecha_pago AS 'Fecha del Pago',
    hp.monto_pagado AS 'Monto', hp.metodo_pago AS 'Método', hp.estado_transaccion AS 'Estado',
    t.numero_tarjeta AS 'Tarjeta Asociada'
FROM historial_pagos AS hp
JOIN cuotas_manejo AS cm ON hp.cuota_id = cm.cuota_id
JOIN tarjetas AS t ON cm.tarjeta_id = t.tarjeta_id
WHERE hp.fecha_pago >= CURDATE() - INTERVAL 15 DAY
ORDER BY hp.fecha_pago DESC;

-- consulta 32: Agrupar pagos por método de pago y mostrar el total recaudado por cada uno.
SELECT metodo_pago AS 'Método de Pago', COUNT(pago_id) AS 'Cantidad de Transacciones', ROUND(SUM(monto_pagado), 2) AS 'Total Recaudado'
FROM historial_pagos
WHERE estado_transaccion = 'Exitoso'
GROUP BY metodo_pago
ORDER BY 'Total_Recaudado' DESC;

-- consulta 33: Identificar transacciones con estado 'Fallido' del último mes.
SELECT numero_transaccion AS 'Número de Transacción', fecha_pago AS 'Fecha del Intento', monto_pagado AS 'Monto',
    metodo_pago AS 'Método', canal_pago AS 'Canal', banco_origen AS 'Banco Origen', observaciones AS 'Observaciones'
FROM historial_pagos
WHERE estado_transaccion = 'Fallido' AND fecha_pago >= CURDATE() - INTERVAL 1 MONTH
ORDER BY fecha_pago DESC;

-- consulta 34: Analizar qué canal de pago es más utilizado por los clientes.
SELECT canal_pago AS 'Canal de Pago', COUNT(pago_id) AS 'Número de Usos', ROUND(SUM(monto_pagado), 2) AS 'Monto Total Procesado'
FROM historial_pagos
WHERE estado_transaccion = 'Exitoso'
GROUP BY canal_pago
ORDER BY 'Numero_de_Usos' DESC;

-- consulta 35: Mostrar todo el historial de pagos de un cliente específico.
SELECT CONCAT(c.nombres, ' ', c.apellidos) AS 'Cliente',
    t.numero_tarjeta AS 'Número de Tarjeta',
    hp.fecha_pago AS 'Fecha de Pago',
    hp.monto_pagado AS 'Monto Pagado',
    hp.metodo_pago AS 'Método',
    hp.canal_pago AS 'Canal',
    hp.estado_transaccion AS 'Estado del Pago'
FROM historial_pagos AS hp
JOIN cuotas_manejo AS cm ON hp.cuota_id = cm.cuota_id
JOIN tarjetas AS t ON cm.tarjeta_id = t.tarjeta_id
JOIN clientes AS c ON t.cliente_id = c.cliente_id
WHERE c.cliente_id = 5
ORDER BY hp.fecha_pago DESC;

-- consulta 36: Listar pagos que generaron comisión
SELECT numero_transaccion AS 'Número de Transacción', fecha_pago AS 'Fecha de Pago',
    monto_pagado AS 'Monto del Pago', comision AS 'Comisión Cobrada'
FROM historial_pagos
WHERE comision > 0 AND estado_transaccion = 'Exitoso'
ORDER BY fecha_pago DESC;

-- consulta 37: Agrupar pagos por banco de origen cuando aplique.
SELECT banco_origen AS 'Banco de Origen', COUNT(pago_id) AS 'Cantidad de Transacciones', ROUND(SUM(monto_pagado), 2) AS 'Monto Total Procesado'
FROM historial_pagos
WHERE banco_origen IS NOT NULL AND banco_origen != '' AND estado_transaccion = 'Exitoso'
GROUP BY banco_origen
ORDER BY 'Monto_Total_Procesado' DESC;

-- consulta 38: Identificar cuotas que fueron pagadas en múltiples transacciones.
SELECT hp.cuota_id AS 'ID de la Cuota', t.numero_tarjeta AS 'Número de Tarjeta', hp.numero_transaccion AS 'Número de Transacción',
    hp.fecha_pago AS 'Fecha de Pago', hp.monto_pagado AS 'Monto del Pago Parcial'
FROM historial_pagos AS hp
JOIN cuotas_manejo AS cm ON hp.cuota_id = cm.cuota_id
JOIN tarjetas AS t ON cm.tarjeta_id = t.tarjeta_id
WHERE hp.cuota_id IN (
        SELECT cuota_id
        FROM historial_pagos
        WHERE estado_transaccion = 'Exitoso'
        GROUP BY cuota_id
        HAVING COUNT(pago_id) > 1
    )
ORDER BY  hp.cuota_id, hp.fecha_pago;

-- consulta 39: Mostrar el total recaudado por día en el último mes.
SELECT DATE(fecha_pago) AS 'Día', COUNT(pago_id) AS 'Número de Pagos', ROUND(SUM(monto_pagado), 2) AS 'Total Recaudado'
FROM historial_pagos
WHERE estado_transaccion = 'Exitoso' AND fecha_pago >= CURDATE() - INTERVAL 1 MONTH
GROUP BY Día
ORDER BY Día ASC;

-- consulta 40: Analizar qué usuarios del sistema registran más transacciones.
SELECT usuario_registro AS 'Usuario del Sistema', COUNT(pago_id) AS 'Transacciones Registradas (Total)',
    SUM(IF(estado_transaccion = 'Exitoso', 1, 0)) AS 'Transacciones Exitosas',
    ROUND(SUM(IF(estado_transaccion = 'Exitoso', monto_pagado, 0)), 2) AS 'Monto Total Procesado Correctamente'
FROM historial_pagos
WHERE usuario_registro IS NOT NULL
GROUP BY usuario_registro
ORDER BY `Transacciones Registradas (Total)` DESC;

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

-- 51-60 Consultas - CONSULTAS DE REPORTES MENSUALES/ANUALES
-- consulta 51: Calcular ingresos totales por cuotas de manejo por mes.
SELECT YEAR(fecha_pago) AS 'Año', LPAD(MONTH(fecha_pago), 2, '0') AS 'Mes', DATE_FORMAT(fecha_pago, '%M') AS 'Nombre del Mes',
    ROUND(SUM(monto_pagado), 2) AS 'Ingresos Totales'
FROM historial_pagos
WHERE estado_transaccion = 'Exitoso'
GROUP BY Año, Mes, `Nombre del Mes`
ORDER BY Año, Mes;

-- consulta 52: Comparar ingresos del año actual vs año anterior por mes.
SELECT reporte.mes_nombre, reporte.ingresos_anio_anterior, reporte.ingresos_anio_actual,
    ROUND(
        IF(
            reporte.ingresos_anio_anterior > 0,
            (reporte.ingresos_anio_actual - reporte.ingresos_anio_anterior) * 100.0 / reporte.ingresos_anio_anterior,
            IF(reporte.ingresos_anio_actual > 0, 100.0, 0) -- Si antes era 0 y ahora hay ingresos, es 100% crecimiento.
        ), 2
    ) AS 'Crecimiento (%)'
FROM (
    SELECT
        MONTH(fecha_pago) AS mes_numero,
        DATE_FORMAT(fecha_pago, '%M') AS mes_nombre,
        -- Suma condicional para el año anterior
        SUM(IF(YEAR(fecha_pago) = YEAR(CURDATE()) - 1, monto_pagado, 0)) AS ingresos_anio_anterior,
        -- Suma condicional para el año actual
        SUM(IF(YEAR(fecha_pago) = YEAR(CURDATE()), monto_pagado, 0)) AS ingresos_anio_actual
    FROM historial_pagos
    WHERE estado_transaccion = 'Exitoso' AND YEAR(fecha_pago) IN (YEAR(CURDATE()), YEAR(CURDATE()) - 1)
    GROUP BY mes_numero, mes_nombre
) AS reporte
ORDER BY reporte.mes_numero;

-- consulta 53: Calcular el porcentaje de crecimiento mes a mes.


-- 61-70 Consultas - CONSULTAS DE MORA Y VENCIMIENTOS
-- consulta 61: mostrar todas las cuotas vencidas con sus dias de mora
SELECT cuota_id, tarjeta_id, periodo_mes, periodo_año, monto_final, fecha_vencimiento,
  DATEDIFF(CURDATE(), fecha_vencimiento) AS dias_mora_calculados
FROM cuotas_manejo
WHERE estado = 'Vencida'
  AND CURDATE() > fecha_vencimiento;

-- consulta 62: agrupar cuotas vencidas por rango de dias
SELECT 
  CASE
    WHEN DATEDIFF(CURDATE(), fecha_vencimiento) BETWEEN 1 AND 10 THEN '1-10 días'           -- en este caso todas son del 2024, por la consulta solo va a dar en que todas son mas de 60 dias
    WHEN DATEDIFF(CURDATE(), fecha_vencimiento) BETWEEN 11 AND 30 THEN '11-30 días'         -- revisar la consulta de abajo, osea que la que esta despues de esta
    WHEN DATEDIFF(CURDATE(), fecha_vencimiento) BETWEEN 31 AND 60 THEN '31-60 días'
    ELSE 'Más de 60 días'
  END AS rango_mora,
  COUNT(*) AS total_cuotas
FROM cuotas_manejo
WHERE estado = 'Vencida'
  AND CURDATE() > fecha_vencimiento
GROUP BY rango_mora
ORDER BY MIN(DATEDIFF(CURDATE(), fecha_vencimiento));
-- consulta para ver el rango de dias de mora
SELECT cuota_id, fecha_vencimiento, DATEDIFF(CURDATE(), fecha_vencimiento) AS dias_mora
FROM cuotas_manejo
WHERE estado = 'Vencida'
ORDER BY fecha_vencimiento;

-- consulta 63: calcular el total de interes generados por mora
SELECT 
  SUM(interes_mora) AS total_intereses_mora
FROM cuotas_manejo
WHERE interes_mora > 0;

-- consulta 64: identificar clientes con cuotas vencidas hace mas de 200 dias
SELECT c.cliente_id, c.nombres, c.apellidos, c.numero_documento, c.email, c.telefono, cm.cuota_id, cm.fecha_vencimiento,
  DATEDIFF(CURDATE(), cm.fecha_vencimiento) AS dias_en_mora
FROM cuotas_manejo cm
JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
JOIN clientes c ON t.cliente_id = c.cliente_id
WHERE cm.estado = 'Vencida' AND DATEDIFF(CURDATE(), cm.fecha_vencimiento) > 90
ORDER BY dias_en_mora DESC;

-- consulta 65: analizar cuotas que salieron de mora
SELECT cm.cuota_id, cm.tarjeta_id, cm.periodo_mes, cm.periodo_año, cm.monto_final, cm.fecha_vencimiento, cm.dias_mora, cm.estado, hp.fecha_pago, c.cliente_id, c.nombres, c.apellidos
FROM cuotas_manejo cm
JOIN historial_pagos hp ON cm.cuota_id = hp.cuota_id
JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
JOIN clientes c ON t.cliente_id = c.cliente_id
WHERE cm.estado = 'Pagada' AND cm.dias_mora > 0 AND hp.estado_transaccion = 'Exitoso';

-- consulta 66: mostrar la evolucion del porcentaje de mora por mes
SELECT cm.periodo_año, cm.periodo_mes,
  COUNT(*) AS total_cuotas,
  SUM(CASE WHEN cm.estado = 'Vencida' THEN 1 ELSE 0 END) AS cuotas_vencidas,
  ROUND((SUM(CASE WHEN cm.estado = 'Vencida' THEN 1 ELSE 0 END) / COUNT(*)) * 100,2) AS porcentaje_mora
FROM cuotas_manejo cm
GROUP BY cm.periodo_año, cm.periodo_mes
ORDER BY cm.periodo_año, cm.periodo_mes;

-- consulta 68: identificar cuotas prioritarias para gestion de cobro en el 2024
SELECT cm.cuota_id, cm.tarjeta_id, cm.periodo_mes, cm.periodo_año, cm.monto_total_con_mora, cm.fecha_vencimiento,
  DATEDIFF(CURDATE(), cm.fecha_vencimiento) AS dias_en_mora, c.cliente_id, c.nombres, c.apellidos, c.telefono, c.email
FROM cuotas_manejo cm
JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
JOIN clientes c ON t.cliente_id = c.cliente_id
WHERE cm.estado = 'Vencida' AND cm.periodo_año = 2024 AND DATEDIFF(CURDATE(), cm.fecha_vencimiento) > 60
ORDER BY dias_en_mora DESC, cm.monto_total_con_mora DESC;

-- consulta 69: mostrar el historial de mora por cliente
SELECT c.cliente_id, c.nombres, c.apellidos, COUNT(cm.cuota_id) AS total_cuotas_con_mora,
  SUM(CASE WHEN cm.estado = 'Vencida' THEN 1 ELSE 0 END) AS cuotas_vencidas,
  SUM(CASE WHEN cm.estado = 'Pagada' AND cm.dias_mora > 0 THEN 1 ELSE 0 END) AS cuotas_pagadas_con_mora,
  SUM(cm.dias_mora) AS total_dias_en_mora,
  SUM(cm.interes_mora) AS total_intereses_mora
FROM cuotas_manejo cm
JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
JOIN clientes c ON t.cliente_id = c.cliente_id
WHERE cm.dias_mora > 0
GROUP BY c.cliente_id, c.nombres, c.apellidos
ORDER BY total_cuotas_con_mora DESC;

-- consulta 70: identificar cuotas que podrian entrar en mora en el 2024
SELECT cm.cuota_id, cm.tarjeta_id, cm.periodo_mes, cm.periodo_año, cm.monto_final, cm.fecha_vencimiento,
  DATEDIFF(CURDATE(), cm.fecha_vencimiento) AS dias_sin_pago, c.cliente_id, c.nombres, c.apellidos, c.email
FROM cuotas_manejo cm
JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
JOIN clientes c ON t.cliente_id = c.cliente_id
WHERE cm.estado = 'Pendiente' AND cm.periodo_año = 2024 AND cm.fecha_vencimiento <= CURDATE()
ORDER BY cm.fecha_vencimiento ASC;


-- 71-80 Consultas: CONSULTAS AVANZADAS CON JOINS



-- 81-90: consultas avanzadas en general
