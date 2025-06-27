USE BancoCL;

-- 1er procedimiento: registrar un nuevo cliente y tmb su primera tarjeta en un solo paso
DELIMITER $$

CREATE PROCEDURE registrar_cliente_y_tarjeta (
  IN p_numero_cuenta VARCHAR(20),
  IN p_tipo_documento ENUM('CC','CE','PA','NIT'),
  IN p_numero_documento VARCHAR(20),
  IN p_nombres VARCHAR(100),
  IN p_apellidos VARCHAR(100),
  IN p_fecha_nacimiento DATE,
  IN p_telefono VARCHAR(15),
  IN p_email VARCHAR(100),
  IN p_direccion TEXT,
  IN p_ciudad VARCHAR(50),
  IN p_departamento VARCHAR(50),
  IN p_codigo_postal VARCHAR(10),
  IN p_ocupacion VARCHAR(100),
  IN p_ingresos DECIMAL(12,2),
  IN p_tipo_tarjeta_id INT,
  IN p_descuento_id INT,
  IN p_monto_apertura DECIMAL(10,2),
  IN p_limite_credito DECIMAL(12,2)
)
BEGIN
  DECLARE cliente_id_new INT;

  INSERT INTO Clientes (
    numero_cuenta, tipo_documento, numero_documento, nombres, apellidos,
    fecha_nacimiento, telefono, email, direccion, ciudad, departamento,
    codigo_postal, ocupacion, ingresos_mensuales
  )
  VALUES (
    p_numero_cuenta, p_tipo_documento, p_numero_documento, p_nombres, p_apellidos,
    p_fecha_nacimiento, p_telefono, p_email, p_direccion, p_ciudad, p_departamento,
    p_codigo_postal, p_ocupacion, p_ingresos
  );

  SET cliente_id_new = LAST_INSERT_ID();

  INSERT INTO Tarjetas (
    numero_tarjeta, cliente_id, tipo_tarjeta_id, descuento_id,
    monto_apertura, limite_credito, saldo_disponible,
    fecha_apertura, fecha_vencimiento
  )
  VALUES (
    UUID(), cliente_id_new, p_tipo_tarjeta_id, p_descuento_id,
    p_monto_apertura, p_limite_credito, p_limite_credito,
    CURRENT_DATE, DATE_ADD(CURRENT_DATE, INTERVAL 3 YEAR)
  );
END$$

DELIMITER ;

-- 2do procedimiento: generar una cuota de manejo con calculo de descuento
DELIMITER $$

CREATE PROCEDURE registrar_cuota_con_descuento (
  IN p_tarjeta_id INT,
  IN p_mes INT,
  IN p_anio INT
)
BEGIN
  DECLARE base DECIMAL(8,2);
  DECLARE descuento DECIMAL(5,2);
  DECLARE valor_descuento DECIMAL(8,2);
  DECLARE total DECIMAL(8,2);

  SELECT t.cuota_base_mensual, nd.porcentaje_descuento
  INTO base, descuento
  FROM Tarjetas ta
  JOIN Tipos_Tarjeta t ON ta.tipo_tarjeta_id = t.tipo_tarjeta_id
  JOIN Niveles_Descuento nd ON ta.descuento_id = nd.descuento_id
  WHERE ta.tarjeta_id = p_tarjeta_id;

  SET valor_descuento = base * descuento / 100;
  SET total = base - valor_descuento;

  INSERT INTO Cuotas_Manejo (
    tarjeta_id, periodo_mes, periodo_año,
    monto_base, porcentaje_descuento, valor_descuento,
    monto_final, fecha_vencimiento
  )
  VALUES (
    p_tarjeta_id, p_mes, p_anio,
    base, descuento, valor_descuento,
    total, LAST_DAY(CONCAT(p_anio, '-', p_mes, '-01'))
  );
END$$

DELIMITER ;

-- 3er procedimiento: registrasr un pago de una cuota y actualizar el estado
DELIMITER $$

CREATE PROCEDURE procesar_pago_cuota (
  IN p_cuota_id INT,
  IN p_monto DECIMAL(8,2),
  IN p_metodo_pago ENUM('Transferencia','Efectivo','Debito_Automatico','PSE','Tarjeta_Debito','Corresponsal'),
  IN p_canal ENUM('Sucursal','ATM','Online','App_Movil','Call_Center'),
  IN p_usuario VARCHAR(50),
  IN p_ip VARCHAR(45)
)
BEGIN
  INSERT INTO Historial_Pagos (
    cuota_id, numero_transaccion, monto_pagado, monto_pendiente,
    fecha_pago, metodo_pago, canal_pago, usuario_registro, ip_origen
  )
  VALUES (
    p_cuota_id, UUID(), p_monto, 0,
    NOW(), p_metodo_pago, p_canal, p_usuario, p_ip
  );

  UPDATE Cuotas_Manejo
  SET estado = 'Pagada', dias_mora = 0, interes_mora = 0
  WHERE cuota_id = p_cuota_id;
END$$

DELIMITER ;

-- 4to procedimiento: esta funcion devuelve un resumen mensual de cuotas generadas, pagadas y pendientes
DELIMITER $$

CREATE PROCEDURE generar_reporte_mensual (
  IN p_anio INT,
  IN p_mes INT
)
BEGIN
  SELECT 
    COUNT(*) AS total_cuotas,
    SUM(CASE WHEN estado = 'Pagada' THEN 1 ELSE 0 END) AS pagadas,
    SUM(CASE WHEN estado = 'Pendiente' THEN 1 ELSE 0 END) AS pendientes,
    SUM(monto_final) AS total_monto_generado
  FROM Cuotas_Manejo
  WHERE periodo_año = p_anio AND periodo_mes = p_mes;
END$$

DELIMITER ;

-- 5to procedimiento: cambiar el nivel de descuento de una tarjeta si el monto de apertura cambio
DELIMITER $$

CREATE PROCEDURE actualizar_descuento_cliente (
  IN p_tarjeta_id INT
)
BEGIN
  DECLARE apertura DECIMAL(10,2);
  DECLARE nuevo_descuento_id INT;

  SELECT monto_apertura INTO apertura
  FROM Tarjetas WHERE tarjeta_id = p_tarjeta_id;

  SELECT descuento_id INTO nuevo_descuento_id
  FROM Niveles_Descuento
  WHERE apertura BETWEEN monto_minimo_requerido AND monto_maximo_aplicable
    AND estado = TRUE
  LIMIT 1;

  UPDATE Tarjetas
  SET descuento_id = nuevo_descuento_id
  WHERE tarjeta_id = p_tarjeta_id;
END$$

DELIMITER ;

-- 6to procedimiento: cambiar el estado de la tarjeta a vencido si su fecha de vencimiento paso
DELIMITER $$

CREATE PROCEDURE bloquear_tarjeta_vencida ()
BEGIN
  UPDATE Tarjetas
  SET estado = 'Vencida'
  WHERE fecha_vencimiento < CURDATE() AND estado = 'Activa';
END$$

DELIMITER ;

-- 7mo procedimiento: eliminar clientes inactivos que no tengan tarjetas asociadas
DELIMITER $$

CREATE PROCEDURE eliminar_clientes_inactivos ()
BEGIN
  DELETE FROM Clientes
  WHERE estado = 'Inactivo'
    AND cliente_id NOT IN (
      SELECT cliente_id FROM Tarjetas
    );
END$$

DELIMITER ;

-- 8vo procedimiento: devolver el ahorro total por descuentos de un cliente
DELIMITER $$

CREATE PROCEDURE obtener_total_ahorro_cliente (
  IN p_cliente_id INT
)
BEGIN
  SELECT c.cliente_id, SUM(cm.valor_descuento) AS total_ahorrado
  FROM Cuotas_Manejo cm
  JOIN Tarjetas t ON cm.tarjeta_id = t.tarjeta_id
  JOIN Clientes c ON t.cliente_id = c.cliente_id
  WHERE c.cliente_id = p_cliente_id
  GROUP BY c.cliente_id;
END$$

DELIMITER ;

-- 9no procedimiento: mostrar cuotas vencidas agrupadas por ciudad del cliente
DELIMITER $$

CREATE PROCEDURE cuotas_vencidas_por_ciudad ()
BEGIN
  SELECT c.ciudad, COUNT(*) AS total_vencidas
  FROM Cuotas_Manejo cm
  JOIN Tarjetas t ON cm.tarjeta_id = t.tarjeta_id
  JOIN Clientes c ON t.cliente_id = c.cliente_id
  WHERE cm.estado = 'Vencida'
  GROUP BY c.ciudad;
END$$

DELIMITER ;

-- 10mo procedimiento: actualizar los dias de mora para cuotas vencida
DELIMITER $$

CREATE PROCEDURE establecer_dias_mora_automatica ()
BEGIN
  UPDATE Cuotas_Manejo
  SET dias_mora = DATEDIFF(CURDATE(), fecha_vencimiento)
  WHERE estado = 'Vencida';
END$$

DELIMITER ;


