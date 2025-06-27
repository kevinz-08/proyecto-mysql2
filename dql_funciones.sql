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
