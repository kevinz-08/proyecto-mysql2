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



