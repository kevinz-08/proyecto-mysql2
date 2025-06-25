USE BancoCL;
-- TABLAS
-- tabla de clientes
CREATE TABLE clientes (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    numero_cuenta VARCHAR(20) UNIQUE NOT NULL,
    tipo_documento ENUM('CC', 'CE', 'PA', 'NIT') NOT NULL,
    numero_documento VARCHAR(20) UNIQUE NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    telefono VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    direccion TEXT,
    ciudad VARCHAR(50),
    departamento VARCHAR(50),
    codigo_postal VARCHAR(10),
    ocupacion VARCHAR(100),
    ingresos_mensuales DECIMAL(12,2),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultimo_acceso DATETIME,
    estado ENUM('Activo', 'Inactivo', 'Suspendido', 'Bloqueado') DEFAULT 'Activo',
    observaciones TEXT,
    INDEX idx_documento (numero_documento),
    INDEX idx_email (email),
    INDEX idx_estado (estado)
);

-- tabla tipo tarjeta
CREATE TABLE tipos_tarjeta (
    tipo_tarjeta_id INT PRIMARY KEY AUTO_INCREMENT,
    codigo_tipo VARCHAR(10) UNIQUE NOT NULL,
    nombre_tipo VARCHAR(50) UNIQUE NOT NULL,
    descripcion TEXT,
    edad_minima INT DEFAULT 18,
    edad_maxima INT DEFAULT 99,
    ingresos_minimos DECIMAL(10,2) DEFAULT 0,
    monto_minimo_apertura DECIMAL(10,2) NOT NULL,
    monto_maximo_apertura DECIMAL(12,2),
    cuota_base_mensual DECIMAL(8,2) NOT NULL,
    tasa_interes DECIMAL(5,2) DEFAULT 0,
    beneficios TEXT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado BOOLEAN DEFAULT TRUE,
    INDEX idx_codigo (codigo_tipo)
);

-- tabla niveles de descuento
CREATE TABLE niveles_descuento (
    descuento_id INT PRIMARY KEY AUTO_INCREMENT,
    codigo_descuento VARCHAR(10) UNIQUE NOT NULL,
    nombre_descuento VARCHAR(50) UNIQUE NOT NULL,
    descripcion TEXT,
    porcentaje_descuento DECIMAL(5,2) NOT NULL CHECK (porcentaje_descuento >= 0 AND porcentaje_descuento <= 100),
    monto_minimo_requerido DECIMAL(10,2) NOT NULL,
    monto_maximo_aplicable DECIMAL(12,2),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    estado BOOLEAN DEFAULT TRUE,
    INDEX idx_codigo (codigo_descuento),
    INDEX idx_monto_minimo (monto_minimo_requerido)
);

-- tabla de tarjetas
CREATE TABLE tarjetas (
    tarjeta_id INT PRIMARY KEY AUTO_INCREMENT,
    numero_tarjeta VARCHAR(19) UNIQUE NOT NULL,
    cliente_id INT NOT NULL,
    tipo_tarjeta_id INT NOT NULL,
    descuento_id INT NOT NULL,
    monto_apertura DECIMAL(10,2) NOT NULL,
    limite_credito DECIMAL(12,2),
    saldo_disponible DECIMAL(12,2),
    fecha_apertura DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    fecha_ultimo_uso DATETIME,
    pin_encriptado VARCHAR(255),
    intentos_fallidos INT DEFAULT 0,
    estado ENUM('Activa', 'Bloqueada', 'Vencida', 'Cancelada', 'Suspendida') DEFAULT 'Activa',
    motivo_bloqueo TEXT,
    observaciones TEXT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id) ON DELETE CASCADE,
    FOREIGN KEY (tipo_tarjeta_id) REFERENCES Tipos_Tarjeta(tipo_tarjeta_id),
    FOREIGN KEY (descuento_id) REFERENCES niveles_descuento(descuento_id),
    INDEX idx_cliente (cliente_id),
    INDEX idx_tipo (tipo_tarjeta_id),
    INDEX idx_estado (estado),
    INDEX idx_fecha_vencimiento (fecha_vencimiento)
);

-- tabla de cuotas de manejo
CREATE TABLE cuotas_manejo (
    cuota_id INT PRIMARY KEY AUTO_INCREMENT,
    tarjeta_id INT NOT NULL,
    periodo_mes INT NOT NULL CHECK (periodo_mes BETWEEN 1 AND 12),
    periodo_año INT NOT NULL CHECK (periodo_año >= 2020),
    monto_base DECIMAL(8,2) NOT NULL,
    porcentaje_descuento DECIMAL(5,2) NOT NULL,
    valor_descuento DECIMAL(8,2) NOT NULL,
    monto_final DECIMAL(8,2) NOT NULL,
    fecha_generacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_vencimiento DATE NOT NULL,
    dias_mora INT DEFAULT 0,
    interes_mora DECIMAL(8,2) DEFAULT 0,
    monto_total_con_mora DECIMAL(8,2),
    estado ENUM('Pendiente', 'Pagada', 'Vencida', 'Condonada') DEFAULT 'Pendiente',
    metodo_calculo ENUM('Automatico', 'Manual', 'Ajustado') DEFAULT 'Automatico',
    observaciones TEXT,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (tarjeta_id) REFERENCES tarjetas(tarjeta_id) ON DELETE CASCADE,
    UNIQUE KEY unique_cuota_periodo (tarjeta_id, periodo_mes, periodo_año),
    INDEX idx_tarjeta (tarjeta_id),
    INDEX idx_periodo (periodo_año, periodo_mes),
    INDEX idx_estado (estado),
    INDEX idx_vencimiento (fecha_vencimiento)
);

-- tabla de historial de pagos
CREATE TABLE historial_pagos (
    pago_id INT PRIMARY KEY AUTO_INCREMENT,
    cuota_id INT NOT NULL,
    numero_transaccion VARCHAR(50) UNIQUE NOT NULL,
    monto_pagado DECIMAL(8,2) NOT NULL,
    monto_pendiente DECIMAL(8,2) NOT NULL,
    fecha_pago DATETIME NOT NULL,
    metodo_pago ENUM('Transferencia', 'Efectivo', 'Debito_Automatico', 'PSE', 'Tarjeta_Debito', 'Corresponsal') NOT NULL,
    referencia_pago VARCHAR(100),
    banco_origen VARCHAR(50),
    canal_pago ENUM('Sucursal', 'ATM', 'Online', 'App_Movil', 'Call_Center') NOT NULL,
    usuario_registro VARCHAR(50),
    ip_origen VARCHAR(45),
    estado_transaccion ENUM('Exitoso', 'Fallido', 'Pendiente', 'Reversado') DEFAULT 'Exitoso',
    comision DECIMAL(6,2) DEFAULT 0,
    observaciones TEXT,
    fecha_procesamiento DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cuota_id) REFERENCES cuotas_manejo(cuota_id) ON DELETE CASCADE,
    INDEX idx_cuota (cuota_id),
    INDEX idx_fecha_pago (fecha_pago),
    INDEX idx_metodo_pago (metodo_pago),
    INDEX idx_estado (estado_transaccion),
    INDEX idx_numero_transaccion (numero_transaccion)
);

-- tabla de audioria de operaciones
-- IMPORTANTE -> esta tabla tecnicamente no esta relacionada con otras entidades ya que su proposito es meramente logico, eso quiere decir que su objetivo es registrar toda operacion que afecte las demas tablas de nuestra base de datos, para mas informacion, por favor dirigirse al readme que explica el funcionamiento de cada una de las tablas. 
CREATE TABLE auditoria_operaciones (
    auditoria_id INT PRIMARY KEY AUTO_INCREMENT,
    tabla_afectada VARCHAR(50) NOT NULL,
    operacion ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    registro_id INT NOT NULL,
    datos_anteriores JSON,
    datos_nuevos JSON,
    usuario VARCHAR(50) NOT NULL,
    fecha_operacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    ip_usuario VARCHAR(45),
    descripcion TEXT,
    INDEX idx_tabla (tabla_afectada),
    INDEX idx_fecha (fecha_operacion),
    INDEX idx_usuario (usuario)
);