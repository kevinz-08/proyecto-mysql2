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