/*EJERCICIO 1*/

/*1.1 Lista de los nombres de los artículos de la tienda*/
SELECT nombre
FROM articulos;

/*1.2 Lista de  los nombres y los precios de los artículos de la tienda*/
SELECT nombre, precio
FROM articulos;

/*1.3 Lista de los nombres de los productos curyo precio sea menor o igual a 200*/
SELECT nombre
FROM articulos
WHERE precio <=200;

/*1.4 Lista de todos los datos de los artículos cuyo precio esté entre 60 y 120 (Ambos incluidos)*/
SELECT *
FROM articulos
WHERE precio BETWEEN 60 AND 120;

/*1.5 Lista de nombre y precio (En pesetas)*/
SELECT nombre, precio * 166.386 AS Precio_Pesetas
FROM articulos;

/*1.6 Precio medio de todos los artículos*/
SELECT AVG(precio)
FROM articulos;

/*1.7 Precio medio  de los artículos cuyo fabricante sea 2*/
SELECT AVG(precio)
FROM articulos
WHERE fabricante = 2;

/*1.8 Número de artículs cuyo precio sea mayor o igual a 180*/
SELECT COUNT(*)
FROM articulos
WHERE precio >= 180;

/*1.9 Lista de articulos (nombre y precio) cuyo precio sea mayor o igual a 180 y ordernarlos descendentemente por precio  y luego ascendetemente por nombre*/
SELECT nombre, precio 
FROM articulos
WHERE precio >=180
ORDER BY precio DESC, nombre;

/*1.10 Lista completa de articulos, incluyendo por cada articulos los datos del articulos y de su fabricante*/
SELECT *
FROM articulos, fabricantes
WHERE articulos.fabricante = fabricantes.codigo;

/*1.11 Lista de articulos ( nombre, precio y nombre del fabricante)*/
SELECT articulos.nombre, precio, fabricantes.nombre
FROM articulos, fabricantes
WHERE articulos.fabricante = fabricantes.codigo;

/*1.12 Lista de precio medio de articulos por fabricante, mostrando solamente los códigos de fabricante*/
SELECT AVG(precio), fabricantes.codigo
FROM articulos , fabricantes
WHERE articulos.fabricante = fabricantes.codigo
GROUP BY fabricantes.codigo;

/*1.13 Lista de precio medio de los articulos de cada fabricante mostrando el nombre del fabricante.*/
SELECT AVG(precio), fabricantes.nombre
FROM articulos, fabricantes
WHERE articulos.fabricante = fabricantes.codigo
GROUP BY fabricantes.nombre;

/*1.14 Lista de nombres de fabricantes que ofrezcan productos cuyo precio medio sea mayor o igual a 150*/
SELECT fabricantes.nombre
FROM fabricantes, articulos
WHERE articulos.fabricante = fabricantes.codigo
GROUP BY fabricantes.nombre
HAVING AVG(precio) >= 150;  

/*1.15 Nombre y precio del artículo más barato*/
SELECT nombre, precio
FROM articulos
WHERE precio = (SELECT MIN(precio) FROM articulos);

/*1.16 Lista con nombre y precio  de los artículo mas caros de cada proveedor (incluyendo el nombre del proveedor)*/
SELECT articulos.nombre, precio, fabricantes.nombre
FROM articulos, fabricantes
WHERE articulos.fabricante = fabricantes.codigo AND articulos.precio = ( SELECT MAX(articulos.precio) FROM articulos WHERE articulos.fabricante = fabricantes.codigo);

/*-------------------------------------------------------------X----------------------------------------------------------------------------------------*/
/*EJERCICIO 2/

/*2.1 Lista de apellidos de los empleados*/
SELECT apellidos
FROM empleados;

/*2.2 Lista de apellidos de los empleados sin repeticion*/
SELECT  DISTINCT apellidos
FROM empleados;

/*2.3 Lista de todos los datos de empleados que se apedillas López*/
SELECT *
FROM empleados
WHERE apellidos = "López";

/*2.4 Lista de todos los empleados que se apellidan López y los que se apellidan Pérez*/
SELECT *
FROM empleados
WHERE apellidos = "López" OR apellidos = "Pérez";

/*2.5 Lista de todos los empleados (Con todos sus datos)  que trabajan en el departamento 14*/
SELECT *
FROM empleados
WHERE departamento = 14;

/*2.6 Lista de todos los empleados que trabajan en el departamento 37 o para el departamento 77 */
SELECT *
FROM empleados
WHERE departamento = 37 OR departamento = 77;

/*2.7 Lista de todos los datos de los  empleados cuyo apellido comience por P*/
SELECT * 
FROM empleados
WHERE apellidos LIKE "P%";

/*2.8 Presupuesto total de todos los deprtamentos*/
SELECT SUM(presupuesto)
FROM departamentos;

/*2.9 Numero de empleados en cada deprtamento*/
SELECT COUNT(*) AS Num_Empleados, departamento
FROM empleados
GROUP BY departamento;

/*2.10 Listado completo de empleados incluyendo por cada empleado los datos del empleado y de su departamento*/
SELECT *
FROM empleados, departamentos
WHERE empleados.departamento = departamentos.codigo;

/*2.11 Listado completo de empleados incluyendo nombre, apellidos del empleado junto al nombre y presupuesto de su departamento*/
SELECT empleados.nombre, empleados.apellidos , departamentos.nombre, departamentos.presupuesto
FROM empleados, departamentos
WHERE empleados.departamento = departamentos.codigo;

/*2.12 Lista de nombre y apellidos de trabajador que estén en departamentos cuyo presupuesto sea mayor de 60.000€*/
SELECT empleados.nombre, empleados.apellidos
FROM empleados, departamentos
WHERE empleados.departamento = departamentos.codigo AND departamentos.presupuesto >60.000;

/*2.13 Lista de departamentos cuyo presupuesto es superior al presupuesto medio de todos los departamentos*/
SELECT*
FROM departamentos
WHERE presupuesto > (SELECT AVG(presupuesto) FROM departamentos);

/*2.14 Lista de los departamentos (solo nombre) que tienen mas de dos empleados*/
SELECT nombre
FROM departamentos
WHERE codigo IN (SELECT departamento FROM empleados GROUP BY departamento HAVING COUNT(*) >2);

/*-------------------------------------------------------------X----------------------------------------------------------------------------------------*/

/*EJERCICIO 3*/

/*3.1 Lista de todos los almacenes*/
SELECT *
FROM almacenes;

/*3.2 Lista de todas las cajas cuyo contenido tenga un valor superior a 150*/
SELECT *
FROM cajas
WHERE valor >150;

/*3.3 Lista de tipos de contenido de las cajas*/
SELECT DISTINCT contenido
FROM cajas;

/*3.4 Valor medio de todas las cajas*/
SELECT AVG(valor)
FROM cajas;

/*3.5 Valor medio de las cajas de cada almacen*/
SELECT almacenes.lugar, AVG(cajas.valor)
FROM cajas, almacenes
WHERE almacenes.codigo = cajas.almacen
GROUP BY almacenes.lugar;

/*3.5.1 Lista de códigos de los almacenes cuyo valor medio de las cajas sea superior a 150*/
SELECT almacen
FROM cajas
GROUP BY almacen
HAVING AVG(valor)>150;

/*3.6 Lista de número de referencia de cada caja con el nombre de la ciudad en la que se encuentran.*/
SELECT numreferencia, lugar
FROM cajas, almacenes
WHERE almacenes.codigo = cajas.almacen;

/*3.7 Número de cajas que hay en cada almacen*/
SELECT almacen, COUNT(*)
FROM cajas
GROUP BY almacen;

/*3.8 Lista de los códigos de los almacenes que están saturados*/
SELECT codigo
FROM almacenes
WHERE capacidad <(SELECT COUNT(*) FROM cajas WHERE almacen = codigo);

/*3.9 Lista de los numeros de referencia de las cajas que están en Sevilla*/
SELECT numreferencia
FROM cajas
WHERE almacen IN (SELECT codigo FROM almacenes WHERE lugar = "Sevilla");