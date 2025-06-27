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
SELECT reporte.mes_nombre, reporte.ingresos_año_anterior, reporte.ingresos_anio_actual,
    ROUND(
        IF(
            reporte.ingresos_año_anterior > 0,
            (reporte.ingresos_anio_actual - reporte.ingresos_año_anterior) * 100.0 / reporte.ingresos_año_anterior,
            IF(reporte.ingresos_anio_actual > 0, 100.0, 0) -- Si antes era 0 y ahora hay ingresos, es 100% crecimiento.
        ), 2
    ) AS 'Crecimiento (%)'
FROM (
    SELECT
        MONTH(fecha_pago) AS mes_numero,
        DATE_FORMAT(fecha_pago, '%M') AS mes_nombre,
        SUM(IF(YEAR(fecha_pago) = YEAR(CURDATE()) - 1, monto_pagado, 0)) AS ingresos_año_anterior,
        SUM(IF(YEAR(fecha_pago) = YEAR(CURDATE()), monto_pagado, 0)) AS ingresos_anio_actual
    FROM historial_pagos
    WHERE estado_transaccion = 'Exitoso' AND YEAR(fecha_pago) IN (YEAR(CURDATE()), YEAR(CURDATE()) - 1)
    GROUP BY mes_numero, mes_nombre
) AS reporte
ORDER BY reporte.mes_numero;

-- consulta 53: Calcular el porcentaje de crecimiento mes a mes.
-- Consulta difícil, comentarios para mayor facilidad
-- Usamos una CTE para modularizar y hacer más legible la consulta.
WITH IngresosMensuales AS (
    -- Reporte de ingresos por mes
    SELECT
        YEAR(fecha_pago) AS año,
        MONTH(fecha_pago) AS mes,
        SUM(monto_pagado) AS ingresos_actuales
    FROM
        historial_pagos
    WHERE
        estado_transaccion = 'Exitoso'
    GROUP BY
        año, mes
)
-- Cálculo de rendimiento sobre tabla virtual
SELECT
    año,
    mes,
    ROUND(ingresos_actuales, 2) AS 'Ingresos del Mes',
    -- LAG() para obtener el ingreso del mes previo
    ROUND(LAG(ingresos_actuales, 1, 0) OVER (ORDER BY año, mes), 2) AS 'Ingresos Mes Anterior',
    -- Calculamos el % de crecimiento, manejando el caso de que el mes anterior sea 0.
    ROUND(
        IF(LAG(ingresos_actuales, 1, 0) OVER (ORDER BY año, mes) > 0,
            (ingresos_actuales - LAG(ingresos_actuales, 1, 0) OVER (ORDER BY año, mes)) * 100.0
            / LAG(ingresos_actuales, 1, 0) OVER (ORDER BY año, mes),
            IF(ingresos_actuales > 0, 100.0, 0)), 2
    ) AS 'Crecimiento Mes a Mes (%)'
FROM IngresosMensuales
ORDER BY año, mes;

-- consulta 54: Identificar los meses con mayor y menor recaudación.
SELECT DATE_FORMAT(fecha_pago, '%M') AS nombre_del_mes, ROUND(SUM(monto_pagado), 2) AS recaudacion_historica_total
FROM historial_pagos
WHERE estado_transaccion = 'Exitoso'
GROUP BY MONTH(fecha_pago), nombre_del_mes
ORDER BY recaudacion_historica_total DESC;

-- consulta 55: Contar clientes nuevos registrados por mes.
SELECT YEAR(fecha_registro) AS 'Año',
    MONTH(fecha_registro) AS 'Mes',
    DATE_FORMAT(fecha_registro, '%M') AS 'Nombre del Mes',
    COUNT(cliente_id) AS 'Cantidad de Clientes Nuevos'
FROM clientes
GROUP BY Año, Mes, `Nombre del Mes`
ORDER BY  Año, Mes;

-- consulta 56: Analizar cuántas tarjetas se emiten mensualmente.
SELECT
  YEAR(t.fecha_apertura) AS 'Año',
  MONTH(t.fecha_apertura) AS 'Mes',
  SUM(IF(tt.nombre_tipo = 'Clásica', 1, 0)) AS 'Emitidas Clásica',
  SUM(IF(tt.nombre_tipo = 'Oro', 1, 0)) AS 'Emitidas Oro',
  SUM(IF(tt.nombre_tipo = 'Platino', 1, 0)) AS 'Emitidas Platino',
  SUM(IF(tt.nombre_tipo = 'Black', 1, 0)) AS 'Emitidas Black',
  COUNT(t.tarjeta_id) AS 'Total Emitidas'
FROM tarjetas AS t
JOIN tipos_tarjeta AS tt ON t.tipo_tarjeta_id = tt.tipo_tarjeta_id
GROUP BY Año, Mes
ORDER BY Año, Mes;

-- consulta 57: Calcular el porcentaje de cuotas pagadas vs generadas por mes.
SELECT
  periodo_año AS 'Año de Generación',
  periodo_mes AS 'Mes de Generación',
  COUNT(cuota_id) AS 'Total Cuotas Generadas',
  SUM(IF(estado = 'Pagada', 1, 0)) AS 'Cuotas Pagadas',
  ROUND(
      (SUM(IF(estado = 'Pagada', 1, 0)) / COUNT(cuota_id)) * 100,
      2
  ) AS 'Efectividad de Cobro (%)'
FROM cuotas_manejo
GROUP BY `Año de Generación`, `Mes de Generación`
ORDER BY  `Año de Generación`, `Mes de Generación`;

-- consulta 58: Mostrar la evolución de la cartera vencida mes a mes.
SELECT periodo_año AS 'Año', periodo_mes AS 'Mes',
  ROUND(SUM(monto_final), 2) AS 'Monto Total Generado',
  ROUND(SUM(IF(estado = 'Vencida', monto_final, 0)), 2) AS 'Monto en Mora',
  ROUND(SUM(IF(estado = 'Pagada', monto_final, 0)), 2) AS 'Monto Pagado',
  ROUND(SUM(IF(estado = 'Pendiente', monto_final, 0)), 2) AS 'Monto Pendiente'
FROM cuotas_manejo
GROUP BY Año, Mes
ORDER BY Año, Mes;

-- consulta 59: Crear un dashboard con las métricas principales mensuales.
-- Consulta difícil, comentarios para facilidad
WITH
-- CTE 1: Ingresos mensuales (basado en fecha de pago)
Ingresos AS (
    SELECT YEAR(fecha_pago) AS año, MONTH(fecha_pago) AS mes, SUM(monto_pagado) AS total_ingresos
    FROM historial_pagos WHERE estado_transaccion = 'Exitoso' GROUP BY año, mes
),
-- CTE 2: Nuevos clientes por mes (basado en fecha de registro)
NuevosClientes AS (
    SELECT YEAR(fecha_registro) AS año, MONTH(fecha_registro) AS mes, COUNT(cliente_id) AS total_nuevos_clientes
    FROM clientes GROUP BY año, mes
),
-- CTE 3: Tarjetas emitidas por mes (basado en fecha de apertura)
TarjetasNuevas AS (
    SELECT YEAR(fecha_apertura) AS año, MONTH(fecha_apertura) AS mes, COUNT(tarjeta_id) AS total_tarjetas_nuevas
    FROM tarjetas GROUP BY año, mes
),
-- CTE Maestra: Lista de todos los períodos únicos para no perder datos
Periodos AS (
    SELECT año, mes FROM Ingresos
    UNION
    SELECT año, mes FROM NuevosClientes
    UNION
    SELECT año, mes FROM TarjetasNuevas
)
-- Consulta final que une todo
SELECT
    p.año,
    p.mes,
    IFNULL(ROUND(i.total_ingresos, 2), 0) AS 'Ingresos Totales',
    IFNULL(nc.total_nuevos_clientes, 0) AS 'Nuevos Clientes',
    IFNULL(tn.total_tarjetas_nuevas, 0) AS 'Tarjetas Emitidas'
FROM Periodos p
LEFT JOIN Ingresos       i  ON p.año = i.año AND p.mes = i.mes
LEFT JOIN NuevosClientes nc ON p.año = nc.año AND p.mes = nc.mes
LEFT JOIN TarjetasNuevas tn ON p.año = tn.año AND p.mes = tn.mes
ORDER BY p.año, p.mes;

-- consulta 60: Calcular proyecciones de ingresos basadas en tendencias históricas.
WITH IngresosMensuales AS (
    SELECT YEAR(fecha_pago) AS año, MONTH(fecha_pago) AS mes, SUM(monto_pagado) AS ingresos_totales
    FROM historial_pagos
    WHERE estado_transaccion = 'Exitoso'
    GROUP BY año, mes
)
SELECT año, mes, ROUND(ingresos_totales, 2) AS 'Ingresos Reales del Mes',
    ROUND(AVG(ingresos_totales) OVER (ORDER BY año, mes ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS 'Promedio Móvil de 3 Meses'
FROM IngresosMensuales
ORDER BY año, mes;

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
-- consulta 71: Crear una consulta que muestre cliente, sus tarjetas, cuotas y pagos.
SELECT c.cliente_id, c.nombres, c.apellidos, c.email,
  -- Datos de la tarjeta
  t.numero_tarjeta, t.estado AS estado_tarjeta, t.limite_credito,
  -- Datos de la cuota
  cm.periodo_año AS año_cuota, cm.periodo_mes AS mes_cuota, cm.monto_final AS monto_cuota, cm.estado AS estado_cuota,
  -- Datos del pago
  hp.fecha_pago, hp.monto_pagado, hp.metodo_pago
FROM clientes AS c
LEFT JOIN tarjetas AS t ON c.cliente_id = t.cliente_id
LEFT JOIN cuotas_manejo AS cm ON t.tarjeta_id = cm.tarjeta_id
LEFT JOIN historial_pagos AS hp ON cm.cuota_id = hp.cuota_id
-- ¡Recuerda cambiar este ID por el del cliente que quieres consultar!
WHERE c.cliente_id = 10
ORDER BY t.numero_tarjeta,
  año_cuota DESC,
  mes_cuota DESC,
  hp.fecha_pago DESC;

-- consulta 72: Calcular ingresos netos por cliente considerando descuentos.
WITH
-- 1. Calculamos los ingresos brutos por cliente (dinero real pagado).
IngresosPorCliente AS (
  SELECT c.cliente_id, SUM(hp.monto_pagado) AS ingresos_brutos
  FROM clientes c
  JOIN tarjetas t ON c.cliente_id = t.cliente_id
  JOIN cuotas_manejo cm ON t.tarjeta_id = cm.tarjeta_id
  JOIN historial_pagos hp ON cm.cuota_id = hp.cuota_id
  WHERE hp.estado_transaccion = 'Exitoso'
  GROUP BY c.cliente_id
),
-- 2. Calculamos el total de descuentos otorgados a cada cliente.
DescuentosPorCliente AS (
  SELECT c.cliente_id, SUM(cm.valor_descuento) AS total_descuentos
  FROM clientes c
  JOIN tarjetas t ON c.cliente_id = t.cliente_id
  JOIN cuotas_manejo cm ON t.tarjeta_id = cm.tarjeta_id
  GROUP BY c.cliente_id
)
-- 3. Unimos todo para el reporte final.
SELECT c.cliente_id, c.nombres, c.apellidos,
  IFNULL(ip.ingresos_brutos, 0) AS ingresos_totales,
  IFNULL(dp.total_descuentos, 0) AS descuentos_totales,
  (IFNULL(ip.ingresos_brutos, 0) - IFNULL(dp.total_descuentos, 0)) AS rentabilidad_neta
FROM clientes c
LEFT JOIN IngresosPorCliente   ip ON c.cliente_id = ip.cliente_id
LEFT JOIN DescuentosPorCliente dp ON c.cliente_id = dp.cliente_id
ORDER BY rentabilidad_neta DESC;

-- consulta 73: Clasificar clientes por comportamiento de pago y uso de productos.
WITH MetricasClientes AS (
    SELECT c.cliente_id, c.fecha_registro, c.ultimo_acceso,
      COUNT(DISTINCT t.tarjeta_id) AS num_tarjetas,
      IFNULL(MAX(cm.dias_mora), 0) AS max_dias_mora,
      SUM(IF(cm.estado = 'Vencida', 1, 0)) AS total_cuotas_vencidas
    FROM clientes c
    LEFT JOIN tarjetas t ON c.cliente_id = t.cliente_id
    LEFT JOIN cuotas_manejo cm ON t.tarjeta_id = cm.tarjeta_id
    GROUP BY c.cliente_id, c.fecha_registro, c.ultimo_acceso
)
SELECT c.cliente_id, c.nombres, c.apellidos,
  -- El CASE evalúa las condiciones en orden y se detiene en la primera que es verdadera.
  CASE
      WHEN mc.total_cuotas_vencidas > 2 OR mc.max_dias_mora > 90 THEN 'Moroso Crónico'
      WHEN mc.ultimo_acceso < CURDATE() - INTERVAL 6 MONTH THEN 'En Riesgo (Inactivo)'
      WHEN c.fecha_registro >= CURDATE() - INTERVAL 3 MONTH THEN 'Cliente Nuevo'
      WHEN mc.num_tarjetas > 2 AND mc.total_cuotas_vencidas = 0 THEN 'Cliente VIP Fiel'
      WHEN mc.total_cuotas_vencidas = 0 AND mc.num_tarjetas > 0 THEN 'Pagador Puntual'
      ELSE 'Cliente Estándar'
  END AS segmento_cliente
FROM
    clientes c
JOIN
    MetricasClientes mc ON c.cliente_id = mc.cliente_id
ORDER BY
    segmento_cliente;

-- consulta 74: Identificar clientes aptos para productos adicionales.
SELECT DISTINCT c.cliente_id, c.nombres, c.apellidos, c.ingresos_mensuales, 'Ofrecer Tarjeta Oro' AS oportunidad_cross_selling
FROM clientes AS c
-- Nos aseguramos que tenga al menos una tarjeta activa
JOIN tarjetas AS t ON c.cliente_id = t.cliente_id AND t.estado = 'Activa'
WHERE
  c.ingresos_mensuales >= 2500000.00
  AND c.estado = 'Activo'
  AND NOT EXISTS (
      SELECT 1
      FROM tarjetas t2
      WHERE t2.cliente_id = c.cliente_id AND t2.tipo_tarjeta_id >= 2
  )
  -- Regla 4: Verificamos que NO EXISTA una cuota vencida para este cliente.
  AND NOT EXISTS (
      SELECT 1
      FROM cuotas_manejo cm3
      JOIN tarjetas t3 ON cm3.tarjeta_id = t3.tarjeta_id
      WHERE t3.cliente_id = c.cliente_id AND cm3.estado = 'Vencida'
  );

-- consulta 75: Mostrar la evolución completa de un cliente desde su registro.
-- Evento 1: Registro del Cliente
(SELECT
    fecha_registro AS fecha_evento,
    '1. Registro de Cliente' AS tipo_evento,
    CONCAT('El cliente ', nombres, ' ', apellidos, ' se unió a la entidad.') AS descripcion
FROM clientes WHERE cliente_id = 10)

UNION ALL

-- Evento 2: Apertura de Tarjetas
(SELECT
    t.fecha_apertura,
    '2. Apertura de Tarjeta',
    CONCAT('Abrió la tarjeta ', tt.nombre_tipo, ' No. ', t.numero_tarjeta)
FROM tarjetas t
JOIN tipos_tarjeta tt ON t.tipo_tarjeta_id = tt.tipo_tarjeta_id
WHERE t.cliente_id = 10)

UNION ALL

-- Evento 3: Generación de Cuotas de Manejo
(SELECT
    cm.fecha_generacion,
    '3. Generación de Cuota',
    CONCAT('Se generó cuota de ', cm.monto_final, ' para tarjeta ', t.numero_tarjeta)
FROM cuotas_manejo cm
JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
WHERE t.cliente_id = 10)

UNION ALL

-- Evento 4: Pagos Realizados Exitosamente
(SELECT
    hp.fecha_pago,
    '4. Pago Realizado',
    CONCAT('Realizó un pago exitoso de ', hp.monto_pagado, ' con ', hp.metodo_pago)
FROM historial_pagos hp
JOIN cuotas_manejo cm ON hp.cuota_id = cm.cuota_id
JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
WHERE t.cliente_id = 10 AND hp.estado_transaccion = 'Exitoso')

UNION ALL

-- Evento 5: Último Acceso al Sistema (si existe)
(SELECT
    ultimo_acceso,
    '5. Acceso al Sistema',
    'El cliente inició sesión en una plataforma digital.'
FROM clientes
WHERE cliente_id = 10 AND ultimo_acceso IS NOT NULL)

-- Ordenamos toda la bitácora unificada por fecha y luego por el tipo de evento.
ORDER BY fecha_evento ASC, tipo_evento ASC;

-- consulta 76: Analizar el rendimiento de cada tipo de tarjeta.
WITH
-- CTE para métricas a nivel de tarjeta (cuántas hay y cuánto cupo suman)
MetricasPorTarjeta AS (
  SELECT t.tipo_tarjeta_id,
    COUNT(t.tarjeta_id) AS cantidad_tarjetas_activas,
    SUM(t.limite_credito) AS suma_limites_credito
  FROM tarjetas t
  WHERE t.estado = 'Activa'
  GROUP BY t.tipo_tarjeta_id
),
-- CTE para métricas a nivel de cuota (ingresos y mora)
MetricasPorCuota AS (
  SELECT t.tipo_tarjeta_id,
    SUM(IF(cm.estado = 'Pagada', cm.monto_final, 0)) AS ingresos_por_cuotas,
    AVG(IF(cm.estado = 'Vencida', cm.dias_mora, NULL)) AS promedio_dias_mora,
    SUM(IF(cm.estado = 'Vencida', 1, 0)) AS total_cuotas_vencidas
  FROM tarjetas t
  JOIN cuotas_manejo cm ON t.tarjeta_id = cm.tarjeta_id
  GROUP BY t.tipo_tarjeta_id
)
-- Unimos todo para el reporte final
SELECT
  tt.nombre_tipo AS 'Tipo de Tarjeta',
  IFNULL(mt.cantidad_tarjetas_activas, 0) AS 'Num. Tarjetas Activas',
  IFNULL(mt.suma_limites_credito, 0) AS 'Cupo Total Asignado',
  IFNULL(mc.ingresos_por_cuotas, 0) AS 'Ingresos por Cuotas',
  IFNULL(mc.total_cuotas_vencidas, 0) AS 'Cuotas en Mora',
  IFNULL(ROUND(mc.promedio_dias_mora, 1), 0) AS 'Promedio Días Mora (Vencidas)'
FROM tipos_tarjeta tt
LEFT JOIN MetricasPorTarjeta mt ON tt.tipo_tarjeta_id = mt.tipo_tarjeta_id
LEFT JOIN MetricasPorCuota mc ON tt.tipo_tarjeta_id = mc.tipo_tarjeta_id
WHERE tt.estado = TRUE
ORDER BY `Num. Tarjetas Activas` DESC;

-- consulta 77: Identificar clientes de mayor valor y antigüedad.
WITH
ValorCliente AS (
  SELECT c.cliente_id, (SUM(IFNULL(hp.monto_pagado, 0)) - SUM(IFNULL(cm.valor_descuento,0))) AS rentabilidad_neta
  FROM clientes c
  LEFT JOIN tarjetas t ON c.cliente_id = t.cliente_id
  LEFT JOIN cuotas_manejo cm ON t.tarjeta_id = cm.tarjeta_id
  LEFT JOIN historial_pagos hp ON cm.cuota_id = hp.cuota_id AND hp.estado_transaccion = 'Exitoso'
  GROUP BY c.cliente_id
)
-- Consulta final que combina valor y antigüedad
SELECT c.cliente_id, c.nombres, c.apellidos, c.fecha_registro,
  -- DATEDIFF calcula la diferencia en días entre dos fechas.
  DATEDIFF(CURDATE(), c.fecha_registro) AS dias_como_cliente,
  -- FLOOR() redondea hacia abajo para obtener los años completos.
  FLOOR(DATEDIFF(CURDATE(), c.fecha_registro) / 365) AS años_como_cliente,
  IFNULL(vc.rentabilidad_neta, 0) AS valor_neto_cliente
FROM clientes c
LEFT JOIN  ValorCliente vc ON c.cliente_id = vc.cliente_id
WHERE c.estado = 'Activo'
-- Ordenamos por el valor y luego por la antigüedad.
ORDER BY dias_como_cliente DESC
LIMIT 50;

-- consulta 78: Evaluar el riesgo de cada cliente basado en su historial.
WITH
MetricasRiesgo AS (
  SELECT c.cliente_id,
    SUM(IF(hp.estado_transaccion = 'Fallido', 1, 0)) AS num_pagos_fallidos,
    SUM(IF(cm.estado = 'Vencida', 1, 0)) AS num_cuotas_vencidas,
    IFNULL(MAX(cm.dias_mora), 0) AS max_dias_mora,
    SUM(t.intentos_fallidos) AS total_intentos_pin_fallidos
  FROM clientes c
  LEFT JOIN tarjetas t ON c.cliente_id = t.cliente_id
  LEFT JOIN cuotas_manejo cm ON t.tarjeta_id = cm.tarjeta_id
  LEFT JOIN historial_pagos hp ON cm.cuota_id = hp.cuota_id
  GROUP BY c.cliente_id
)
SELECT c.cliente_id, c.nombres, c.apellidos, mr.num_cuotas_vencidas, mr.max_dias_mora,
    -- El CASE asigna una categoría basada en el impacto de las métricas de riesgo.
    CASE
        WHEN mr.max_dias_mora > 90 OR mr.num_cuotas_vencidas > 3 THEN 'Muy Alto'
        WHEN mr.max_dias_mora > 30 OR mr.num_cuotas_vencidas > 1 THEN 'Alto'
        WHEN mr.num_pagos_fallidos > 5 OR mr.max_dias_mora > 0 THEN 'Medio'
        ELSE 'Bajo'
    END AS nivel_de_riesgo
FROM clientes c
JOIN MetricasRiesgo mr ON c.cliente_id = mr.cliente_id
-- La función FIELD nos permite ordenar por un orden personalizado.
ORDER BY FIELD(nivel_de_riesgo, 'Muy Alto', 'Alto', 'Medio', 'Bajo'), mr.max_dias_mora DESC;

-- consulta 79: Medir tiempos promedio de procesamiento de operaciones.
SELECT canal_pago, COUNT(pago_id) AS numero_de_pagos,
  -- Calculamos el tiempo promedio en segundos y minutos para una mejor interpretación.
  ROUND(AVG(TIMESTAMPDIFF(SECOND, fecha_pago, fecha_procesamiento)), 2) AS 'tiempo_promedio_procesamiento_seg',
  ROUND(AVG(TIMESTAMPDIFF(MINUTE, fecha_pago, fecha_procesamiento)), 2) AS 'tiempo_promedio_procesamiento_min'
FROM historial_pagos
WHERE estado_transaccion = 'Exitoso'
    -- ambas fechas existan para poder calcular la diferencia.
    AND fecha_procesamiento IS NOT NULL AND fecha_pago IS NOT NULL
GROUP BY canal_pago
ORDER BY tiempo_promedio_procesamiento_seg DESC;

-- consulta 80: Correlacionar datos de uso con indicadores de satisfacción.
WITH
MetricasSatisfaccion AS (
  SELECT c.cliente_id,
    DATEDIFF(CURDATE(), c.fecha_registro) AS dias_antiguedad,
    SUM(IF(t.estado = 'Activa', 1, 0)) AS num_tarjetas_activas,
    SUM(IF(t.estado = 'Cancelada', 1, 0)) AS num_tarjetas_canceladas,
    COUNT(hp.pago_id) AS total_transacciones_exitosas,
    IFNULL(AVG(cm.dias_mora), 0) AS promedio_dias_mora
  FROM clientes c
  LEFT JOIN tarjetas t ON c.cliente_id = t.cliente_id
  LEFT JOIN cuotas_manejo cm ON t.tarjeta_id = cm.tarjeta_id
  LEFT JOIN historial_pagos hp ON cm.cuota_id = hp.cuota_id AND hp.estado_transaccion = 'Exitoso'
  GROUP BY c.cliente_id, c.fecha_registro
)
SELECT c.cliente_id, c.nombres, c.apellidos,
    -- Creamos un puntaje ponderado. Los valores son ejemplos.
    (
        (ms.dias_antiguedad / 365 * 5)  -- +5 puntos por cada año como cliente
        + (ms.num_tarjetas_activas * 10) -- +10 puntos por cada tarjeta activa
        - (ms.num_tarjetas_canceladas * 20) -- -20 puntos por cada tarjeta cancelada
        - (ms.promedio_dias_mora * 2)  -- -2 puntos por cada día de mora promedio
        + (ms.total_transacciones_exitosas * 1) -- +1 punto por cada pago exitoso
    ) AS puntaje_lealtad_inferido
FROM clientes c
JOIN MetricasSatisfaccion ms ON c.cliente_id = ms.cliente_id
ORDER BY puntaje_lealtad_inferido DESC;



-- 81-90: consultas avanzadas en general
-- consulta 81: listar los clientes que han pagado todas sus cuotas sin mora
SELECT c.cliente_id, c.nombres, c.apellidos, c.numero_documento, c.email, COUNT(cm.cuota_id) AS total_cuotas_pagadas
FROM cuotas_manejo cm
    JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
    JOIN clientes c ON t.cliente_id = c.cliente_id
WHERE cm.estado = 'Pagada'
GROUP BY c.cliente_id, c.nombres, c.apellidos, c.numero_documento, c.email
HAVING MAX(cm.dias_mora) = 0
ORDER BY total_cuotas_pagadas DESC;

-- consulta 82: mostrar por cliente cuanto ha pagado en total de cuotas
SELECT c.cliente_id, c.nombres, c.apellidos, SUM(cm.monto_final) AS total_pagado
FROM cuotas_manejo cm
    JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
    JOIN clientes c ON t.cliente_id = c.cliente_id
WHERE cm.estado = 'Pagada'
GROUP BY c.cliente_id, c.nombres, c.apellidos
ORDER BY total_pagado DESC;

-- consulta 83: mostrar cuotas que tengan un descuento superior al promedio de todos los descuentos
SELECT cm.cuota_id, cm.tarjeta_id, cm.periodo_mes, cm.periodo_año, cm.monto_final, cm.fecha_vencimiento, cm.dias_mora, cm.interes_mora, cm.estado
FROM cuotas_manejo cm
WHERE cm.porcentaje_descuento > (SELECT AVG(porcentaje_descuento) FROM cuotas_manejo)

-- consulta 84: ver clientes cuya ultima cuota pagada tenia dias de mora > 0
SELECT c.cliente_id, c.nombres, c.apellidos, cm.cuota_id, cm.dias_mora, MAX(hp.fecha_pago) AS ultima_fecha_pago
FROM historial_pagos hp
JOIN cuotas_manejo cm ON hp.cuota_id = cm.cuota_id
JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
JOIN clientes c ON t.cliente_id = c.cliente_id
WHERE hp.estado_transaccion = 'Exitoso' AND cm.dias_mora > 0
GROUP BY c.cliente_id, c.nombres, c.apellidos, cm.cuota_id, cm.dias_mora
ORDER BY ultima_fecha_pago DESC;

-- consulta 85: mostrar la suma total pagada en mora agrupada por ciudad de los clientes
SELECT c.ciudad, SUM(hp.monto_pagado) AS total_pagado_en_mora
FROM historial_pagos hp
JOIN cuotas_manejo cm ON hp.cuota_id = cm.cuota_id
JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
JOIN clientes c ON t.cliente_id = c.cliente_id
WHERE hp.estado_transaccion = 'Exitoso' AND cm.dias_mora > 0
GROUP BY c.ciudad
ORDER BY total_pagado_en_mora DESC;

-- consulta 86: mostrar cual es el metodo de pago mas utilizado por cada ciudad
SELECT hp.metodo_pago, c.ciudad, COUNT(*) AS total_usos
FROM historial_pagos hp
JOIN cuotas_manejo cm ON hp.cuota_id = cm.cuota_id
JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
JOIN clientes c ON t.cliente_id = c.cliente_id
GROUP BY c.ciudad, hp.metodo_pago
HAVING COUNT(*) = (
    SELECT COUNT(*) 
    FROM historial_pagos hp2
    JOIN cuotas_manejo cm2 ON hp2.cuota_id = cm2.cuota_id
    JOIN tarjetas t2 ON cm2.tarjeta_id = t2.tarjeta_id
    JOIN clientes c2 ON t2.cliente_id = c2.cliente_id
    WHERE c2.ciudad = c.ciudad
    GROUP BY hp2.metodo_pago
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- consulta 87: contar cuantos pagos se han hecho por cada tarjeta y mostrar las 5 con los montos mas altos en pagos
SELECT t.tarjeta_id,t.numero_tarjeta, COUNT(hp.pago_id) AS cantidad_pagos, SUM(hp.monto_pagado) AS total_pagado
FROM historial_pagos hp
JOIN cuotas_manejo cm ON hp.cuota_id = cm.cuota_id
JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
WHERE hp.estado_transaccion = 'Exitoso'
GROUP BY t.tarjeta_id, t.numero_tarjeta
ORDER BY total_pagado DESC
LIMIT 5;

-- consulta 88: mostrar el promedio de días de mora según el tipo de tarjeta
SELECT tt.nombre_tipo AS tipo_tarjeta, ROUND(AVG(cm.dias_mora), 2) AS promedio_dias_mora
FROM cuotas_manejo cm
JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
JOIN tipos_tarjeta tt ON t.tipo_tarjeta_id = tt.tipo_tarjeta_id
GROUP BY tt.nombre_tipo
ORDER BY promedio_dias_mora DESC;

-- consulta 89: listar clientes que nunca han tenido días de mora > 0 en ninguna cuota
SELECT c.cliente_id, c.nombres, c.apellidos, c.numero_documento, c.email
FROM cuotas_manejo cm
JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
JOIN clientes c ON t.cliente_id = c.cliente_id
GROUP BY c.cliente_id, c.nombres, c.apellidos, c.numero_documento, c.email
HAVING MAX(cm.dias_mora) = 0
ORDER BY c.nombres;

-- consulta 90: identificar el mes con mayor tasa de mora 
SELECT periodo_año, periodo_mes, COUNT(*) AS total_cuotas, SUM(estado = 'Vencida') AS cuotas_vencidas,
  ROUND(SUM(estado = 'Vencida') / COUNT(*) * 100, 2) AS porcentaje_mora
FROM cuotas_manejo
GROUP BY periodo_año, periodo_mes
ORDER BY porcentaje_mora DESC
LIMIT 1;

-- 91-100 Consultas
-- consulta 91: Agrupar el total de monto_pagado por tipo_tarjeta (Visa Gold, Nómina, etc.).
SELECT tt.nombre_tipo AS 'Tipo de Tarjeta', ROUND(SUM(hp.monto_pagado), 2) AS 'Ingresos Totales'
FROM historial_pagos AS hp
JOIN cuotas_manejo AS cm ON hp.cuota_id = cm.cuota_id
JOIN tarjetas AS t ON cm.tarjeta_id = t.tarjeta_id
JOIN tipos_tarjeta AS tt ON t.tipo_tarjeta_id = tt.tipo_tarjeta_id
WHERE hp.estado_transaccion = 'Exitoso'
GROUP BY tt.nombre_tipo
ORDER BY `Ingresos Totales` DESC;

-- consulta 92: Mostrar clientes cuyas tarjetas tienen montos de apertura superiores al promedio general.
SELECT c.nombres, c.apellidos, t.numero_tarjeta, t.monto_apertura
FROM clientes AS c
JOIN tarjetas AS t ON c.cliente_id = t.cliente_id
-- Comparamos el monto de apertura de cada tarjeta con el resultado de la subconsulta.
WHERE t.monto_apertura > (
        SELECT AVG(monto_apertura) FROM tarjetas
    )
ORDER BY t.monto_apertura DESC;

-- consulta 93: Listar tarjetas ordenadas por fecha_ultimo_uso descendente.
SELECT t.numero_tarjeta, t.fecha_ultimo_uso, CONCAT(c.nombres, ' ', c.apellidos) AS 'Nombre del Cliente', t.estado
FROM tarjetas AS t
JOIN clientes AS c ON t.cliente_id = c.cliente_id
-- Nos aseguramos de que la tarjeta tenga una fecha de último uso.
WHERE t.fecha_ultimo_uso IS NOT NULL
ORDER BY t.fecha_ultimo_uso DESC;

-- consulta 94: Identificar clientes que estén acumulando mora de forma reciente.
SELECT c.cliente_id, c.nombres, c.apellidos, COUNT(cm.cuota_id) AS 'Cuotas Vencidas Recientes'
FROM clientes AS c
JOIN tarjetas AS t ON c.cliente_id = t.cliente_id
JOIN cuotas_manejo AS cm ON t.tarjeta_id = cm.tarjeta_id
WHERE cm.estado = 'Vencida'
    -- Filtramos para cuotas cuyo vencimiento fue en el período reciente.
    AND cm.fecha_vencimiento >= CURDATE() - INTERVAL 3 MONTH
GROUP BY c.cliente_id, c.nombres, c.apellidos
HAVING COUNT(cm.cuota_id) > 2
ORDER BY `Cuotas Vencidas Recientes` DESC;

-- consulta 95: Contar cuántas tarjetas han usado cada tipo de descuento y mostrarlas ordenadas.
SELECT nd.nombre_descuento, nd.porcentaje_descuento, COUNT(t.tarjeta_id) AS 'Numero de Tarjetas con este Descuento'
FROM niveles_descuento AS nd
JOIN tarjetas AS t ON nd.descuento_id = t.descuento_id
GROUP BY nd.descuento_id, nd.nombre_descuento, nd.porcentaje_descuento
ORDER BY `Numero de Tarjetas con este Descuento` DESC;

-- consulta 96: Mostrar el promedio de ingresos_mensuales de clientes con tipo_tarjeta que contiene ‘Visa’.
SELECT ROUND(AVG(ingresos_mensuales), 2) AS 'Promedio de Ingresos de Clientes con Tarjeta Visa'
FROM clientes
WHERE
    cliente_id IN (
        -- Subconsulta que obtiene los IDs de todos los clientes que tienen una tarjeta 'Visa'.
        SELECT DISTINCT t.cliente_id
        FROM tarjetas AS t
        JOIN tipos_tarjeta AS tt ON t.tipo_tarjeta_id = tt.tipo_tarjeta_id
        WHERE tt.nombre_tipo LIKE '%Visa%'
    );

-- consulta 97: Ver clientes que han usado diferentes canales (app, online, corresponsal, etc.).
SELECT c.cliente_id, c.nombres, c.apellidos, COUNT(DISTINCT hp.canal_pago) AS 'Cantidad de Canales Usados'
FROM clientes AS c
JOIN tarjetas AS t ON c.cliente_id = t.cliente_id
JOIN cuotas_manejo AS cm ON t.tarjeta_id = cm.tarjeta_id
JOIN historial_pagos AS hp ON cm.cuota_id = hp.cuota_id
WHERE hp.estado_transaccion = 'Exitoso'
GROUP BY c.cliente_id, c.nombres, c.apellidos
HAVING COUNT(DISTINCT hp.canal_pago) > 1
ORDER BY `Cantidad de Canales Usados` DESC;

-- consulta 98: Buscar clientes cuyas tarjetas incluyen cierto texto en el campo beneficios (por ejemplo: 'cash back').
SELECT DISTINCT c.cliente_id, c.nombres, c.apellidos, tt.nombre_tipo
FROM clientes AS c
JOIN tarjetas AS t ON c.cliente_id = t.cliente_id
JOIN tipos_tarjeta AS tt ON t.tipo_tarjeta_id = tt.tipo_tarjeta_id
WHERE tt.beneficios LIKE '%cash back%';

-- consulta 99: Mostrar cuánto ha acumulado en interes_mora cada cliente.
SELECT c.cliente_id, c.nombres, c.apellidos, ROUND(SUM(cm.interes_mora), 2) AS 'Total Intereses por Mora Acumulados'
FROM clientes AS c
JOIN tarjetas AS t ON c.cliente_id = t.cliente_id
JOIN cuotas_manejo AS cm ON t.tarjeta_id = cm.tarjeta_id
GROUP BY c.cliente_id, c.nombres, c.apellidos
HAVING SUM(cm.interes_mora) > 0
ORDER BY `Total Intereses por Mora Acumulados` DESC;

-- consulta 100: Identificar pagos que se realizaron el mismo día en que la cuota fue generada.
SELECT hp.numero_transaccion, hp.monto_pagado, DATE(cm.fecha_generacion) AS 'Fecha de Generación', DATE(hp.fecha_pago) AS 'Fecha de Pago', t.numero_tarjeta
FROM historial_pagos AS hp
JOIN cuotas_manejo AS cm ON hp.cuota_id = cm.cuota_id
JOIN tarjetas AS t ON cm.tarjeta_id = t.tarjeta_id
WHERE DATE(hp.fecha_pago) = DATE(cm.fecha_generacion) AND hp.estado_transaccion = 'Exitoso'
ORDER BY hp.fecha_pago DESC;