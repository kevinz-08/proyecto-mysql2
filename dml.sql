-- Inserccion de datos
-- 1. Tipos de tarjeta
INSERT INTO Tipos_Tarjeta (codigo_tipo, nombre_tipo, descripcion, edad_minima, edad_maxima, ingresos_minimos, monto_minimo_apertura, monto_maximo_apertura, cuota_base_mensual, tasa_interes, beneficios) VALUES
('JOV', 'Joven', 'tarjeta diseñada para jovenes entre 18 y 25 años', 18, 25, 500000, 50000, 500000, 8000, 1.5, 'Descuentos en cines, restaurantes y tiendas de tecnologia'),
('NOM', 'Nómina', 'tarjeta para empleados con nomina domiciliada', 18, 65, 1000000, 100000, 2000000, 12000, 1.2, 'Sin cuota de manejo por domiciliacion de nómina'),
('VCL', 'Visa Clásica', 'tarjeta Visa con beneficios basicos', 21, 75, 1500000, 200000, 3000000, 15000, 1.8, 'Aceptacion internacional, seguros básicos'),
('VGO', 'Visa Gold', 'tarjeta Visa con beneficios premium', 25, 75, 3000000, 500000, 8000000, 25000, 1.6, 'Sala VIP aeropuertos, seguros de viaje, concierge'),
('VPL', 'Visa Platinum', 'tarjeta Visa de alta gama', 30, 75, 6000000, 1000000, 20000000, 35000, 1.4, 'Beneficios premium, cash back, asistencia 24/7');

-- 2. Niveles de descuento
INSERT INTO niveles_descuento (codigo_descuento, nombre_descuento, descripcion, porcentaje_descuento, monto_minimo_requerido, monto_maximo_aplicable, fecha_inicio) VALUES
('BAS', 'Básico', 'Sin descuento aplicable', 0.00, 0, 999999999, '2024-01-01'),
('PLA', 'Platino', 'Descuento para clientes con montos medios', 15.00, 300000, 799999, '2024-01-01'),
('DIA', 'Diamante', 'Descuento para clientes con montos altos', 25.00, 800000, 1499999, '2024-01-01'),
('VIP', 'VIP', 'Descuento máximo para clientes premium', 35.00, 1500000, 999999999, '2024-01-01'),
('ESP', 'Especial', 'Descuento promocional temporal', 20.00, 250000, 999999999, '2024-01-01');

-- 3. Clientes
INSERT INTO Clientes (numero_cuenta, tipo_documento, numero_documento, nombres, apellidos, fecha_nacimiento, telefono, email, direccion, ciudad, departamento, codigo_postal, ocupacion, ingresos_mensuales, estado) VALUES
('1100457890', 'CC', '1012345678', 'Juan', 'Pérez', '1995-06-15', '3123456789', 'juan.perez@email.com', 'Calle 123 #45-67', 'Bogotá', 'Cundinamarca', '110111', 'Desarrollador', 3500000, 'Activo'),
('1100457891', 'CC', '1023456789', 'María', 'Rodríguez', '1988-09-10', '3001234567', 'maria.rodriguez@email.com', 'Carrera 10 #20-30', 'Medellín', 'Antioquia', '050010', 'Diseñadora Gráfica', 2500000, 'Activo');

-- 4. Tarjetas
INSERT INTO tarjetas (numero_tarjeta, cliente_id, tipo_tarjeta_id, descuento_id, monto_apertura, limite_credito, saldo_disponible, fecha_apertura, fecha_vencimiento, estado) VALUES
('4000123412341234', 1, 3, 3, 1200000, 3000000, 3000000, '2024-05-01', '2027-05-01', 'Activa'),
('4000987612345678', 2, 3, 2, 700000, 2000000, 2000000, '2024-06-01', '2027-06-01', 'Activa');

-- 5. Cuotas de manejo
INSERT INTO cuotas_manejo (tarjeta_id, periodo_mes, periodo_año, monto_base, porcentaje_descuento, valor_descuento, monto_final, fecha_vencimiento) VALUES
(1, 6, 2024, 15000, 25.00, 3750, 11250, '2024-06-30'),
(2, 6, 2024, 15000, 15.00, 2250, 12750, '2024-06-30');

-- 6. Historial de Pagos
INSERT INTO Historial_Pagos (cuota_id, numero_transaccion, monto_pagado, monto_pendiente, fecha_pago, metodo_pago, canal_pago, usuario_registro, ip_origen) VALUES
(1, 'TRX0001', 6000, 5250, '2024-06-10', 'PSE', 'Online', 'admin', '192.168.0.10'),
(2, 'TRX0002', 12750, 0, '2024-06-12', 'Tarjeta_Debito', 'App_Movil', 'admin', '192.168.0.11');

-- 3.1. Vamos a agregar mas variedad de clientes
INSERT INTO Clientes (numero_cuenta, tipo_documento, numero_documento, nombres, apellidos, fecha_nacimiento, telefono, email, direccion, ciudad, departamento, codigo_postal, ocupacion, ingresos_mensuales, estado) VALUES
('1100457892', 'CC', '1034567890', 'Andrés', 'Gómez', '1990-03-25', '3112345670', 'andres.gomez@ejemplo.com', 'Calle 20 #10-30', 'Cali', 'Valle del Cauca', '760001', 'Ingeniero Civil', 4200000, 'Activo'),
('1100457893', 'CE', 'AA123456', 'Luisa', 'Martínez', '1985-07-12', '3209876543', 'luisa.martinez@ejemplo.com', 'Carrera 15 #34-56', 'Cartagena', 'Bolívar', '130001', 'Abogada', 6500000, 'Inactivo'),
('1100457894', 'CC', '1045678912', 'Camilo', 'Ríos', '2000-11-08', '3105553333', 'camilo.rios@ejemplo.com', 'Av. Siempre Viva #100-01', 'Bucaramanga', 'Santander', '680001', 'Estudiante', 850000, 'Activo'),
('1100457895', 'NIT', '800123456', 'Empresa ABC S.A.S.', '', '1999-01-01', '6014567890', 'contacto@empresaabc.com', 'Zona Industrial KM 5', 'Medellín', 'Antioquia', '050010', 'Empresa', 25000000, 'Activo'),
('1100457896', 'CC', '1056789012', 'Tatiana', 'Vargas', '1992-09-18', '3004567890', 'tatiana.vargas@ejemplo.com', 'Calle 45 #23-17', 'Pereira', 'Risaralda', '660001', 'Arquitecta', 3700000, 'Activo'),
('1100457897', 'CE', 'BB987654', 'José', 'Torres', '1987-05-03', '3157896541', 'jose.torres@ejemplo.com', 'Carrera 9 #89-20', 'Cúcuta', 'Norte de Santander', '540001', 'Técnico Electricista', 2800000, 'Bloqueado'),
('1100457898', 'CC', '1067890123', 'Diana', 'López', '1999-12-30', '3012345671', 'diana.lopez@ejemplo.com', 'Calle 1 #2-3', 'Neiva', 'Huila', '410001', 'Docente', 3200000, 'Activo'),
('1100457899', 'CC', '1078901234', 'Carlos', 'Mejía', '1994-04-21', '3229876543', 'carlos.mejia@ejemplo.com', 'Carrera 80 #45-60', 'Villavicencio', 'Meta', '500001', 'Agrónomo', 2100000, 'Suspendido'),
('1100457900', 'CC', '1089012345', 'Laura', 'Moreno', '1998-08-05', '3123456789', 'laura.moreno@ejemplo.com', 'Calle 12 #34-56', 'Manizales', 'Caldas', '170001', 'Diseñadora UX', 4500000, 'Activo'),
('1100457901', 'CC', '1090123456', 'Felipe', 'Castro', '1983-01-19', '3167890123', 'felipe.castro@ejemplo.com', 'Av. 30 #25-55', 'Barranquilla', 'Atlántico', '080001', 'Contador', 3900000, 'Activo');

-- 3.2 Vamos a modificar la fecha de registro

UPDATE Clientes
SET fecha_registro = '2023-11-14 10:25:00'
WHERE numero_cuenta = '1100457892';

UPDATE Clientes
SET fecha_registro = '2024-01-09 08:45:00'
WHERE numero_cuenta = '1100457893';

UPDATE Clientes
SET fecha_registro = '2025-03-22 14:10:00'
WHERE numero_cuenta = '1100457894';

UPDATE Clientes
SET fecha_registro = '2024-10-01 09:00:00'
WHERE numero_cuenta = '1100457895';

UPDATE Clientes
SET fecha_registro = '2024-05-17 16:32:00'
WHERE numero_cuenta = '1100457896';

UPDATE Clientes
SET fecha_registro = '2023-09-27 12:05:00'
WHERE numero_cuenta = '1100457897';

UPDATE Clientes
SET fecha_registro = '2025-01-03 11:45:00'
WHERE numero_cuenta = '1100457898';

UPDATE Clientes
SET fecha_registro = '2024-07-21 19:20:00'
WHERE numero_cuenta = '1100457899';

UPDATE Clientes
SET fecha_registro = '2024-12-12 07:35:00'
WHERE numero_cuenta = '1100457900';

UPDATE Clientes
SET fecha_registro = '2023-08-02 13:15:00'
WHERE numero_cuenta = '1100457901';

-- 3.3 vamos a modificar la ultima vez de acceso de los clientes
UPDATE Clientes
SET ultimo_acceso = '2025-06-22 08:12:00'
WHERE numero_cuenta = '1100457892';

UPDATE Clientes
SET ultimo_acceso = '2025-05-14 17:35:00'
WHERE numero_cuenta = '1100457893';

UPDATE Clientes
SET ultimo_acceso = '2025-06-20 13:05:00'
WHERE numero_cuenta = '1100457894';

UPDATE Clientes
SET ultimo_acceso = '2025-04-30 09:00:00'
WHERE numero_cuenta = '1100457895';

UPDATE Clientes
SET ultimo_acceso = '2025-06-18 22:50:00'
WHERE numero_cuenta = '1100457896';

UPDATE Clientes
SET ultimo_acceso = '2024-12-10 10:45:00'
WHERE numero_cuenta = '1100457897';

UPDATE Clientes
SET ultimo_acceso = '2025-06-21 06:40:00'
WHERE numero_cuenta = '1100457898';

UPDATE Clientes
SET ultimo_acceso = '2025-03-15 14:20:00'
WHERE numero_cuenta = '1100457899';

UPDATE Clientes
SET ultimo_acceso = '2025-06-19 19:30:00'
WHERE numero_cuenta = '1100457900';

UPDATE Clientes
SET ultimo_acceso = '2025-01-27 12:15:00'
WHERE numero_cuenta = '1100457901';

UPDATE Clientes
SET ultimo_acceso = '2025-06-01 22:05:00'
WHERE numero_cuenta = 1100457890;

UPDATE Clientes
SET ultimo_acceso = '2025-03-26 10:14:00'
WHERE numero_cuenta = 1100457891;

-- 3.4 vamos a agregar a algunas observaciones 
UPDATE Clientes
SET observaciones = 'Cliente con perfil estudiantil; ingresos limitados, potencial para plan joven.'
WHERE numero_cuenta = '1100457894';

UPDATE Clientes
SET observaciones = 'Bloqueo preventivo por actividad sospechosa. Requiere revisión manual.'
WHERE numero_cuenta = '1100457897';

UPDATE Clientes
SET observaciones = 'Cliente corporativo con alto volumen de ingresos. Priorizar seguimiento comercial.'
WHERE numero_cuenta = '1100457895';

UPDATE Clientes
SET observaciones = 'Cliente suspendido por mora en cuotas de manejo. Requiere contacto del área de cartera.'
WHERE numero_cuenta = '1100457899';

UPDATE Clientes
SET observaciones = 'Perfil de cliente premium. Posible candidato a tarjeta Visa Gold o Platinum.'
WHERE numero_cuenta = '1100457893';

-- modificacion de las tarjetas para dar mas variedad
INSERT INTO tarjetas (numero_tarjeta, cliente_id, tipo_tarjeta_id, descuento_id, monto_apertura, limite_credito, saldo_disponible, fecha_apertura, fecha_vencimiento, fecha_ultimo_uso, pin_encriptado, estado, motivo_bloqueo, observaciones) VALUES
('4532-1234-5678-9012', 3, 1, 2, 60000, 500000, 480000, '2024-01-15', '2026-01-15', '2025-06-01 09:00:00', 'pin01', 'Activa', NULL, 'Tarjeta joven aprobada sin inconvenientes'),
('4532-9876-5432-1098', 4, 3, 3, 250000, 1800000, 1200000, '2023-11-20', '2026-11-20', '2025-06-22 11:00:00', 'pin02', 'Activa', NULL, NULL),
('4532-5555-6666-7777', 5, 1, 1, 50000, 200000, 180000, '2025-02-01', '2027-02-01', NULL, 'pin03', 'Activa', NULL, 'Tarjeta estudiantil asignada recientemente'),
('4532-8888-9999-0000', 6, 5, 5, 2000000, 10000000, 8000000, '2024-03-10', '2029-03-10', '2025-06-18 14:45:00', 'pin04', 'Activa', NULL, 'Tarjeta corporativa alta gama'),
('4532-4444-1111-2222', 7, 2, 2, 120000, 1000000, 900000, '2023-06-25', '2026-06-25', '2025-06-20 08:12:00', 'pin05', 'Suspendida', NULL, 'Suspendida por mora'),
('4532-3333-6666-9999', 8, 4, 4, 700000, 6000000, 2000000, '2022-09-01', '2025-09-01', '2024-12-30 17:00:00', 'pin06', 'Bloqueada', 'Intentos de acceso inválidos', NULL),
('4532-1010-2020-3030', 9, 3, 3, 200000, 1500000, 1450000, '2023-12-01', '2026-12-01', '2025-06-15 19:00:00', 'pin07', 'Activa', NULL, NULL),
('4532-1111-2222-3333', 10, 2, 1, 100000, 700000, 700000, '2024-07-10', '2027-07-10', NULL, 'pin08', 'Cancelada', 'Solicitud del cliente', 'Saldo en cero'),
('4532-4444-5555-6666', 11, 5, 4, 1500000, 9000000, 8500000, '2023-05-20', '2026-05-20', '2025-06-21 13:30:00', 'pin09', 'Activa', NULL, 'Cliente premium con excelente historial'),
('4532-7777-8888-9999', 12, 4, 3, 1000000, 5000000, 4500000, '2025-01-01', '2028-01-01', NULL, 'pin10', 'Vencida', NULL, 'No se ha renovado');

-- vamos a modular el numero de tarjeta de una mejor manera (los primeros dos son diferentes al resto)
UPDATE tarjetas
SET pin_encriptado = 'pin01'
WHERE cliente_id = '1';

UPDATE tarjetas
SET numero_tarjeta = '4532-3141-5926-5358'
WHERE cliente_id = '1';

UPDATE tarjetas
SET pin_encriptado = 'pin02'
WHERE cliente_id = '2';

UPDATE tarjetas
SET numero_tarjeta = '4532-2718-2818-2845'
WHERE cliente_id = '2';

-- vamos a corregir un error de pines encriptados
UPDATE tarjetas
SET pin_encriptado = 'pin03'
WHERE cliente_id = '3';

UPDATE tarjetas
SET pin_encriptado = 'pin04'
WHERE cliente_id = '4';

UPDATE tarjetas
SET pin_encriptado = 'pin05'
WHERE cliente_id = '5';

UPDATE tarjetas
SET pin_encriptado = 'pin06'
WHERE cliente_id = '6';

UPDATE tarjetas
SET pin_encriptado = 'pin07'
WHERE cliente_id = '7';

UPDATE tarjetas
SET pin_encriptado = 'pin08'
WHERE cliente_id = '8';

UPDATE tarjetas
SET pin_encriptado = 'pin09'
WHERE cliente_id = '9';

UPDATE tarjetas
SET pin_encriptado = 'pin10'
WHERE cliente_id = '10';

UPDATE tarjetas
SET pin_encriptado = 'pin11'
WHERE cliente_id = '11';

UPDATE tarjetas
SET pin_encriptado = 'pin12'
WHERE cliente_id = '12';

-- modificacion de las cuotas de manejo para dar mas variedad
INSERT INTO cuotas_manejo (tarjeta_id, periodo_mes, periodo_año, monto_base, porcentaje_descuento, valor_descuento, monto_final, fecha_vencimiento, dias_mora, interes_mora, monto_total_con_mora, estado) VALUES
(3, 6, 2024, 8000, 0.00, 0, 8000, '2024-06-30', 0, 0, 8000, 'Pagada'),

(4, 6, 2024, 35000, 20.00, 7000, 28000, '2024-06-30', 5, 1800, 29800, 'Vencida'),

(5, 6, 2024, 12000, 10.00, 1200, 10800, '2024-06-30', 0, 0, 10800, 'Pendiente'),

(6, 6, 2024, 25000, 35.00, 8750, 16250, '2024-06-30', 15, 3500, 19750, 'Vencida'),

(7, 6, 2024, 15000, 15.00, 2250, 12750, '2024-06-30', 0, 0, 12750, 'Pagada'),

(8, 6, 2024, 12000, 0.00, 0, 12000, '2024-06-30', 2, 500, 12500, 'Condonada'),

(9, 6, 2024, 35000, 25.00, 8750, 26250, '2024-06-30', 0, 0, 26250, 'Pendiente'),

(10, 6, 2024, 25000, 15.00, 3750, 21250, '2024-06-30', 0, 0, 21250, 'Pendiente'),

(11, 6, 2024, 15000, 5.00, 750, 14250, '2024-06-30', 1, 200, 14450, 'Pagada'),

(12, 6, 2024, 25000, 0.00, 0, 25000, '2024-06-30', 0, 0, 25000, 'Pagada');

UPDATE cuotas_manejo
SET interes_mora = 1800,
    monto_total_con_mora = monto_final + 1800
WHERE tarjeta_id = 1 AND periodo_mes = 6 AND periodo_año = 2024;

UPDATE cuotas_manejo
SET interes_mora = 1200,
    monto_total_con_mora = monto_final + 1200
WHERE tarjeta_id = 2 AND periodo_mes = 6 AND periodo_año = 2024;

-- modificacion o inserccion de el historial de pagos para dar variedad
INSERT INTO historial_pagos (cuota_id, numero_transaccion, monto_pagado, monto_pendiente, fecha_pago, metodo_pago, referencia_pago, banco_origen, canal_pago, usuario_registro, ip_origen, estado_transaccion, comision, observaciones) VALUES
(1, 'TXN0001', 11250, 0, '2024-06-25 10:30:00', 'Transferencia', 'REF-112233', 'Banco CL', 'Online', 'juan.perez', '192.168.1.10', 'Exitoso', 0, 'Pago completo sin inconvenientes');

INSERT INTO historial_pagos (cuota_id, numero_transaccion, monto_pagado, monto_pendiente, fecha_pago, metodo_pago, referencia_pago, banco_origen, canal_pago, usuario_registro, ip_origen, estado_transaccion, comision, observaciones) VALUES
(2, 'TXN0002', 10000, 2750, '2024-06-26 14:15:00', 'PSE', 'REF-445566', 'Banco CL', 'App_Movil', 'maria.rodriguez', '192.168.1.20', 'Exitoso', 0, 'Pago parcial, pendiente de abono restante');

INSERT INTO historial_pagos (cuota_id, numero_transaccion, monto_pagado, monto_pendiente, fecha_pago, metodo_pago, referencia_pago, banco_origen, canal_pago, usuario_registro, ip_origen, estado_transaccion, comision, observaciones) VALUES
(3, 'TXN0003', 8000, 0, '2024-06-20 09:30:00', 'Debito_Automatico', 'REF-3001', 'Banco CL', 'App_Movil', 'usuario3', '192.168.0.3', 'Exitoso', 0, 'Pago programado exitosamente'),
(4, 'TXN0004', 15000, 14800, '2024-07-01 10:15:00', 'Transferencia', 'REF-4002', 'Bancolombia', 'Online', 'usuario4', '192.168.0.4', 'Exitoso', 0, 'Pago parcial tras vencimiento'),
(5, 'TXN0005', 0, 10800, '2024-06-30 00:00:00', 'PSE', 'REF-5003', 'Davivienda', 'Online', 'usuario5', '192.168.0.5', 'Pendiente', 0, 'Transacción en espera de confirmación'),
(6, 'TXN0006', 19750, 0, '2024-07-05 18:45:00', 'Efectivo', 'REF-6004', 'Banco CL', 'Sucursal', 'usuario6', '192.168.0.6', 'Exitoso', 0, 'Pago realizado luego de mora'),
(7, 'TXN0007', 12750, 0, '2024-06-24 11:00:00', 'Debito_Automatico', 'REF-7005', 'Banco CL', 'App_Movil', 'usuario7', '192.168.0.7', 'Exitoso', 0, NULL),
(8, 'TXN0008', 0, 12000, '2024-06-28 09:15:00', 'Tarjeta_Debito', 'REF-8006', 'Banco CL', 'Online', 'usuario8', '192.168.0.8', 'Fallido', 0, 'Error en la validación del pago'),
(9, 'TXN0009', 15000, 11250, '2024-06-26 14:40:00', 'PSE', 'REF-9007', 'Banco de Bogotá', 'App_Movil', 'usuario9', '192.168.0.9', 'Exitoso', 0, 'Cliente realizó abono parcial'),
(10, 'TXN0010', 21250, 0, '2024-06-23 10:00:00', 'Transferencia', 'REF-10008', 'Banco CL', 'Online', 'usuario10', '192.168.0.10', 'Exitoso', 0, NULL),
(11, 'TXN0011', 14450, 0, '2024-06-24 16:20:00', 'Corresponsal', 'REF-11009', 'Banco AV Villas', 'Sucursal', 'usuario11', '192.168.0.11', 'Exitoso', 450, 'Incluye comisión del corresponsal'),
(12, 'TXN0012', 25000, 0, '2024-06-25 12:45:00', 'Debito_Automatico', 'REF-12010', 'Banco CL', 'App_Movil', 'usuario12', '192.168.0.12', 'Exitoso', 0, NULL);

-- modificacion de el pago id - correcion
UPDATE historial_pagos
SET pago_id = 3
WHERE cuota_id = 3;

UPDATE historial_pagos
SET pago_id = 4
WHERE cuota_id = 4;

UPDATE historial_pagos
SET pago_id = 5
WHERE cuota_id = 5;

UPDATE historial_pagos
SET pago_id = 6
WHERE cuota_id = 6;

UPDATE historial_pagos
SET pago_id = 7
WHERE cuota_id = 7;

UPDATE historial_pagos
SET pago_id = 8
WHERE cuota_id = 8;

UPDATE historial_pagos
SET pago_id = 9
WHERE cuota_id = 9;

UPDATE historial_pagos
SET pago_id = 10
WHERE cuota_id = 10;

UPDATE historial_pagos
SET pago_id = 11
WHERE cuota_id = 11;

UPDATE historial_pagos
SET pago_id = 12
WHERE cuota_id = 12;