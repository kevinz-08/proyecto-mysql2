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



