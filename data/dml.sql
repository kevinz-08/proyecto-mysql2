-- INSERCCION DE DATOS
-- AREA ESTRUCTURADA Y CONSOLIDADA DE TODAS LAS ENTIDADES
-- 1. Tipos de tarjeta
INSERT INTO Tipos_Tarjeta (
    codigo_tipo, nombre_tipo, descripcion, edad_minima, edad_maxima,
    ingresos_minimos, monto_minimo_apertura, monto_maximo_apertura,
    cuota_base_mensual, tasa_interes, beneficios
) VALUES
('JOV', 'Joven', 'tarjeta diseñada para jovenes entre 18 y 25 años', 18, 25, 500000, 50000, 500000, 8000, 1.5, 'Descuentos en cines, restaurantes y tiendas de tecnologia'),
('NOM', 'Nómina', 'tarjeta para empleados con nomina domiciliada', 18, 65, 1000000, 100000, 2000000, 12000, 1.2, 'Sin cuota de manejo por domiciliacion de nómina'),
('VCL', 'Visa Clásica', 'tarjeta Visa con beneficios basicos', 21, 75, 1500000, 200000, 3000000, 15000, 1.8, 'Aceptacion internacional, seguros básicos'),
('VGO', 'Visa Gold', 'tarjeta Visa con beneficios premium', 25, 75, 3000000, 500000, 8000000, 25000, 1.6, 'Sala VIP aeropuertos, seguros de viaje, concierge'),
('VPL', 'Visa Platinum', 'tarjeta Visa de alta gama', 30, 75, 6000000, 1000000, 20000000, 35000, 1.4, 'Beneficios premium, cash back, asistencia 24/7');

-- 2. Niveles de descuento
INSERT INTO niveles_descuento (
    codigo_descuento, nombre_descuento, descripcion,
    porcentaje_descuento, monto_minimo_requerido,
    monto_maximo_aplicable, fecha_inicio
) VALUES
('BAS', 'Básico', 'Sin descuento aplicable', 0.00, 0, 999999999, '2024-01-01'),
('PLA', 'Platino', 'Descuento para clientes con montos medios', 15.00, 300000, 799999, '2024-01-01'),
('DIA', 'Diamante', 'Descuento para clientes con montos altos', 25.00, 800000, 1499999, '2024-01-01'),
('VIP', 'VIP', 'Descuento máximo para clientes premium', 35.00, 1500000, 999999999, '2024-01-01'),
('ESP', 'Especial', 'Descuento promocional temporal', 20.00, 250000, 999999999, '2024-01-01');

-- 3. Clientes
INSERT INTO Clientes (
    numero_cuenta, tipo_documento, numero_documento, nombres, apellidos,
    fecha_nacimiento, telefono, email, direccion, ciudad,
    departamento, codigo_postal, ocupacion, ingresos_mensuales, estado
) VALUES
('1100457890', 'CC', '1012345678', 'Juan', 'Pérez', '1995-06-15', '3123456789', 'juan.perez@email.com', 'Calle 123 #45-67', 'Bogotá', 'Cundinamarca', '110111', 'Desarrollador', 3500000, 'Activo'),
('1100457891', 'CC', '1023456789', 'María', 'Rodríguez', '1988-09-10', '3001234567', 'maria.rodriguez@email.com', 'Carrera 10 #20-30', 'Medellín', 'Antioquia', '050010', 'Diseñadora Gráfica', 2500000, 'Activo'),
('1100457892', 'CC', '1034567890', 'Andrés', 'Gómez', '1990-03-25', '3112345670', 'andres.gomez@ejemplo.com', 'Calle 20 #10-30', 'Cali', 'Valle del Cauca', '760001', 'Ingeniero Civil', 4200000, 'Activo'),
('1100457893', 'CE', 'AA123456', 'Luisa', 'Martínez', '1985-07-12', '3209876543', 'luisa.martinez@ejemplo.com', 'Carrera 15 #34-56', 'Cartagena', 'Bolívar', '130001', 'Abogada', 6500000, 'Inactivo'),
('1100457894', 'CC', '1045678912', 'Camilo', 'Ríos', '2000-11-08', '3105553333', 'camilo.rios@ejemplo.com', 'Av. Siempre Viva #100-01', 'Bucaramanga', 'Santander', '680001', 'Estudiante', 850000, 'Activo'),
('1100457895', 'NIT', '800123456', 'Empresa ABC S.A.S.', '', '1999-01-01', '6014567890', 'contacto@empresaabc.com', 'Zona Industrial KM 5', 'Medellín', 'Antioquia', '050010', 'Empresa', 25000000, 'Activo'),
('1100457896', 'CC', '1056789012', 'Tatiana', 'Vargas', '1992-09-18', '3004567890', 'tatiana.vargas@ejemplo.com', 'Calle 45 #23-17', 'Pereira', 'Risaralda', '660001', 'Arquitecta', 3700000, 'Activo'),
('1100457897', 'CE', 'BB987654', 'José', 'Torres', '1987-05-03', '3157896541', 'jose.torres@ejemplo.com', 'Carrera 9 #89-20', 'Cúcuta', 'Norte de Santander', '540001', 'Técnico Electricista', 2800000, 'Bloqueado'),
('1100457898', 'CC', '1067890123', 'Diana', 'López', '1999-12-30', '3012345671', 'diana.lopez@ejemplo.com', 'Calle 1 #2-3', 'Neiva', 'Huila', '410001', 'Docente', 3200000, 'Activo'),
('1100457899', 'CC', '1078901234', 'Carlos', 'Mejía', '1994-04-21', '3229876543', 'carlos.mejia@ejemplo.com', 'Carrera 80 #45-60', 'Villavicencio', 'Meta', '500001', 'Agrónomo', 2100000, 'Suspendido'),
('1100457900', 'CC', '1089012345', 'Laura', 'Moreno', '1998-08-05', '3123456789', 'laura.moreno@ejemplo.com', 'Calle 12 #34-56', 'Manizales', 'Caldas', '170001', 'Diseñadora UX', 4500000, 'Activo'),
('1100457901', 'CC', '1090123456', 'Felipe', 'Castro', '1983-01-19', '3167890123', 'felipe.castro@ejemplo.com', 'Av. 30 #25-55', 'Barranquilla', 'Atlántico', '080001', 'Contador', 3900000, 'Activo'),
('1100457902', 'CC', '1091234567', 'Sofía', 'Ramírez', '1997-02-28', '3187654321', 'sofia.ramirez@email.com', 'Calle 7 #8-9', 'Armenia', 'Quindío', '630001', 'Psicóloga', 2900000, 'Activo'),
('1100457903', 'CE', 'CC345678', 'David', 'Silva', '1980-11-01', '3051234567', 'david.silva@email.com', 'Carrera 20 #1-2', 'Santa Marta', 'Magdalena', '470001', 'Gerente de Proyectos', 7000000, 'Activo'),
('1100457904', 'CC', '1092345678', 'Isabella', 'González', '2001-07-07', '3029876543', 'isabella.gonzalez@email.com', 'Calle 50 #60-70', 'Popayán', 'Cauca', '190001', 'Diseñadora de Modas', 2200000, 'Activo'),
('1100457905', 'NIT', '800654321', 'Tecno Solutions Ltda.', '', '2005-03-10', '6047890123', 'info@tecnosolutions.com', 'Av. El Poblado #10-20', 'Medellín', 'Antioquia', '050010', 'Empresa', 30000000, 'Activo'),
('1100457906', 'CC', '1093456789', 'Mateo', 'Herrera', '1993-09-03', '3145678901', 'mateo.herrera@email.com', 'Calle 80 #90-10', 'Montería', 'Córdoba', '230001', 'Veterinario', 3100000, 'Activo'),
('1100457907', 'CC', '1094567890', 'Valentina', 'Díaz', '1996-01-20', '3008765432', 'valentina.diaz@email.com', 'Carrera 70 #5-15', 'Villavicencio', 'Meta', '500001', 'Nutricionista', 2600000, 'Activo'),
('1100457908', 'CC', '1095678901', 'Sebastián', 'Velasco', '1989-06-05', '3132109876', 'sebastian.velasco@email.com', 'Calle 3 #4-5', 'Pasto', 'Nariño', '520001', 'Fotógrafo', 2400000, 'Inactivo'),
('1100457909', 'CE', 'DD567890', 'Andrea', 'Castro', '1982-10-14', '3216543210', 'andrea.castro@email.com', 'Av. Circunvalar #100-200', 'Tunja', 'Boyacá', '150001', 'Periodista', 3800000, 'Activo'),
('1100457910', 'CC', '1096789012', 'Daniel', 'Rojas', '1991-04-11', '3017890123', 'daniel.rojas@email.com', 'Carrera 4 #5-6', 'Ibagué', 'Tolima', '730001', 'Arquitecto', 4100000, 'Activo'),
('1100457911', 'CC', '1097890123', 'Valeria', 'Sierra', '2000-12-01', '3101234567', 'valeria.sierra@email.com', 'Callejón 1 #2-3', 'Yopal', 'Casanare', '850001', 'Marketing Digital', 2700000, 'Activo'),
('1100457912', 'CC', '1098901234', 'Diego', 'Guerrero', '1986-08-22', '3176543210', 'diego.guerrero@email.com', 'Carrera 8 #9-10', 'Riohacha', 'La Guajira', '440001', 'Ingeniero de Sistemas', 4800000, 'Activo'),
('1100457913', 'NIT', '900112233', 'Global Consultores S.A.S.', '', '2010-07-25', '6019876543', 'contacto@globalconsultores.com', 'Diagonal 45 #50-55', 'Barranquilla', 'Atlántico', '080001', 'Empresa', 45000000, 'Activo'),
('1100457914', 'CC', '1099012345', 'Camila', 'Jiménez', '1994-03-17', '3002345678', 'camila.jimenez@email.com', 'Calle 100 #10-10', 'Bucaramanga', 'Santander', '680001', 'Contadora Pública', 3300000, 'Activo'),
('1100457915', 'CE', 'EE789012', 'Juan Pablo', 'Ramírez', '1984-05-29', '3203456789', 'juanpablo.ramirez@email.com', 'Carrera 1 #2-3', 'Cali', 'Valle del Cauca', '760001', 'Médico', 7500000, 'Activo'),
('1100457916', 'CC', '1100123456', 'Gabriela', 'Ortega', '1998-09-09', '3158765432', 'gabriela.ortega@email.com', 'Calle 25 #30-35', 'Manizales', 'Caldas', '170001', 'Publicista', 2900000, 'Activo'),
('1100457917', 'CC', '1101234567', 'José Luis', 'Méndez', '1990-11-16', '3119876540', 'joseluis.mendez@email.com', 'Carrera 50 #55-60', 'Neiva', 'Huila', '410001', 'Electricista', 2300000, 'Activo'),
('1100457918', 'CC', '1102345678', 'Natalia', 'Pardo', '1997-04-02', '3041234567', 'natalia.pardo@email.com', 'Calle 60 #70-80', 'Pereira', 'Risaralda', '660001', 'Diseñadora Industrial', 3100000, 'Activo'),
('1100457919', 'NIT', '800998877', 'Inversiones XYZ S.A.S.', '', '2008-02-14', '6071234567', 'gerencia@inversionesxyz.com', 'Zona Franca #1-2', 'Cartagena', 'Bolívar', '130001', 'Empresa', 50000000, 'Activo'),
('1100457920', 'CC', '1103456789', 'Ricardo', 'Sánchez', '1981-06-21', '3218765432', 'ricardo.sanchez@email.com', 'Carrera 10 #11-12', 'Cúcuta', 'Norte de Santander', '540001', 'Ingeniero Químico', 5200000, 'Activo'),
('1100457921', 'CC', '1104567890', 'Carolina', 'Vargas', '1995-10-27', '3009876543', 'carolina.vargas@email.com', 'Calle 15 #16-17', 'Villavicencio', 'Meta', '500001', 'Veterinaria', 3000000, 'Activo'),
('1100457922', 'CC', '1105678901', 'Pablo', 'Lozano', '1987-01-09', '3134567890', 'pablo.lozano@email.com', 'Av. Santander #20-25', 'Manizales', 'Caldas', '170001', 'Agrónomo', 3500000, 'Inactivo'),
('1100457923', 'CE', 'FF123456', 'María Fernanda', 'Gil', '1992-08-08', '3167890123', 'mariafernanda.gil@email.com', 'Calle 30 #35-40', 'Bucaramanga', 'Santander', '680001', 'Química Farmacéutica', 4000000, 'Activo'),
('1100457924', 'CC', '1106789012', 'Esteban', 'Quiroga', '1999-05-19', '3056789012', 'esteban.quiroga@email.com', 'Carrera 80 #85-90', 'Bogotá', 'Cundinamarca', '110111', 'Comunicador Social', 2800000, 'Activo'),
('1100457925', 'CC', '1107890123', 'Jimena', 'Sierra', '1983-12-04', '3123456789', 'jimena.sierra@email.com', 'Calle 2 #3-4', 'Medellín', 'Antioquia', '050010', 'Arquitecta', 4300000, 'Activo'),
('1100457926', 'NIT', '900223344', 'DataTech Solutions', '', '2015-09-01', '6023456789', 'contact@datatech.com', 'Parque Tecnológico #1', 'Cali', 'Valle del Cauca', '760001', 'Empresa', 28000000, 'Activo'),
('1100457927', 'CC', '1108901234', 'Alejandro', 'Fuentes', '1996-02-13', '3145678901', 'alejandro.fuentes@email.com', 'Av. Principal #5-6', 'Cartagena', 'Bolívar', '130001', 'Programador', 3600000, 'Activo'),
('1100457928', 'CE', 'GG987654', 'Laura Sofía', 'Ramírez', '1990-07-26', '3001122334', 'laura.ramirez@email.com', 'Calle 10 #12-14', 'Pereira', 'Risaralda', '660001', 'Diseñadora UX/UI', 3900000, 'Activo'),
('1100457929', 'CC', '1109012345', 'Fernando', 'Castillo', '1985-04-07', '3189012345', 'fernando.castillo@email.com', 'Carrera 7 #8-9', 'Cúcuta', 'Norte de Santander', '540001', 'Contador', 4000000, 'Activo'),
('1100457930', 'CC', '1110123456', 'Mariana', 'Muñoz', '1993-11-11', '3012345678', 'mariana.munoz@email.com', 'Calle 40 #50-60', 'Neiva', 'Huila', '410001', 'Ingeniera de Alimentos', 3200000, 'Activo'),
('1100457931', 'CC', '1111234567', 'Andrés Felipe', 'García', '2000-06-29', '3229876543', 'andresfelipe.garcia@email.com', 'Carrera 15 #20-25', 'Villavicencio', 'Meta', '500001', 'Estudiante', 900000, 'Activo'),
('1100457932', 'CC', '1112345678', 'Paola', 'Vargas', '1988-03-03', '3123456789', 'paola.vargas@email.com', 'Calle 100 #1-2', 'Manizales', 'Caldas', '170001', 'Abogada', 6000000, 'Activo'),
('1100457933', 'NIT', '900334455', 'Innovación Digital S.A.S.', '', '2018-05-12', '6017654321', 'contacto@innovaciondigital.com', 'Centro Comercial #1', 'Bogotá', 'Cundinamarca', '110111', 'Empresa', 35000000, 'Activo'),
('1100457934', 'CC', '1113456789', 'Jorge', 'Soto', '1991-09-01', '3167890123', 'jorge.soto@email.com', 'Carrera 10 #1-2', 'Medellín', 'Antioquia', '050010', 'Ingeniero Industrial', 4700000, 'Activo'),
('1100457935', 'CE', 'HH345678', 'Daniela', 'Marín', '1994-02-05', '3008765432', 'daniela.marin@email.com', 'Calle 20 #25-30', 'Cali', 'Valle del Cauca', '760001', 'Psicóloga Clínica', 3400000, 'Activo'),
('1100457936', 'CC', '1114567890', 'Julián', 'Pérez', '1980-10-10', '3176543210', 'julian.perez@email.com', 'Av. 30 #35-40', 'Barranquilla', 'Atlántico', '080001', 'Administrador de Empresas', 5500000, 'Activo'),
('1100457937', 'CC', '1115678901', 'Sofía', 'López', '1997-07-07', '3012345678', 'sofia.lopez@email.com', 'Calle 50 #55-60', 'Bucaramanga', 'Santander', '680001', 'Diseñadora Gráfica', 2700000, 'Activo'),
('1100457938', 'CC', '1116789012', 'Carlos', 'Martínez', '1989-01-18', '3158765432', 'carlos.martinez@email.com', 'Carrera 70 #75-80', 'Pereira', 'Risaralda', '660001', 'Desarrollador Web', 4200000, 'Activo'),
('1100457939', 'CC', '1117890123', 'Laura', 'Gómez', '1995-04-04', '3041234567', 'laura.gomez@email.com', 'Calle 1 #2-3', 'Pasto', 'Nariño', '520001', 'Docente', 3000000, 'Activo');

-- 4. Tarjetas
INSERT INTO tarjetas (numero_tarjeta, cliente_id, tipo_tarjeta_id, descuento_id, monto_apertura, limite_credito, saldo_disponible, fecha_apertura, fecha_vencimiento, fecha_ultimo_uso, pin_encriptado, estado, motivo_bloqueo, observaciones) VALUES
('4532-3141-5926-5358', 1, 3, 3, 1200000, 3000000, 3000000, '2024-05-01', '2027-05-01', NULL, 'pin01', 'Activa', NULL, NULL),
('4532-2718-2818-2845', 2, 3, 2, 700000, 2000000, 2000000, '2024-06-01', '2027-06-01', NULL, 'pin02', 'Activa', NULL, NULL),
('4532-1234-5678-9012', 3, 1, 2, 60000, 500000, 480000, '2024-01-15', '2026-01-15', '2025-06-01 09:00:00', 'pin03', 'Activa', NULL, 'Tarjeta joven aprobada sin inconvenientes'),
('4532-9876-5432-1098', 4, 3, 3, 250000, 1800000, 1200000, '2023-11-20', '2026-11-20', '2025-06-22 11:00:00', 'pin04', 'Activa', NULL, NULL),
('4532-5555-6666-7777', 5, 1, 1, 50000, 200000, 180000, '2025-02-01', '2027-02-01', NULL, 'pin05', 'Activa', NULL, 'Tarjeta estudiantil asignada recientemente'),
('4532-8888-9999-0000', 6, 5, 5, 2000000, 10000000, 8000000, '2024-03-10', '2029-03-10', '2025-06-18 14:45:00', 'pin06', 'Activa', NULL, 'Tarjeta corporativa alta gama'),
('4532-4444-1111-2222', 7, 2, 2, 120000, 1000000, 900000, '2023-06-25', '2026-06-25', '2025-06-20 08:12:00', 'pin07', 'Suspendida', NULL, 'Suspendida por mora'),
('4532-3333-6666-9999', 8, 4, 4, 700000, 6000000, 2000000, '2022-09-01', '2025-09-01', '2024-12-30 17:00:00', 'pin08', 'Bloqueada', 'Intentos de acceso inválidos', NULL),
('4532-1010-2020-3030', 9, 3, 3, 200000, 1500000, 1450000, '2023-12-01', '2026-12-01', '2025-06-15 19:00:00', 'pin09', 'Activa', NULL, NULL),
('4532-1111-2222-3333', 10, 2, 1, 100000, 700000, 700000, '2024-07-10', '2027-07-10', NULL, 'pin10', 'Cancelada', 'Solicitud del cliente', 'Saldo en cero'),
('4532-4444-5555-6666', 11, 5, 4, 1500000, 9000000, 8500000, '2023-05-20', '2026-05-20', '2025-06-21 13:30:00', 'pin11', 'Activa', NULL, 'Cliente premium con excelente historial'),
('4532-7777-8888-9999', 12, 4, 3, 1000000, 5000000, 4500000, '2025-01-01', '2028-01-01', NULL, 'pin12', 'Vencida', NULL, 'No se ha renovado'),
('4532-0000-1111-2222', 13, 1, 1, 75000, 600000, 550000, '2024-04-01', '2027-04-01', '2025-06-23 10:15:00', 'pin13', 'Activa', NULL, 'Primera tarjeta del cliente.'),
('4532-2222-3333-4444', 14, 2, 2, 150000, 1200000, 1100000, '2023-03-10', '2026-03-10', '2025-06-19 16:30:00', 'pin14', 'Activa', NULL, 'Cliente con buen historial de crédito.'),
('4532-5678-9012-3456', 15, 3, 3, 300000, 2000000, 1900000, '2024-08-01', '2027-08-01', '2025-06-24 10:00:00', 'pin15', 'Activa', NULL, 'Tarjeta de crédito principal del cliente.'),
('4532-7890-1234-5678', 16, 4, 4, 800000, 7000000, 6500000, '2023-01-20', '2026-01-20', '2025-06-10 11:30:00', 'pin16', 'Activa', NULL, 'Cliente frecuente con alto límite.'),
('4532-1122-3344-5566', 17, 1, 1, 55000, 300000, 280000, '2025-03-15', '2028-03-15', NULL, 'pin17', 'Activa', NULL, 'Tarjeta para cliente con ingresos bajos.'),
('4532-6789-0123-4567', 18, 5, 5, 2500000, 12000000, 10000000, '2024-05-01', '2029-05-01', '2025-06-22 09:45:00', 'pin18', 'Activa', NULL, 'Tarjeta corporativa de alta prioridad.'),
('4532-0011-2233-4455', 19, 2, 2, 100000, 800000, 750000, '2023-09-05', '2026-09-05', '2025-06-17 14:00:00', 'pin19', 'Activa', NULL, NULL),
('4532-9988-7766-5544', 20, 3, 3, 180000, 1400000, 1300000, '2024-06-01', '2027-06-01', NULL, 'pin20', 'Activa', NULL, 'Cliente con pagos siempre puntuales.'),
('4532-1357-2468-9012', 21, 1, 1, 40000, 150000, 100000, '2025-01-20', '2027-01-20', NULL, 'pin21', 'Activa', NULL, 'Tarjeta recién emitida, sin actividad registrada.'),
('4532-2468-1357-9012', 22, 4, 3, 900000, 4800000, 4000000, '2022-11-15', '2025-11-15', '2025-06-05 18:00:00', 'pin22', 'Activa', NULL, 'Tarjeta con historial de compras grandes.'),
('4532-1111-0000-9999', 23, 2, 1, 110000, 900000, 850000, '2024-02-28', '2027-02-28', '2025-06-20 09:30:00', 'pin23', 'Activa', NULL, NULL),
('4532-3333-2222-1111', 24, 3, 2, 220000, 1600000, 1500000, '2023-07-12', '2026-07-12', '2025-06-18 11:00:00', 'pin24', 'Activa', NULL, NULL),
('4532-6666-5555-4444', 25, 1, 1, 65000, 550000, 500000, '2024-09-01', '2027-09-01', '2025-06-23 15:00:00', 'pin25', 'Activa', NULL, 'Cliente con historial corto, pero buen uso.'),
('4532-9999-8888-7777', 26, 5, 5, 3000000, 15000000, 12000000, '2023-04-05', '2028-04-05', '2025-06-21 10:00:00', 'pin26', 'Activa', NULL, 'Tarjeta de la más alta gama, uso constante.'),
('4532-0101-0202-0303', 27, 2, 2, 130000, 1100000, 1000000, '2025-01-05', '2028-01-05', NULL, 'pin27', 'Activa', NULL, 'Emitida recientemente, en espera de primer uso.'),
('4532-0303-0202-0101', 28, 3, 3, 270000, 1900000, 1750000, '2024-02-10', '2027-02-10', '2025-06-20 17:00:00', 'pin28', 'Activa', NULL, NULL),
('4532-1472-5836-9012', 29, 1, 1, 45000, 180000, 150000, '2025-04-01', '2028-04-01', NULL, 'pin29', 'Activa', NULL, 'Tarjeta de entrada, límite conservador.'),
('4532-3691-2580-7410', 30, 4, 4, 600000, 5000000, 4800000, '2023-08-18', '2026-08-18', '2025-06-16 12:30:00', 'pin30', 'Activa', NULL, 'Límite de crédito importante para el cliente.'),
('4532-2580-7410-3691', 31, 2, 2, 160000, 1300000, 1200000, '2024-01-25', '2027-01-25', '2025-06-22 09:00:00', 'pin31', 'Activa', NULL, NULL),
('4532-7891-2345-6789', 32, 5, 5, 2200000, 11000000, 9500000, '2024-06-01', '2029-06-01', '2025-06-24 15:00:00', 'pin32', 'Activa', NULL, 'Cliente corporativo de alto valor.'),
('4532-0000-0000-0000', 33, 1, 1, 50000, 200000, 0, '2025-03-01', '2027-03-01', NULL, 'pin33', 'Activa', NULL, 'Saldo en cero, listo para primer uso.'),
('4532-1212-1313-1414', 34, 2, 1, 100000, 750000, 700000, '2023-10-01', '2026-10-01', '2025-06-19 10:00:00', 'pin34', 'Activa', NULL, NULL),
('4532-1515-1616-1717', 35, 3, 2, 200000, 1500000, 1400000, '2024-04-20', '2027-04-20', '2025-06-20 11:00:00', 'pin35', 'Activa', NULL, 'Buen comportamiento de pago, uso frecuente.'),
('4532-1818-1919-2020', 36, 4, 3, 750000, 6500000, 6000000, '2023-02-15', '2026-02-15', '2025-06-15 13:00:00', 'pin36', 'Activa', NULL, 'Tarjeta de crédito principal para el cliente.'),
('4532-2121-2222-2323', 37, 1, 1, 60000, 450000, 400000, '2025-05-10', '2028-05-10', NULL, 'pin37', 'Activa', NULL, 'Nueva emisión, espera de activación.'),
('4532-2424-2525-2626', 38, 5, 4, 1800000, 9500000, 9000000, '2024-08-10', '2029-08-10', '2025-06-23 08:30:00', 'pin38', 'Activa', NULL, 'Cliente VIP, uso frecuente y alto límite.'),
('4532-2727-2828-2929', 39, 2, 2, 140000, 1150000, 1050000, '2023-05-01', '2026-05-01', '2025-06-18 16:00:00', 'pin39', 'Activa', NULL, NULL),
('4532-3030-3131-3232', 40, 3, 3, 230000, 1700000, 1600000, '2024-03-05', '2027-03-05', '2025-06-21 11:45:00', 'pin40', 'Activa', NULL, NULL),
('4532-3333-3434-3535', 41, 1, 1, 70000, 500000, 450000, '2025-02-20', '2028-02-20', NULL, 'pin41', 'Activa', NULL, 'Tarjeta de uso diario.'),
('4532-3636-3737-3838', 42, 4, 4, 850000, 7200000, 6800000, '2023-09-10', '2026-09-10', '2025-06-17 09:00:00', 'pin42', 'Activa', NULL, 'Cliente con gran capacidad de gasto.'),
('4532-3939-4040-4141', 43, 2, 2, 180000, 1400000, 1300000, '2024-07-01', '2027-07-01', '2025-06-24 10:30:00', 'pin43', 'Activa', NULL, NULL),
('4532-4242-4343-4444', 44, 1, 1, 50000, 250000, 200000, '2025-01-10', '2027-01-10', NULL, 'pin44', 'Activa', NULL, 'Tarjeta ideal para jóvenes.'),
('4532-4545-4646-4747', 45, 3, 2, 260000, 1850000, 1700000, '2023-04-15', '2026-04-15', '2025-06-20 14:00:00', 'pin45', 'Activa', NULL, NULL),
('4532-4848-4949-5050', 46, 5, 5, 2700000, 14000000, 11000000, '2024-09-20', '2029-09-20', '2025-06-21 11:00:00', 'pin46', 'Activa', NULL, 'Límite excepcionalmente alto.'),
('4532-5151-5252-5353', 47, 2, 1, 90000, 650000, 600000, '2025-04-10', '2028-04-10', NULL, 'pin47', 'Activa', NULL, 'Primera tarjeta con pequeño límite.'),
('4532-5454-5555-5656', 48, 3, 3, 210000, 1600000, 1500000, '2023-11-01', '2026-11-01', '2025-06-15 10:00:00', 'pin48', 'Activa', NULL, NULL),
('4532-5757-5858-5959', 49, 4, 4, 700000, 5800000, 5000000, '2024-01-30', '2027-01-30', '2025-06-22 13:00:00', 'pin49', 'Activa', NULL, 'Cliente con historial de pago muy bueno.'),
('4532-6060-6161-6262', 50, 1, 1, 40000, 150000, 120000, '2025-03-25', '2028-03-25', NULL, 'pin50', 'Activa', NULL, 'Último cliente de la lista, tarjeta básica.');

-- 5. Cuotas de manejo
INSERT INTO cuotas_manejo (tarjeta_id, periodo_mes, periodo_año, monto_base, porcentaje_descuento, valor_descuento, monto_final, fecha_vencimiento, dias_mora, interes_mora, monto_total_con_mora, estado) VALUES
(1, 6, 2024, 9000, 25.00, 0, 15000, '2024-06-30', 0, 0, 9000, 'Pagada'),
(2, 6, 2024, 9000, 15.00, 0, 15000, '2024-06-30', 0, 0, 9000, 'Pagada'),
(3, 6, 2024, 9000, 0.00, 0, 8000, '2024-06-30', 0, 0, 9000, 'Pagada'),
(4, 6, 2024, 9000, 20.00, 0, 35000, '2024-06-30', 0, 0, 9000, 'Pagada'),
(5, 6, 2024, 9000, 10.00, 0, 12000, '2024-06-30', 0, 0, 9000, 'Pagada'),
(6, 6, 2024, 9000, 35.00, 0, 25000, '2024-06-30', 0, 0, 9000, 'Pagada'),
(7, 6, 2024, 9000, 15.00, 0, 15000, '2024-06-30', 0, 0, 9000, 'Pagada'),
(8, 6, 2024, 9000, 0.00, 0, 12000, '2024-06-30', 0, 0, 9000, 'Pagada'),
(9, 6, 2024, 9000, 25.00, 0, 35000, '2024-06-30', 0, 0, 9000, 'Pagada'),
(10, 6, 2024, 9000, 15.00, 0, 25000, '2024-06-30', 0, 0, 9000, 'Pagada'),
(11, 6, 2024, 9000, 5.00, 0, 15000, '2024-06-30', 0, 0, 9000, 'Pagada'),
(12, 6, 2024, 9000, 0.00, 0, 25000, '2024-06-30', 0, 0, 9000, 'Pagada'),
(13, 6, 2024, 9000, 0.00, 0, 9000, '2024-06-30', 0, 0, 9000, 'Pagada'),
(14, 6, 2024, 18000, 10.00, 1800, 16200, '2024-06-30', 0, 0, 16200, 'Pendiente'),
(15, 6, 2024, 40000, 20.00, 8000, 32000, '2024-06-30', 10, 2500, 34500, 'Vencida'),
(16, 6, 2024, 60000, 30.00, 18000, 42000, '2024-06-30', 0, 0, 42000, 'Pagada'),
(17, 6, 2024, 10000, 0.00, 0, 10000, '2024-06-30', 0, 0, 10000, 'Pendiente'),
(18, 6, 2024, 70000, 40.00, 28000, 42000, '2024-06-30', 20, 5000, 47000, 'Vencida'),
(19, 6, 2024, 20000, 5.00, 1000, 19000, '2024-06-30', 0, 0, 19000, 'Pagada'),
(20, 6, 2024, 45000, 25.00, 11250, 33750, '2024-06-30', 0, 0, 33750, 'Pendiente'),
(21, 6, 2024, 7000, 0.00, 0, 7000, '2024-06-30', 0, 0, 7000, 'Pagada'),
(22, 6, 2024, 50000, 15.00, 7500, 42500, '2024-06-30', 7, 3000, 45500, 'Vencida'),
(23, 6, 2024, 22000, 10.00, 2200, 19800, '2024-06-30', 0, 0, 19800, 'Pendiente'),
(24, 6, 2024, 13000, 0.00, 0, 13000, '2024-06-30', 0, 0, 13000, 'Pagada'),
(25, 6, 2024, 8500, 0.00, 0, 8500, '2024-06-30', 0, 0, 8500, 'Pagada'),
(26, 6, 2024, 55000, 35.00, 19250, 35750, '2024-06-30', 12, 4000, 39750, 'Vencida'),
(27, 6, 2024, 16000, 0.00, 0, 16000, '2024-06-30', 0, 0, 16000, 'Pendiente'),
(28, 6, 2024, 38000, 20.00, 7600, 30400, '2024-06-30', 0, 0, 30400, 'Pagada'),
(29, 6, 2024, 7500, 0.00, 0, 7500, '2024-06-30', 0, 0, 7500, 'Pendiente'),
(30, 6, 2024, 62000, 25.00, 15500, 46500, '2024-06-30', 18, 4500, 51000, 'Vencida'),
(31, 6, 2024, 19000, 10.00, 1900, 17100, '2024-06-30', 0, 0, 17100, 'Pagada'),
(32, 6, 2024, 68000, 40.00, 27200, 40800, '2024-06-30', 0, 0, 40800, 'Pendiente'),
(33, 6, 2024, 8000, 0.00, 0, 8000, '2024-06-30', 0, 0, 8000, 'Pagada'),
(34, 6, 2024, 17000, 5.00, 850, 16150, '2024-06-30', 0, 0, 16150, 'Pendiente'),
(35, 6, 2024, 42000, 20.00, 8400, 33600, '2024-06-30', 8, 2800, 36400, 'Vencida'),
(36, 6, 2024, 65000, 30.00, 19500, 45500, '2024-06-30', 0, 0, 45500, 'Pagada'),
(37, 6, 2024, 11000, 0.00, 0, 11000, '2024-06-30', 0, 0, 11000, 'Pendiente'),
(38, 6, 2024, 75000, 45.00, 33750, 41250, '2024-06-30', 25, 6000, 47250, 'Vencida'),
(39, 6, 2024, 21000, 10.00, 2100, 18900, '2024-06-30', 0, 0, 18900, 'Pagada'),
(40, 6, 2024, 48000, 25.00, 12000, 36000, '2024-06-30', 0, 0, 36000, 'Pendiente'),
(41, 6, 2024, 9500, 0.00, 0, 9500, '2024-06-30', 0, 0, 9500, 'Pagada'),
(42, 6, 2024, 52000, 15.00, 7800, 44200, '2024-06-30', 5, 2000, 46200, 'Vencida'),
(43, 6, 2024, 24000, 10.00, 2400, 21600, '2024-06-30', 0, 0, 21600, 'Pendiente'),
(44, 6, 2024, 14000, 0.00, 0, 14000, '2024-06-30', 0, 0, 14000, 'Pagada'),
(45, 6, 2024, 40000, 20.00, 8000, 32000, '2024-06-30', 0, 0, 32000, 'Pendiente'),
(46, 6, 2024, 70000, 35.00, 24500, 45500, '2024-06-30', 15, 4800, 50300, 'Vencida'),
(47, 6, 2024, 16000, 5.00, 800, 15200, '2024-06-30', 0, 0, 15200, 'Pagada'),
(48, 6, 2024, 30000, 20.00, 6000, 24000, '2024-06-30', 0, 0, 24000, 'Pendiente'),
(49, 6, 2024, 58000, 25.00, 14500, 43500, '2024-06-30', 10, 3200, 46700, 'Vencida'),
(50, 6, 2024, 12000, 0.00, 0, 12000, '2024-06-30', 0, 0, 12000, 'Pagada');

-- 6. Historial de pagos
INSERT INTO historial_pagos (cuota_id, numero_transaccion, monto_pagado, monto_pendiente, fecha_pago, metodo_pago, referencia_pago, banco_origen, canal_pago, usuario_registro, ip_origen, estado_transaccion, comision, observaciones) VALUES
(1, 'TXN0001', 11250, 0, '2024-06-25 10:30:00', 'Transferencia', 'REF-112233', 'Banco CL', 'Online', 'juan.perez', '192.168.1.10', 'Exitoso', 0, 'Pago completo sin inconvenientes'),
(2, 'TXN0002', 10000, 2750, '2024-06-26 14:15:00', 'PSE', 'REF-445566', 'Banco CL', 'App_Movil', 'maria.rodriguez', '192.168.1.20', 'Exitoso', 0, 'Pago parcial, pendiente de abono restante'),
(3, 'TXN0003', 8000, 0, '2024-06-20 09:30:00', 'Debito_Automatico', 'REF-3001', 'Banco CL', 'App_Movil', 'usuario3', '192.168.0.3', 'Exitoso', 0, 'Pago programado exitosamente'),
(4, 'TXN0004', 15000, 14800, '2024-07-01 10:15:00', 'Transferencia', 'REF-4002', 'Bancolombia', 'Online', 'usuario4', '192.168.0.4', 'Exitoso', 0, 'Pago parcial tras vencimiento'),
(5, 'TXN0005', 0, 10800, '2024-06-30 00:00:00', 'PSE', 'REF-5003', 'Davivienda', 'Online', 'usuario5', '192.168.0.5', 'Pendiente', 0, 'Transacción en espera de confirmación'),
(6, 'TXN0006', 19750, 0, '2024-07-05 18:45:00', 'Efectivo', 'REF-6004', 'Banco CL', 'Sucursal', 'usuario6', '192.168.0.6', 'Exitoso', 0, 'Pago realizado luego de mora'),
(7, 'TXN0007', 12750, 0, '2024-06-24 11:00:00', 'Debito_Automatico', 'REF-7005', 'Banco CL', 'App_Movil', 'usuario7', '192.168.0.7', 'Exitoso', 0, NULL),
(8, 'TXN0008', 0, 12000, '2024-06-28 09:15:00', 'Tarjeta_Debito', 'REF-8006', 'Banco CL', 'Online', 'usuario8', '192.168.0.8', 'Fallido', 0, 'Error en la validación del pago'),
(9, 'TXN0009', 15000, 11250, '2024-06-26 14:40:00', 'PSE', 'REF-9007', 'Banco de Bogotá', 'App_Movil', 'usuario9', '192.168.0.9', 'Exitoso', 0, 'Cliente realizó abono parcial'),
(10, 'TXN0010', 21250, 0, '2024-06-23 10:00:00', 'Transferencia', 'REF-10008', 'Banco CL', 'Online', 'usuario10', '192.168.0.10', 'Exitoso', 0, NULL),
(11, 'TXN0011', 14450, 0, '2024-06-24 16:20:00', 'Corresponsal', 'REF-11009', 'Banco AV Villas', 'Sucursal', 'usuario11', '192.168.0.11', 'Exitoso', 450, 'Incluye comisión del corresponsal'),
(12, 'TXN0012', 25000, 0, '2024-06-25 12:45:00', 'Debito_Automatico', 'REF-12010', 'Banco CL', 'App_Movil', 'usuario12', '192.168.0.12', 'Exitoso', 0, NULL),
(13, 'TXN0013', 9000, 0, '2024-06-25 10:00:00', 'Debito_Automatico', 'REF-13011', 'Banco CL', 'App_Movil', 'usuario13', '192.168.0.13', 'Exitoso', 0, 'Pago recurrente automático'),
(14, 'TXN0014', 8000, 8200, '2024-06-28 11:30:00', 'PSE', 'REF-14012', 'Bancolombia', 'Online', 'usuario14', '192.168.0.14', 'Exitoso', 0, 'Abono parcial de cuota'),
(15, 'TXN0015', 0, 34500, '2024-06-29 14:00:00', 'Transferencia', 'REF-15013', 'Davivienda', 'Online', 'usuario15', '192.168.0.15', 'Fallido', 0, 'Fondos insuficientes'),
(16, 'TXN0016', 42000, 0, '2024-06-26 15:45:00', 'Debito_Automatico', 'REF-16014', 'Banco CL', 'App_Movil', 'usuario16', '192.168.0.16', 'Exitoso', 0, NULL),
(17, 'TXN0017', 0, 10000, '2024-06-30 00:00:00', 'Efectivo', 'REF-17015', 'Banco CL', 'Sucursal', 'usuario17', '192.168.0.17', 'Pendiente', 0, 'Pendiente de registrar en sistema'),
(18, 'TXN0018', 25000, 22000, '2024-07-02 09:00:00', 'Transferencia', 'REF-18016', 'Banco de Bogotá', 'Online', 'usuario18', '192.168.0.18', 'Exitoso', 0, 'Pago parcial con transferencia bancaria'),
(19, 'TXN0019', 19000, 0, '2024-06-24 10:20:00', 'PSE', 'REF-19017', 'Banco AV Villas', 'App_Movil', 'usuario19', '192.168.0.19', 'Exitoso', 0, NULL),
(20, 'TXN0020', 0, 33750, '2024-06-27 16:00:00', 'Transferencia', 'REF-20018', 'Bancolombia', 'Online', 'usuario20', '192.168.0.20', 'Pendiente', 0, 'Transferencia iniciada, esperando confirmación'),
(21, 'TXN0021', 7000, 0, '2024-06-25 11:15:00', 'Debito_Automatico', 'REF-21019', 'Banco CL', 'App_Movil', 'usuario21', '192.168.0.21', 'Exitoso', 0, NULL),
(22, 'TXN0022', 42500, 3000, '2024-07-01 13:00:00', 'PSE', 'REF-22020', 'Davivienda', 'Online', 'usuario22', '192.168.0.22', 'Exitoso', 0, 'Primer abono de cuota vencida'),
(23, 'TXN0023', 0, 19800, '2024-06-29 08:45:00', 'Efectivo', 'REF-23021', 'Banco CL', 'Sucursal', 'usuario23', '192.168.0.23', 'Pendiente', 0, 'Recibo de pago en caja, pendiente de procesar'),
(24, 'TXN0024', 13000, 0, '2024-06-26 14:00:00', 'Debito_Automatico', 'REF-24022', 'Banco CL', 'App_Movil', 'usuario24', '192.168.0.24', 'Exitoso', 0, NULL),
(25, 'TXN0025', 8500, 0, '2024-06-24 15:30:00', 'PSE', 'REF-25023', 'Banco CL', 'Online', 'usuario25', '192.168.0.25', 'Exitoso', 0, NULL),
(26, 'TXN0026', 15000, 24750, '2024-07-03 10:40:00', 'Transferencia', 'REF-26024', 'Bancolombia', 'Online', 'usuario26', '192.168.0.26', 'Exitoso', 0, 'Pago parcial de cuota atrasada'),
(27, 'TXN0027', 0, 16000, '2024-06-30 00:00:00', 'Tarjeta_Debito', 'REF-27025', 'Davivienda', 'Online', 'usuario27', '192.168.0.27', 'Fallido', 0, 'Tarjeta declinada'),
(28, 'TXN0028', 30400, 0, '2024-06-28 12:00:00', 'Debito_Automatico', 'REF-28026', 'Banco de Bogotá', 'App_Movil', 'usuario28', '192.168.0.28', 'Exitoso', 0, NULL),
(29, 'TXN0029', 0, 7500, '2024-06-29 17:00:00', 'PSE', 'REF-29027', 'Banco AV Villas', 'Online', 'usuario29', '192.168.0.29', 'Pendiente', 0, 'Transacción pendiente de aprobación final'),
(30, 'TXN0030', 46500, 4500, '2024-07-04 11:20:00', 'Efectivo', 'REF-30028', 'Banco CL', 'Sucursal', 'usuario30', '192.168.0.30', 'Exitoso', 0, 'Pago en caja por cuota vencida'),
(31, 'TXN0031', 17100, 0, '2024-06-25 09:10:00', 'Debito_Automatico', 'REF-31029', 'Bancolombia', 'App_Movil', 'usuario31', '192.168.0.31', 'Exitoso', 0, NULL),
(32, 'TXN0032', 0, 40800, '2024-06-28 13:45:00', 'Transferencia', 'REF-32030', 'Davivienda', 'Online', 'usuario32', '192.168.0.32', 'Pendiente', 0, 'Esperando confirmación interbancaria'),
(33, 'TXN0033', 8000, 0, '2024-06-24 14:15:00', 'PSE', 'REF-33031', 'Banco CL', 'Online', 'usuario33', '192.168.0.33', 'Exitoso', 0, 'Pago en día hábil'),
(34, 'TXN0034', 0, 16150, '2024-06-29 18:00:00', 'Transferencia', 'REF-34032', 'Banco de Bogotá', 'App_Movil', 'usuario34', '192.168.0.34', 'Fallido', 0, 'Fondos insuficientes o error de procesamiento'),
(35, 'TXN0035', 20000, 16400, '2024-07-01 10:00:00', 'Efectivo', 'REF-35033', 'Banco CL', 'Sucursal', 'usuario35', '192.168.0.35', 'Exitoso', 0, 'Pago parcial para evitar más mora'),
(36, 'TXN0036', 45500, 0, '2024-06-26 11:55:00', 'Debito_Automatico', 'REF-36034', 'Banco CL', 'App_Movil', 'usuario36', '192.168.0.36', 'Exitoso', 0, NULL),
(37, 'TXN0037', 0, 11000, '2024-06-30 00:00:00', 'PSE', 'REF-37035', 'Bancolombia', 'Online', 'usuario37', '192.168.0.37', 'Pendiente', 0, 'Transacción programada'),
(38, 'TXN0038', 30000, 17250, '2024-07-05 14:30:00', 'Transferencia', 'REF-38036', 'Davivienda', 'Online', 'usuario38', '192.168.0.38', 'Exitoso', 0, 'Primer abono de cuota con mucha mora'),
(39, 'TXN0039', 18900, 0, '2024-06-25 16:00:00', 'Debito_Automatico', 'REF-39037', 'Banco de Bogotá', 'App_Movil', 'usuario39', '192.168.0.39', 'Exitoso', 0, NULL),
(40, 'TXN0040', 0, 36000, '2024-06-29 10:00:00', 'Tarjeta_Debito', 'REF-40038', 'Banco AV Villas', 'Online', 'usuario40', '192.168.0.40', 'Fallido', 0, 'Saldo insuficiente en cuenta origen'),
(41, 'TXN0041', 9500, 0, '2024-06-24 09:00:00', 'PSE', 'REF-41039', 'Banco CL', 'Online', 'usuario41', '192.168.0.41', 'Exitoso', 0, 'Pago temprano, antes de la fecha límite'),
(42, 'TXN0042', 44200, 2000, '2024-07-02 12:00:00', 'Efectivo', 'REF-42040', 'Bancolombia', 'Sucursal', 'usuario42', '192.168.0.42', 'Exitoso', 0, 'Pago en ventanilla, incluye interés de mora'),
(43, 'TXN0043', 0, 21600, '2024-06-30 00:00:00', 'Transferencia', 'REF-43041', 'Davivienda', 'Online', 'usuario43', '192.168.0.43', 'Pendiente', 0, 'Transferencia programada para fin de mes'),
(44, 'TXN0044', 14000, 0, '2024-06-27 13:00:00', 'Debito_Automatico', 'REF-44042', 'Banco CL', 'App_Movil', 'usuario44', '192.168.0.44', 'Exitoso', 0, NULL),
(45, 'TXN0045', 0, 32000, '2024-06-29 15:00:00', 'PSE', 'REF-45043', 'Banco de Bogotá', 'Online', 'usuario45', '192.168.0.45', 'Fallido', 0, 'Error de autenticación'),
(46, 'TXN0046', 20000, 30300, '2024-07-03 09:30:00', 'Transferencia', 'REF-46044', 'Banco AV Villas', 'Online', 'usuario46', '192.168.0.46', 'Exitoso', 0, 'Pago inicial de cuota muy atrasada'),
(47, 'TXN0047', 15200, 0, '2024-06-25 10:45:00', 'Debito_Automatico', 'REF-47045', 'Banco CL', 'App_Movil', 'usuario47', '192.168.0.47', 'Exitoso', 0, NULL),
(48, 'TXN0048', 0, 24000, '2024-06-28 11:00:00', 'Transferencia', 'REF-48046', 'Bancolombia', 'Online', 'usuario48', '192.168.0.48', 'Pendiente', 0, 'Revisión manual de transferencia'),
(49, 'TXN0049', 40000, 6700, '2024-07-01 14:00:00', 'PSE', 'REF-49047', 'Davivienda', 'Online', 'usuario49', '192.168.0.49', 'Exitoso', 0, 'Pago parcial considerable'),
(50, 'TXN0050', 12000, 0, '2024-06-26 09:30:00', 'Debito_Automatico', 'REF-50048', 'Banco CL', 'App_Movil', 'usuario50', '192.168.0.50', 'Exitoso', 0, 'Último pago programado del mes');

-- roles de usuarios
-- admin
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin123';
GRANT ALL PRIVILEGES ON banco_cl.* TO 'admin'@'localhost';

-- operador de pagos
CREATE USER 'operador_pagos'@'localhost' IDENTIFIED BY 'pago456';
GRANT SELECT, INSERT, UPDATE ON banco_cl.historial_pagos TO 'operador_pagos'@'localhost';
GRANT SELECT, INSERT, UPDATE ON banco_cl.cuotas_manejo TO 'operador_pagos'@'localhost';

-- gerente
CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'gerente789';
GRANT SELECT ON banco_cl.cuotas_manejo TO 'gerente'@'localhost';
GRANT SELECT ON banco_cl.historial_pagos TO 'gerente'@'localhost';
GRANT SELECT ON banco_cl.tarjetas TO 'gerente'@'localhost';
GRANT SELECT ON banco_cl.clientes TO 'gerente'@'localhost';
GRANT SELECT ON banco_cl.tipos_tarjeta TO 'gerente'@'localhost';
GRANT SELECT ON banco_cl.niveles_descuento TO 'gerente'@'localhost';

-- consultor de tarjetas
CREATE USER 'consultor_tarjetas'@'localhost' IDENTIFIED BY 'consulta101';
GRANT SELECT ON banco_cl.tarjetas TO 'consultor_tarjetas'@'localhost';
GRANT SELECT ON banco_cl.cuotas_manejo TO 'consultor_tarjetas'@'localhost';
GRANT SELECT ON banco_cl.tipos_tarjeta TO 'consultor_tarjetas'@'localhost';
GRANT SELECT ON banco_cl.niveles_descuento TO 'consultor_tarjetas'@'localhost';

-- auditor
CREATE USER 'auditor'@'localhost' IDENTIFIED BY 'auditor202';
GRANT SELECT ON banco_cl.* TO 'auditor'@'localhost';


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
INSERT INTO historial_pagos (cuota_id, numero_transaccion, monto_pagado, monto_pendiente, fecha_pago, metodo_pago, canal_pago, usuario_registro, ip_origen) VALUES
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

-- modificacion de la fecha de generacion para dar mas variedad
UPDATE cuotas_manejo SET fecha_generacion = '2024-06-01 08:00:00' WHERE cuota_id = 1;
UPDATE cuotas_manejo SET fecha_generacion = '2024-06-02 09:15:00' WHERE cuota_id = 2;
UPDATE cuotas_manejo SET fecha_generacion = '2024-06-03 07:45:00' WHERE cuota_id = 3;
UPDATE cuotas_manejo SET fecha_generacion = '2024-06-04 10:20:00' WHERE cuota_id = 4;
UPDATE cuotas_manejo SET fecha_generacion = '2024-06-05 11:10:00' WHERE cuota_id = 5;
UPDATE cuotas_manejo SET fecha_generacion = '2024-06-06 08:30:00' WHERE cuota_id = 6;
UPDATE cuotas_manejo SET fecha_generacion = '2024-06-07 12:00:00' WHERE cuota_id = 7;
UPDATE cuotas_manejo SET fecha_generacion = '2024-06-08 09:50:00' WHERE cuota_id = 8;
UPDATE cuotas_manejo SET fecha_generacion = '2024-06-09 13:05:00' WHERE cuota_id = 9;
UPDATE cuotas_manejo SET fecha_generacion = '2024-06-10 10:40:00' WHERE cuota_id = 10;
UPDATE cuotas_manejo SET fecha_generacion = '2024-06-11 11:25:00' WHERE cuota_id = 11;
UPDATE cuotas_manejo SET fecha_generacion = '2024-06-12 08:10:00' WHERE cuota_id = 12;

-- modificacion de la fecha de vencimiento
-- Cuotas vencidas 
UPDATE cuotas_manejo SET fecha_vencimiento = '2024-06-10' WHERE cuota_id = 1;
UPDATE cuotas_manejo SET fecha_vencimiento = '2024-06-15' WHERE cuota_id = 2;
UPDATE cuotas_manejo SET fecha_vencimiento = '2024-06-18' WHERE cuota_id = 3;

-- Cuotas venciendo pronto
UPDATE cuotas_manejo SET fecha_vencimiento = '2024-06-24' WHERE cuota_id = 4;
UPDATE cuotas_manejo SET fecha_vencimiento = '2024-06-25' WHERE cuota_id = 5;
UPDATE cuotas_manejo SET fecha_vencimiento = '2024-06-27' WHERE cuota_id = 6;

-- Cuotas con fecha estándar a final de mes
UPDATE cuotas_manejo SET fecha_vencimiento = '2024-06-30' WHERE cuota_id = 7;
UPDATE cuotas_manejo SET fecha_vencimiento = '2024-06-30' WHERE cuota_id = 8;
UPDATE cuotas_manejo SET fecha_vencimiento = '2024-06-30' WHERE cuota_id = 9;

-- Cuotas con fecha un poco posterior para pruebas con "por vencer"
UPDATE cuotas_manejo SET fecha_vencimiento = '2024-07-02' WHERE cuota_id = 10;
UPDATE cuotas_manejo SET fecha_vencimiento = '2024-07-05' WHERE cuota_id = 11;
UPDATE cuotas_manejo SET fecha_vencimiento = '2024-07-10' WHERE cuota_id = 12;


-- inserccion de los otros 38 clientes
INSERT INTO Clientes (numero_cuenta, tipo_documento, numero_documento, nombres, apellidos, fecha_nacimiento, telefono, email, direccion, ciudad, departamento, codigo_postal, ocupacion, ingresos_mensuales, estado) VALUES
('1100457902', 'CC', '1091234567', 'Sofía', 'Ramírez', '1997-02-28', '3187654321', 'sofia.ramirez@email.com', 'Calle 7 #8-9', 'Armenia', 'Quindío', '630001', 'Psicóloga', 2900000, 'Activo'),
('1100457903', 'CE', 'CC345678', 'David', 'Silva', '1980-11-01', '3051234567', 'david.silva@email.com', 'Carrera 20 #1-2', 'Santa Marta', 'Magdalena', '470001', 'Gerente de Proyectos', 7000000, 'Activo'),
('1100457904', 'CC', '1092345678', 'Isabella', 'González', '2001-07-07', '3029876543', 'isabella.gonzalez@email.com', 'Calle 50 #60-70', 'Popayán', 'Cauca', '190001', 'Diseñadora de Modas', 2200000, 'Activo'),
('1100457905', 'NIT', '800654321', 'Tecno Solutions Ltda.', '', '2005-03-10', '6047890123', 'info@tecnosolutions.com', 'Av. El Poblado #10-20', 'Medellín', 'Antioquia', '050010', 'Empresa', 30000000, 'Activo'),
('1100457906', 'CC', '1093456789', 'Mateo', 'Herrera', '1993-09-03', '3145678901', 'mateo.herrera@email.com', 'Calle 80 #90-10', 'Montería', 'Córdoba', '230001', 'Veterinario', 3100000, 'Activo'),
('1100457907', 'CC', '1094567890', 'Valentina', 'Díaz', '1996-01-20', '3008765432', 'valentina.diaz@email.com', 'Carrera 70 #5-15', 'Villavicencio', 'Meta', '500001', 'Nutricionista', 2600000, 'Activo'),
('1100457908', 'CC', '1095678901', 'Sebastián', 'Velasco', '1989-06-05', '3132109876', 'sebastian.velasco@email.com', 'Calle 3 #4-5', 'Pasto', 'Nariño', '520001', 'Fotógrafo', 2400000, 'Inactivo'),
('1100457909', 'CE', 'DD567890', 'Andrea', 'Castro', '1982-10-14', '3216543210', 'andrea.castro@email.com', 'Av. Circunvalar #100-200', 'Tunja', 'Boyacá', '150001', 'Periodista', 3800000, 'Activo'),
('1100457910', 'CC', '1096789012', 'Daniel', 'Rojas', '1991-04-11', '3017890123', 'daniel.rojas@email.com', 'Carrera 4 #5-6', 'Ibagué', 'Tolima', '730001', 'Arquitecto', 4100000, 'Activo'),
('1100457911', 'CC', '1097890123', 'Valeria', 'Sierra', '2000-12-01', '3101234567', 'valeria.sierra@email.com', 'Callejón 1 #2-3', 'Yopal', 'Casanare', '850001', 'Marketing Digital', 2700000, 'Activo'),
('1100457912', 'CC', '1098901234', 'Diego', 'Guerrero', '1986-08-22', '3176543210', 'diego.guerrero@email.com', 'Carrera 8 #9-10', 'Riohacha', 'La Guajira', '440001', 'Ingeniero de Sistemas', 4800000, 'Activo'),
('1100457913', 'NIT', '900112233', 'Global Consultores S.A.S.', '', '2010-07-25', '6019876543', 'contacto@globalconsultores.com', 'Diagonal 45 #50-55', 'Barranquilla', 'Atlántico', '080001', 'Empresa', 45000000, 'Activo'),
('1100457914', 'CC', '1099012345', 'Camila', 'Jiménez', '1994-03-17', '3002345678', 'camila.jimenez@email.com', 'Calle 100 #10-10', 'Bucaramanga', 'Santander', '680001', 'Contadora Pública', 3300000, 'Activo'),
('1100457915', 'CE', 'EE789012', 'Juan Pablo', 'Ramírez', '1984-05-29', '3203456789', 'juanpablo.ramirez@email.com', 'Carrera 1 #2-3', 'Cali', 'Valle del Cauca', '760001', 'Médico', 7500000, 'Activo'),
('1100457916', 'CC', '1100123456', 'Gabriela', 'Ortega', '1998-09-09', '3158765432', 'gabriela.ortega@email.com', 'Calle 25 #30-35', 'Manizales', 'Caldas', '170001', 'Publicista', 2900000, 'Activo'),
('1100457917', 'CC', '1101234567', 'José Luis', 'Méndez', '1990-11-16', '3119876540', 'joseluis.mendez@email.com', 'Carrera 50 #55-60', 'Neiva', 'Huila', '410001', 'Electricista', 2300000, 'Activo'),
('1100457918', 'CC', '1102345678', 'Natalia', 'Pardo', '1997-04-02', '3041234567', 'natalia.pardo@email.com', 'Calle 60 #70-80', 'Pereira', 'Risaralda', '660001', 'Diseñadora Industrial', 3100000, 'Activo'),
('1100457919', 'NIT', '800998877', 'Inversiones XYZ S.A.S.', '', '2008-02-14', '6071234567', 'gerencia@inversionesxyz.com', 'Zona Franca #1-2', 'Cartagena', 'Bolívar', '130001', 'Empresa', 50000000, 'Activo'),
('1100457920', 'CC', '1103456789', 'Ricardo', 'Sánchez', '1981-06-21', '3218765432', 'ricardo.sanchez@email.com', 'Carrera 10 #11-12', 'Cúcuta', 'Norte de Santander', '540001', 'Ingeniero Químico', 5200000, 'Activo'),
('1100457921', 'CC', '1104567890', 'Carolina', 'Vargas', '1995-10-27', '3009876543', 'carolina.vargas@email.com', 'Calle 15 #16-17', 'Villavicencio', 'Meta', '500001', 'Veterinaria', 3000000, 'Activo'),
('1100457922', 'CC', '1105678901', 'Pablo', 'Lozano', '1987-01-09', '3134567890', 'pablo.lozano@email.com', 'Av. Santander #20-25', 'Manizales', 'Caldas', '170001', 'Agrónomo', 3500000, 'Inactivo'),
('1100457923', 'CE', 'FF123456', 'María Fernanda', 'Gil', '1992-08-08', '3167890123', 'mariafernanda.gil@email.com', 'Calle 30 #35-40', 'Bucaramanga', 'Santander', '680001', 'Química Farmacéutica', 4000000, 'Activo'),
('1100457924', 'CC', '1106789012', 'Esteban', 'Quiroga', '1999-05-19', '3056789012', 'esteban.quiroga@email.com', 'Carrera 80 #85-90', 'Bogotá', 'Cundinamarca', '110111', 'Comunicador Social', 2800000, 'Activo'),
('1100457925', 'CC', '1107890123', 'Jimena', 'Sierra', '1983-12-04', '3123456789', 'jimena.sierra@email.com', 'Calle 2 #3-4', 'Medellín', 'Antioquia', '050010', 'Arquitecta', 4300000, 'Activo'),
('1100457926', 'NIT', '900223344', 'DataTech Solutions', '', '2015-09-01', '6023456789', 'contact@datatech.com', 'Parque Tecnológico #1', 'Cali', 'Valle del Cauca', '760001', 'Empresa', 28000000, 'Activo'),
('1100457927', 'CC', '1108901234', 'Alejandro', 'Fuentes', '1996-02-13', '3145678901', 'alejandro.fuentes@email.com', 'Av. Principal #5-6', 'Cartagena', 'Bolívar', '130001', 'Programador', 3600000, 'Activo'),
('1100457928', 'CE', 'GG987654', 'Laura Sofía', 'Ramírez', '1990-07-26', '3001122334', 'laura.ramirez@email.com', 'Calle 10 #12-14', 'Pereira', 'Risaralda', '660001', 'Diseñadora UX/UI', 3900000, 'Activo'),
('1100457929', 'CC', '1109012345', 'Fernando', 'Castillo', '1985-04-07', '3189012345', 'fernando.castillo@email.com', 'Carrera 7 #8-9', 'Cúcuta', 'Norte de Santander', '540001', 'Contador', 4000000, 'Activo'),
('1100457930', 'CC', '1110123456', 'Mariana', 'Muñoz', '1993-11-11', '3012345678', 'mariana.munoz@email.com', 'Calle 40 #50-60', 'Neiva', 'Huila', '410001', 'Ingeniera de Alimentos', 3200000, 'Activo'),
('1100457931', 'CC', '1111234567', 'Andrés Felipe', 'García', '2000-06-29', '3229876543', 'andresfelipe.garcia@email.com', 'Carrera 15 #20-25', 'Villavicencio', 'Meta', '500001', 'Estudiante', 900000, 'Activo'),
('1100457932', 'CC', '1112345678', 'Paola', 'Vargas', '1988-03-03', '3123456789', 'paola.vargas@email.com', 'Calle 100 #1-2', 'Manizales', 'Caldas', '170001', 'Abogada', 6000000, 'Activo'),
('1100457933', 'NIT', '900334455', 'Innovación Digital S.A.S.', '', '2018-05-12', '6017654321', 'contacto@innovaciondigital.com', 'Centro Comercial #1', 'Bogotá', 'Cundinamarca', '110111', 'Empresa', 35000000, 'Activo'),
('1100457934', 'CC', '1113456789', 'Jorge', 'Soto', '1991-09-01', '3167890123', 'jorge.soto@email.com', 'Carrera 10 #1-2', 'Medellín', 'Antioquia', '050010', 'Ingeniero Industrial', 4700000, 'Activo'),
('1100457935', 'CE', 'HH345678', 'Daniela', 'Marín', '1994-02-05', '3008765432', 'daniela.marin@email.com', 'Calle 20 #25-30', 'Cali', 'Valle del Cauca', '760001', 'Psicóloga Clínica', 3400000, 'Activo'),
('1100457936', 'CC', '1114567890', 'Julián', 'Pérez', '1980-10-10', '3176543210', 'julian.perez@email.com', 'Av. 30 #35-40', 'Barranquilla', 'Atlántico', '080001', 'Administrador de Empresas', 5500000, 'Activo'),
('1100457937', 'CC', '1115678901', 'Sofía', 'López', '1997-07-07', '3012345678', 'sofia.lopez@email.com', 'Calle 50 #55-60', 'Bucaramanga', 'Santander', '680001', 'Diseñadora Gráfica', 2700000, 'Activo'),
('1100457938', 'CC', '1116789012', 'Carlos', 'Martínez', '1989-01-18', '3158765432', 'carlos.martinez@email.com', 'Carrera 70 #75-80', 'Pereira', 'Risaralda', '660001', 'Desarrollador Web', 4200000, 'Activo'),
('1100457939', 'CC', '1117890123', 'Laura', 'Gómez', '1995-04-04', '3041234567', 'laura.gomez@email.com', 'Calle 1 #2-3', 'Pasto', 'Nariño', '520001', 'Docente', 3000000, 'Activo');

-- Vamos a modificar la fecha de registro de los otros 38 clientes
INSERT INTO Clientes (numero_cuenta, tipo_documento, numero_documento, nombres, apellidos, fecha_nacimiento, telefono, email, direccion, ciudad, departamento, codigo_postal, ocupacion, ingresos_mensuales, estado, fecha_registro) VALUES
('1100457890', 'CC', '1012345678', 'Juan', 'Pérez', '1995-06-15', '3123456789', 'juan.perez@email.com', 'Calle 123 #45-67', 'Bogotá', 'Cundinamarca', '110111', 'Desarrollador', 3500000, 'Activo', '2023-10-20 09:30:00'),
('1100457891', 'CC', '1023456789', 'María', 'Rodríguez', '1988-09-10', '3001234567', 'maria.rodriguez@email.com', 'Carrera 10 #20-30', 'Medellín', 'Antioquia', '050010', 'Diseñadora Gráfica', 2500000, 'Activo', '2024-02-15 11:00:00'),
('1100457892', 'CC', '1034567890', 'Andrés', 'Gómez', '1990-03-25', '3112345670', 'andres.gomez@ejemplo.com', 'Calle 20 #10-30', 'Cali', 'Valle del Cauca', '760001', 'Ingeniero Civil', 4200000, 'Activo', '2023-11-14 10:25:00'),
('1100457893', 'CE', 'AA123456', 'Luisa', 'Martínez', '1985-07-12', '3209876543', 'luisa.martinez@ejemplo.com', 'Carrera 15 #34-56', 'Cartagena', 'Bolívar', '130001', 'Abogada', 6500000, 'Inactivo', '2024-01-09 08:45:00'),
('1100457894', 'CC', '1045678912', 'Camilo', 'Ríos', '2000-11-08', '3105553333', 'camilo.rios@ejemplo.com', 'Av. Siempre Viva #100-01', 'Bucaramanga', 'Santander', '680001', 'Estudiante', 850000, 'Activo', '2025-03-22 14:10:00'),
('1100457895', 'NIT', '800123456', 'Empresa ABC S.A.S.', '', '1999-01-01', '6014567890', 'contacto@empresaabc.com', 'Zona Industrial KM 5', 'Medellín', 'Antioquia', '050010', 'Empresa', 25000000, 'Activo', '2024-10-01 09:00:00'),
('1100457896', 'CC', '1056789012', 'Tatiana', 'Vargas', '1992-09-18', '3004567890', 'tatiana.vargas@ejemplo.com', 'Calle 45 #23-17', 'Pereira', 'Risaralda', '660001', 'Arquitecta', 3700000, 'Activo', '2024-05-17 16:32:00'),
('1100457897', 'CE', 'BB987654', 'José', 'Torres', '1987-05-03', '3157896541', 'jose.torres@ejemplo.com', 'Carrera 9 #89-20', 'Cúcuta', 'Norte de Santander', '540001', 'Técnico Electricista', 2800000, 'Bloqueado', '2023-09-27 12:05:00'),
('1100457898', 'CC', '1067890123', 'Diana', 'López', '1999-12-30', '3012345671', 'diana.lopez@ejemplo.com', 'Calle 1 #2-3', 'Neiva', 'Huila', '410001', 'Docente', 3200000, 'Activo', '2025-01-03 11:45:00'),
('1100457899', 'CC', '1078901234', 'Carlos', 'Mejía', '1994-04-21', '3229876543', 'carlos.mejia@ejemplo.com', 'Carrera 80 #45-60', 'Villavicencio', 'Meta', '500001', 'Agrónomo', 2100000, 'Suspendido', '2024-07-21 19:20:00'),
('1100457900', 'CC', '1089012345', 'Laura', 'Moreno', '1998-08-05', '3123456789', 'laura.moreno@ejemplo.com', 'Calle 12 #34-56', 'Manizales', 'Caldas', '170001', 'Diseñadora UX', 4500000, 'Activo', '2024-12-12 07:35:00'),
('1100457901', 'CC', '1090123456', 'Felipe', 'Castro', '1983-01-19', '3167890123', 'felipe.castro@ejemplo.com', 'Av. 30 #25-55', 'Barranquilla', 'Atlántico', '080001', 'Contador', 3900000, 'Activo', '2023-08-02 13:15:00'),
('1100457902', 'CC', '1091234567', 'Sofía', 'Ramírez', '1997-02-28', '3187654321', 'sofia.ramirez@email.com', 'Calle 7 #8-9', 'Armenia', 'Quindío', '630001', 'Psicóloga', 2900000, 'Activo', '2024-06-01 10:00:00'),
('1100457903', 'CE', 'CC345678', 'David', 'Silva', '1980-11-01', '3051234567', 'david.silva@email.com', 'Carrera 20 #1-2', 'Santa Marta', 'Magdalena', '470001', 'Gerente de Proyectos', 7000000, 'Activo', '2023-07-10 15:30:00'),
('1100457904', 'CC', '1092345678', 'Isabella', 'González', '2001-07-07', '3029876543', 'isabella.gonzalez@email.com', 'Calle 50 #60-70', 'Popayán', 'Cauca', '190001', 'Diseñadora de Modas', 2200000, 'Activo', '2025-02-20 09:15:00'),
('1100457905', 'NIT', '800654321', 'Tecno Solutions Ltda.', '', '2005-03-10', '6047890123', 'info@tecnosolutions.com', 'Av. El Poblado #10-20', 'Medellín', 'Antioquia', '050010', 'Empresa', 30000000, 'Activo', '2024-09-05 14:00:00'),
('1100457906', 'CC', '1093456789', 'Mateo', 'Herrera', '1993-09-03', '3145678901', 'mateo.herrera@email.com', 'Calle 80 #90-10', 'Montería', 'Córdoba', '230001', 'Veterinario', 3100000, 'Activo', '2023-12-25 11:20:00'),
('1100457907', 'CC', '1094567890', 'Valentina', 'Díaz', '1996-01-20', '3008765432', 'valentina.diaz@email.com', 'Carrera 70 #5-15', 'Villavicencio', 'Meta', '500001', 'Nutricionista', 2600000, 'Activo', '2024-04-18 08:00:00'),
('1100457908', 'CC', '1095678901', 'Sebastián', 'Velasco', '1989-06-05', '3132109876', 'sebastian.velasco@email.com', 'Calle 3 #4-5', 'Pasto', 'Nariño', '520001', 'Fotógrafo', 2400000, 'Inactivo', '2025-01-29 17:00:00'),
('1100457909', 'CE', 'DD567890', 'Andrea', 'Castro', '1982-10-14', '3216543210', 'andrea.castro@email.com', 'Av. Circunvalar #100-200', 'Tunja', 'Boyacá', '150001', 'Periodista', 3800000, 'Activo', '2024-11-03 13:40:00'),
('1100457910', 'CC', '1096789012', 'Daniel', 'Rojas', '1991-04-11', '3017890123', 'daniel.rojas@email.com', 'Carrera 4 #5-6', 'Ibagué', 'Tolima', '730001', 'Arquitecto', 4100000, 'Activo', '2023-05-09 10:10:00'),
('1100457911', 'CC', '1097890123', 'Valeria', 'Sierra', '2000-12-01', '3101234567', 'valeria.sierra@email.com', 'Callejón 1 #2-3', 'Yopal', 'Casanare', '850001', 'Marketing Digital', 2700000, 'Activo', '2024-08-14 09:50:00'),
('1100457912', 'CC', '1098901234', 'Diego', 'Guerrero', '1986-08-22', '3176543210', 'diego.guerrero@email.com', 'Carrera 8 #9-10', 'Riohacha', 'La Guajira', '440001', 'Ingeniero de Sistemas', 4800000, 'Activo', '2025-03-01 16:00:00'),
('1100457913', 'NIT', '900112233', 'Global Consultores S.A.S.', '', '2010-07-25', '6019876543', 'contacto@globalconsultores.com', 'Diagonal 45 #50-55', 'Barranquilla', 'Atlántico', '080001', 'Empresa', 45000000, 'Activo', '2024-07-07 11:30:00'),
('1100457914', 'CC', '1099012345', 'Camila', 'Jiménez', '1994-03-17', '3002345678', 'camila.jimenez@email.com', 'Calle 100 #10-10', 'Bucaramanga', 'Santander', '680001', 'Contadora Pública', 3300000, 'Activo', '2023-06-22 14:25:00'),
('1100457915', 'CE', 'EE789012', 'Juan Pablo', 'Ramírez', '1984-05-29', '3203456789', 'juanpablo.ramirez@email.com', 'Carrera 1 #2-3', 'Cali', 'Valle del Cauca', '760001', 'Médico', 7500000, 'Activo', '2025-04-10 10:45:00'),
('1100457916', 'CC', '1100123456', 'Gabriela', 'Ortega', '1998-09-09', '3158765432', 'gabriela.ortega@email.com', 'Calle 25 #30-35', 'Manizales', 'Caldas', '170001', 'Publicista', 2900000, 'Activo', '2024-01-01 07:00:00'),
('1100457917', 'CC', '1101234567', 'José Luis', 'Méndez', '1990-11-16', '3119876540', 'joseluis.mendez@email.com', 'Carrera 50 #55-60', 'Neiva', 'Huila', '410001', 'Electricista', 2300000, 'Activo', '2023-10-05 18:00:00'),
('1100457918', 'CC', '1102345678', 'Natalia', 'Pardo', '1997-04-02', '3041234567', 'natalia.pardo@email.com', 'Calle 60 #70-80', 'Pereira', 'Risaralda', '660001', 'Diseñadora Industrial', 3100000, 'Activo', '2024-03-19 12:15:00'),
('1100457919', 'NIT', '800998877', 'Inversiones XYZ S.A.S.', '', '2008-02-14', '6071234567', 'gerencia@inversionesxyz.com', 'Zona Franca #1-2', 'Cartagena', 'Bolívar', '130001', 'Empresa', 50000000, 'Activo', '2025-02-08 09:30:00'),
('1100457920', 'CC', '1103456789', 'Ricardo', 'Sánchez', '1981-06-21', '3218765432', 'ricardo.sanchez@email.com', 'Carrera 10 #11-12', 'Cúcuta', 'Norte de Santander', '540001', 'Ingeniero Químico', 5200000, 'Activo', '2024-08-28 15:00:00'),
('1100457921', 'CC', '1104567890', 'Carolina', 'Vargas', '1995-10-27', '3009876543', 'carolina.vargas@email.com', 'Calle 15 #16-17', 'Villavicencio', 'Meta', '500001', 'Veterinaria', 3000000, 'Activo', '2023-09-12 11:00:00'),
('1100457922', 'CC', '1105678901', 'Pablo', 'Lozano', '1987-01-09', '3134567890', 'pablo.lozano@email.com', 'Av. Santander #20-25', 'Manizales', 'Caldas', '170001', 'Agrónomo', 3500000, 'Inactivo', '2025-01-15 13:00:00'),
('1100457923', 'CE', 'FF123456', 'María Fernanda', 'Gil', '1992-08-08', '3167890123', 'mariafernanda.gil@email.com', 'Calle 30 #35-40', 'Bucaramanga', 'Santander', '680001', 'Química Farmacéutica', 4000000, 'Activo', '2024-06-29 08:30:00'),
('1100457924', 'CC', '1106789012', 'Esteban', 'Quiroga', '1999-05-19', '3056789012', 'esteban.quiroga@email.com', 'Carrera 80 #85-90', 'Bogotá', 'Cundinamarca', '110111', 'Comunicador Social', 2800000, 'Activo', '2023-07-03 16:45:00'),
('1100457925', 'CC', '1107890123', 'Jimena', 'Sierra', '1983-12-04', '3123456789', 'jimena.sierra@email.com', 'Calle 2 #3-4', 'Medellín', 'Antioquia', '050010', 'Arquitecta', 4300000, 'Activo', '2025-03-08 10:20:00'),
('1100457926', 'NIT', '900223344', 'DataTech Solutions', '', '2015-09-01', '6023456789', 'contact@datatech.com', 'Parque Tecnológico #1', 'Cali', 'Valle del Cauca', '760001', 'Empresa', 28000000, 'Activo', '2024-09-19 09:00:00'),
('1100457927', 'CC', '1108901234', 'Alejandro', 'Fuentes', '1996-02-13', '3145678901', 'alejandro.fuentes@email.com', 'Av. Principal #5-6', 'Cartagena', 'Bolívar', '130001', 'Programador', 3600000, 'Activo', '2023-11-30 14:00:00'),
('1100457928', 'CE', 'GG987654', 'Laura Sofía', 'Ramírez', '1990-07-26', '3001122334', 'laura.ramirez@email.com', 'Calle 10 #12-14', 'Pereira', 'Risaralda', '660001', 'Diseñadora UX/UI', 3900000, 'Activo', '2025-02-25 11:10:00'),
('1100457929', 'CC', '1109012345', 'Fernando', 'Castillo', '1985-04-07', '3189012345', 'fernando.castillo@email.com', 'Carrera 7 #8-9', 'Cúcuta', 'Norte de Santander', '540001', 'Contador', 4000000, 'Activo', '2024-05-02 12:00:00'),
('1100457930', 'CC', '1110123456', 'Mariana', 'Muñoz', '1993-11-11', '3012345678', 'mariana.munoz@email.com', 'Calle 40 #50-60', 'Neiva', 'Huila', '410001', 'Ingeniera de Alimentos', 3200000, 'Activo', '2023-12-18 07:45:00'),
('1100457931', 'CC', '1111234567', 'Andrés Felipe', 'García', '2000-06-29', '3229876543', 'andresfelipe.garcia@email.com', 'Carrera 15 #20-25', 'Villavicencio', 'Meta', '500001', 'Estudiante', 900000, 'Activo', '2025-01-07 16:30:00'),
('1100457932', 'CC', '1112345678', 'Paola', 'Vargas', '1988-03-03', '3123456789', 'paola.vargas@email.com', 'Calle 100 #1-2', 'Manizales', 'Caldas', '170001', 'Abogada', 6000000, 'Activo', '2024-04-22 10:55:00'),
('1100457933', 'NIT', '900334455', 'Innovación Digital S.A.S.', '', '2018-05-12', '6017654321', 'contacto@innovaciondigital.com', 'Centro Comercial #1', 'Bogotá', 'Cundinamarca', '110111', 'Empresa', 35000000, 'Activo', '2023-08-05 09:00:00'),
('1100457934', 'CC', '1113456789', 'Jorge', 'Soto', '1991-09-01', '3167890123', 'jorge.soto@email.com', 'Carrera 10 #1-2', 'Medellín', 'Antioquia', '050010', 'Ingeniero Industrial', 4700000, 'Activo', '2025-03-14 15:20:00'),
('1100457935', 'CE', 'HH345678', 'Daniela', 'Marín', '1994-02-05', '3008765432', 'daniela.marin@email.com', 'Calle 20 #25-30', 'Cali', 'Valle del Cauca', '760001', 'Psicóloga Clínica', 3400000, 'Activo', '2024-10-26 13:00:00'),
('1100457936', 'CC', '1114567890', 'Julián', 'Pérez', '1980-10-10', '3176543210', 'julian.perez@email.com', 'Av. 30 #35-40', 'Barranquilla', 'Atlántico', '080001', 'Administrador de Empresas', 5500000, 'Activo', '2023-06-08 11:00:00'),
('1100457937', 'CC', '1115678901', 'Sofía', 'López', '1997-07-07', '3012345678', 'sofia.lopez@email.com', 'Calle 50 #55-60', 'Bucaramanga', 'Santander', '680001', 'Diseñadora Gráfica', 2700000, 'Activo', '2025-04-01 08:30:00'),
('1100457938', 'CC', '1116789012', 'Carlos', 'Martínez', '1989-01-18', '3158765432', 'carlos.martinez@email.com', 'Carrera 70 #75-80', 'Pereira', 'Risaralda', '660001', 'Desarrollador Web', 4200000, 'Activo', '2024-07-13 14:10:00'),
('1100457939', 'CC', '1117890123', 'Laura', 'Gómez', '1995-04-04', '3041234567', 'laura.gomez@email.com', 'Calle 1 #2-3', 'Pasto', 'Nariño', '520001', 'Docente', 3000000, 'Activo', '2023-09-02 12:40:00')
ON DUPLICATE KEY UPDATE
    tipo_documento = VALUES(tipo_documento),
    numero_documento = VALUES(numero_documento),
    nombres = VALUES(nombres),
    apellidos = VALUES(apellidos),
    fecha_nacimiento = VALUES(fecha_nacimiento),
    telefono = VALUES(telefono),
    email = VALUES(email),
    direccion = VALUES(direccion),
    ciudad = VALUES(ciudad),
    departamento = VALUES(departamento),
    codigo_postal = VALUES(codigo_postal),
    ocupacion = VALUES(ocupacion),
    ingresos_mensuales = VALUES(ingresos_mensuales),
    estado = VALUES(estado),
    fecha_registro = VALUES(fecha_registro);

-- modificar la ultima vez de acceso de los otros 38 clientes
INSERT INTO Clientes (numero_cuenta, tipo_documento, numero_documento, nombres, apellidos, fecha_nacimiento, telefono, email, direccion, ciudad, departamento, codigo_postal, ocupacion, ingresos_mensuales, estado, fecha_registro, ultimo_acceso) VALUES
('1100457890', 'CC', '1012345678', 'Juan', 'Pérez', '1995-06-15', '3123456789', 'juan.perez@email.com', 'Calle 123 #45-67', 'Bogotá', 'Cundinamarca', '110111', 'Desarrollador', 3500000, 'Activo', '2023-10-20 09:30:00', '2025-06-01 22:05:00'),
('1100457891', 'CC', '1023456789', 'María', 'Rodríguez', '1988-09-10', '3001234567', 'maria.rodriguez@email.com', 'Carrera 10 #20-30', 'Medellín', 'Antioquia', '050010', 'Diseñadora Gráfica', 2500000, 'Activo', '2024-02-15 11:00:00', '2025-03-26 10:14:00'),
('1100457892', 'CC', '1034567890', 'Andrés', 'Gómez', '1990-03-25', '3112345670', 'andres.gomez@ejemplo.com', 'Calle 20 #10-30', 'Cali', 'Valle del Cauca', '760001', 'Ingeniero Civil', 4200000, 'Activo', '2023-11-14 10:25:00', '2025-06-22 08:12:00'),
('1100457893', 'CE', 'AA123456', 'Luisa', 'Martínez', '1985-07-12', '3209876543', 'luisa.martinez@ejemplo.com', 'Carrera 15 #34-56', 'Cartagena', 'Bolívar', '130001', 'Abogada', 6500000, 'Inactivo', '2024-01-09 08:45:00', '2025-05-14 17:35:00'),
('1100457894', 'CC', '1045678912', 'Camilo', 'Ríos', '2000-11-08', '3105553333', 'camilo.rios@ejemplo.com', 'Av. Siempre Viva #100-01', 'Bucaramanga', 'Santander', '680001', 'Estudiante', 850000, 'Activo', '2025-03-22 14:10:00', '2025-06-20 13:05:00'),
('1100457895', 'NIT', '800123456', 'Empresa ABC S.A.S.', '', '1999-01-01', '6014567890', 'contacto@empresaabc.com', 'Zona Industrial KM 5', 'Medellín', 'Antioquia', '050010', 'Empresa', 25000000, 'Activo', '2024-10-01 09:00:00', '2025-04-30 09:00:00'),
('1100457896', 'CC', '1056789012', 'Tatiana', 'Vargas', '1992-09-18', '3004567890', 'tatiana.vargas@ejemplo.com', 'Calle 45 #23-17', 'Pereira', 'Risaralda', '660001', 'Arquitecta', 3700000, 'Activo', '2024-05-17 16:32:00', '2025-06-18 22:50:00'),
('1100457897', 'CE', 'BB987654', 'José', 'Torres', '1987-05-03', '3157896541', 'jose.torres@ejemplo.com', 'Carrera 9 #89-20', 'Cúcuta', 'Norte de Santander', '540001', 'Técnico Electricista', 2800000, 'Bloqueado', '2023-09-27 12:05:00', '2024-12-10 10:45:00'),
('1100457898', 'CC', '1067890123', 'Diana', 'López', '1999-12-30', '3012345671', 'diana.lopez@ejemplo.com', 'Calle 1 #2-3', 'Neiva', 'Huila', '410001', 'Docente', 3200000, 'Activo', '2025-01-03 11:45:00', '2025-06-21 06:40:00'),
('1100457899', 'CC', '1078901234', 'Carlos', 'Mejía', '1994-04-21', '3229876543', 'carlos.mejia@ejemplo.com', 'Carrera 80 #45-60', 'Villavicencio', 'Meta', '500001', 'Agrónomo', 2100000, 'Suspendido', '2024-07-21 19:20:00', '2025-03-15 14:20:00'),
('1100457900', 'CC', '1089012345', 'Laura', 'Moreno', '1998-08-05', '3123456789', 'laura.moreno@ejemplo.com', 'Calle 12 #34-56', 'Manizales', 'Caldas', '170001', 'Diseñadora UX', 4500000, 'Activo', '2024-12-12 07:35:00', '2025-06-19 19:30:00'),
('1100457901', 'CC', '1090123456', 'Felipe', 'Castro', '1983-01-19', '3167890123', 'felipe.castro@ejemplo.com', 'Av. 30 #25-55', 'Barranquilla', 'Atlántico', '080001', 'Contador', 3900000, 'Activo', '2023-08-02 13:15:00', '2025-01-27 12:15:00'),
('1100457902', 'CC', '1091234567', 'Sofía', 'Ramírez', '1997-02-28', '3187654321', 'sofia.ramirez@email.com', 'Calle 7 #8-9', 'Armenia', 'Quindío', '630001', 'Psicóloga', 2900000, 'Activo', '2024-06-01 10:00:00', '2025-06-23 10:00:00'),
('1100457903', 'CE', 'CC345678', 'David', 'Silva', '1980-11-01', '3051234567', 'david.silva@email.com', 'Carrera 20 #1-2', 'Santa Marta', 'Magdalena', '470001', 'Gerente de Proyectos', 7000000, 'Activo', '2023-07-10 15:30:00', '2025-05-01 11:30:00'),
('1100457904', 'CC', '1092345678', 'Isabella', 'González', '2001-07-07', '3029876543', 'isabella.gonzalez@email.com', 'Calle 50 #60-70', 'Popayán', 'Cauca', '190001', 'Diseñadora de Modas', 2200000, 'Activo', '2025-02-20 09:15:00', '2025-06-15 09:15:00'),
('1100457905', 'NIT', '800654321', 'Tecno Solutions Ltda.', '', '2005-03-10', '6047890123', 'info@tecnosolutions.com', 'Av. El Poblado #10-20', 'Medellín', 'Antioquia', '050010', 'Empresa', 30000000, 'Activo', '2024-09-05 14:00:00', '2025-04-05 14:00:00'),
('1100457906', 'CC', '1093456789', 'Mateo', 'Herrera', '1993-09-03', '3145678901', 'mateo.herrera@email.com', 'Calle 80 #90-10', 'Montería', 'Córdoba', '230001', 'Veterinario', 3100000, 'Activo', '2023-12-25 11:20:00', '2025-06-10 11:20:00'),
('1100457907', 'CC', '1094567890', 'Valentina', 'Díaz', '1996-01-20', '3008765432', 'valentina.diaz@email.com', 'Carrera 70 #5-15', 'Villavicencio', 'Meta', '500001', 'Nutricionista', 2600000, 'Activo', '2024-04-18 08:00:00', '2025-02-28 08:00:00'),
('1100457908', 'CC', '1095678901', 'Sebastián', 'Velasco', '1989-06-05', '3132109876', 'sebastian.velasco@email.com', 'Calle 3 #4-5', 'Pasto', 'Nariño', '520001', 'Fotógrafo', 2400000, 'Inactivo', '2025-01-29 17:00:00', '2025-06-24 07:00:00'),
('1100457909', 'CE', 'DD567890', 'Andrea', 'Castro', '1982-10-14', '3216543210', 'andrea.castro@email.com', 'Av. Circunvalar #100-200', 'Tunja', 'Boyacá', '150001', 'Periodista', 3800000, 'Activo', '2024-11-03 13:40:00', '2025-03-01 13:40:00'),
('1100457910', 'CC', '1096789012', 'Daniel', 'Rojas', '1991-04-11', '3017890123', 'daniel.rojas@email.com', 'Carrera 4 #5-6', 'Ibagué', 'Tolima', '730001', 'Arquitecto', 4100000, 'Activo', '2023-05-09 10:10:00', '2025-06-17 10:10:00'),
('1100457911', 'CC', '1097890123', 'Valeria', 'Sierra', '2000-12-01', '3101234567', 'valeria.sierra@email.com', 'Callejón 1 #2-3', 'Yopal', 'Casanare', '850001', 'Marketing Digital', 2700000, 'Activo', '2024-08-14 09:50:00', '2025-04-12 09:50:00'),
('1100457912', 'CC', '1098901234', 'Diego', 'Guerrero', '1986-08-22', '3176543210', 'diego.guerrero@email.com', 'Carrera 8 #9-10', 'Riohacha', 'La Guajira', '440001', 'Ingeniero de Sistemas', 4800000, 'Activo', '2025-03-01 16:00:00', '2025-06-23 16:00:00'),
('1100457913', 'NIT', '900112233', 'Global Consultores S.A.S.', '', '2010-07-25', '6019876543', 'contacto@globalconsultores.com', 'Diagonal 45 #50-55', 'Barranquilla', 'Atlántico', '080001', 'Empresa', 45000000, 'Activo', '2024-07-07 11:30:00', '2025-05-05 11:30:00'),
('1100457914', 'CC', '1099012345', 'Camila', 'Jiménez', '1994-03-17', '3002345678', 'camila.jimenez@email.com', 'Calle 100 #10-10', 'Bucaramanga', 'Santander', '680001', 'Contadora Pública', 3300000, 'Activo', '2023-06-22 14:25:00', '2025-06-14 14:25:00'),
('1100457915', 'CE', 'EE789012', 'Juan Pablo', 'Ramírez', '1984-05-29', '3203456789', 'juanpablo.ramirez@email.com', 'Carrera 1 #2-3', 'Cali', 'Valle del Cauca', '760001', 'Médico', 7500000, 'Activo', '2025-04-10 10:45:00', '2025-03-20 10:45:00'),
('1100457916', 'CC', '1100123456', 'Gabriela', 'Ortega', '1998-09-09', '3158765432', 'gabriela.ortega@email.com', 'Calle 25 #30-35', 'Manizales', 'Caldas', '170001', 'Publicista', 2900000, 'Activo', '2024-01-01 07:00:00', '2025-06-22 07:00:00'),
('1100457917', 'CC', '1101234567', 'José Luis', 'Méndez', '1990-11-16', '3119876540', 'joseluis.mendez@email.com', 'Carrera 50 #55-60', 'Neiva', 'Huila', '410001', 'Electricista', 2300000, 'Activo', '2023-10-05 18:00:00', '2025-04-01 18:00:00'),
('1100457918', 'CC', '1102345678', 'Natalia', 'Pardo', '1997-04-02', '3041234567', 'natalia.pardo@email.com', 'Calle 60 #70-80', 'Pereira', 'Risaralda', '660001', 'Diseñadora Industrial', 3100000, 'Activo', '2024-03-19 12:15:00', '2025-06-20 12:15:00'),
('1100457919', 'NIT', '800998877', 'Inversiones XYZ S.A.S.', '', '2008-02-14', '6071234567', 'gerencia@inversionesxyz.com', 'Zona Franca #1-2', 'Cartagena', 'Bolívar', '130001', 'Empresa', 50000000, 'Activo', '2025-02-08 09:30:00', '2025-05-18 09:30:00'),
('1100457920', 'CC', '1103456789', 'Ricardo', 'Sánchez', '1981-06-21', '3218765432', 'ricardo.sanchez@email.com', 'Carrera 10 #11-12', 'Cúcuta', 'Norte de Santander', '540001', 'Ingeniero Químico', 5200000, 'Activo', '2024-08-28 15:00:00', '2025-06-16 15:00:00'),
('1100457921', 'CC', '1104567890', 'Carolina', 'Vargas', '1995-10-27', '3009876543', 'carolina.vargas@email.com', 'Calle 15 #16-17', 'Villavicencio', 'Meta', '500001', 'Veterinaria', 3000000, 'Activo', '2023-09-12 11:00:00', '2025-03-09 11:00:00'),
('1100457922', 'CC', '1105678901', 'Pablo', 'Lozano', '1987-01-09', '3134567890', 'pablo.lozano@email.com', 'Av. Santander #20-25', 'Manizales', 'Caldas', '170001', 'Agrónomo', 3500000, 'Inactivo', '2025-01-15 13:00:00', '2025-06-24 13:00:00'),
('1100457923', 'CE', 'FF123456', 'María Fernanda', 'Gil', '1992-08-08', '3167890123', 'mariafernanda.gil@email.com', 'Calle 30 #35-40', 'Bucaramanga', 'Santander', '680001', 'Química Farmacéutica', 4000000, 'Activo', '2024-06-29 08:30:00', '2025-04-25 08:30:00'),
('1100457924', 'CC', '1106789012', 'Esteban', 'Quiroga', '1999-05-19', '3056789012', 'esteban.quiroga@email.com', 'Carrera 80 #85-90', 'Bogotá', 'Cundinamarca', '110111', 'Comunicador Social', 2800000, 'Activo', '2023-07-03 16:45:00', '2025-06-13 16:45:00'),
('1100457925', 'CC', '1107890123', 'Jimena', 'Sierra', '1983-12-04', '3123456789', 'jimena.sierra@email.com', 'Calle 2 #3-4', 'Medellín', 'Antioquia', '050010', 'Arquitecta', 4300000, 'Activo', '2025-03-08 10:20:00', '2025-05-08 10:20:00'),
('1100457926', 'NIT', '900223344', 'DataTech Solutions', '', '2015-09-01', '6023456789', 'contact@datatech.com', 'Parque Tecnológico #1', 'Cali', 'Valle del Cauca', '760001', 'Empresa', 28000000, 'Activo', '2024-09-19 09:00:00', '2025-06-22 09:00:00'),
('1100457927', 'CC', '1108901234', 'Alejandro', 'Fuentes', '1996-02-13', '3145678901', 'alejandro.fuentes@email.com', 'Av. Principal #5-6', 'Cartagena', 'Bolívar', '130001', 'Programador', 3600000, 'Activo', '2023-11-30 14:00:00', '2025-04-03 14:00:00'),
('1100457928', 'CE', 'GG987654', 'Laura Sofía', 'Ramírez', '1990-07-26', '3001122334', 'laura.ramirez@email.com', 'Calle 10 #12-14', 'Pereira', 'Risaralda', '660001', 'Diseñadora UX/UI', 3900000, 'Activo', '2025-02-25 11:10:00', '2025-06-11 11:10:00'),
('1100457929', 'CC', '1109012345', 'Fernando', 'Castillo', '1985-04-07', '3189012345', 'fernando.castillo@email.com', 'Carrera 7 #8-9', 'Cúcuta', 'Norte de Santander', '540001', 'Contador', 4000000, 'Activo', '2024-05-02 12:00:00', '2025-05-20 12:00:00'),
('1100457930', 'CC', '1110123456', 'Mariana', 'Muñoz', '1993-11-11', '3012345678', 'mariana.munoz@email.com', 'Calle 40 #50-60', 'Neiva', 'Huila', '410001', 'Ingeniera de Alimentos', 3200000, 'Activo', '2023-12-18 07:45:00', '2025-06-24 07:45:00'),
('1100457931', 'CC', '1111234567', 'Andrés Felipe', 'García', '2000-06-29', '3229876543', 'andresfelipe.garcia@email.com', 'Carrera 15 #20-25', 'Villavicencio', 'Meta', '500001', 'Estudiante', 900000, 'Activo', '2025-01-07 16:30:00', '2025-03-29 16:30:00'),
('1100457932', 'CC', '1112345678', 'Paola', 'Vargas', '1988-03-03', '3123456789', 'paola.vargas@email.com', 'Calle 100 #1-2', 'Manizales', 'Caldas', '170001', 'Abogada', 6000000, 'Activo', '2024-04-22 10:55:00', '2025-06-19 10:55:00'),
('1100457933', 'NIT', '900334455', 'Innovación Digital S.A.S.', '', '2018-05-12', '6017654321', 'contacto@innovaciondigital.com', 'Centro Comercial #1', 'Bogotá', 'Cundinamarca', '110111', 'Empresa', 35000000, 'Activo', '2023-08-05 09:00:00', '2025-04-15 09:00:00'),
('1100457934', 'CC', '1113456789', 'Jorge', 'Soto', '1991-09-01', '3167890123', 'jorge.soto@email.com', 'Carrera 10 #1-2', 'Medellín', 'Antioquia', '050010', 'Ingeniero Industrial', 4700000, 'Activo', '2025-03-14 15:20:00', '2025-06-23 15:20:00'),
('1100457935', 'CE', 'HH345678', 'Daniela', 'Marín', '1994-02-05', '3008765432', 'daniela.marin@email.com', 'Calle 20 #25-30', 'Cali', 'Valle del Cauca', '760001', 'Psicóloga Clínica', 3400000, 'Activo', '2024-10-26 13:00:00', '2025-05-22 13:00:00'),
('1100457936', 'CC', '1114567890', 'Julián', 'Pérez', '1980-10-10', '3176543210', 'julian.perez@email.com', 'Av. 30 #35-40', 'Barranquilla', 'Atlántico', '080001', 'Administrador de Empresas', 5500000, 'Activo', '2023-06-08 11:00:00', '2025-06-12 11:00:00'),
('1100457937', 'CC', '1115678901', 'Sofía', 'López', '1997-07-07', '3012345678', 'sofia.lopez@email.com', 'Calle 50 #55-60', 'Bucaramanga', 'Santander', '680001', 'Diseñadora Gráfica', 2700000, 'Activo', '2025-04-01 08:30:00', '2025-04-08 08:30:00'),
('1100457938', 'CC', '1116789012', 'Carlos', 'Martínez', '1989-01-18', '3158765432', 'carlos.martinez@email.com', 'Carrera 70 #75-80', 'Pereira', 'Risaralda', '660001', 'Desarrollador Web', 4200000, 'Activo', '2024-07-13 14:10:00', '2025-06-21 14:10:00'),
('1117890123', 'CC', '1117890123', 'Laura', 'Gómez', '1995-04-04', '3041234567', 'laura.gomez@email.com', 'Calle 1 #2-3', 'Pasto', 'Nariño', '520001', 'Docente', 3000000, 'Activo', '2023-09-02 12:40:00', '2025-05-03 12:40:00')
ON DUPLICATE KEY UPDATE
    tipo_documento = VALUES(tipo_documento),
    numero_documento = VALUES(numero_documento),
    nombres = VALUES(nombres),
    apellidos = VALUES(apellidos),
    fecha_nacimiento = VALUES(fecha_nacimiento),
    telefono = VALUES(telefono),
    email = VALUES(email),
    direccion = VALUES(direccion),
    ciudad = VALUES(ciudad),
    departamento = VALUES(departamento),
    codigo_postal = VALUES(codigo_postal),
    ocupacion = VALUES(ocupacion),
    ingresos_mensuales = VALUES(ingresos_mensuales),
    estado = VALUES(estado),
    fecha_registro = VALUES(fecha_registro),
    ultimo_acceso = VALUES(ultimo_acceso);

-- Inserccion de las observaciones de los otros 38 clientes
INSERT INTO Clientes (numero_cuenta, tipo_documento, numero_documento, nombres, apellidos, fecha_nacimiento, telefono, email, direccion, ciudad, departamento, codigo_postal, ocupacion, ingresos_mensuales, estado, fecha_registro, ultimo_acceso, observaciones) VALUES
('1100457890', 'CC', '1012345678', 'Juan', 'Pérez', '1995-06-15', '3123456789', 'juan.perez@email.com', 'Calle 123 #45-67', 'Bogotá', 'Cundinamarca', '110111', 'Desarrollador', 3500000, 'Activo', '2023-10-20 09:30:00', '2025-06-01 22:05:00', NULL),
('1100457891', 'CC', '1023456789', 'María', 'Rodríguez', '1988-09-10', '3001234567', 'maria.rodriguez@email.com', 'Carrera 10 #20-30', 'Medellín', 'Antioquia', '050010', 'Diseñadora Gráfica', 2500000, 'Activo', '2024-02-15 11:00:00', '2025-03-26 10:14:00', NULL),
('1100457892', 'CC', '1034567890', 'Andrés', 'Gómez', '1990-03-25', '3112345670', 'andres.gomez@ejemplo.com', 'Calle 20 #10-30', 'Cali', 'Valle del Cauca', '760001', 'Ingeniero Civil', 4200000, 'Activo', '2023-11-14 10:25:00', '2025-06-22 08:12:00', NULL),
('1100457893', 'CE', 'AA123456', 'Luisa', 'Martínez', '1985-07-12', '3209876543', 'luisa.martinez@ejemplo.com', 'Carrera 15 #34-56', 'Cartagena', 'Bolívar', '130001', 'Abogada', 6500000, 'Inactivo', '2024-01-09 08:45:00', '2025-05-14 17:35:00', 'Cliente inactivo, contactar para reactivación.'),
('1100457894', 'CC', '1045678912', 'Camilo', 'Ríos', '2000-11-08', '3105553333', 'camilo.rios@ejemplo.com', 'Av. Siempre Viva #100-01', 'Bucaramanga', 'Santander', '680001', 'Estudiante', 850000, 'Activo', '2025-03-22 14:10:00', '2025-06-20 13:05:00', 'Ingresos bajos por ser estudiante.'),
('1100457895', 'NIT', '800123456', 'Empresa ABC S.A.S.', '', '1999-01-01', '6014567890', 'contacto@empresaabc.com', 'Zona Industrial KM 5', 'Medellín', 'Antioquia', '050010', 'Empresa', 25000000, 'Activo', '2024-10-01 09:00:00', '2025-04-30 09:00:00', 'Gran volumen de ingresos. Potencial cliente VIP.'),
('1100457896', 'CC', '1056789012', 'Tatiana', 'Vargas', '1992-09-18', '3004567890', 'tatiana.vargas@ejemplo.com', 'Calle 45 #23-17', 'Pereira', 'Risaralda', '660001', 'Arquitecta', 3700000, 'Activo', '2024-05-17 16:32:00', '2025-06-18 22:50:00', NULL),
('1100457897', 'CE', 'BB987654', 'José', 'Torres', '1987-05-03', '3157896541', 'jose.torres@ejemplo.com', 'Carrera 9 #89-20', 'Cúcuta', 'Norte de Santander', '540001', 'Técnico Electricista', 2800000, 'Bloqueado', '2023-09-27 12:05:00', '2024-12-10 10:45:00', 'Cuenta bloqueada por incumplimiento. Revisar historial.'),
('1100457898', 'CC', '1067890123', 'Diana', 'López', '1999-12-30', '3012345671', 'diana.lopez@ejemplo.com', 'Calle 1 #2-3', 'Neiva', 'Huila', '410001', 'Docente', 3200000, 'Activo', '2025-01-03 11:45:00', '2025-06-21 06:40:00', NULL),
('1100457899', 'CC', '1078901234', 'Carlos', 'Mejía', '1994-04-21', '3229876543', 'carlos.mejia@ejemplo.com', 'Carrera 80 #45-60', 'Villavicencio', 'Meta', '500001', 'Agrónomo', 2100000, 'Suspendido', '2024-07-21 19:20:00', '2025-03-15 14:20:00', 'Cuenta suspendida, requiere verificación.'),
('1100457900', 'CC', '1089012345', 'Laura', 'Moreno', '1998-08-05', '3123456789', 'laura.moreno@ejemplo.com', 'Calle 12 #34-56', 'Manizales', 'Caldas', '170001', 'Diseñadora UX', 4500000, 'Activo', '2024-12-12 07:35:00', '2025-06-19 19:30:00', NULL),
('1100457901', 'CC', '1090123456', 'Felipe', 'Castro', '1983-01-19', '3167890123', 'felipe.castro@ejemplo.com', 'Av. 30 #25-55', 'Barranquilla', 'Atlántico', '080001', 'Contador', 3900000, 'Activo', '2023-08-02 13:15:00', '2025-01-27 12:15:00', NULL),
('1100457902', 'CC', '1091234567', 'Sofía', 'Ramírez', '1997-02-28', '3187654321', 'sofia.ramirez@email.com', 'Calle 7 #8-9', 'Armenia', 'Quindío', '630001', 'Psicóloga', 2900000, 'Activo', '2024-06-01 10:00:00', '2025-06-23 10:00:00', NULL),
('1100457903', 'CE', 'CC345678', 'David', 'Silva', '1980-11-01', '3051234567', 'david.silva@email.com', 'Carrera 20 #1-2', 'Santa Marta', 'Magdalena', '470001', 'Gerente de Proyectos', 7000000, 'Activo', '2023-07-10 15:30:00', '2025-05-01 11:30:00', 'Ingresos altos. Potencial para productos premium.'),
('1100457904', 'CC', '1092345678', 'Isabella', 'González', '2001-07-07', '3029876543', 'isabella.gonzalez@email.com', 'Calle 50 #60-70', 'Popayán', 'Cauca', '190001', 'Diseñadora de Modas', 2200000, 'Activo', '2025-02-20 09:15:00', '2025-06-15 09:15:00', NULL),
('1100457905', 'NIT', '800654321', 'Tecno Solutions Ltda.', '', '2005-03-10', '6047890123', 'info@tecnosolutions.com', 'Av. El Poblado #10-20', 'Medellín', 'Antioquia', '050010', 'Empresa', 30000000, 'Activo', '2024-09-05 14:00:00', '2025-04-05 14:00:00', 'Empresa con alto volumen transaccional.'),
('1100457906', 'CC', '1093456789', 'Mateo', 'Herrera', '1993-09-03', '3145678901', 'mateo.herrera@email.com', 'Calle 80 #90-10', 'Montería', 'Córdoba', '230001', 'Veterinario', 3100000, 'Activo', '2023-12-25 11:20:00', '2025-06-10 11:20:00', NULL),
('1100457907', 'CC', '1094567890', 'Valentina', 'Díaz', '1996-01-20', '3008765432', 'valentina.diaz@email.com', 'Carrera 70 #5-15', 'Villavicencio', 'Meta', '500001', 'Nutricionista', 2600000, 'Activo', '2024-04-18 08:00:00', '2025-02-28 08:00:00', NULL),
('1100457908', 'CC', '1095678901', 'Sebastián', 'Velasco', '1989-06-05', '3132109876', 'sebastian.velasco@email.com', 'Calle 3 #4-5', 'Pasto', 'Nariño', '520001', 'Fotógrafo', 2400000, 'Inactivo', '2025-01-29 17:00:00', '2025-06-24 07:00:00', 'Inactivo, con acceso reciente. Contactar.'),
('1100457909', 'CE', 'DD567890', 'Andrea', 'Castro', '1982-10-14', '3216543210', 'andrea.castro@email.com', 'Av. Circunvalar #100-200', 'Tunja', 'Boyacá', '150001', 'Periodista', 3800000, 'Activo', '2024-11-03 13:40:00', '2025-03-01 13:40:00', NULL),
('1100457910', 'CC', '1096789012', 'Daniel', 'Rojas', '1991-04-11', '3017890123', 'daniel.rojas@email.com', 'Carrera 4 #5-6', 'Ibagué', 'Tolima', '730001', 'Arquitecto', 4100000, 'Activo', '2023-05-09 10:10:00', '2025-06-17 10:10:00', NULL),
('1100457911', 'CC', '1097890123', 'Valeria', 'Sierra', '2000-12-01', '3101234567', 'valeria.sierra@email.com', 'Callejón 1 #2-3', 'Yopal', 'Casanare', '850001', 'Marketing Digital', 2700000, 'Activo', '2024-08-14 09:50:00', '2025-04-12 09:50:00', NULL),
('1100457912', 'CC', '1098901234', 'Diego', 'Guerrero', '1986-08-22', '3176543210', 'diego.guerrero@email.com', 'Carrera 8 #9-10', 'Riohacha', 'La Guajira', '440001', 'Ingeniero de Sistemas', 4800000, 'Activo', '2025-03-01 16:00:00', '2025-06-23 16:00:00', NULL),
('1100457913', 'NIT', '900112233', 'Global Consultores S.A.S.', '', '2010-07-25', '6019876543', 'contacto@globalconsultores.com', 'Diagonal 45 #50-55', 'Barranquilla', 'Atlántico', '080001', 'Empresa', 45000000, 'Activo', '2024-07-07 11:30:00', '2025-05-05 11:30:00', 'Empresa de consultoría, ingresos muy altos.'),
('1100457914', 'CC', '1099012345', 'Camila', 'Jiménez', '1994-03-17', '3002345678', 'camila.jimenez@email.com', 'Calle 100 #10-10', 'Bucaramanga', 'Santander', '680001', 'Contadora Pública', 3300000, 'Activo', '2023-06-22 14:25:00', '2025-06-14 14:25:00', NULL),
('1100457915', 'CE', 'EE789012', 'Juan Pablo', 'Ramírez', '1984-05-29', '3203456789', 'juanpablo.ramirez@email.com', 'Carrera 1 #2-3', 'Cali', 'Valle del Cauca', '760001', 'Médico', 7500000, 'Activo', '2025-04-10 10:45:00', '2025-03-20 10:45:00', 'Profesional de la salud, ingresos significativos.'),
('1100457916', 'CC', '1100123456', 'Gabriela', 'Ortega', '1998-09-09', '3158765432', 'gabriela.ortega@email.com', 'Calle 25 #30-35', 'Manizales', 'Caldas', '170001', 'Publicista', 2900000, 'Activo', '2024-01-01 07:00:00', '2025-06-22 07:00:00', NULL),
('1100457917', 'CC', '1101234567', 'José Luis', 'Méndez', '1990-11-16', '3119876540', 'joseluis.mendez@email.com', 'Carrera 50 #55-60', 'Neiva', 'Huila', '410001', 'Electricista', 2300000, 'Activo', '2023-10-05 18:00:00', '2025-04-01 18:00:00', NULL),
('1100457918', 'CC', '1102345678', 'Natalia', 'Pardo', '1997-04-02', '3041234567', 'natalia.pardo@email.com', 'Calle 60 #70-80', 'Pereira', 'Risaralda', '660001', 'Diseñadora Industrial', 3100000, 'Activo', '2024-03-19 12:15:00', '2025-06-20 12:15:00', NULL),
('1100457919', 'NIT', '800998877', 'Inversiones XYZ S.A.S.', '', '2008-02-14', '6071234567', 'gerencia@inversionesxyz.com', 'Zona Franca #1-2', 'Cartagena', 'Bolívar', '130001', 'Empresa', 50000000, 'Activo', '2025-02-08 09:30:00', '2025-05-18 09:30:00', 'Mayor cliente empresarial, alto potencial.'),
('1100457920', 'CC', '1103456789', 'Ricardo', 'Sánchez', '1981-06-21', '3218765432', 'ricardo.sanchez@email.com', 'Carrera 10 #11-12', 'Cúcuta', 'Norte de Santander', '540001', 'Ingeniero Químico', 5200000, 'Activo', '2024-08-28 15:00:00', '2025-06-16 15:00:00', NULL),
('1100457921', 'CC', '1104567890', 'Carolina', 'Vargas', '1995-10-27', '3009876543', 'carolina.vargas@email.com', 'Calle 15 #16-17', 'Villavicencio', 'Meta', '500001', 'Veterinaria', 3000000, 'Activo', '2023-09-12 11:00:00', '2025-03-09 11:00:00', NULL),
('1100457922', 'CC', '1105678901', 'Pablo', 'Lozano', '1987-01-09', '3134567890', 'pablo.lozano@email.com', 'Av. Santander #20-25', 'Manizales', 'Caldas', '170001', 'Agrónomo', 3500000, 'Inactivo', '2025-01-15 13:00:00', '2025-06-24 13:00:00', 'Cliente inactivo, pero con acceso reciente. Indagar razón.'),
('1100457923', 'CE', 'FF123456', 'María Fernanda', 'Gil', '1992-08-08', '3167890123', 'mariafernanda.gil@email.com', 'Calle 30 #35-40', 'Bucaramanga', 'Santander', '680001', 'Química Farmacéutica', 4000000, 'Activo', '2024-06-29 08:30:00', '2025-04-25 08:30:00', NULL),
('1100457924', 'CC', '1106789012', 'Esteban', 'Quiroga', '1999-05-19', '3056789012', 'esteban.quiroga@email.com', 'Carrera 80 #85-90', 'Bogotá', 'Cundinamarca', '110111', 'Comunicador Social', 2800000, 'Activo', '2023-07-03 16:45:00', '2025-06-13 16:45:00', NULL),
('1100457925', 'CC', '1107890123', 'Jimena', 'Sierra', '1983-12-04', '3123456789', 'jimena.sierra@email.com', 'Calle 2 #3-4', 'Medellín', 'Antioquia', '050010', 'Arquitecta', 4300000, 'Activo', '2025-03-08 10:20:00', '2025-05-08 10:20:00', NULL),
('1100457926', 'NIT', '900223344', 'DataTech Solutions', '', '2015-09-01', '6023456789', 'contact@datatech.com', 'Parque Tecnológico #1', 'Cali', 'Valle del Cauca', '760001', 'Empresa', 28000000, 'Activo', '2024-09-19 09:00:00', '2025-06-22 09:00:00', 'Empresa de tecnología, potencial de crecimiento.'),
('1100457927', 'CC', '1108901234', 'Alejandro', 'Fuentes', '1996-02-13', '3145678901', 'alejandro.fuentes@email.com', 'Av. Principal #5-6', 'Cartagena', 'Bolívar', '130001', 'Programador', 3600000, 'Activo', '2023-11-30 14:00:00', '2025-04-03 14:00:00', NULL),
('1100457928', 'CE', 'GG987654', 'Laura Sofía', 'Ramírez', '1990-07-26', '3001122334', 'laura.ramirez@email.com', 'Calle 10 #12-14', 'Pereira', 'Risaralda', '660001', 'Diseñadora UX/UI', 3900000, 'Activo', '2025-02-25 11:10:00', '2025-06-11 11:10:00', NULL),
('1100457929', 'CC', '1109012345', 'Fernando', 'Castillo', '1985-04-07', '3189012345', 'fernando.castillo@email.com', 'Carrera 7 #8-9', 'Cúcuta', 'Norte de Santander', '540001', 'Contador', 4000000, 'Activo', '2024-05-02 12:00:00', '2025-05-20 12:00:00', NULL),
('1100457930', 'CC', '1110123456', 'Mariana', 'Muñoz', '1993-11-11', '3012345678', 'mariana.munoz@email.com', 'Calle 40 #50-60', 'Neiva', 'Huila', '410001', 'Ingeniera de Alimentos', 3200000, 'Activo', '2023-12-18 07:45:00', '2025-06-24 07:45:00', NULL),
('1100457931', 'CC', '1111234567', 'Andrés Felipe', 'García', '2000-06-29', '3229876543', 'andresfelipe.garcia@email.com', 'Carrera 15 #20-25', 'Villavicencio', 'Meta', '500001', 'Estudiante', 900000, 'Activo', '2025-01-07 16:30:00', '2025-03-29 16:30:00', 'Ingresos bajos, perfil estudiantil.'),
('1100457932', 'CC', '1112345678', 'Paola', 'Vargas', '1988-03-03', '3123456789', 'paola.vargas@email.com', 'Calle 100 #1-2', 'Manizales', 'Caldas', '170001', 'Abogada', 6000000, 'Activo', '2024-04-22 10:55:00', '2025-06-19 10:55:00', 'Profesional con altos ingresos.'),
('1100457933', 'NIT', '900334455', 'Innovación Digital S.A.S.', '', '2018-05-12', '6017654321', 'contacto@innovaciondigital.com', 'Centro Comercial #1', 'Bogotá', 'Cundinamarca', '110111', 'Empresa', 35000000, 'Activo', '2023-08-05 09:00:00', '2025-04-15 09:00:00', 'Empresa con historial de innovación.'),
('1100457934', 'CC', '1113456789', 'Jorge', 'Soto', '1991-09-01', '3167890123', 'jorge.soto@email.com', 'Carrera 10 #1-2', 'Medellín', 'Antioquia', '050010', 'Ingeniero Industrial', 4700000, 'Activo', '2025-03-14 15:20:00', '2025-06-23 15:20:00', NULL),
('1100457935', 'CE', 'HH345678', 'Daniela', 'Marín', '1994-02-05', '3008765432', 'daniela.marin@email.com', 'Calle 20 #25-30', 'Cali', 'Valle del Cauca', '760001', 'Psicóloga Clínica', 3400000, 'Activo', '2024-10-26 13:00:00', '2025-05-22 13:00:00', NULL),
('1100457936', 'CC', '1114567890', 'Julián', 'Pérez', '1980-10-10', '3176543210', 'julian.perez@email.com', 'Av. 30 #35-40', 'Barranquilla', 'Atlántico', '080001', 'Administrador de Empresas', 5500000, 'Activo', '2023-06-08 11:00:00', '2025-06-12 11:00:00', 'Perfil directivo, con ingresos sólidos.'),
('1100457937', 'CC', '1115678901', 'Sofía', 'López', '1997-07-07', '3012345678', 'sofia.lopez@email.com', 'Calle 50 #55-60', 'Bucaramanga', 'Santander', '680001', 'Diseñadora Gráfica', 2700000, 'Activo', '2025-04-01 08:30:00', '2025-04-08 08:30:00', NULL),
('1100457938', 'CC', '1116789012', 'Carlos', 'Martínez', '1989-01-18', '3158765432', 'carlos.martinez@email.com', 'Carrera 70 #75-80', 'Pereira', 'Risaralda', '660001', 'Desarrollador Web', 4200000, 'Activo', '2024-07-13 14:10:00', '2025-06-21 14:10:00', NULL),
('1117890123', 'CC', '1117890123', 'Laura', 'Gómez', '1995-04-04', '3041234567', 'laura.gomez@email.com', 'Calle 1 #2-3', 'Pasto', 'Nariño', '520001', 'Docente', 3000000, 'Activo', '2023-09-02 12:40:00', '2025-05-03 12:40:00', NULL)
ON DUPLICATE KEY UPDATE
    tipo_documento = VALUES(tipo_documento),
    numero_documento = VALUES(numero_documento),
    nombres = VALUES(nombres),
    apellidos = VALUES(apellidos),
    fecha_nacimiento = VALUES(fecha_nacimiento),
    telefono = VALUES(telefono),
    email = VALUES(email),
    direccion = VALUES(direccion),
    ciudad = VALUES(ciudad),
    departamento = VALUES(departamento),
    codigo_postal = VALUES(codigo_postal),
    ocupacion = VALUES(ocupacion),
    ingresos_mensuales = VALUES(ingresos_mensuales),
    estado = VALUES(estado),
    fecha_registro = VALUES(fecha_registro),
    ultimo_acceso = VALUES(ultimo_acceso),
    observaciones = VALUES(observaciones);

-- inserccion de las 38 tarjetas faltantes
INSERT INTO tarjetas (numero_tarjeta, cliente_id, tipo_tarjeta_id, descuento_id, monto_apertura, limite_credito, saldo_disponible, fecha_apertura, fecha_vencimiento, fecha_ultimo_uso, pin_encriptado, estado, motivo_bloqueo, observaciones) VALUES
('4532-0000-1111-2222', 13, 1, 1, 75000, 600000, 550000, '2024-04-01', '2027-04-01', '2025-06-23 10:15:00', 'pin13', 'Activa', NULL, 'Primera tarjeta del cliente.'),
('4532-2222-3333-4444', 14, 2, 2, 150000, 1200000, 1100000, '2023-03-10', '2026-03-10', '2025-06-19 16:30:00', 'pin14', 'Activa', NULL, 'Cliente con buen historial de crédito.'),
('4532-5678-9012-3456', 15, 3, 3, 300000, 2000000, 1900000, '2024-08-01', '2027-08-01', '2025-06-24 10:00:00', 'pin15', 'Activa', NULL, 'Tarjeta de crédito principal del cliente.'),
('4532-7890-1234-5678', 16, 4, 4, 800000, 7000000, 6500000, '2023-01-20', '2026-01-20', '2025-06-10 11:30:00', 'pin16', 'Activa', NULL, 'Cliente frecuente con alto límite.'),
('4532-1122-3344-5566', 17, 1, 1, 55000, 300000, 280000, '2025-03-15', '2028-03-15', NULL, 'pin17', 'Activa', NULL, 'Tarjeta para cliente con ingresos bajos.'),
('4532-6789-0123-4567', 18, 5, 5, 2500000, 12000000, 10000000, '2024-05-01', '2029-05-01', '2025-06-22 09:45:00', 'pin18', 'Activa', NULL, 'Tarjeta corporativa de alta prioridad.'),
('4532-0011-2233-4455', 19, 2, 2, 100000, 800000, 750000, '2023-09-05', '2026-09-05', '2025-06-17 14:00:00', 'pin19', 'Activa', NULL, NULL),
('4532-9988-7766-5544', 20, 3, 3, 180000, 1400000, 1300000, '2024-06-01', '2027-06-01', NULL, 'pin20', 'Activa', NULL, 'Cliente con pagos siempre puntuales.'),
('4532-1357-2468-9012', 21, 1, 1, 40000, 150000, 100000, '2025-01-20', '2027-01-20', NULL, 'pin21', 'Activa', NULL, 'Tarjeta recién emitida, sin actividad registrada.'), -- Cambiado de 'Inactiva' a 'Activa'
('4532-2468-1357-9012', 22, 4, 3, 900000, 4800000, 4000000, '2022-11-15', '2025-11-15', '2025-06-05 18:00:00', 'pin22', 'Activa', NULL, 'Tarjeta con historial de compras grandes.'),
('4532-1111-0000-9999', 23, 2, 1, 110000, 900000, 850000, '2024-02-28', '2027-02-28', '2025-06-20 09:30:00', 'pin23', 'Activa', NULL, NULL),
('4532-3333-2222-1111', 24, 3, 2, 220000, 1600000, 1500000, '2023-07-12', '2026-07-12', '2025-06-18 11:00:00', 'pin24', 'Activa', NULL, NULL),
('4532-6666-5555-4444', 25, 1, 1, 65000, 550000, 500000, '2024-09-01', '2027-09-01', '2025-06-23 15:00:00', 'pin25', 'Activa', NULL, 'Cliente con historial corto, pero buen uso.'),
('4532-9999-8888-7777', 26, 5, 5, 3000000, 15000000, 12000000, '2023-04-05', '2028-04-05', '2025-06-21 10:00:00', 'pin26', 'Activa', NULL, 'Tarjeta de la más alta gama, uso constante.'),
('4532-0101-0202-0303', 27, 2, 2, 130000, 1100000, 1000000, '2025-01-05', '2028-01-05', NULL, 'pin27', 'Activa', NULL, 'Emitida recientemente, en espera de primer uso.'),
('4532-0303-0202-0101', 28, 3, 3, 270000, 1900000, 1750000, '2024-02-10', '2027-02-10', '2025-06-20 17:00:00', 'pin28', 'Activa', NULL, NULL),
('4532-1472-5836-9012', 29, 1, 1, 45000, 180000, 150000, '2025-04-01', '2028-04-01', NULL, 'pin29', 'Activa', NULL, 'Tarjeta de entrada, límite conservador.'),
('4532-3691-2580-7410', 30, 4, 4, 600000, 5000000, 4800000, '2023-08-18', '2026-08-18', '2025-06-16 12:30:00', 'pin30', 'Activa', NULL, 'Límite de crédito importante para el cliente.'),
('4532-2580-7410-3691', 31, 2, 2, 160000, 1300000, 1200000, '2024-01-25', '2027-01-25', '2025-06-22 09:00:00', 'pin31', 'Activa', NULL, NULL),
('4532-7891-2345-6789', 32, 5, 5, 2200000, 11000000, 9500000, '2024-06-01', '2029-06-01', '2025-06-24 15:00:00', 'pin32', 'Activa', NULL, 'Cliente corporativo de alto valor.'),
('4532-0000-0000-0000', 33, 1, 1, 50000, 200000, 0, '2025-03-01', '2027-03-01', NULL, 'pin33', 'Activa', NULL, 'Saldo en cero, listo para primer uso.'),
('4532-1212-1313-1414', 34, 2, 1, 100000, 750000, 700000, '2023-10-01', '2026-10-01', '2025-06-19 10:00:00', 'pin34', 'Activa', NULL, NULL),
('4532-1515-1616-1717', 35, 3, 2, 200000, 1500000, 1400000, '2024-04-20', '2027-04-20', '2025-06-20 11:00:00', 'pin35', 'Activa', NULL, 'Buen comportamiento de pago, uso frecuente.'),
('4532-1818-1919-2020', 36, 4, 3, 750000, 6500000, 6000000, '2023-02-15', '2026-02-15', '2025-06-15 13:00:00', 'pin36', 'Activa', NULL, 'Tarjeta de crédito principal para el cliente.'),
('4532-2121-2222-2323', 37, 1, 1, 60000, 450000, 400000, '2025-05-10', '2028-05-10', NULL, 'pin37', 'Activa', NULL, 'Nueva emisión, espera de activación.'),
('4532-2424-2525-2626', 38, 5, 4, 1800000, 9500000, 9000000, '2024-08-10', '2029-08-10', '2025-06-23 08:30:00', 'pin38', 'Activa', NULL, 'Cliente VIP, uso frecuente y alto límite.'),
('4532-2727-2828-2929', 39, 2, 2, 140000, 1150000, 1050000, '2023-05-01', '2026-05-01', '2025-06-18 16:00:00', 'pin39', 'Activa', NULL, NULL),
('4532-3030-3131-3232', 40, 3, 3, 230000, 1700000, 1600000, '2024-03-05', '2027-03-05', '2025-06-21 11:45:00', 'pin40', 'Activa', NULL, NULL),
('4532-3333-3434-3535', 41, 1, 1, 70000, 500000, 450000, '2025-02-20', '2028-02-20', NULL, 'pin41', 'Activa', NULL, 'Tarjeta de uso diario.'),
('4532-3636-3737-3838', 42, 4, 4, 850000, 7200000, 6800000, '2023-09-10', '2026-09-10', '2025-06-17 09:00:00', 'pin42', 'Activa', NULL, 'Cliente con gran capacidad de gasto.'),
('4532-3939-4040-4141', 43, 2, 2, 180000, 1400000, 1300000, '2024-07-01', '2027-07-01', '2025-06-24 10:30:00', 'pin43', 'Activa', NULL, NULL),
('4532-4242-4343-4444', 44, 1, 1, 50000, 250000, 200000, '2025-01-10', '2027-01-10', NULL, 'pin44', 'Activa', NULL, 'Tarjeta ideal para jóvenes.'),
('4532-4545-4646-4747', 45, 3, 2, 260000, 1850000, 1700000, '2023-04-15', '2026-04-15', '2025-06-20 14:00:00', 'pin45', 'Activa', NULL, NULL),
('4532-4848-4949-5050', 46, 5, 5, 2700000, 14000000, 11000000, '2024-09-20', '2029-09-20', '2025-06-21 11:00:00', 'pin46', 'Activa', NULL, 'Límite excepcionalmente alto.'),
('4532-5151-5252-5353', 47, 2, 1, 90000, 650000, 600000, '2025-04-10', '2028-04-10', NULL, 'pin47', 'Activa', NULL, 'Primera tarjeta con pequeño límite.'),
('4532-5454-5555-5656', 48, 3, 3, 210000, 1600000, 1500000, '2023-11-01', '2026-11-01', '2025-06-15 10:00:00', 'pin48', 'Activa', NULL, NULL),
('4532-5757-5858-5959', 49, 4, 4, 700000, 5800000, 5000000, '2024-01-30', '2027-01-30', '2025-06-22 13:00:00', 'pin49', 'Activa', NULL, 'Cliente con historial de pago muy bueno.'),
('4532-6060-6161-6262', 50, 1, 1, 40000, 150000, 120000, '2025-03-25', '2028-03-25', NULL, 'pin50', 'Activa', NULL, 'Último cliente de la lista, tarjeta básica.')
;

-- modificacion de tarjeta_id
UPDATE tarjetas SET tarjeta_id = 13 WHERE cliente_id = 13;
UPDATE tarjetas SET tarjeta_id = 14 WHERE cliente_id = 14;
UPDATE tarjetas SET tarjeta_id = 15 WHERE cliente_id = 15;
UPDATE tarjetas SET tarjeta_id = 16 WHERE cliente_id = 16;
UPDATE tarjetas SET tarjeta_id = 17 WHERE cliente_id = 17;
UPDATE tarjetas SET tarjeta_id = 18 WHERE cliente_id = 18;
UPDATE tarjetas SET tarjeta_id = 19 WHERE cliente_id = 19;
UPDATE tarjetas SET tarjeta_id = 20 WHERE cliente_id = 20;
UPDATE tarjetas SET tarjeta_id = 21 WHERE cliente_id = 21;
UPDATE tarjetas SET tarjeta_id = 22 WHERE cliente_id = 22;
UPDATE tarjetas SET tarjeta_id = 23 WHERE cliente_id = 23;
UPDATE tarjetas SET tarjeta_id = 24 WHERE cliente_id = 24;
UPDATE tarjetas SET tarjeta_id = 25 WHERE cliente_id = 25;
UPDATE tarjetas SET tarjeta_id = 26 WHERE cliente_id = 26;
UPDATE tarjetas SET tarjeta_id = 27 WHERE cliente_id = 27;
UPDATE tarjetas SET tarjeta_id = 28 WHERE cliente_id = 28;
UPDATE tarjetas SET tarjeta_id = 29 WHERE cliente_id = 29;
UPDATE tarjetas SET tarjeta_id = 30 WHERE cliente_id = 30;
UPDATE tarjetas SET tarjeta_id = 31 WHERE cliente_id = 31;
UPDATE tarjetas SET tarjeta_id = 32 WHERE cliente_id = 32;
UPDATE tarjetas SET tarjeta_id = 33 WHERE cliente_id = 33;
UPDATE tarjetas SET tarjeta_id = 34 WHERE cliente_id = 34;
UPDATE tarjetas SET tarjeta_id = 35 WHERE cliente_id = 35;
UPDATE tarjetas SET tarjeta_id = 36 WHERE cliente_id = 36;
UPDATE tarjetas SET tarjeta_id = 37 WHERE cliente_id = 37;
UPDATE tarjetas SET tarjeta_id = 38 WHERE cliente_id = 38;
UPDATE tarjetas SET tarjeta_id = 39 WHERE cliente_id = 39;
UPDATE tarjetas SET tarjeta_id = 40 WHERE cliente_id = 40;
UPDATE tarjetas SET tarjeta_id = 41 WHERE cliente_id = 41;
UPDATE tarjetas SET tarjeta_id = 42 WHERE cliente_id = 42;
UPDATE tarjetas SET tarjeta_id = 43 WHERE cliente_id = 43;
UPDATE tarjetas SET tarjeta_id = 44 WHERE cliente_id = 44;
UPDATE tarjetas SET tarjeta_id = 45 WHERE cliente_id = 45;
UPDATE tarjetas SET tarjeta_id = 46 WHERE cliente_id = 46;
UPDATE tarjetas SET tarjeta_id = 47 WHERE cliente_id = 47;
UPDATE tarjetas SET tarjeta_id = 48 WHERE cliente_id = 48;
UPDATE tarjetas SET tarjeta_id = 49 WHERE cliente_id = 49;
UPDATE tarjetas SET tarjeta_id = 50 WHERE cliente_id = 50;

-- inserccion de las 38 cuotas de manejo restantes
INSERT INTO cuotas_manejo (tarjeta_id, periodo_mes, periodo_año, monto_base, porcentaje_descuento, valor_descuento, monto_final, fecha_vencimiento, dias_mora, interes_mora, monto_total_con_mora, estado) VALUES
(13, 6, 2024, 9000, 0.00, 0, 9000, '2024-06-30', 0, 0, 9000, 'Pagada'),
(14, 6, 2024, 18000, 10.00, 1800, 16200, '2024-06-30', 0, 0, 16200, 'Pendiente'),
(15, 6, 2024, 40000, 20.00, 8000, 32000, '2024-06-30', 10, 2500, 34500, 'Vencida'),
(16, 6, 2024, 60000, 30.00, 18000, 42000, '2024-06-30', 0, 0, 42000, 'Pagada'),
(17, 6, 2024, 10000, 0.00, 0, 10000, '2024-06-30', 0, 0, 10000, 'Pendiente'),
(18, 6, 2024, 70000, 40.00, 28000, 42000, '2024-06-30', 20, 5000, 47000, 'Vencida'),
(19, 6, 2024, 20000, 5.00, 1000, 19000, '2024-06-30', 0, 0, 19000, 'Pagada'),
(20, 6, 2024, 45000, 25.00, 11250, 33750, '2024-06-30', 0, 0, 33750, 'Pendiente'),
(21, 6, 2024, 7000, 0.00, 0, 7000, '2024-06-30', 0, 0, 7000, 'Pagada'),
(22, 6, 2024, 50000, 15.00, 7500, 42500, '2024-06-30', 7, 3000, 45500, 'Vencida'),
(23, 6, 2024, 22000, 10.00, 2200, 19800, '2024-06-30', 0, 0, 19800, 'Pendiente'),
(24, 6, 2024, 13000, 0.00, 0, 13000, '2024-06-30', 0, 0, 13000, 'Pagada'),
(25, 6, 2024, 8500, 0.00, 0, 8500, '2024-06-30', 0, 0, 8500, 'Pagada'),
(26, 6, 2024, 55000, 35.00, 19250, 35750, '2024-06-30', 12, 4000, 39750, 'Vencida'),
(27, 6, 2024, 16000, 0.00, 0, 16000, '2024-06-30', 0, 0, 16000, 'Pendiente'),
(28, 6, 2024, 38000, 20.00, 7600, 30400, '2024-06-30', 0, 0, 30400, 'Pagada'),
(29, 6, 2024, 7500, 0.00, 0, 7500, '2024-06-30', 0, 0, 7500, 'Pendiente'),
(30, 6, 2024, 62000, 25.00, 15500, 46500, '2024-06-30', 18, 4500, 51000, 'Vencida'),
(31, 6, 2024, 19000, 10.00, 1900, 17100, '2024-06-30', 0, 0, 17100, 'Pagada'),
(32, 6, 2024, 68000, 40.00, 27200, 40800, '2024-06-30', 0, 0, 40800, 'Pendiente'),
(33, 6, 2024, 8000, 0.00, 0, 8000, '2024-06-30', 0, 0, 8000, 'Pagada'),
(34, 6, 2024, 17000, 5.00, 850, 16150, '2024-06-30', 0, 0, 16150, 'Pendiente'),
(35, 6, 2024, 42000, 20.00, 8400, 33600, '2024-06-30', 8, 2800, 36400, 'Vencida'),
(36, 6, 2024, 65000, 30.00, 19500, 45500, '2024-06-30', 0, 0, 45500, 'Pagada'),
(37, 6, 2024, 11000, 0.00, 0, 11000, '2024-06-30', 0, 0, 11000, 'Pendiente'),
(38, 6, 2024, 75000, 45.00, 33750, 41250, '2024-06-30', 25, 6000, 47250, 'Vencida'),
(39, 6, 2024, 21000, 10.00, 2100, 18900, '2024-06-30', 0, 0, 18900, 'Pagada'),
(40, 6, 2024, 48000, 25.00, 12000, 36000, '2024-06-30', 0, 0, 36000, 'Pendiente'),
(41, 6, 2024, 9500, 0.00, 0, 9500, '2024-06-30', 0, 0, 9500, 'Pagada'),
(42, 6, 2024, 52000, 15.00, 7800, 44200, '2024-06-30', 5, 2000, 46200, 'Vencida'),
(43, 6, 2024, 24000, 10.00, 2400, 21600, '2024-06-30', 0, 0, 21600, 'Pendiente'),
(44, 6, 2024, 14000, 0.00, 0, 14000, '2024-06-30', 0, 0, 14000, 'Pagada'),
(45, 6, 2024, 40000, 20.00, 8000, 32000, '2024-06-30', 0, 0, 32000, 'Pendiente'),
(46, 6, 2024, 70000, 35.00, 24500, 45500, '2024-06-30', 15, 4800, 50300, 'Vencida'),
(47, 6, 2024, 16000, 5.00, 800, 15200, '2024-06-30', 0, 0, 15200, 'Pagada'),
(48, 6, 2024, 30000, 20.00, 6000, 24000, '2024-06-30', 0, 0, 24000, 'Pendiente'),
(49, 6, 2024, 58000, 25.00, 14500, 43500, '2024-06-30', 10, 3200, 46700, 'Vencida'),
(50, 6, 2024, 12000, 0.00, 0, 12000, '2024-06-30', 0, 0, 12000, 'Pagada');

-- inserccion de los 38 historial de pagos restantes
INSERT INTO historial_pagos (cuota_id, numero_transaccion, monto_pagado, monto_pendiente, fecha_pago, metodo_pago, referencia_pago, banco_origen, canal_pago, usuario_registro, ip_origen, estado_transaccion, comision, observaciones) VALUES
(13, 'TXN0013', 9000, 0, '2024-06-25 10:00:00', 'Debito_Automatico', 'REF-13011', 'Banco CL', 'App_Movil', 'usuario13', '192.168.0.13', 'Exitoso', 0, 'Pago recurrente automático'),
(14, 'TXN0014', 8000, 8200, '2024-06-28 11:30:00', 'PSE', 'REF-14012', 'Bancolombia', 'Online', 'usuario14', '192.168.0.14', 'Exitoso', 0, 'Abono parcial de cuota'),
(15, 'TXN0015', 0, 34500, '2024-06-29 14:00:00', 'Transferencia', 'REF-15013', 'Davivienda', 'Online', 'usuario15', '192.168.0.15', 'Fallido', 0, 'Fondos insuficientes'),
(16, 'TXN0016', 42000, 0, '2024-06-26 15:45:00', 'Debito_Automatico', 'REF-16014', 'Banco CL', 'App_Movil', 'usuario16', '192.168.0.16', 'Exitoso', 0, NULL),
(17, 'TXN0017', 0, 10000, '2024-06-30 00:00:00', 'Efectivo', 'REF-17015', 'Banco CL', 'Sucursal', 'usuario17', '192.168.0.17', 'Pendiente', 0, 'Pendiente de registrar en sistema'),
(18, 'TXN0018', 25000, 22000, '2024-07-02 09:00:00', 'Transferencia', 'REF-18016', 'Banco de Bogotá', 'Online', 'usuario18', '192.168.0.18', 'Exitoso', 0, 'Pago parcial con transferencia bancaria'),
(19, 'TXN0019', 19000, 0, '2024-06-24 10:20:00', 'PSE', 'REF-19017', 'Banco AV Villas', 'App_Movil', 'usuario19', '192.168.0.19', 'Exitoso', 0, NULL),
(20, 'TXN0020', 0, 33750, '2024-06-27 16:00:00', 'Transferencia', 'REF-20018', 'Bancolombia', 'Online', 'usuario20', '192.168.0.20', 'Pendiente', 0, 'Transferencia iniciada, esperando confirmación'),
(21, 'TXN0021', 7000, 0, '2024-06-25 11:15:00', 'Debito_Automatico', 'REF-21019', 'Banco CL', 'App_Movil', 'usuario21', '192.168.0.21', 'Exitoso', 0, NULL),
(22, 'TXN0022', 42500, 3000, '2024-07-01 13:00:00', 'PSE', 'REF-22020', 'Davivienda', 'Online', 'usuario22', '192.168.0.22', 'Exitoso', 0, 'Primer abono de cuota vencida'),
(23, 'TXN0023', 0, 19800, '2024-06-29 08:45:00', 'Efectivo', 'REF-23021', 'Banco CL', 'Sucursal', 'usuario23', '192.168.0.23', 'Pendiente', 0, 'Recibo de pago en caja, pendiente de procesar'),
(24, 'TXN0024', 13000, 0, '2024-06-26 14:00:00', 'Debito_Automatico', 'REF-24022', 'Banco CL', 'App_Movil', 'usuario24', '192.168.0.24', 'Exitoso', 0, NULL),
(25, 'TXN0025', 8500, 0, '2024-06-24 15:30:00', 'PSE', 'REF-25023', 'Banco CL', 'Online', 'usuario25', '192.168.0.25', 'Exitoso', 0, NULL),
(26, 'TXN0026', 15000, 24750, '2024-07-03 10:40:00', 'Transferencia', 'REF-26024', 'Bancolombia', 'Online', 'usuario26', '192.168.0.26', 'Exitoso', 0, 'Pago parcial de cuota atrasada'),
(27, 'TXN0027', 0, 16000, '2024-06-30 00:00:00', 'Tarjeta_Debito', 'REF-27025', 'Davivienda', 'Online', 'usuario27', '192.168.0.27', 'Fallido', 0, 'Tarjeta declinada'),
(28, 'TXN0028', 30400, 0, '2024-06-28 12:00:00', 'Debito_Automatico', 'REF-28026', 'Banco de Bogotá', 'App_Movil', 'usuario28', '192.168.0.28', 'Exitoso', 0, NULL),
(29, 'TXN0029', 0, 7500, '2024-06-29 17:00:00', 'PSE', 'REF-29027', 'Banco AV Villas', 'Online', 'usuario29', '192.168.0.29', 'Pendiente', 0, 'Transacción pendiente de aprobación final'),
(30, 'TXN0030', 46500, 4500, '2024-07-04 11:20:00', 'Efectivo', 'REF-30028', 'Banco CL', 'Sucursal', 'usuario30', '192.168.0.30', 'Exitoso', 0, 'Pago en caja por cuota vencida'),
(31, 'TXN0031', 17100, 0, '2024-06-25 09:10:00', 'Debito_Automatico', 'REF-31029', 'Bancolombia', 'App_Movil', 'usuario31', '192.168.0.31', 'Exitoso', 0, NULL),
(32, 'TXN0032', 0, 40800, '2024-06-28 13:45:00', 'Transferencia', 'REF-32030', 'Davivienda', 'Online', 'usuario32', '192.168.0.32', 'Pendiente', 0, 'Esperando confirmación interbancaria'),
(33, 'TXN0033', 8000, 0, '2024-06-24 14:15:00', 'PSE', 'REF-33031', 'Banco CL', 'Online', 'usuario33', '192.168.0.33', 'Exitoso', 0, 'Pago en día hábil'),
(34, 'TXN0034', 0, 16150, '2024-06-29 18:00:00', 'Transferencia', 'REF-34032', 'Banco de Bogotá', 'App_Movil', 'usuario34', '192.168.0.34', 'Fallido', 0, 'Fondos insuficientes o error de procesamiento'),
(35, 'TXN0035', 20000, 16400, '2024-07-01 10:00:00', 'Efectivo', 'REF-35033', 'Banco CL', 'Sucursal', 'usuario35', '192.168.0.35', 'Exitoso', 0, 'Pago parcial para evitar más mora'),
(36, 'TXN0036', 45500, 0, '2024-06-26 11:55:00', 'Debito_Automatico', 'REF-36034', 'Banco CL', 'App_Movil', 'usuario36', '192.168.0.36', 'Exitoso', 0, NULL),
(37, 'TXN0037', 0, 11000, '2024-06-30 00:00:00', 'PSE', 'REF-37035', 'Bancolombia', 'Online', 'usuario37', '192.168.0.37', 'Pendiente', 0, 'Transacción programada'),
(38, 'TXN0038', 30000, 17250, '2024-07-05 14:30:00', 'Transferencia', 'REF-38036', 'Davivienda', 'Online', 'usuario38', '192.168.0.38', 'Exitoso', 0, 'Primer abono de cuota con mucha mora'),
(39, 'TXN0039', 18900, 0, '2024-06-25 16:00:00', 'Debito_Automatico', 'REF-39037', 'Banco de Bogotá', 'App_Movil', 'usuario39', '192.168.0.39', 'Exitoso', 0, NULL),
(40, 'TXN0040', 0, 36000, '2024-06-29 10:00:00', 'Tarjeta_Debito', 'REF-40038', 'Banco AV Villas', 'Online', 'usuario40', '192.168.0.40', 'Fallido', 0, 'Saldo insuficiente en cuenta origen'),
(41, 'TXN0041', 9500, 0, '2024-06-24 09:00:00', 'PSE', 'REF-41039', 'Banco CL', 'Online', 'usuario41', '192.168.0.41', 'Exitoso', 0, 'Pago temprano, antes de la fecha límite'),
(42, 'TXN0042', 44200, 2000, '2024-07-02 12:00:00', 'Efectivo', 'REF-42040', 'Bancolombia', 'Sucursal', 'usuario42', '192.168.0.42', 'Exitoso', 0, 'Pago en ventanilla, incluye interés de mora'),
(43, 'TXN0043', 0, 21600, '2024-06-30 00:00:00', 'Transferencia', 'REF-43041', 'Davivienda', 'Online', 'usuario43', '192.168.0.43', 'Pendiente', 0, 'Transferencia programada para fin de mes'),
(44, 'TXN0044', 14000, 0, '2024-06-27 13:00:00', 'Debito_Automatico', 'REF-44042', 'Banco CL', 'App_Movil', 'usuario44', '192.168.0.44', 'Exitoso', 0, NULL),
(45, 'TXN0045', 0, 32000, '2024-06-29 15:00:00', 'PSE', 'REF-45043', 'Banco de Bogotá', 'Online', 'usuario45', '192.168.0.45', 'Fallido', 0, 'Error de autenticación'),
(46, 'TXN0046', 20000, 30300, '2024-07-03 09:30:00', 'Transferencia', 'REF-46044', 'Banco AV Villas', 'Online', 'usuario46', '192.168.0.46', 'Exitoso', 0, 'Pago inicial de cuota muy atrasada'),
(47, 'TXN0047', 15200, 0, '2024-06-25 10:45:00', 'Debito_Automatico', 'REF-47045', 'Banco CL', 'App_Movil', 'usuario47', '192.168.0.47', 'Exitoso', 0, NULL),
(48, 'TXN0048', 0, 24000, '2024-06-28 11:00:00', 'Transferencia', 'REF-48046', 'Bancolombia', 'Online', 'usuario48', '192.168.0.48', 'Pendiente', 0, 'Revisión manual de transferencia'),
(49, 'TXN0049', 40000, 6700, '2024-07-01 14:00:00', 'PSE', 'REF-49047', 'Davivienda', 'Online', 'usuario49', '192.168.0.49', 'Exitoso', 0, 'Pago parcial considerable'),
(50, 'TXN0050', 12000, 0, '2024-06-26 09:30:00', 'Debito_Automatico', 'REF-50048', 'Banco CL', 'App_Movil', 'usuario50', '192.168.0.50', 'Exitoso', 0, 'Último pago programado del mes');

-- correcion de errores en pago_id -> numeros incorrectos al hacer mal el insert
UPDATE historial_pagos SET pago_id = 13 WHERE cuota_id = 13;
UPDATE historial_pagos SET pago_id = 14 WHERE cuota_id = 14;
UPDATE historial_pagos SET pago_id = 15 WHERE cuota_id = 15;
UPDATE historial_pagos SET pago_id = 16 WHERE cuota_id = 16;
UPDATE historial_pagos SET pago_id = 17 WHERE cuota_id = 17;
UPDATE historial_pagos SET pago_id = 18 WHERE cuota_id = 18;
UPDATE historial_pagos SET pago_id = 19 WHERE cuota_id = 19;
UPDATE historial_pagos SET pago_id = 20 WHERE cuota_id = 20;
UPDATE historial_pagos SET pago_id = 21 WHERE cuota_id = 21;
UPDATE historial_pagos SET pago_id = 22 WHERE cuota_id = 22;
UPDATE historial_pagos SET pago_id = 23 WHERE cuota_id = 23;
UPDATE historial_pagos SET pago_id = 24 WHERE cuota_id = 24;
UPDATE historial_pagos SET pago_id = 25 WHERE cuota_id = 25;
UPDATE historial_pagos SET pago_id = 26 WHERE cuota_id = 26;
UPDATE historial_pagos SET pago_id = 27 WHERE cuota_id = 27;
UPDATE historial_pagos SET pago_id = 28 WHERE cuota_id = 28;
UPDATE historial_pagos SET pago_id = 29 WHERE cuota_id = 29;
UPDATE historial_pagos SET pago_id = 30 WHERE cuota_id = 30;
UPDATE historial_pagos SET pago_id = 31 WHERE cuota_id = 31;
UPDATE historial_pagos SET pago_id = 32 WHERE cuota_id = 32;
UPDATE historial_pagos SET pago_id = 33 WHERE cuota_id = 33;
UPDATE historial_pagos SET pago_id = 34 WHERE cuota_id = 34;
UPDATE historial_pagos SET pago_id = 35 WHERE cuota_id = 35;
UPDATE historial_pagos SET pago_id = 36 WHERE cuota_id = 36;
UPDATE historial_pagos SET pago_id = 37 WHERE cuota_id = 37;
UPDATE historial_pagos SET pago_id = 38 WHERE cuota_id = 38;
UPDATE historial_pagos SET pago_id = 39 WHERE cuota_id = 39;
UPDATE historial_pagos SET pago_id = 40 WHERE cuota_id = 40;
UPDATE historial_pagos SET pago_id = 41 WHERE cuota_id = 41;
UPDATE historial_pagos SET pago_id = 42 WHERE cuota_id = 42;
UPDATE historial_pagos SET pago_id = 43 WHERE cuota_id = 43;
UPDATE historial_pagos SET pago_id = 44 WHERE cuota_id = 44;
UPDATE historial_pagos SET pago_id = 45 WHERE cuota_id = 45;
UPDATE historial_pagos SET pago_id = 46 WHERE cuota_id = 46;
UPDATE historial_pagos SET pago_id = 47 WHERE cuota_id = 47;
UPDATE historial_pagos SET pago_id = 48 WHERE cuota_id = 48;
UPDATE historial_pagos SET pago_id = 49 WHERE cuota_id = 49;
UPDATE historial_pagos SET pago_id = 50 WHERE cuota_id = 50;
