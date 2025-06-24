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

-- 7. Vamos a agregar mas variedad de clientes
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