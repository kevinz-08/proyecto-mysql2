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