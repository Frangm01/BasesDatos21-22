-- Consulta de dos tablas
SELECT e.APELLIDO
FROM enfermo e
INNER JOIN ocupacion o ON e.INSCRIPCION = o.INSCRIPCION;

-- Consulta de tres tablas, saber qué enfermera/o está con qué enfermo
SELECT e.APELLIDO AS 'Paciente', p.EMPLEADO_NO AS 'Empleado'
FROM enfermo e
INNER JOIN ocupacion o ON e.INSCRIPCION = o.INSCRIPCION
INNER JOIN plantilla p ON o.HOSPITAL_COD = p.HOSPITAL_COD AND o.SALA_COD = p.SALA_COD;

-- Mostrar la lista de nombres de enfermeros/as, enfermos y nombres de salas
SELECT e.APELLIDO AS 'Paciente', p.APELLIDO AS 'Enfermere', s.NOMBRE AS 'Nombre sala'
FROM enfermo e
INNER JOIN ocupacion o ON e.INSCRIPCION = o.INSCRIPCION
INNER JOIN plantilla p ON o.HOSPITAL_COD = p.HOSPITAL_COD AND o.SALA_COD = p.SALA_COD
INNER JOIN sala s ON p.HOSPITAL_COD = s.HOSPITAL_COD AND p.SALA_COD = s.SALA_COD
ORDER BY Paciente;

-- Mostrar cuántos enfermeros tratan a cada paciente, agrupados por paciente
SELECT e.APELLIDO AS 'Paciente', COUNT(p.EMPLEADO_NO) AS 'Numero enfermeros'
FROM enfermo e
INNER JOIN ocupacion o ON e.INSCRIPCION = o.INSCRIPCION
INNER JOIN plantilla p ON o.HOSPITAL_COD = p.HOSPITAL_COD AND o.SALA_COD = p.SALA_COD
GROUP BY Paciente;

-- Calcula la media de salario que tienen los enfermeros de cada paciente
SELECT e.APELLIDO AS 'Paciente', AVG(p.SALARIO) AS 'Salario medio enfermeros'
FROM enfermo e
INNER JOIN ocupacion o ON e.INSCRIPCION = o.INSCRIPCION
INNER JOIN plantilla p ON o.HOSPITAL_COD = p.HOSPITAL_COD AND o.SALA_COD = p.SALA_COD
GROUP BY Paciente;

-- Saber cuántos pacientes hay por sala. Mostrar el nombre de la sala.
SELECT DISTINCT s.Nombre AS 'Sala', COUNT(o.INSCRIPCION) AS 'Numero pacientes'
FROM sala s
INNER JOIN ocupacion o ON s.HOSPITAL_COD = o.HOSPITAL_COD AND s.SALA_COD = o.SALA_COD
GROUP BY sala;

-- Saber qué salas no tienen pacientes
SELECT DISTINCT s.Nombre AS 'Sala', COUNT(o.INSCRIPCION) AS 'NumPacientes'
FROM sala s
LEFT JOIN ocupacion o ON s.HOSPITAL_COD = o.HOSPITAL_COD AND s.SALA_COD = o.SALA_COD
GROUP BY sala
HAVING NumPacientes = 0;

