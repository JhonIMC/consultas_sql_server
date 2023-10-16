CREATE DATABASE tienda;
USE tienda;

CREATE TABLE fabricante (
  id INT,
  nombre VARCHAR(100),
  PRIMARY KEY (id)
);

CREATE TABLE producto (
  id INT,
  nombre VARCHAR(100),
  precio DECIMAL(10, 2),
  moneda VARCHAR(50),
  id_fabricante INT,
  PRIMARY KEY (id),
  FOREIGN KEY (id_fabricante) REFERENCES fabricante(id)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 'USD',  5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 'USD', 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 'EUR', 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 'USD', 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 'EUR', 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 'EUR', 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 'USD', 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 'EUR', 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 'EUR', 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 'USD', 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 'USD', 3);

-- Cambiar el nombre a una Columna
ALTER TABLE producto
ADD moneda VARCHAR(50)

-- Cambiar el valor de una Campo
UPDATE producto
SET moneda = 'MXM'
WHERE id = 10;

-- Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre FROM producto;


-- Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre, precio FROM producto;


-- Lista todas las columnas de la tabla producto.
SELECT * FROM producto;


-- Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
SELECT nombre FROM producto WHERE moneda = 'USD' OR moneda = 'EUR'


-- Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes alias 
-- para las columnas: nombre de producto, euros, dólares.
SELECT nombre AS 'Nombre del producto', precio FROM producto WHERE moneda = 'USD' OR moneda = 'EUR'


-- Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.
SELECT UPPER(nombre), precio FROM producto;


-- Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.
SELECT LOWER(nombre), precio FROM producto;


-- Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.
SELECT nombre, UPPER(SUBSTRING(nombre, 1,2)) + SUBSTRING(nombre, 3,50) AS 'Fabricante_Mayuscula' FROM fabricante;


-- Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
SELECT ROUND(precio, 0) FROM producto; -- El 0 es para REDONDEAR el valor


-- Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
SELECT nombre, CONVERT(INT, (ROUND(precio, 0))) as 'precio' FROM producto;


-- Lista el identificador de los fabricantes que tienen productos en la tabla producto.
SELECT id_fabricante FROM producto WHERE nombre != '';


-- Lista el identificador de los fabricantes que tienen productos en la tabla producto, eliminando los identificadores que aparecen repetidos.
SELECT DISTINCT id_fabricante FROM producto WHERE nombre != '';


-- Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre FROM fabricante ORDER BY nombre ASC;


-- Lista los nombres de los fabricantes ordenados de forma descendente.
SELECT nombre FROM fabricante ORDER BY nombre DESC;


-- Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;


-- Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT TOP 5 * FROM fabricante;


-- Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta
SELECT * FROM fabricante ORDER BY (SELECT NULL) OFFSET 3 ROWS FETCH NEXT 2 ROWS ONLY;


-- Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT precio FROM producto ORDER BY precio ASC OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;


-- Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT precio FROM producto ORDER BY precio DESC OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;


-- Lista el nombre de todos los productos del fabricante cuyo identificador de fabricante es igual a 2.
SELECT nombre FROM producto WHERE id_fabricante = 2;


-- Lista el nombre de los productos que tienen un precio menor o igual a 280€.
SELECT nombre FROM producto WHERE moneda = 'EUR' AND precio <= 280;


-- Lista el nombre de los productos que tienen un precio mayor o igual a 400€
SELECT nombre FROM producto WHERE moneda = 'EUR' AND precio >= 400;


-- Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.
SELECT nombre FROM producto WHERE moneda = 'EUR' AND precio < 400;


-- Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.
SELECT nombre FROM producto WHERE moneda = 'EUR' AND precio >= 80 AND precio <= 300;


-- Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.
SELECT nombre FROM producto WHERE moneda = 'EUR' AND precio BETWEEN 60 AND 200;


-- Lista todos los productos que tengan un precio mayor que 200 y que el identificador de fabricante sea igual a 6.
SELECT nombre FROM producto WHERE precio > 200 AND id_fabricante = 6;


-- Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Sin utilizar el operador IN
SELECT nombre FROM producto WHERE id_fabricante = 1 OR id_fabricante = 3 OR id_fabricante = 5;


-- Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT nombre FROM producto WHERE id_fabricante IN (1, 3, 5);


-- Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). Cree un alias para la 
-- columna que contiene el precio que se llame céntimos
SELECT nombre, precio * 100 AS 'Céntimos' FROM producto;


-- Lista los nombres de los fabricantes cuyo nombre empiece por la letra S
SELECT nombre FROM fabricante WHERE nombre LIKE 'S%'
SELECT nombre FROM fabricante WHERE SUBSTRING(nombre, 1, 1) = 'S';


-- Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
SELECT nombre FROM fabricante WHERE nombre LIKE '%e';


-- Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.
SELECT nombre FROM fabricante WHERE nombre LIKE '%w%';


-- Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
SELECT nombre FROM fabricante WHERE LEN(nombre) = 4


-- Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
SELECT nombre FROM producto WHERE nombre LIKE '%Portátil%';


-- Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €.
SELECT nombre FROM producto WHERE nombre LIKE '%Portátil%' AND moneda = 'EUR' AND precio < 600;


-- Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180 (Cualquier moneda). Ordene el resultado en primer 
-- lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).
SELECT nombre, precio FROM producto WHERE precio >= 180 ORDER BY precio DESC, nombre ASC;



-- ********** CONSULTAS MULTITABLA (COMPOSICION INTERNA) **********

-- Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
SELECT p.nombre AS nombre_producto, p.precio, f.nombre AS nombre_fabricante
FROM producto AS p
INNER JOIN fabricante AS f ON p.id_fabricante = f.id;


-- Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. 
-- Ordene el resultado por el nombre del fabricante, por orden alfabético.
SELECT p.nombre AS nombre_producto, p.precio AS precio_producto, f.nombre AS nombre_fabricate
FROM producto AS p
INNER JOIN fabricante AS f
ON p.id_fabricante = f.id
ORDER BY f.nombre ASC


-- Devuelve una lista con el identificador del producto, nombre del producto, identificador del fabricante y nombre del fabricante, de todos los 
-- productos de la base de datos
SELECT p.id AS id_producto, p.nombre AS nombre_producto, f.id AS id_fabricante, f.nombre AS nombre_fabricante
FROM producto AS p
INNER JOIN fabricante AS f
ON p.id_fabricante = f.id


-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT p.nombre AS nombre_producto, p.precio AS precio_producto, f.nombre AS nombre_fabricante
FROM producto AS p
INNER JOIN fabricante AS f
ON p.id_fabricante = f.id
WHERE p.precio = (SELECT MIN(precio) FROM producto)


-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
SELECT p.nombre AS nombre_producto, p.precio AS precio_producto, f.nombre AS nombre_fabricante
FROM producto AS p
INNER JOIN fabricante AS f
ON p.id_fabricante = f.id
WHERE p.precio = (SELECT MAX(precio) FROM producto)


-- Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT p.nombre AS nombre_producto, f.nombre AS nombre_fabricante
FROM producto AS p
INNER JOIN fabricante AS f
ON p.id_fabricante = f.id
WHERE f.nombre = 'Lenovo'


-- Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 100 (No importa la moneda).
SELECT p.nombre AS nombre_producto, f.nombre AS fabricante
FROM producto AS p
INNER JOIN fabricante AS f
ON p.id_fabricante = f.id
WHERE f.nombre = 'Crucial' AND p.precio > 100


-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Sin utilizar el operador IN.
SELECT p.nombre AS nombre_producto, f.nombre AS nombre_fabricante
FROM producto AS p
INNER JOIN fabricante AS f
ON p.id_fabricante = f.id
WHERE 
	f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate'


-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Utilizando el operador IN.
SELECT p.nombre AS nombre_producto, f.nombre AS nombre_fabricante
FROM producto AS p
INNER JOIN fabricante AS f
ON p.id_fabricante = f.id
WHERE 
	f.nombre IN('Asus', 'Hewlett-Packard', 'Seagate');


-- Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e
SELECT p.nombre AS nombre_producto, p.precio AS precio_producto
FROM producto AS p
INNER JOIN fabricante AS f
ON p.id_fabricante = f.id
WHERE f.nombre LIKE '%e'


-- Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
SELECT p.nombre AS nombre, p.precio AS precio
FROM producto p
INNER JOIN fabricante f
ON p.id_fabricante = f.id
WHERE f.nombre LIKE '%w%'


-- Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. 
-- Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
SELECT p.nombre AS nombre_producto, p.precio AS precio_producto, f.nombre AS nombre_fabricante
FROM producto p
INNER JOIN fabricante f
ON p.id_fabricante = f.id
WHERE p.precio >= 180
ORDER BY p.precio DESC, p.nombre ASC


-- Devuelve un listado con el identificador y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en DB.
SELECT f.id AS id_fabricante, f.nombre AS nombre_fabricante
FROM fabricante AS f
INNER JOIN producto AS p
ON f.id = p.id_fabricante



-- ********** CONSULTAS MULTITABLA (COMPOSICION EXTERNA) **********
-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.


-- Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. 
-- El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
SELECT * FROM fabricante f
LEFT JOIN producto p
ON f.id = p.id_fabricante


-- Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT f.nombre FROM fabricante f
LEFT JOIN producto p
ON f.id = p.id_fabricante
WHERE p.id_fabricante IS NULL