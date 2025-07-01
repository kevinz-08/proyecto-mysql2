USE BancoCL;
-- 1er trigger: registrar la creación de nuevos clientes en la tabla de auditoría.
CREATE TRIGGER trg_insert_cliente
AFTER INSERT ON Clientes
FOR EACH ROW
INSERT INTO Auditoria_Operaciones (
  tabla_afectada, operacion, registro_id, datos_nuevos, usuario, descripcion
) VALUES (
  'Clientes', 'INSERT', NEW.cliente_id,
  JSON_OBJECT('nombres', NEW.nombres, 'apellidos', NEW.apellidos),
  'sistema', 'Se registró un nuevo cliente'
);
-- 2do trigger: auditar cuando se actualiza el ingreso mensual de un cliente
CREATE TRIGGER trg_update_ingresos
AFTER UPDATE ON Clientes
FOR EACH ROW
IF OLD.ingresos_mensuales <> NEW.ingresos_mensuales THEN
  INSERT INTO Auditoria_Operaciones (
    tabla_afectada, operacion, registro_id, datos_anteriores, datos_nuevos, usuario, descripcion
  ) VALUES (
    'Clientes', 'UPDATE', NEW.cliente_id,
    JSON_OBJECT('ingresos_mensuales', OLD.ingresos_mensuales),
    JSON_OBJECT('ingresos_mensuales', NEW.ingresos_mensuales),
    'sistema', 'Cambio en los ingresos mensuales del cliente'
  );
END IF;
-- 3er trigger: validar que la tarjeta no se bloquee sin un motivo.
CREATE TRIGGER trg_validar_bloqueo_tarjeta
BEFORE UPDATE ON Tarjetas
FOR EACH ROW
IF NEW.estado = 'Bloqueada' AND (NEW.motivo_bloqueo IS NULL OR NEW.motivo_bloqueo = '') THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Debe especificar un motivo para bloquear la tarjeta.';
END IF;
-- 4to trigger: registrar el cambio de estado de una tarjeta en la auditoria
CREATE TRIGGER trg_estado_tarjeta
AFTER UPDATE ON Tarjetas
FOR EACH ROW
IF OLD.estado <> NEW.estado THEN
  INSERT INTO Auditoria_Operaciones (
    tabla_afectada, operacion, registro_id, datos_anteriores, datos_nuevos, usuario, descripcion
  ) VALUES (
    'Tarjetas', 'UPDATE', NEW.tarjeta_id,
    JSON_OBJECT('estado', OLD.estado),
    JSON_OBJECT('estado', NEW.estado),
    'sistema', 'Cambio de estado de la tarjeta'
  );
END IF;
-- 5to trigger: registrar inserción de una nueva tarjeta.
CREATE TRIGGER trg_insert_tarjeta
AFTER INSERT ON Tarjetas
FOR EACH ROW
INSERT INTO Auditoria_Operaciones (
  tabla_afectada, operacion, registro_id, datos_nuevos, usuario, descripcion
) VALUES (
  'Tarjetas', 'INSERT', NEW.tarjeta_id,
  JSON_OBJECT('numero_tarjeta', NEW.numero_tarjeta),
  'sistema', 'Se creó una nueva tarjeta'
);
-- 6to trigger: Evitar que se elimine un historial de pago.
CREATE TRIGGER trg_prevenir_delete_pago
BEFORE DELETE ON Historial_Pagos
FOR EACH ROW
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se permite eliminar pagos del historial.';

-- 7mo trigger: Verificar que el porcentaje de descuento de una cuota sea válido (0 a 100).
CREATE TRIGGER trg_validar_descuento
BEFORE INSERT ON Cuotas_Manejo
FOR EACH ROW
IF NEW.porcentaje_descuento < 0 OR NEW.porcentaje_descuento > 100 THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Porcentaje de descuento inválido.';
END IF;

-- 8vo trigger: auditar el cambio de estado de una cuota de manejo
CREATE TRIGGER trg_estado_cuota
AFTER UPDATE ON Cuotas_Manejo
FOR EACH ROW
IF OLD.estado <> NEW.estado THEN
  INSERT INTO Auditoria_Operaciones (
    tabla_afectada, operacion, registro_id, datos_anteriores, datos_nuevos, usuario, descripcion
  ) VALUES (
    'Cuotas_Manejo', 'UPDATE', NEW.cuota_id,
    JSON_OBJECT('estado', OLD.estado),
    JSON_OBJECT('estado', NEW.estado),
    'sistema', 'Cambio de estado en cuota de manejo'
  );
END IF;

-- 9no trigger: Auditar pago exitoso registrado en historial de pagos
CREATE TRIGGER trg_pago_exitoso
AFTER INSERT ON Historial_Pagos
FOR EACH ROW
IF NEW.estado_transaccion = 'Exitoso' THEN
  INSERT INTO Auditoria_Operaciones (
    tabla_afectada, operacion, registro_id, datos_nuevos, usuario, descripcion
  ) VALUES (
    'Historial_Pagos', 'INSERT', NEW.pago_id,
    JSON_OBJECT('monto_pagado', NEW.monto_pagado, 'cuota_id', NEW.cuota_id),
    'sistema', 'Pago exitoso registrado'
  );
END IF;

-- 10mo trigger: Registrar eliminación de una cuota en la auditoría.
CREATE TRIGGER trg_delete_cuota
AFTER DELETE ON Cuotas_Manejo
FOR EACH ROW
INSERT INTO Auditoria_Operaciones (
  tabla_afectada, operacion, registro_id, datos_anteriores, usuario, descripcion
) VALUES (
  'Cuotas_Manejo', 'DELETE', OLD.cuota_id,
  JSON_OBJECT('monto_final', OLD.monto_final),
  'sistema', 'Se eliminó una cuota de manejo'
);


--- TRIGGER 11: Actualizar Saldo Disponible Después de un Pago
-- Se dispara después de un pago exitoso para aumentar el saldo disponible en la tarjeta.
DELIMITER $$
DROP TRIGGER IF EXISTS tr_actualizar_saldo_disponible;
CREATE TRIGGER tr_actualizar_saldo_disponible
AFTER INSERT ON historial_pagos
FOR EACH ROW
BEGIN
    DECLARE v_tarjeta_id INT;

    IF NEW.estado_transaccion = 'Exitoso' THEN
        -- Encontrar la tarjeta asociada a la cuota que se pagó.
        SELECT tarjeta_id INTO v_tarjeta_id
        FROM cuotas_manejo
        WHERE cuota_id = NEW.cuota_id;

        -- Actualizar el saldo disponible en la tabla de tarjetas.
        IF v_tarjeta_id IS NOT NULL THEN
            UPDATE tarjetas
            SET saldo_disponible = saldo_disponible + NEW.monto_pagado
            WHERE tarjeta_id = v_tarjeta_id;
        END IF;
    END IF;
END$$
DELIMITER ;
-- Para probar: Inserte un pago exitoso y verifique que el saldo de la tarjeta correspondiente aumente.


--- TRIGGER 12: Validar Idoneidad del Cliente para una Tarjeta
-- Se dispara antes de asignar una tarjeta para verificar si el cliente cumple los requisitos.
DELIMITER $$
DROP TRIGGER IF EXISTS tr_validar_idoneidad_cliente;
CREATE TRIGGER tr_validar_idoneidad_cliente
BEFORE INSERT ON tarjetas
FOR EACH ROW
BEGIN
    DECLARE v_edad INT;
    DECLARE v_ingresos_cliente DECIMAL(12,2);
    DECLARE v_edad_minima INT;
    DECLARE v_ingresos_minimos DECIMAL(10,2);

    -- Obtener datos del cliente
    SELECT TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()), ingresos_mensuales
    INTO v_edad, v_ingresos_cliente
    FROM clientes WHERE cliente_id = NEW.cliente_id;

    -- Obtener requisitos del tipo de tarjeta
    SELECT edad_minima, ingresos_minimos
    INTO v_edad_minima, v_ingresos_minimos
    FROM tipos_tarjeta WHERE tipo_tarjeta_id = NEW.tipo_tarjeta_id;

    -- Validar edad
    IF v_edad < v_edad_minima THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El cliente no cumple con la edad mínima requerida para esta tarjeta.';
    END IF;

    -- Validar ingresos
    IF v_ingresos_cliente < v_ingresos_minimos THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El cliente no cumple con los ingresos mínimos requeridos para esta tarjeta.';
    END IF;
END$$
DELIMITER ;
-- Para probar: Intente insertar una tarjeta para un cliente que no cumpla la edad o los ingresos definidos en tipos_tarjeta.


--- TRIGGER 13: Resetear Intentos de PIN al Reactivar una Tarjeta
-- Se dispara antes de actualizar una tarjeta para resetear los intentos fallidos si se reactiva.
DELIMITER $$
DROP TRIGGER IF EXISTS tr_resetear_intentos_pin;
CREATE TRIGGER tr_resetear_intentos_pin
BEFORE UPDATE ON tarjetas
FOR EACH ROW
BEGIN
    -- Si la tarjeta estaba bloqueada y ahora se está activando...
    IF OLD.estado = 'Bloqueada' AND NEW.estado = 'Activa' THEN
        -- ...reseteamos el contador de intentos fallidos a 0.
        SET NEW.intentos_fallidos = 0;
    END IF;
END$$
DELIMITER ;
-- Para probar: Bloquee una tarjeta (aumentando sus intentos fallidos), luego actualice su estado a 'Activa' y verifique que los intentos vuelvan a 0.


--- TRIGGER 14: Actualizar Fecha de Último Uso de la Tarjeta
-- Se dispara después de un pago para mantener un registro de la actividad de la tarjeta.
DELIMITER $$
DROP TRIGGER IF EXISTS tr_actualizar_fecha_ultimo_uso;
CREATE TRIGGER tr_actualizar_fecha_ultimo_uso
AFTER INSERT ON historial_pagos
FOR EACH ROW
BEGIN
    DECLARE v_tarjeta_id INT;

    IF NEW.estado_transaccion = 'Exitoso' THEN
        -- Encontrar la tarjeta asociada.
        SELECT tarjeta_id INTO v_tarjeta_id
        FROM cuotas_manejo
        WHERE cuota_id = NEW.cuota_id;

        -- Actualizar la fecha de último uso en la tabla de tarjetas.
        IF v_tarjeta_id IS NOT NULL THEN
            UPDATE tarjetas
            SET fecha_ultimo_uso = NEW.fecha_pago
            WHERE tarjeta_id = v_tarjeta_id;
        END IF;
    END IF;
END$$
DELIMITER ;
-- Para probar: Inserte un pago y verifique que la columna 'fecha_ultimo_uso' de la tarjeta se actualice.


--- TRIGGER 15: Prevenir Cancelación de Tarjeta con Deuda Pendiente
-- Se dispara antes de actualizar una tarjeta para impedir su cancelación si tiene deudas.
DELIMITER $$
DROP TRIGGER IF EXISTS tr_prevenir_cancelacion_con_deuda;
CREATE TRIGGER tr_prevenir_cancelacion_con_deuda
BEFORE UPDATE ON tarjetas
FOR EACH ROW
BEGIN
    DECLARE v_deuda_pendiente INT;

    -- Solo actuar si se intenta cancelar la tarjeta.
    IF NEW.estado = 'Cancelada' AND OLD.estado <> 'Cancelada' THEN
        -- Contar si existen cuotas pendientes o vencidas para esta tarjeta.
        SELECT COUNT(*) INTO v_deuda_pendiente
        FROM cuotas_manejo
        WHERE tarjeta_id = OLD.tarjeta_id
          AND estado IN ('Pendiente', 'Vencida');

        -- Si hay deuda, se cancela la operación.
        IF v_deuda_pendiente > 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No se puede cancelar la tarjeta. Existen cuotas pendientes o vencidas.';
        END IF;
    END IF;
END$$
DELIMITER ;
-- Para probar: Intente actualizar el estado de una tarjeta a 'Cancelada' cuando esta tenga cuotas en estado 'Pendiente' o 'Vencida'.


--- TRIGGER 16: Marcar Cuota como 'Pagada' Automáticamente
-- Se dispara después de un pago para verificar si la cuota ya fue saldada y actualizar su estado.
DELIMITER $$
DROP TRIGGER IF EXISTS tr_marcar_cuota_pagada;
CREATE TRIGGER tr_marcar_cuota_pagada
AFTER INSERT ON historial_pagos
FOR EACH ROW
BEGIN
    DECLARE v_total_pagado DECIMAL(10, 2);
    DECLARE v_monto_adeudado DECIMAL(10, 2);

    IF NEW.estado_transaccion = 'Exitoso' THEN
        -- Sumar todos los pagos para esa cuota
        SELECT IFNULL(SUM(monto_pagado), 0) INTO v_total_pagado
        FROM historial_pagos
        WHERE cuota_id = NEW.cuota_id AND estado_transaccion = 'Exitoso';

        -- Obtener el monto total que se debe pagar por la cuota
        SELECT IFNULL(monto_total_con_mora, monto_final) INTO v_monto_adeudado
        FROM cuotas_manejo
        WHERE cuota_id = NEW.cuota_id;

        -- Si el total pagado cubre la deuda, se marca como 'Pagada'
        IF v_total_pagado >= v_monto_adeudado THEN
            UPDATE cuotas_manejo SET estado = 'Pagada' WHERE cuota_id = NEW.cuota_id;
        END IF;
    END IF;
END$$
DELIMITER ;
-- Para probar: Realice pagos a una cuota hasta que la suma de los montos pagados iguale o supere el monto_final de la cuota. Verifique que el estado de la cuota cambie a 'Pagada'.


--- TRIGGER 17: Limitar Aumentos de Límite de Crédito
-- Se dispara antes de una actualización en 'tarjetas' para prevenir aumentos de crédito superiores al 25%.
DELIMITER $$
DROP TRIGGER IF EXISTS tr_limitar_aumento_credito;
CREATE TRIGGER tr_limitar_aumento_credito
BEFORE UPDATE ON tarjetas
FOR EACH ROW
BEGIN
    DECLARE v_porcentaje_aumento DECIMAL(5, 2);

    -- Solo actuar si el límite de crédito está aumentando.
    IF NEW.limite_credito > OLD.limite_credito THEN
        -- Calcular el porcentaje de aumento.
        SET v_porcentaje_aumento = ((NEW.limite_credito - OLD.limite_credito) / OLD.limite_credito) * 100;

        -- Si el aumento supera el 25%, se bloquea la operación.
        IF v_porcentaje_aumento > 25.00 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El aumento del límite de crédito no puede superar el 25% en una sola operación sin aprobación especial.';
        END IF;
    END IF;
END$$
DELIMITER ;
-- Para probar: Intente actualizar el límite de crédito de una tarjeta con un aumento mayor al 25% del valor actual.


--- TRIGGER 18: Asegurar Cálculo Correcto en Nuevas Cuotas
-- Se dispara antes de insertar una cuota para auto-corregir los cálculos de descuento y monto final.
DELIMITER $$
DROP TRIGGER IF EXISTS tr_autocalcular_nueva_cuota;
CREATE TRIGGER tr_autocalcular_nueva_cuota
BEFORE INSERT ON cuotas_manejo
FOR EACH ROW
BEGIN
    DECLARE v_valor_descuento_calculado DECIMAL(8, 2);

    -- Recalcular el valor del descuento basado en el monto base y el porcentaje.
    SET v_valor_descuento_calculado = NEW.monto_base * (NEW.porcentaje_descuento / 100);
    SET NEW.valor_descuento = v_valor_descuento_calculado;

    -- Recalcular el monto final.
    SET NEW.monto_final = NEW.monto_base - v_valor_descuento_calculado;
END$$
DELIMITER ;
-- Para probar: Intente insertar una nueva cuota con valores incorrectos en 'valor_descuento' y 'monto_final'. Verifique que los valores guardados en la tabla sean los correctos.


--- TRIGGER 19: Suspender Tarjetas al Inactivar un Cliente
-- Se dispara después de actualizar un cliente para suspender sus tarjetas si el cliente es inactivado.
DELIMITER $$
DROP TRIGGER IF EXISTS tr_suspender_tarjetas_cliente_inactivo;
CREATE TRIGGER tr_suspender_tarjetas_cliente_inactivo
AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
    -- Solo actuar si el estado del cliente cambió y no es 'Activo'.
    IF OLD.estado <> NEW.estado AND NEW.estado IN ('Inactivo', 'Suspendido', 'Bloqueado') THEN
        UPDATE tarjetas
        SET estado = 'Suspendida', motivo_bloqueo = CONCAT('Suspendida automáticamente por cambio de estado del cliente a ', NEW.estado)
        WHERE cliente_id = NEW.cliente_id AND estado = 'Activa';
    END IF;
END$$
DELIMITER ;
-- Para probar: Cambie el estado de un cliente activo a 'Suspendido' y verifique que el estado de todas sus tarjetas activas cambie a 'Suspendida'.


--- TRIGGER 20: Prevenir Pagos Duplicados a Cuotas ya Pagadas
-- Se dispara antes de insertar un pago para evitar que se pague una cuota que ya está saldada.
DELIMITER $$
DROP TRIGGER IF EXISTS tr_prevenir_pago_a_cuota_saldada;
CREATE TRIGGER tr_prevenir_pago_a_cuota_saldada
BEFORE INSERT ON historial_pagos
FOR EACH ROW
BEGIN
    DECLARE v_estado_cuota VARCHAR(50);

    -- Obtener el estado actual de la cuota.
    SELECT estado INTO v_estado_cuota
    FROM cuotas_manejo
    WHERE cuota_id = NEW.cuota_id;

    -- Si la cuota ya está 'Pagada' o 'Condonada', bloquear la inserción del nuevo pago.
    IF v_estado_cuota IN ('Pagada', 'Condonada') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La cuota ya ha sido saldada. No se pueden registrar más pagos.';
    END IF;
END$$
DELIMITER ;
-- Para probar: Marque una cuota como 'Pagada' y luego intente insertar un nuevo pago en 'historial_pagos' para esa misma cuota_id.