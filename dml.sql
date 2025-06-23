-- Inserccion de datos
-- 1. Tipos de Tarjeta
INSERT INTO Tipos_Tarjeta (codigo_tipo, nombre_tipo, descripcion, edad_minima, edad_maxima, ingresos_minimos, monto_minimo_apertura, monto_maximo_apertura, cuota_base_mensual, tasa_interes, beneficios) VALUES
('JOV', 'Joven', 'tarjeta diseñada para jovenes entre 18 y 25 años', 18, 25, 500000, 50000, 500000, 8000, 1.5, 'Descuentos en cines, restaurantes y tiendas de tecnologia'),
('NOM', 'Nómina', 'tarjeta para empleados con nomina domiciliada', 18, 65, 1000000, 100000, 2000000, 12000, 1.2, 'Sin cuota de manejo por domiciliacion de nómina'),
('VCL', 'Visa Clásica', 'tarjeta Visa con beneficios basicos', 21, 75, 1500000, 200000, 3000000, 15000, 1.8, 'Aceptacion internacional, seguros básicos'),
('VGO', 'Visa Gold', 'tarjeta Visa con beneficios premium', 25, 75, 3000000, 500000, 8000000, 25000, 1.6, 'Sala VIP aeropuertos, seguros de viaje, concierge'),
('VPL', 'Visa Platinum', 'tarjeta Visa de alta gama', 30, 75, 6000000, 1000000, 20000000, 35000, 1.4, 'Beneficios premium, cash back, asistencia 24/7');