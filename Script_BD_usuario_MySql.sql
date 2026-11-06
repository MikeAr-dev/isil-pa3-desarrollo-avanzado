-- 1. Crear la base de datos que espera la aplicación
CREATE DATABASE IF NOT EXISTS pedidosdb 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 2. Crear el usuario que está definido en tu application.properties
CREATE USER IF NOT EXISTS 'spedidos_app'@'localhost' IDENTIFIED BY 'userapp_2026!';

-- 3. Darle todos los privilegios sobre esa base de datos
GRANT ALL PRIVILEGES ON pedidosdb.* TO 'spedidos_app'@'localhost';

-- 4. Aplicar los cambios
FLUSH PRIVILEGES;

USE pedidosdb;

INSERT INTO pedido (cantidad, cliente, fecha, precio_unitario, producto_codigo, producto_nombre, total) 
VALUES 
(2, 'Juan', NOW(), 50.00, 'PROD001', 'Teclado Mecanico', 100.00),
(1, 'Carlos', NOW(), 75.50, 'PROD002', 'Mouse Gamer', 75.50),
(3, 'Juan', NOW(), 60.00, 'PROD003', 'Audifonos Bluetooth', 180.00),
(1, 'Ana', NOW(), 120.00, 'PROD004', 'Monitor 24 pulgadas', 120.00),
(2, 'Carlos', NOW(), 45.00, 'PROD005', 'Base para Laptop', 90.00),
(4, 'Maria', NOW(), 25.00, 'PROD006', 'Mousepad XXL', 100.00),
(1, 'Juan', NOW(), 350.00, 'PROD007', 'Silla Ergonomica', 350.00),
(2, 'Ana', NOW(), 80.00, 'PROD008', 'Disco Duro Externo', 160.00);