
/* Tarea 4 */
	
	USE bdmontecastelo;
	
	
/* ==================================
	FABRICANTES Y ARTÍCULOS
	================================== */
	
/*	1.1 Añadir un nuevo artículo: Altavoces de 70€ (del fabricante 2). */
	
	INSERT INTO articulos(nombre, precio, fabricante)
	VALUES ('Altavoces', 70, 2);
	
/*	1.2 Cambiar el nombre del producto 8 a 'Impresora Laser'. */
	
	UPDATE articulos
	SET nombre = 'Impresora Laser'
	WHERE codigo = 8;
	
/*	1.3 Aplicar un descuento del 10% (multiplicar el precio por 0,9) a todos los
	artículos. */
	
	UPDATE articulos
	SET precio = precio * 0.9;
	
/*	1.4 Aplicar un descuento de 10€ a todos los artículos cuyo precio sea mayor o igual a 120€. */
	
	UPDATE articulos
	SET precio = precio * 0.9
	WHERE precio >= 120;
	
	
/* ==================================
	EMPLEADOS
	================================== */
	
/*	2.1 Añadir un nuevo departamento: 'Calidad', con presupuesto de 40.000€ y
	código 11. Añadir un empleado vinculado al departamento recién creado:
	Esther Vázquez, DNI: 8926710. */
	
	INSERT INTO departamentos(codigo, nombre, presupuesto)
	VALUES (11, 'Calidad', 40000);
	
	INSERT INTO empleados(DNI, nombre, apellidos, departamento)
	VALUES (8926710, 'Esther', 'Vázquez', 11);
	
/*	2.2 Aplicar un recorte presupuestario del 10% a todos los departamentos. */
	
	UPDATE departamentos
	SET presupuesto = presupuesto * 0.9;
	
/*	2.3 Reasignar a los empleados del departamento de investigación (código 77) al
	departamento de informática (código 14). */
	
	UPDATE empleados
	SET departamento = 14
	WHERE departamento = 77;
	
	/*	2.4 Despedir a todos los empleados que trabajan para el departamento de
	informática (código 14). */
	
	DELETE FROM empleados
	WHERE departamento = 14;
	
	/*	2.5 Despedir a todos los empleados que trabajen para departamentos cuyo
	presupuesto sea superior a loa 60.000€. */
	
	DELETE FROM empleados
	WHERE departamento IN (SELECT codigo
									FROM departamentos
									WHERE presupuesto > 60000);
									
/*	2.6 Despedir a todos los empleados. */
	
	DELETE FROM empleados;
	
	
/* ==================================
	ALMACENES
	================================== */
	
/*	3.1 Insertar un nuevo almacén en Barcelona con capacidad para 3 cajas. */
	
	INSERT INTO almacenes(lugar, capacidad)
	VALUES ('Barcelona', 3);
	
/*	3.2 Insertar una nueva caja, con número de referencia 'H5RT', con contenido
	'Papel', valor 200 y situada en el almacén 2. */
	
	INSERT INTO cajas(numreferencia, contenido, valor, almacen)
	VALUES ('H5RT', 'Papel', 200, 2);
	
/*	3.3 Rebajar el valor de todas las cajas un 15%. */
	
	UPDATE cajas
	SET valor = valor * 0.85;
	
/*	3.4 Rebajar un 20% el valor de todas las cajas cuyo valor sea superior al valor
	medio de todas las cajas. */
	
	UPDATE cajas
	SET valor = valor * 0.8
	WHERE valor > (SELECT AVG(valor) FROM cajas);
	
/*	3.5 Eliminar todas las cajas cuyo valor sea inferior a 100€. */
	
	DELETE FROM cajas
	WHERE valor < 100;
	
/*	3.6 Vaciar el contenido de los almacenes que están saturados. */

	DELETE FROM cajas
	WHERE almacen IN (SELECT codigo
							FROM almacenes a
							WHERE capacidad < (SELECT COUNT(*)
														FROM cajas c
														WHERE a.codigo = c.almacen);)


/* ==================================
	PELÍCULAS Y SALAS
	================================== */
	
/*	4.1 Añadir una nueva película  'Uno, Dos, Tres', para mayores de 7 años. */
	
	INSERT INTO peliculas(nombre, calificacionedad)
	VALUES ('Uno, Dos, Tres', 7)
	
/*	4.2 Hacer constar que todas las películas no calificadas han sido calificadas 'no
	recomendables para menores de 13 años. */
	
	UPDATE peliculas
	SET calificacionedad = 13
	WHERE calificacionedad IS NULL;
	
/*	4.3 Eliminar todas las salas que proyectan películas recomendadas para todos los públicos. */
	
	DELETE FROM salas
	WHERE pelicula IN (SELECT codigo
								FROM peliculas
								WHERE calificacionedad = 0)


/* ==================================
	DIRECTORES
	================================== */
	
/*	5.1 Añadir un nuevo director llamado Paco Pérez, DNI 28301700, sin jefe, y situado
	en el despacho 124. */
	
	INSERT INTO directores(dni, nomapels, dnijefe, despacho)
	VALUES (28301700, 'Paco Pérez', NULL, 124)
	
/*	5.2 Asignar a todos los empleados apellidados Pérez un nuevo jefe con DNI 74568521. */
	
	UPDATE directores
	SET dnijefe = 74568521
	WHERE nomapels LIKE '%Pérez%'
	
/*	5.3 Despedir a todos los directores, excepto a los que no tienen jefe. */
	
	DELETE FROM directores
	WHERE dnijefe IS NOT NULL;
	
	
/* ==================================
	PIEZAS Y PROVEEDORES
	================================== */
	
/*	6.1 Hacer constar en la base de datos que la empresa 'Skellington
	Supplies' (código TNBC) va a empezar a suministrarnos tuercas (código1) a 7
	pesetas cada tuerca. */
	
	INSERT INTO proveedores(id,nombre)
	VALUES ('TNBC', 'Skellington Supplies')
	
	INSERT INTO suministra(codigopieza, idproveedor, precio)
	VALUES (1, 'TNBC', 7)
	
/*	6.2 Aumentar los precios en una unidad. */
	
	UPDATE suministra
	SET precio = precio + 1;
	
/*	6.3 Hacer constar en la base de datos que la empresa 'Susan Calvin Corp' (RBT)
	no va a suministrarnos ninguna pieza (aunque la empresa en sí va a seguir
	constando en nuestra base de datos). */
	
	DELETE FROM suministra
	WHERE idproveedor = 'RBT';
	
/*	6.4 Hacer constar en la base de datos que la empresa 'Susan Calvin Corp' (RBT)
	ya no va a suministrarnos clavos (código 4). */
	
	DELETE FROM suministra
	WHERE idproveedor = 'RBT' AND codigopieza = 4;
	