USE BancoCL;

-- 1era funcion: calcular el promedio de valor de cuotas por tipo de tarjeta
DELIMITER $$

CREATE FUNCTION calcular_promedio_cuota(tipo_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE promedio DECIMAL(10,2);
  SELECT AVG(cm.monto_final)
  INTO promedio
  FROM cuotas_manejo cm
  JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
  WHERE t.tipo_tarjeta_id = tipo_id;
  RETURN promedio;
END$$

DELIMITER ;
-----------
-- 2da funcion: calcular el promedio de valor de cuotas por tipo de tarjeta
DELIMITER $$

CREATE FUNCTION total_pagado_cliente(cliente INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
  DECLARE total DECIMAL(12,2);
  SELECT SUM(hp.monto_pagado)
  INTO total
  FROM historial_pagos hp
  JOIN cuotas_manejo cm ON hp.cuota_id = cm.cuota_id
  JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
  WHERE t.cliente_id = cliente AND hp.estado_transaccion = 'Exitoso';
  RETURN IFNULL(total, 0);
END$$

DELIMITER ;
-----------
-- 3ra funcion: calcular la edad de un cliente
DELIMITER $$

CREATE FUNCTION calcular_edad(fecha_nac DATE)
RETURNS INT
DETERMINISTIC
BEGIN
  RETURN TIMESTAMPDIFF(YEAR, fecha_nac, CURDATE());
END$$

DELIMITER ;
-----------
-- 4ta funcion: obtener porcentaje promedio de descuentos aplicados
DELIMITER $$

CREATE FUNCTION promedio_descuento()
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
  DECLARE resultado DECIMAL(5,2);
  SELECT AVG(porcentaje_descuento)
  INTO resultado
  FROM cuotas_manejo;
  RETURN resultado;
END$$
-------
DELIMITER ;
-----------
-- 5ta funcion: calcular el interes generado por mora en una cuota
DELIMITER $$

CREATE FUNCTION interes_mora(cuota INT)
RETURNS DECIMAL(8,2)
DETERMINISTIC
BEGIN
  DECLARE interes DECIMAL(8,2);
  SELECT interes_mora
  INTO interes
  FROM cuotas_manejo
  WHERE cuota_id = cuota;
  RETURN IFNULL(interes, 0);
END$$

DELIMITER ;
-----------
-- 6ta funcion: total de cuotas pagadas por una tarjeta
DELIMITER $$

CREATE FUNCTION total_pagos_tarjeta(tarjeta INT)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE pagos INT;
  SELECT COUNT(*) INTO pagos
  FROM historial_pagos hp
  JOIN cuotas_manejo cm ON hp.cuota_id = cm.cuota_id
  WHERE cm.tarjeta_id = tarjeta AND hp.estado_transaccion = 'Exitoso';
  RETURN pagos;
END$$

DELIMITER ;
-----------
-- 7ta funcion: obtener monto total de descuentos aplicados por un cliente
DELIMITER $$

CREATE FUNCTION total_descuento_cliente(cliente_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE total DECIMAL(10,2);
  SELECT SUM(cm.valor_descuento)
  INTO total
  FROM cuotas_manejo cm
  JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
  WHERE t.cliente_id = cliente_id;
  RETURN IFNULL(total, 0);
END$$

DELIMITER ;
-----------
-- 8ta funcion: determinar si una cuota esta vencida
DELIMITER $$

CREATE FUNCTION cuota_vencida(cuota INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
  DECLARE vencida BOOLEAN;
  SELECT CASE
    WHEN fecha_vencimiento < CURDATE() AND estado = 'Pendiente' THEN TRUE
    ELSE FALSE
  END
  INTO vencida
  FROM cuotas_manejo
  WHERE cuota_id = cuota;
  RETURN vencida;
END$$

DELIMITER ;
-----------
-- 9na funcion: calcular el ahorro en una cuota
DELIMITER $$

CREATE FUNCTION ahorro_en_cuota(cuota_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE descuento DECIMAL(10,2);
  SELECT valor_descuento INTO descuento
  FROM cuotas_manejo
  WHERE cuota_id = cuota_id;
  RETURN IFNULL(descuento, 0);
END$$

DELIMITER ;

-- 10ma funcion: obtener dias de mora de una cuota
DELIMITER $$

CREATE FUNCTION dias_mora_cuota(cuota_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE dias INT;
  SELECT dias_mora INTO dias
  FROM cuotas_manejo
  WHERE cuota_id = cuota_id;
  RETURN IFNULL(dias, 0);
END$$

DELIMITER ;

-- FUNCIÓN 11: Obtener ingresos totales por un tipo de tarjeta específico.
-- Basado en la consulta #91.
DELIMITER $$
DROP FUNCTION IF EXISTS f_ingresos_por_tipo_tarjeta;
CREATE FUNCTION f_ingresos_por_tipo_tarjeta(p_tipo_tarjeta_id INT)
RETURNS DECIMAL(15, 2)
DETERMINISTIC
BEGIN
    DECLARE v_ingresos_totales DECIMAL(15, 2);
    SELECT IFNULL(SUM(hp.monto_pagado), 0) INTO v_ingresos_totales
    FROM historial_pagos AS hp
    JOIN cuotas_manejo AS cm ON hp.cuota_id = cm.cuota_id
    JOIN tarjetas AS t ON cm.tarjeta_id = t.tarjeta_id
    WHERE t.tipo_tarjeta_id = p_tipo_tarjeta_id AND hp.estado_transaccion = 'Exitoso';
    RETURN v_ingresos_totales;
END$$
DELIMITER ;

SELECT nombre_tipo, f_ingresos_por_tipo_tarjeta(tipo_tarjeta_id) AS ingresos_totales FROM tipos_tarjeta;


-- FUNCIÓN 12: Calcular la rentabilidad neta de un cliente.
-- Basado en la consulta #72.
DELIMITER $$
DROP FUNCTION IF EXISTS f_rentabilidad_neta_cliente;
CREATE FUNCTION f_rentabilidad_neta_cliente(p_cliente_id INT)
RETURNS DECIMAL(15, 2)
DETERMINISTIC
BEGIN
    DECLARE v_ingresos DECIMAL(15, 2);
    DECLARE v_descuentos DECIMAL(15, 2);
    SELECT IFNULL(SUM(hp.monto_pagado), 0) INTO v_ingresos
    FROM historial_pagos hp JOIN cuotas_manejo cm ON hp.cuota_id = cm.cuota_id JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
    WHERE t.cliente_id = p_cliente_id AND hp.estado_transaccion = 'Exitoso';
    SELECT IFNULL(SUM(cm.valor_descuento), 0) INTO v_descuentos
    FROM cuotas_manejo cm JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
    WHERE t.cliente_id = p_cliente_id;
    RETURN (v_ingresos - v_descuentos);
END$$
DELIMITER ;

SELECT cliente_id, nombres, f_rentabilidad_neta_cliente(cliente_id) AS rentabilidad_neta FROM clientes LIMIT 5;


-- FUNCIÓN 13: Contar el número de cuotas vencidas de un cliente.
-- Basado en la consulta #94.
DELIMITER $$
DROP FUNCTION IF EXISTS f_contar_cuotas_vencidas_cliente;
CREATE FUNCTION f_contar_cuotas_vencidas_cliente(p_cliente_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_conteo INT;
    SELECT COUNT(cm.cuota_id) INTO v_conteo
    FROM cuotas_manejo cm JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
    WHERE t.cliente_id = p_cliente_id AND cm.estado = 'Vencida';
    RETURN v_conteo;
END$$
DELIMITER ;

SELECT cliente_id, nombres, f_contar_cuotas_vencidas_cliente(cliente_id) AS numero_cuotas_vencidas FROM clientes LIMIT 10;


-- FUNCIÓN 14: Obtener el total recaudado por un método de pago.
-- Basado en la consulta #32.
DELIMITER $$
DROP FUNCTION IF EXISTS f_total_recaudado_por_metodo;
CREATE FUNCTION f_total_recaudado_por_metodo(p_metodo_pago VARCHAR(50))
RETURNS DECIMAL(15, 2)
DETERMINISTIC
BEGIN
    DECLARE v_total_recaudado DECIMAL(15, 2);
    SELECT IFNULL(SUM(monto_pagado), 0) INTO v_total_recaudado
    FROM historial_pagos
    WHERE metodo_pago = p_metodo_pago AND estado_transaccion = 'Exitoso';
    RETURN v_total_recaudado;
END$$
DELIMITER ;

SELECT 'PSE' AS metodo_pago, f_total_recaudado_por_metodo('PSE') AS total_recaudado;


-- FUNCIÓN 15: Calcular el total de intereses por mora de un cliente.
-- Basado en la consulta #99
DELIMITER $$
DROP FUNCTION IF EXISTS f_total_mora_por_cliente;
CREATE FUNCTION f_total_mora_por_cliente(p_cliente_id INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE v_total_mora DECIMAL(10, 2);
    SELECT IFNULL(SUM(cm.interes_mora), 0) INTO v_total_mora
    FROM cuotas_manejo cm JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
    WHERE t.cliente_id = p_cliente_id;
    RETURN v_total_mora;
END$$
DELIMITER ;

SELECT cliente_id, nombres, f_total_mora_por_cliente(cliente_id) AS mora_acumulada FROM clientes WHERE cliente_id BETWEEN 1 AND 50;


-- FUNCIÓN 16: Obtener ingresos totales para un mes y año específicos.
-- Basado en la consulta #51.
DELIMITER $$
DROP FUNCTION IF EXISTS f_ingresos_por_mes_año;
CREATE FUNCTION f_ingresos_por_mes_año(p_mes INT, p_año INT)
RETURNS DECIMAL(15, 2)
DETERMINISTIC
BEGIN
    DECLARE v_ingresos DECIMAL(15, 2);
    SELECT IFNULL(SUM(monto_pagado), 0) INTO v_ingresos
    FROM historial_pagos
    WHERE MONTH(fecha_pago) = p_mes AND YEAR(fecha_pago) = p_año AND estado_transaccion = 'Exitoso';
    RETURN v_ingresos;
END$$
DELIMITER ;

SELECT f_ingresos_por_mes_año(5, 2024) AS 'Ingresos de Mayo 2024';


-- FUNCIÓN 17: Contar cuántas tarjetas están asociadas a un descuento.
-- Basado en la consulta #95
DELIMITER $$
DROP FUNCTION IF EXISTS f_contar_tarjetas_por_descuento;
CREATE FUNCTION f_contar_tarjetas_por_descuento(p_descuento_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_conteo INT;
    SELECT COUNT(tarjeta_id) INTO v_conteo
    FROM tarjetas
    WHERE descuento_id = p_descuento_id;
    RETURN v_conteo;
END$$
DELIMITER ;

SELECT nombre_descuento, f_contar_tarjetas_por_descuento(descuento_id) AS tarjetas_asociadas FROM niveles_descuento;


-- FUNCIÓN 18: Obtener la antigüedad de un cliente en años.
-- Basado en la consulta #77.
DELIMITER $$
DROP FUNCTION IF EXISTS f_antiguedad_cliente_en_años;
CREATE FUNCTION f_antiguedad_cliente_en_años(p_cliente_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_fecha_registro DATE;
    SELECT fecha_registro INTO v_fecha_registro FROM clientes WHERE cliente_id = p_cliente_id;
    IF v_fecha_registro IS NULL THEN RETURN 0; END IF;
    RETURN FLOOR(DATEDIFF(CURDATE(), v_fecha_registro) / 365);
END$$
DELIMITER ;

SELECT cliente_id, nombres, f_antiguedad_cliente_en_años(cliente_id) AS años_como_cliente FROM clientes WHERE cliente_id = 7;


-- FUNCIÓN 19: Verificar si un cliente es elegible para un beneficio (ej. 'cash back').
-- Basado en la consulta #98
DELIMITER $$
DROP FUNCTION IF EXISTS f_cliente_tiene_beneficio;
CREATE FUNCTION f_cliente_tiene_beneficio(p_cliente_id INT, p_beneficio_texto VARCHAR(100))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE v_conteo INT;
    SELECT COUNT(*) INTO v_conteo
    FROM tarjetas t JOIN tipos_tarjeta tt ON t.tipo_tarjeta_id = tt.tipo_tarjeta_id
    WHERE t.cliente_id = p_cliente_id AND tt.beneficios LIKE CONCAT('%', p_beneficio_texto, '%');
    RETURN v_conteo > 0;
END$$
DELIMITER ;

SELECT nombres, apellidos, f_cliente_tiene_beneficio(cliente_id, 'cash back') AS tiene_cash_back FROM clientes WHERE cliente_id = 3;


-- FUNCIÓN 20: Calcular el porcentaje de contribución de un cliente a los ingresos totales.
-- Basado en la consulta #95.
DELIMITER $$
DROP FUNCTION IF EXISTS f_porcentaje_contribucion_cliente;
CREATE FUNCTION f_porcentaje_contribucion_cliente(p_cliente_id INT)
RETURNS DECIMAL(5, 2)
DETERMINISTIC
BEGIN
    DECLARE v_ingresos_cliente DECIMAL(15, 2);
    DECLARE v_ingresos_totales DECIMAL(15, 2);
    SELECT IFNULL(SUM(hp.monto_pagado), 0) INTO v_ingresos_cliente
    FROM historial_pagos hp JOIN cuotas_manejo cm ON hp.cuota_id = cm.cuota_id JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
    WHERE t.cliente_id = p_cliente_id AND hp.estado_transaccion = 'Exitoso';
    SELECT SUM(monto_pagado) INTO v_ingresos_totales FROM historial_pagos WHERE estado_transaccion = 'Exitoso';
    IF v_ingresos_totales IS NULL OR v_ingresos_totales = 0 THEN RETURN 0; END IF;
    RETURN (v_ingresos_cliente / v_ingresos_totales) * 100;
END$$
DELIMITER ;

SELECT nombres, apellidos, CONCAT(ROUND(f_porcentaje_contribucion_cliente(cliente_id), 2), ' %') AS contribucion_a_ingresos FROM clientes WHERE cliente_id = 10;
