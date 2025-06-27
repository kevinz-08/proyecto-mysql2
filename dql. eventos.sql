USE BancoCL;

SET GLOBAL event_scheduler = ON;

-- EVENTO 1: Llama al procedimiento 'sp_vista_completa_cliente'.
-- Se ejecuta una vez al día para (hipotéticamente) generar el reporte de un cliente VIP específico.
DELIMITER $$
DROP EVENT IF EXISTS ev_generar_reporte_vista_cliente;
CREATE EVENT ev_generar_reporte_vista_cliente
ON SCHEDULE EVERY 1 DAY
STARTS TIMESTAMP(CURRENT_DATE, '04:00:00')
COMMENT 'Llama al SP que muestra la vista 360 del cliente con ID 1.'
DO
BEGIN
    CALL sp_vista_completa_cliente(1);
END$$
DELIMITER ;


-- EVENTO 2: Llama al procedimiento 'sp_clientes_con_multiples_tarjetas'.
-- Se ejecuta todos los lunes para buscar clientes con más de 2 tarjetas activas.
DELIMITER $$
DROP EVENT IF EXISTS ev_buscar_clientes_multitarjeta;
CREATE EVENT ev_buscar_clientes_multitarjeta
ON SCHEDULE EVERY 1 WEEK
-- STARTS NEXT_DAY(CURDATE(), 'MONDAY') + INTERVAL 5 HOUR
STARTS TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL (7 - DAYOFWEEK(CURDATE()) + 2) % 7 DAY), '05:00:00')
COMMENT 'Llama al SP que busca clientes con más de 2 tarjetas.'
DO
BEGIN
    CALL sp_clientes_con_multiples_tarjetas(2);
END$$
DELIMITER ;


-- EVENTO 3: Llama al procedimiento 'sp_listar_pagos_por_fecha'.
-- Se ejecuta el primer día de cada mes para generar un listado de los pagos del mes anterior.
DELIMITER $$
DROP EVENT IF EXISTS ev_listar_pagos_mes_anterior;
CREATE EVENT ev_listar_pagos_mes_anterior
ON SCHEDULE EVERY 1 MONTH
STARTS STR_TO_DATE(DATE_FORMAT(NOW(), '%Y-%m-01 02:00:00'), '%Y-%m-%d %H:%i:%s')
COMMENT 'Llama al SP para listar pagos, usando fechas dinámicas para el mes anterior.'
DO
BEGIN
    -- Aquí usé fechas dinámicas para que sea más útil
    CALL sp_listar_pagos_por_fecha(
        DATE_FORMAT(CURDATE() - INTERVAL 1 MONTH, '%Y-%m-01'),
        LAST_DAY(CURDATE() - INTERVAL 1 MONTH)
    );
END$$
DELIMITER ;


-- EVENTO 4: Llama al procedimiento 'sp_reporte_cuotas_por_estado_y_mora'.
-- Se ejecuta diariamente para generar un reporte de las cuotas vencidas con más de 60 días de mora.
DELIMITER $$
DROP EVENT IF EXISTS ev_reporte_mora_critica;
CREATE EVENT ev_reporte_mora_critica
ON SCHEDULE EVERY 1 DAY
STARTS TIMESTAMP(CURRENT_DATE, '03:30:00')
COMMENT 'Llama al SP para obtener el reporte de clientes en mora crítica (>60 días).'
DO
BEGIN
    CALL sp_reporte_cuotas_por_estado_y_mora('Vencida', 60);
END$$
DELIMITER ;


-- EVENTO 5: Llama al procedimiento 'sp_actualizar_estado_tarjeta'.
-- Este es un caso de uso atípico, pero válido para el ejercicio. El evento actualiza siempre la misma tarjeta.
DELIMITER $$
DROP EVENT IF EXISTS ev_ejecutar_actualizacion_programada_tarjeta;
CREATE EVENT ev_ejecutar_actualizacion_programada_tarjeta
ON SCHEDULE EVERY 1 MONTH
COMMENT 'Ejemplo de evento que llama a un SP de acción con parámetros fijos.'
DO
BEGIN
    CALL sp_actualizar_estado_tarjeta(2, 'Suspendida', 'Revisión mensual automática programada', 'system_event');
END$$
DELIMITER ;


-- EVENTO 6: Llama al procedimiento 'sp_buscar_clientes'.
-- Se ejecuta cada domingo para buscar clientes con un apellido común, para una campaña, por ejemplo.
DELIMITER $$
DROP EVENT IF EXISTS ev_buscar_clientes_para_campaña;
CREATE EVENT ev_buscar_clientes_para_campaña
ON SCHEDULE EVERY 1 WEEK
-- STARTS NEXT_DAY(CURDATE(), 'SUNDAY')
STARTS TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL (7 - DAYOFWEEK(CURDATE()) + 1) % 7 DAY), '04:00:00')
COMMENT 'Llama al SP para buscar clientes con el apellido "Garcia".'
DO
BEGIN
    CALL sp_buscar_clientes('Garcia');
END$$
DELIMITER ;


-- EVENTO 7: Llama al procedimiento 'sp_historial_pagos_cliente'.
-- Se ejecuta una vez por hora (ej. para un sistema de caché de reportes).
DELIMITER $$
DROP EVENT IF EXISTS ev_refrescar_historial_cliente_5;
CREATE EVENT ev_refrescar_historial_cliente_5
ON SCHEDULE EVERY 1 HOUR
COMMENT 'Llama al SP para obtener el historial de pagos del cliente con ID 5.'
DO
BEGIN
    CALL sp_historial_pagos_cliente(5);
END$$
DELIMITER ;


-- EVENTO 8: Llama al procedimiento 'sp_reporte_emision_tarjetas_periodo'.
-- Se ejecuta el día 2 de cada mes para reportar las tarjetas emitidas dos meses atrás.
DELIMITER $$
DROP EVENT IF EXISTS ev_reporte_emision_tarjetas;
CREATE EVENT ev_reporte_emision_tarjetas
ON SCHEDULE EVERY 1 MONTH
STARTS STR_TO_DATE(DATE_FORMAT(NOW(), '%Y-%m-02 07:00:00'), '%Y-%m-%d %H:%i:%s')
COMMENT 'Llama al SP para reportar emisiones de tarjetas de hace dos meses.'
DO
BEGIN
    CALL sp_reporte_emision_tarjetas_periodo(YEAR(CURDATE() - INTERVAL 2 MONTH), MONTH(CURDATE() - INTERVAL 2 MONTH));
END$$
DELIMITER ;


-- EVENTO 9: Llama al procedimiento 'sp_ranking_descuentos'.
-- Se ejecuta diariamente.
DELIMITER $$
DROP EVENT IF EXISTS ev_generar_ranking_diario_descuentos;
CREATE EVENT ev_generar_ranking_diario_descuentos
ON SCHEDULE EVERY 1 DAY
STARTS TIMESTAMP(CURRENT_DATE, '02:30:00')
COMMENT 'Llama al SP que genera el ranking de descuentos más utilizados.'
DO
BEGIN
    CALL sp_ranking_descuentos();
END$$
DELIMITER ;


-- EVENTO 10: Llama al procedimiento 'sp_pagos_fallidos_por_fecha' (Tu ejemplo).
-- Se ejecuta diariamente, pero siempre busca en el mismo rango de fechas fijo.
DELIMITER $$
DROP EVENT IF EXISTS ev_reporte_pagos_fallidos_fijo;
CREATE EVENT ev_reporte_pagos_fallidos_fijo
ON SCHEDULE EVERY 1 DAY
STARTS TIMESTAMP(CURRENT_DATE, '06:00:00')
COMMENT 'Llama al SP de pagos fallidos con un rango de fechas fijo.'
DO
BEGIN
    CALL sp_pagos_fallidos_por_fecha('2024-06-01', '2024-07-31');
END$$
DELIMITER ;
