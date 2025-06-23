USE BancoCL;
-- TABLAS
-- tabla de clientes
CREATE TABLE Clientes (
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
CREATE TABLE Tipos_Tarjeta (
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