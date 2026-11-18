-- Creación de la Base de Datos
CREATE DATABASE IF NOT EXISTS db_systemreservas;
USE systemreservas_db;

-- Usuarios (Administradores y Estilistas
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    rol ENUM('Administrador', 'Estilista') NOT NULL,
    porcentaje_comision DECIMAL(5,2) DEFAULT 0.00, -- Útil para estilistas (ej. 40.00%)
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    correo VARCHAR(100),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla 3: Catálogo de Servicios (RF02)
CREATE TABLE servicios (
    id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    nombre_servicio VARCHAR(100) NOT NULL,
    duracion_min INT NOT NULL, -- Duración en minutos
    precio DECIMAL(10,2) NOT NULL,
    estado BOOLEAN DEFAULT TRUE
);

--   Citas
CREATE TABLE citas (
    id_cita INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_estilista INT NOT NULL,
    id_servicio INT NOT NULL,
    fecha_cita DATE NOT NULL,
    hora_cita TIME NOT NULL,
    estado ENUM('Pendiente', 'Completada', 'Cancelada') DEFAULT 'Pendiente',
    CONSTRAINT fk_cita_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_cita_estilista FOREIGN KEY (id_estilista) REFERENCES usuarios(id_usuario),
    CONSTRAINT fk_cita_servicio FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio)
);

-- Liquidación de Comisiones
CREATE TABLE comisiones (
    id_comision INT AUTO_INCREMENT PRIMARY KEY,
    id_estilista INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    total_servicios INT NOT NULL,
    monto_total_recaudado DECIMAL(10,2) NOT NULL,
    monto_comision_pagar DECIMAL(10,2) NOT NULL,
    fecha_liquidacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_comision_estilista FOREIGN KEY (id_estilista) REFERENCES usuarios(id_usuario)
);