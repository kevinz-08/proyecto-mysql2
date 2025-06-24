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