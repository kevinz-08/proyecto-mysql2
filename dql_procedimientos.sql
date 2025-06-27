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


-- PROCEDIMIENTO 11: Obtener la vista completa de un cliente.
-- Basado en la consulta #71. Recibe un ID de cliente y devuelve su historial completo.
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_vista_completa_cliente;
CREATE PROCEDURE sp_vista_completa_cliente(IN p_cliente_id INT)
BEGIN
    SELECT
        c.cliente_id,
        c.nombres,
        c.apellidos,
        t.numero_tarjeta,
        t.estado AS estado_tarjeta,
        cm.periodo_año AS año_cuota,
        cm.periodo_mes AS mes_cuota,
        cm.estado AS estado_cuota,
        hp.fecha_pago,
        hp.monto_pagado
    FROM clientes AS c
    LEFT JOIN tarjetas AS t ON c.cliente_id = t.cliente_id
    LEFT JOIN cuotas_manejo AS cm ON t.tarjeta_id = cm.tarjeta_id
    LEFT JOIN historial_pagos AS hp ON cm.cuota_id = hp.cuota_id
    WHERE c.cliente_id = p_cliente_id
    ORDER BY t.numero_tarjeta, año_cuota DESC, mes_cuota DESC;
END$$
DELIMITER ;

CALL sp_vista_completa_cliente(10);


-- PROCEDIMIENTO 12: Encontrar clientes con más de N tarjetas activas.
-- Basado en la consulta #17. Hace el número de tarjetas un parámetro.
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_clientes_con_multiples_tarjetas;
CREATE PROCEDURE sp_clientes_con_multiples_tarjetas(IN p_num_tarjetas INT)
BEGIN
    SELECT
        c.cliente_id,
        c.nombres,
        c.apellidos,
        COUNT(t.tarjeta_id) AS numero_de_tarjetas_activas
    FROM clientes AS c
    JOIN tarjetas AS t ON c.cliente_id = t.cliente_id
    WHERE t.estado = 'Activa'
    GROUP BY c.cliente_id, c.nombres, c.apellidos
    HAVING COUNT(t.tarjeta_id) > p_num_tarjetas;
END$$
DELIMITER ;
-- Ejemplo (encontrar clientes con más de 1 tarjeta activa):
CALL sp_clientes_con_multiples_tarjetas(1);


-- PROCEDIMIENTO 13: Listar pagos en un rango de fechas.
-- Basado en la consulta #31. Permite especificar fecha de inicio y fin.
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_listar_pagos_por_fecha;
CREATE PROCEDURE sp_listar_pagos_por_fecha(IN p_fecha_inicio DATE, IN p_fecha_fin DATE)
BEGIN
    SELECT
        numero_transaccion,
        fecha_pago,
        monto_pagado,
        metodo_pago,
        estado_transaccion
    FROM historial_pagos
    WHERE DATE(fecha_pago) BETWEEN p_fecha_inicio AND p_fecha_fin
    ORDER BY fecha_pago DESC;
END$$
DELIMITER ;

CALL sp_listar_pagos_por_fecha('2024-06-01', '2024-07-31');


-- PROCEDIMIENTO 14: Generar reporte de cuotas por estado y días de mora.
-- Basado en consultas #61 y #62.
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_reporte_cuotas_por_estado_y_mora;
CREATE PROCEDURE sp_reporte_cuotas_por_estado_y_mora(IN p_estado ENUM('Pendiente', 'Pagada', 'Vencida', 'Condonada'), IN p_dias_mora INT)
BEGIN
    SELECT
        cm.cuota_id,
        t.numero_tarjeta,
        c.nombres,
        c.apellidos,
        cm.monto_final,
        cm.fecha_vencimiento,
        cm.dias_mora
    FROM cuotas_manejo cm
    JOIN tarjetas t ON cm.tarjeta_id = t.tarjeta_id
    JOIN clientes c ON t.cliente_id = c.cliente_id
    WHERE cm.estado = p_estado AND cm.dias_mora >= p_dias_mora
    ORDER BY cm.dias_mora DESC;
END$$
DELIMITER ;
-- Ejemplo (ver cuotas vencidas con más de 30 días de mora):
CALL sp_reporte_cuotas_por_estado_y_mora('Vencida', 30);


-- PROCEDIMIENTO 15: Actualizar el estado de una tarjeta y auditar el cambio.Procedimiento 1de ACCIÓN que modifica datos y usa la tabla de auditoría.
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_actualizar_estado_tarjeta;
CREATE PROCEDURE sp_actualizar_estado_tarjeta(IN p_tarjeta_id INT, IN p_nuevo_estado VARCHAR(50), IN p_motivo VARCHAR(255), IN p_usuario VARCHAR(50))
BEGIN
    DECLARE v_estado_anterior VARCHAR(50);

    -- Obtener el estado actual antes de la modificación
    SELECT estado INTO v_estado_anterior FROM tarjetas WHERE tarjeta_id = p_tarjeta_id;

    -- Realizar la actualización
    UPDATE tarjetas
    SET estado = p_nuevo_estado, motivo_bloqueo = p_motivo
    WHERE tarjeta_id = p_tarjeta_id;

    -- Insertar en la tabla de auditoría
    INSERT INTO auditoria_operaciones (tabla_afectada, operacion, registro_id, datos_anteriores, datos_nuevos, usuario, descripcion)
    VALUES (
        'tarjetas',
        'UPDATE',
        p_tarjeta_id,
        JSON_OBJECT('estado', v_estado_anterior),
        JSON_OBJECT('estado', p_nuevo_estado, 'motivo', p_motivo),
        p_usuario,
        CONCAT('Cambio de estado manual de ', v_estado_anterior, ' a ', p_nuevo_estado)
    );
END$$
DELIMITER ;

CALL sp_actualizar_estado_tarjeta(5, 'Bloqueada', 'Petición del cliente vía telefónica', 'admcallcenter');


-- PROCEDIMIENTO 16: Buscar clientes por nombre o documento.Procedimiento 1de BÚSQUEDA flexible.
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_buscar_clientes;
CREATE PROCEDURE sp_buscar_clientes(IN p_criterio VARCHAR(100))
BEGIN
    SELECT
        cliente_id,
        numero_documento,
        nombres,
        apellidos,
        email,
        telefono,
        estado
    FROM clientes
    WHERE
        nombres LIKE CONCAT('%', p_criterio, '%')
        OR apellidos LIKE CONCAT('%', p_criterio, '%')
        OR numero_documento = p_criterio
    LIMIT 50;
END$$
DELIMITER ;

CALL sp_buscar_clientes('Perez');


-- PROCEDIMIENTO 17: Obtener el historial de pagos de un cliente.
-- Basado en la consulta #35.
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_historial_pagos_cliente;
CREATE PROCEDURE sp_historial_pagos_cliente(IN p_cliente_id INT)
BEGIN
    SELECT
        t.numero_tarjeta,
        hp.fecha_pago,
        hp.monto_pagado,
        hp.metodo_pago,
        hp.canal_pago,
        hp.estado_transaccion
    FROM historial_pagos AS hp
    JOIN cuotas_manejo AS cm ON hp.cuota_id = cm.cuota_id
    JOIN tarjetas AS t ON cm.tarjeta_id = t.tarjeta_id
    WHERE t.cliente_id = p_cliente_id
    ORDER BY hp.fecha_pago DESC;
END$$
DELIMITER ;

CALL sp_historial_pagos_cliente(8);


-- PROCEDIMIENTO 18: Reporte de emisión de tarjetas por mes y año.
-- Basado en la consulta #56, pero parametrizado.
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_reporte_emision_tarjetas_periodo;
CREATE PROCEDURE sp_reporte_emision_tarjetas_periodo(IN p_año INT, IN p_mes INT)
BEGIN
    SELECT
        tt.nombre_tipo,
        COUNT(t.tarjeta_id) AS 'Tarjetas Emitidas'
    FROM tarjetas t
    JOIN tipos_tarjeta tt ON t.tipo_tarjeta_id = tt.tipo_tarjeta_id
    WHERE YEAR(t.fecha_apertura) = p_año AND MONTH(t.fecha_apertura) = p_mes
    GROUP BY tt.nombre_tipo
    ORDER BY `Tarjetas Emitidas` DESC;
END$$
DELIMITER ;
-- Ejemplo (reporte para Junio de 2024):
CALL sp_reporte_emision_tarjetas_periodo(2024, 6);


-- PROCEDIMIENTO 19: Ranking de descuentos más utilizados.
-- Basado en la consulta #95
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ranking_descuentos;
CREATE PROCEDURE sp_ranking_descuentos()
BEGIN
    SELECT
        nd.nombre_descuento,
        nd.porcentaje_descuento,
        COUNT(t.tarjeta_id) AS 'Numero de Tarjetas con este Descuento'
    FROM niveles_descuento AS nd
    JOIN tarjetas AS t ON nd.descuento_id = t.descuento_id
    GROUP BY nd.descuento_id
    ORDER BY `Numero de Tarjetas con este Descuento` DESC;
END$$
DELIMITER ;

CALL sp_ranking_descuentos();


-- PROCEDIMIENTO 20: Obtener pagos fallidos en un rango de fechas.
-- Basado en la consulta #33.
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_pagos_fallidos_por_fecha;
CREATE PROCEDURE sp_pagos_fallidos_por_fecha(IN p_fecha_inicio DATE, IN p_fecha_fin DATE)
BEGIN
    SELECT
        numero_transaccion,
        fecha_pago,
        monto_pagado,
        metodo_pago,
        canal_pago,
        observaciones
    FROM historial_pagos
    WHERE estado_transaccion = 'Fallido'
      AND DATE(fecha_pago) BETWEEN p_fecha_inicio AND p_fecha_fin
    ORDER BY fecha_pago DESC;
END$$
DELIMITER ;

CALL sp_pagos_fallidos_por_fecha('2024-06-01', '2024-07-31');
