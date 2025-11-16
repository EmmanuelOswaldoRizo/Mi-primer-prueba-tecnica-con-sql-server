-- ¡Hola a todos!, mi noombre es Emmanuel Oswaldo Telles Rizo y esta es mi prueba tecnica para TOKA--
  
  /* 1.-¿Qué es una base de datos?
  Una base de datos para mi es la recopilacion de datos de manera sistematica y almacenada (en nuestro caso de manera
  electronica) gestionando, organizando y protegiendo colecciones finitas de datos*/

-- 2. Utilizando el lenguaje DML, de las siguientes tablas codifica las consultas a continuación.--

/*Se usa CREATE para base de datos (DATABASE) */
CREATE DATABASE Pruebatecnica;

/*USE para identificar que las tablas seran de esta base de datos (Aunque dando doble click a la barra de
la izquiera se pone en negritas y permite ejecutar cada script*/
USE Pruebatecnica;

-- Se crea tablas que conforman la base de datos--

CREATE TABLE tb_Sexo (
    Idsexo INT PRIMARY KEY,
    Descripcio VARCHAR(20) NOT NULL
);

CREATE TABLE tb_Idcarrera (
    IdCarrer INT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
);

CREATE TABLE tb_Alumnos (
    id_alumno INT PRIMARY KEY,
    FechaRegistro DATE,
    Nolista VARCHAR(10) UNIQUE NOT NULL,
    Nombre VARCHAR(50),
    Apaterno VARCHAR(50),
    Amaterno VARCHAR(50),
    IdSexo INT,
    IdCarrer INT,
    FOREIGN KEY (IdSexo) REFERENCES tb_Sexo(Idsexo),
    FOREIGN KEY (IdCarrer) REFERENCES tb_Idcarrera(IdCarrer)
);

CREATE TABLE tb_Materias (
    IdMateria INT PRIMARY KEY,
    NombreMateria VARCHAR(100),
    Idcarrera INT,
    FOREIGN KEY (Idcarrera) REFERENCES tb_Idcarrera(IdCarrer)
);

-- insertar datos a las tablas --

/*Se usa INSERT para agregar tal cantidad en los atributos de la tabla*/

INSERT INTO tb_Sexo (Idsexo, Descripcio) VALUES
(1, 'FEMENINO'),
(2, 'MASCULINO');


INSERT INTO tb_Idcarrera (IdCarrer, Nombre) VALUES
(1, 'MEDICINA'),
(2, 'CONTABILIDAD'),
(3, 'ADMINISTRACION');

INSERT INTO tb_Alumnos (id_alumno, FechaRegistro, Nolista, Nombre, Apaterno, Amaterno, IdSexo, IdCarrer) VALUES
(1, '2019-01-01', 'MAT01', 'SOFIA', 'CAMPOS', 'ANDRADE', 1, 3),
(2, '2019-01-02', 'MAT02', 'RAUL', 'LOPEZ', 'RODRIGUEZ', 2, 1),
(3, '2019-01-03', 'MAT03', 'ANDREA', 'HERNANDEZ', 'DAMIAN', 1, 2),
(4, '2019-01-04', 'MAT04', 'TOMAS', 'JUAREZ', 'DOMINGUEZ', 2, 3),
(5, '2019-01-05', 'MAT05', 'LILIANA', 'JIMENEZ', 'NAVA', 1, 1);

INSERT INTO tb_Materias (IdMateria, NombreMateria, Idcarrera) VALUES
(1, 'Química General.', 1),
(2, 'Biología Celular.', 1),
(8, 'Contabilidad Básica.', 2),
(9, 'Administración Aplicada.', 2),
(17, 'Derecho Mercantil.', 3),
(18, 'Administración de Ventas.', 3);

-- 2.1.- Mostrar el numero de lista, nombre, apellidos y el nombre de la carrera que cursa cada alumno. --

USE Pruebatecnica;

/*Se usa SELECT para pedir que datos va a mostrar*/
SELECT a.Nolista, a.Nombre, a.Apaterno, a.Amaterno, c.Nombre AS NombreCarrera
   FROM tb_Alumnos 
   AS a
   JOIN tb_Idcarrera 
   AS c ON a.IdCarrer = c.IdCarrer;
    
    -- 2.2.- Mostrar el número de lista, nombre, apellidos y sexo(masculino o femenino) de los alumnos mujeres que estudien medicina.
    
SELECT a.Nolista, a.Nombre, a.Apaterno, a.Amaterno, s.Descripcio 
   AS Sexo
   FROM tb_Alumnos 
   AS a
   JOIN tb_Idcarrera 
   AS c ON a.IdCarrer = c.IdCarrer
   JOIN tb_Sexo AS s ON a.IdSexo = s.Idsexo
   WHERE s.Descripcio = 'FEMENINO'
   AND c.Nombre = 'MEDICINA';
    
    -- 2.3 Mostrar materias que puede tomar el alumno MAT03--    
/*Aqui quise agregar el nombre completo del alumno*/

SELECT a.Nolista, a.Nombre, a.Apaterno, a.Amaterno, m.NombreMateria
FROM tb_Materias AS m
JOIN tb_Alumnos AS a ON m.Idcarrera = a.IdCarrer
WHERE a.Nolista = 'MAT03';

-- 3.- De las mismas tablas anteriores cual seria la sintaxis para resolver lo siguiente:

-- 3.1.- se requiere ingresar un nuevo alumno número lista: MAT06, nombre: ALFREDO , apellido paterno=ALTAMIRANO ,apellido materno: TORRES, sexo: MASCULINO, carrera: CONTABILIDAD

INSERT INTO tb_Alumnos (
    id_alumno,
    FechaRegistro,
    Nolista,
    Nombre,
    Apaterno,
    Amaterno,
    IdSexo,
    IdCarrer
)
VALUES (
    6,             
    '2019-01-06',    -- Aqui quise agregar la fecha igual viendo el ejecicio proximo-- 
    'MAT06','ALFREDO','ALTAMIRANO','TORRES',     
    2,     -- El ID para 'MASCULINO'
    2      -- El ID para 'CONTABILIDAD'
);

/*Hay que verificar que hasta el momento si se haya agregado correctamente*/
SELECT * FROM tb_alumnos;


-- 3.2.- la fecha de registro de los alumnos de administración debe ser cambiada al año 2020

UPDATE tb_Alumnos
SET FechaRegistro = DATE_ADD(FechaRegistro, INTERVAL (2020 - YEAR(FechaRegistro)) YEAR)
WHERE IdCarrer = 3;

/*Hay que verificar que hasta el momento si se haya cambiado la fecha correctamente*/
SELECT * FROM tb_alumnos;

-- 3.3.- la Materia ADMINISTRACION DE VENTAS ya no es parte del plan de estudios por lo que es necesario eliminarla.

SELECT IdMateria
FROM tb_Materias
WHERE NombreMateria = 'Administración de Ventas.';

DELETE FROM tb_Materias
WHERE IdMateria = 18;

/*Hay que verificar que si se haya eliminado correctamente*/
SELECT * FROM tb_materias;

-- 4.- Utilizando el lenguaje DDL y tomando como referencia las tablas del ejercicio anterior cal seria la sintaxis para las siguientes.
	
-- 1.-La tabla de alumnos es necesario que cuenten con una columna para captura el RFC y otra para capturar el CURP.

    
 /*ALTER nos ayuda a agregar las columnas necesarias para la tabla*/
ALTER TABLE tb_Alumnos
   ADD COLUMN RFC VARCHAR(13),
   ADD COLUMN CURP VARCHAR(18);
   
-- Aqui quise agregar RFC y CURP simuladas para completar las tablas --

UPDATE tb_Alumnos
SET
    RFC = CASE id_alumno
        WHEN 1 THEN 'CAAS850110ABC'
        WHEN 2 THEN 'LORR840215DEF'
        WHEN 3 THEN 'HEDA860320GHI'
        WHEN 4 THEN 'JUDT830425JKL'
        WHEN 5 THEN 'JINL870530MNO'
        WHEN 6 THEN 'AATA880610PQR'
        ELSE RFC
    END,

    CURP = CASE id_alumno
        WHEN 1 THEN 'CAAS850110MDFCRTS0' 
        WHEN 2 THEN 'LORR840215HNLPRZ02' 
        WHEN 3 THEN 'HEDA860320MCMHRND0' 
        WHEN 4 THEN 'JUDT830425HOXJRZG0' 
        WHEN 5 THEN 'JINL870530MJCJMNV0' 
        WHEN 6 THEN 'AATA880610HVCATB06' 
        ELSE CURP
    END
WHERE
    id_alumno IN (1, 2, 3, 4, 5, 6);
    
/*Al igual hay que corroborar*/
select * from tb_alumnos;

-- 4.1.- Se requiere un catalogo de turnos en que se imparten las materias (MATUTINO, VESPERTINO, MIXTO).
/*Aqui hay que crear de nueva cuenta una tabla para que funja como catalogo de "Turnos"*/

CREATE TABLE tb_Turnos (
    IdTurno INT PRIMARY KEY AUTO_INCREMENT,
    Descripcion VARCHAR(20) NOT NULL
);

INSERT INTO tb_Turnos (Descripcion) VALUES ('MATUTINO'),('VESPERTINO'),('MIXTO');

/*verificar si el catalogo se genero bien*/
SELECT * FROM tb_turnos;

-- 4.1.- Se requiere un catalogo de turnos en que se imparten las materias (MATUTINO, VESPERTINO, MIXTO).

ALTER TABLE tb_Materias
ADD COLUMN IdTurno INT,
ADD CONSTRAINT FK_Materia_Turno
    FOREIGN KEY (IdTurno) REFERENCES tb_Turnos(IdTurno);
    
    -- 4.3 Del punto anterior es necesario que las materias de medicina se impartan en turno matutino, las materias de contabilidad se impartan en el turno vespertino y las de administración en turno mixto.

UPDATE tb_Materias
SET
    IdTurno = CASE Idcarrera
        WHEN 1 THEN 1  -- Medicina (1) -> Matutino (1)
        WHEN 2 THEN 2  -- Contabilidad (2) -> Vespertino (2)
        WHEN 3 THEN 3  -- Administración (3) -> Mixto (3)
        ELSE IdTurno  -- No cambiar las demás si no coinciden
    END
WHERE
    Idcarrera IN (1, 2, 3);

/*Este corrobora la organizacion por turnos*/

SELECT
    m.NombreMateria,
    c.Nombre AS Carrera,
    t.Descripcion AS Turno
FROM
    tb_Materias AS m
JOIN
    tb_Idcarrera AS c ON m.Idcarrera = c.IdCarrer
LEFT JOIN
    tb_Turnos AS t ON m.IdTurno = t.IdTurno;
    
    /*Revision de scripts*/
    
    SELECT * from tb_alumnos;
    
    /*Script de verificacion general de materias y turnos*/

    SELECT
    m.IdMateria,
    m.NombreMateria,
    c.Nombre AS Carrera,
    t.Descripcion AS Turno
FROM
    tb_Materias AS m
JOIN
    tb_Idcarrera AS c ON m.Idcarrera = c.IdCarrer
LEFT JOIN
    tb_Turnos AS t ON m.IdTurno = t.IdTurno;






    