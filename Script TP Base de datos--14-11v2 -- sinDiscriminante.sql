DROP SCHEMA IF EXISTS TP;
CREATE SCHEMA IF NOT EXISTS tp;
USE tp;

-- Perfil_Usuario
CREATE TABLE IF NOT EXISTS Perfil_Usuario (
	id_usuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(255) NOT NULL,
	apellido VARCHAR(255) NOT NULL,
	mail VARCHAR(255) UNIQUE,
	fecha_nac DATE NOT NULL,
	direccion_calle VARCHAR(255) NOT NULL,
	direccion_nro INT NOT NULL,
	direccion_cp INT NOT NULL
);

-- Institución
CREATE TABLE IF NOT EXISTS Institucion (
    id_institucion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    contacto VARCHAR(255)
);

--  Formacion_Academica
CREATE TABLE IF NOT EXISTS Formacion_academica (
    id_formacion INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nivel_educativo VARCHAR(50) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    titulo_obtenido VARCHAR(100) NOT NULL
);

-- Educacion
CREATE TABLE IF NOT EXISTS Educacion (
    id_educacion INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fecha_inicio DATE NOT NULL,
	fecha_fin DATE,
    promedio DECIMAL(3, 2),
    id_institucion INT NOT NULL,
    id_formacion INT NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_institucion) REFERENCES Institucion(id_institucion), -- Relacion "Estudia_en"
    FOREIGN KEY (id_formacion) REFERENCES Formacion_Academica(id_formacion), -- Relacion "Realizada"
    FOREIGN KEY (id_usuario) REFERENCES Perfil_Usuario(id_usuario) -- Relacion "Dispone"
);

-- Empresa
CREATE TABLE IF NOT EXISTS Empresa (
    id_empresa  INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_empresa VARCHAR(255) NOT NULL
);

-- Cargo
CREATE TABLE IF NOT EXISTS Cargo (
    id_cargo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

-- Experiencia Laboral
CREATE TABLE IF NOT EXISTS Experiencia_Laboral (
    id_experiencia INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    descripcion VARCHAR(255),
    id_empresa INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Perfil_Usuario(id_usuario),  -- Relación "Tiene"
    FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa)          -- Relación "Trabaja"
);


-- Referencia
CREATE TABLE IF NOT EXISTS Referencia (
    id_referencia INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    mail VARCHAR(100),
    id_usuario INT NOT NULL,  
    FOREIGN KEY (id_usuario) REFERENCES Perfil_Usuario(id_usuario) -- Relación "Menciona"
);

--  Proyecto
CREATE TABLE IF NOT EXISTS Proyecto (
    id_proyecto INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    fecha_inicio DATE NOT NULL,
	fecha_fin DATE NOT NULL,
    objetivo VARCHAR(255) NOT NULL,
    enlace VARCHAR(255) NOT NULL,
    valoracion DECIMAL(3, 2),
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Perfil_Usuario(id_usuario)
);

--  Tecnologia
CREATE TABLE IF NOT EXISTS Tecnologia (
    id_tecnologia INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    entorno VARCHAR(255),
	lenguaje VARCHAR(255)
);
  
--  Tipo
CREATE TABLE IF NOT EXISTS Tipo (
    id_tipo INT PRIMARY KEY,
    nombre VARCHAR(50)
);

--  Habilidad
CREATE TABLE IF NOT EXISTS Habilidad (
    id_habilidad INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    id_tipo INT NOT NULL,  
	FOREIGN KEY (id_tipo) REFERENCES Tipo(id_tipo)  -- Relación "Pertenece" 

);

--  Seniority
CREATE TABLE IF NOT EXISTS Seniority (
    id_seniority INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nivel_dominio VARCHAR(255)
);


-- Telefono (Atributo multivaluado)
CREATE TABLE IF NOT EXISTS Telefono(
	id_usuario INT NOT NULL,
	telefono VARCHAR(255) NOT NULL,
	CONSTRAINT id_telefono PRIMARY KEY (id_usuario, telefono),
	FOREIGN KEY (id_usuario) REFERENCES Perfil_Usuario(id_usuario)
);

-- Logro (Atributo multivaluado)
CREATE TABLE IF NOT EXISTS Logro (
    id_experiencia INT NOT NULL,
    num_logro INT NOT NULL,             -- ya no es AUTO_INCREMENT
    descripcion VARCHAR(255) NOT NULL,
    id_usuario INT NOT NULL,            -- id_usuario como referencia
    PRIMARY KEY (id_experiencia, num_logro),
    FOREIGN KEY (id_experiencia) REFERENCES Experiencia_Laboral(id_experiencia),
    FOREIGN KEY (id_usuario) REFERENCES Perfil_Usuario(id_usuario)
);






-- Caracteristica (Atributo multivaluado)
CREATE TABLE IF NOT EXISTS Caracteristica (
	id_proyecto INT NOT NULL,
	caracteristica VARCHAR(255),
	CONSTRAINT id_caracteristica PRIMARY KEY (id_proyecto, caracteristica),
	FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto)
);


-- Multimedia Imagen (Atributo multivaluado)
CREATE TABLE IF NOT EXISTS multimedia_imagen (
	id_proyecto INT NOT NULL,
    imagen VARCHAR(255) NOT NULL,
    CONSTRAINT id_multimedia_imagen PRIMARY KEY (id_proyecto, imagen),
	FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto) 
);
-- Multimedia Video (Atributo multivaluado)
CREATE TABLE IF NOT EXISTS multimedia_video (
	id_proyecto INT NOT NULL,
	video VARCHAR(255) NOT NULL,
    CONSTRAINT id_multimedia_video PRIMARY KEY (id_proyecto, video),
	FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto) 
);


/*RELACIONES*/

-- Maneja
CREATE TABLE IF NOT EXISTS Maneja(
    id_usuario INT NOT NULL,
	id_habilidad INT NOT NULL,
    CONSTRAINT id_maneja PRIMARY KEY (id_usuario,id_habilidad),
    FOREIGN KEY (id_usuario) REFERENCES Perfil_Usuario(id_usuario),
    FOREIGN KEY (id_habilidad) REFERENCES Habilidad(id_habilidad)  
);

-- Aplica
CREATE TABLE IF NOT EXISTS aplica (
    id_habilidad INT NOT NULL,
    id_seniority INT NOT NULL,
    CONSTRAINT id_aplica PRIMARY KEY (id_habilidad, id_seniority),
    FOREIGN KEY (id_habilidad) REFERENCES Habilidad(id_habilidad),
    FOREIGN KEY (id_seniority) REFERENCES Seniority(id_seniority)
);

-- Desempeña
CREATE TABLE IF NOT EXISTS Desempena (
    id_cargo INT NOT NULL,
    id_usuario INT NOT NULL,  
    CONSTRAINT id_desempena PRIMARY KEY (id_cargo, id_usuario),
    FOREIGN KEY (id_cargo) REFERENCES Cargo(id_cargo),
    FOREIGN KEY (id_usuario) REFERENCES Perfil_Usuario(id_usuario)
);




-- Hace
CREATE TABLE IF NOT EXISTS Hace (
    id_referencia INT NOT NULL,
    id_usuario INT NOT NULL,
    comentario_experiencia VARCHAR(500),
    CONSTRAINT id_hace PRIMARY KEY (id_referencia, id_usuario),
    FOREIGN KEY (id_referencia) REFERENCES Referencia(id_referencia),
    FOREIGN KEY (id_usuario) REFERENCES Perfil_Usuario(id_usuario)
);


-- Registra
CREATE TABLE IF NOT EXISTS Registra(
	id_proyecto INT NOT NULL,
	id_referencia INT NOT NULL,
	comentario_proyecto VARCHAR(500), 
	CONSTRAINT id_registra PRIMARY KEY (id_proyecto,id_referencia),
	FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto),
	FOREIGN KEY (id_referencia) REFERENCES Referencia(id_referencia)
);

-- Usa
CREATE TABLE IF NOT EXISTS Usa (
	id_proyecto INT NOT NULL,
	Id_tecnologia INT NOT NULL,
	CONSTRAINT id_usa PRIMARY KEY (id_proyecto, id_tecnologia),
	FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto),
	FOREIGN KEY (id_tecnologia) REFERENCES tecnologia(id_tecnologia)
);

-- Posee
CREATE TABLE IF NOT EXISTS Posee (
	id_usuario INT NOT NULL,
	id_habilidad INT NOT NULL,
	id_proyecto INT NOT NULL,
	CONSTRAINT id_posee PRIMARY KEY (id_usuario, id_habilidad, id_proyecto),
	FOREIGN KEY (id_usuario) REFERENCES Perfil_usuario(id_usuario),
	FOREIGN KEY (id_habilidad) REFERENCES Habilidad(id_habilidad),
	FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto)
);



/*==================
   INSERT DE DATOS  
====================*/


INSERT INTO Perfil_Usuario (id_usuario, nombre, apellido, mail, fecha_nac, direccion_calle, direccion_nro, direccion_cp)
VALUES 
	(1, 'John', 'Doe', 'johndoe@example.com', '1990-01-15', 'Main Street', 123, 12345), 
	(2, 'Lionel', 'Messi', 'Liomessi@example.com', '1987-06-24', 'Barca Street', 456, 2742), 
	(3, 'Dean', 'Ambrose', 'dino@example.com', '1986-05-13', 'Wwe Street', 789, 0034);
    
INSERT INTO Telefono (id_usuario, telefono)
VALUES
	(1,'+123456789'),
	(2,'+987654321'),
	(2,'+2233445566'),
	(3,'+3344556677');

INSERT INTO Institucion (id_institucion, nombre, direccion, contacto)
VALUES
	(1,'Universidad Nacional de Córdoba', 'Av. Medina Allende s/n', 'universidad@unc.edu.ar'),
	(2,'Universidad de Buenos Aires', 'Pabellón I, Ciudad Universitaria', 'uba@uba.ar'), 
	(3,'Instituto Tecnológico de Buenos Aires', 'Medrano 951', 'itba@itba.edu.ar');

INSERT INTO Formacion_Academica (id_formacion, nivel_educativo, estado, titulo_obtenido)
VALUES
    (1, 'Universitario', 'Cursando', 'Licenciatura en Informática'),
    (2, 'Universitario', 'Graduado', 'Ingeniería Civil' ),
    (3, 'Medio Superior','Cursando', 'Bachillerato en Ciencias');
  
INSERT INTO Educacion (id_educacion, fecha_inicio, fecha_fin, promedio, id_Institucion, id_Formacion, id_Usuario)
VALUES 
	(1, '2010-01-01', '2014-12-31', 8.5, 1, 1, 1), 
	(2, '2009-03-10', '2013-11-30', 5.0, 2, 2, 2), 
	(3, '2011-03-06', '2017-12-01', 7.5, 3, 3, 3);
       
INSERT INTO Referencia (id_referencia, nombre, apellido, telefono, mail, id_usuario) 
VALUES 
	(1, 'John', 'Doe', '+1176258774', 'johndoe@example.com',1), 
	(2, 'Jane', 'Smith', '+1234567890','janesmith@example.com',2), 
	(3, 'Michael', 'Johnson', '+1532437890', 'michael.johnson@company.com', 1), 
	(4, 'Emily', 'Brown', '+9876543210', 'brown.emily@example', 3); 

INSERT INTO Empresa (id_empresa, nombre_empresa) 
VALUES
	(1, 'Webster Inc.'),
	(2, 'TechCo'),
	(3, 'MegaTech Inc.'),
	(4, 'Pablo Web');

INSERT INTO Cargo (id_cargo, nombre) 
VALUES
	(1, 'Jefe de area'),
	(2, 'Empleado');

INSERT INTO Experiencia_Laboral (id_usuario, descripcion, id_empresa, fecha_inicio, fecha_fin) 
VALUES
    (1, 'Soporte Técnico', 1, '2018-01-01', '2020-04-18'),
    (1, 'Desarrollo de software', 4, '2021-01-01', '2024-04-18'),
    (2, 'Gestión de proyectos', 3, '2020-05-15', '2024-04-18'),
    (3, 'Marketing digital', 2, '2021-11-01', '2023-11-02');
 
INSERT INTO Logro (id_experiencia, num_logro, descripcion, id_usuario)
VALUES
    (1, 1, 'Aumento de eficiencia en procesos', 1),
    (1, 2, 'Rediseño de políticas de seguridad', 1),
    (1, 3, 'Gestioné la actualización de software para todos los clientes', 1),
    (2, 1, 'Colaboré en la migración de la base de datos', 2),
    (3, 1, 'Desarrollé un plan de marketing digital para la nueva marca', 3),
    (3, 2, 'Diseñé una campaña digital que aumentó las ventas', 3),
    (3, 3, 'Gestioné relaciones con influencers para campañas de marketing', 3);




INSERT INTO Tecnologia (id_tecnologia, entorno, lenguaje)
VALUES
    (1, 'Desarrollo Movil', 'Java'),
	(2, 'Eclipse', 'Java'),
    (3, 'Eclipse', 'C++'),
	(4, ' Visual Studio', 'Java'),
    (5, 'Eclipse', 'Java'),
    (6, 'Eclipse', 'C++'),
    (7, 'Eclipse', 'PHP'),
    (8, 'Desarrollo Web', 'JavaScript'),
    (9, 'Desarrollo Móvil', 'Kotlin'),
    (10, 'Inteligencia Artificial', 'Python'),
    (11, 'Eclipse', 'JavaScript'),
    (12, 'Eclipse', 'JavaScript'),
    (13, 'Eclipse', 'JavaScript'),
    (14, 'Eclipse', 'JavaScript'), 
    (15, 'Eclipse', 'JavaScript'), 
    (16, 'Eclipse', 'JavaScript'), 
    (17, 'Eclipse', 'JavaScript'), 
    (18, 'Eclipse', 'JavaScript'), 
    (19, 'Eclipse', 'JavaScript'), 
    (20, 'Eclipse', 'JavaScript'), 
    (21, 'Eclipse', 'JavaScript');

INSERT INTO Tipo (id_tipo, nombre) 
VALUES 
    (1, 'Dura'), 
    (2, 'Blanda'); 

INSERT INTO Habilidad (id_habilidad, nombre, id_tipo) 
VALUES
	(1, 'Programación en Java', 1), 
    (2, 'Programación en Python', 1),
    (3, 'Excel', 1),
    (4, 'Análisis de datos', 1),
    (5, 'Gestión de Equipos', 2),
    (6, 'Planificación de Proyectos', 2),
	(7, 'Creatividad', 2),
    (8, 'Negociación', 2);

INSERT INTO Seniority (id_seniority, nivel_dominio)
VALUES
    (1, 'Junior'),
    (2, 'Intermedio'),
    (3, 'Avanzado');

INSERT INTO aplica (id_habilidad, id_seniority)
VALUES
	(1, 1),(1, 2),(1, 3),  -- Programación en Java
    (2, 1),(2, 2),(2, 3),  -- Programación en Python
    (3, 1),(3, 2),(3, 3),  -- Excel
    (4, 1),(4, 2),(4, 3),  -- Análisis de datos
    (5, 1),(5, 2),(5, 3),  -- Gestión de Equipos
    (6, 1),(6, 2),(6, 3),  -- Planificación de Proyectos
    (7, 1),(7, 2),(7, 3),  -- Creatividad
    (8, 1),(8, 2),(8, 3);  -- Negociación

INSERT INTO Maneja (id_usuario, id_habilidad)
VALUES
    (1, 1),(1, 2), 
    (2, 1),(2, 5), 
    (3, 4),(3, 8); 

INSERT INTO Desempena (id_cargo, id_usuario)
VALUES
    (2, 1),   -- Esto ya existía, no lo insertes si ya está en la tabla
    (1, 2),
    (1, 3);



INSERT INTO Hace (id_referencia, id_usuario, comentario_experiencia)
VALUES
    (1, 1, 'Le falto codear un poco mas orientado a lo que seria la parte del backend, no reutilizó el código de forma adecuada.'),
    (2, 1, 'Excelente desempeño en proyectos de desarrollo web.'),
    (3, 2, 'Demostró gran capacidad de liderazgo en equipos multidisciplinarios.'),
    (4, 3, NULL);


    
INSERT INTO Proyecto (id_proyecto, nombre, objetivo, enlace, fecha_inicio, fecha_fin, valoracion, id_usuario)
VALUES
    (8, 'Juego de aplicacion', 'mejorar la jugabilidad', 'https://github.com/usuario/proyecto1', '2023-01-01', '2023-12-31', 4, 1),
    (2, 'Sistema de gestión de inventario para una pequeña empresa', 'Optimizar el control de stock y generar reportes', 'https://bitbucket.org/usuario/proyecto2', '2022-05-15', '2023-04-30', 5, 2),
    (3, 'Desarrollo de un chatbot para atención al cliente', 'Brindar soporte automatizado a los usuarios', 'https://gitlab.com/usuario/proyecto3', '2023-03-10', '2023-04-30', 5, 3),
    (4, 'Sistemas', 'mejorar la jugabilidad', 'https://github.com/usuario/proyecto1', '2023-01-01', '2023-12-31', 3, 1),
    (20, 'Sistemas', 'mejorar el uso de aplicaciones en interfaces', 'https://github.com/usuario/proyecto1', '2023-01-01', '2023-12-31', 3, 2),
    (21, 'Sistemas', 'Jugabilidad de League Of Legends', 'https://github.com/usuario/proyecto1', '2023-01-01', '2023-12-31', 5, 2),
    (22, 'Sistemas', 'mejorar el uso de aplicaciones en interfaces', 'https://github.com/usuario/proyecto1', '2023-01-01', '2023-12-31', 4, 2),
    (23, 'Sistemas', 'Texto a modo de ejemplo', 'https://github.com/usuario/proyecto1', '2023-01-01', '2023-12-31', 4, 2),
    (25, 'Análisis de datos de sensores IoT', 'Desarrollar un modelo de machine learning para predecir fallas en equipos', 'https://github.com/user/iot', '2021-09-01', '2022-02-28', 3, 1),
    (26, 'Desarrollo de una aplicación de escritorio para gestión de proyectos', 'Crear una herramienta para organizar y gestionar proyectos', 'https://bitbucket.org/user/project_management', '2022-05-15', '2022-12-31', 4, 1),
    (27, 'Creación de un chatbot para atención al cliente', 'Desarrollar un asistente virtual para responder preguntas frecuentes', 'https://gitlab.com/user/chatbot', '2023-03-01', '2023-09-30', 4, 1),
    (28, 'Desarrollo de una aplicación web de redes sociales', 'Crear una plataforma para conectar con amigos y familiares', 'https://github.com/user/social_network', '2021-12-01', '2022-08-31', 5, 1),
    (29, 'Análisis de sentimiento en redes sociales', 'Desarrollar un modelo para analizar la opinión pública sobre un tema específico', 'https://github.com/user/sentiment_analysis', '2023-02-15', '2023-05-31', 3, 1),
    (30, 'Desarrollo de una aplicación móvil de realidad aumentada', 'Crear una experiencia inmersiva utilizando la realidad aumentada', 'https://gitlab.com/user/ar_app', '2022-07-01', '2023-01-31', 5, 1),
    (31, 'Automatización de pruebas de software', 'Crear scripts para automatizar las pruebas de software', 'https://bitbucket.org/user/test_automation', '2023-04-15', '2023-09-15', 2, 1),
    (32, 'Desarrollo de una aplicación web de aprendizaje en línea', 'Crear una plataforma para ofrecer cursos en línea', 'https://github.com/user/online_learning', '2022-11-01', '2023-05-31', 4, 1),
    (33, 'Creación de un sistema de recomendación de productos', 'Desarrollar un algoritmo para recomendar productos a los usuarios', 'https://gitlab.com/user/recommendation_system', '2023-03-15', '2023-08-15', 5, 1),
    (34, 'Automatización de procesos con RPA', 'Crear bots para automatizar tareas repetitivas', 'https://bitbucket.org/user/rpa', '2023-04-01', '2023-09-30', 3, 1);

INSERT INTO multimedia_imagen (id_proyecto, imagen)
VALUES
	(8, 'https://example.com/imagen1.jpg'),
    (2, 'https://example.com/imagen2.png'),
    (3, 'https://example.com/imagen2.png'),
    (4, 'https://example.com/imagen1.jpg'),
    (20, 'https://example.com/imagen1.jpg'),
    (21, 'https://example.com/imagen1.jpg'),
    (22, 'https://example.com/imagen1.jpg'),
    (23, 'https://example.com/imagen1.jpg'),
    (25, 'https://example.com/iot_dashboard.png'),
    (26, 'https://example.com/project_management.png'),
    (27, 'https://example.com/chatbot.gif'),
    (28, 'https://example.com/social_network.jpg'),
    (29, 'https://example.com/sentiment_analysis.png'),
    (30, 'https://example.com/ar_app.png'),
    (31, 'https://example.com/test_automation.gif'),
    (32, 'https://example.com/online_learning.jpg'),
    (33, 'https://example.com/recommendation_system.png'),
    (34, 'https://example.com/rpa_robot.gif');
    
INSERT INTO multimedia_video (id_proyecto, video)
VALUES    
    (8, 'https://example.com/video1.mp4'),
    (2, 'https://example.com/video1.mp4'),
    (3, 'https://youtu.be/video3'),
    (4, 'https://example.com/video1.mp4'),
    (20, 'https://example.com/video1.mp4'),
    (21, 'https://example.com/video1.mp4'),
    (22, 'https://example.com/video1.mp4'),
    (23, 'https://example.com/video1.mp4'),
    (25, 'https://dailymotion.com/iot_demo'),
    (26, 'https://www.youtube.com/project_management_demo'),
    (27, 'https://vimeo.com/chatbot_demo'),
    (28, 'https://youtu.be/social_network_demo'),
    (29, 'https://dailymotion.com/sentiment_analysis_demo'),
    (30, 'https://vimeo.com/ar_demo'),
    (31, 'https://www.youtube.com/test_automation_demo'),
    (32, 'https://youtu.be/online_learning_demo'),
    (33, 'https://vimeo.com/recommendation_system_demo'),
    (34, 'https://www.youtube.com/rpa_demo');
    
INSERT INTO Caracteristica (id_proyecto, caracteristica)
VALUES
    (8, 'Mejora de jugabilidad'),
    (8, 'Mejoras en interactividad del juego'),
	(2, 'Generación de reportes'),
    (3, 'Optimización de respuestas del chatbot'),
    (4, 'Implementación de funciones avanzadas'),
    (22, 'Mejora de interfaces'),
    (26, 'Desarrollo de herramienta de gestión de proyectos'),
    (32, 'Plataforma de aprendizaje en línea'),
    (33, 'Sistema de recomendación de productos');
    
INSERT INTO Registra (id_proyecto, id_referencia, comentario_proyecto)
VALUES
    (8, 1, 'Contribución clave en el diseño de la arquitectura del sistema.'),
    (2, 2, 'Participación activa en el desarrollo de nuevas funcionalidades.'),
    (3, 3, 'Implementación de mejoras en la eficiencia del código.');

INSERT INTO Usa (id_proyecto, id_tecnologia)
VALUES
    (8, 08),
    (2, 09),
    (3, 10),
    (4, 4),
    (25, 12), 
    (26, 13), 
    (27, 14), 
    (28, 15),
    (29, 16), 
    (30, 17), 
    (31, 18),
    (32, 19),
    (33, 20),
    (34, 21),
    (20, 5),
    (21, 6),
    (22, 7),
    (23, 11);
   
INSERT INTO Posee (id_usuario, id_habilidad, id_proyecto)
VALUES
    (1, 1, 8),
    (2, 2, 2),
    (3, 3, 3),
	(1, 1, 4),
    (1, 5, 3),
    (2, 7, 20),
    (1, 6, 21),
    (2, 2, 22),
    (3, 2, 23);
 


/*=========
   CONSULTAS
===========*/

-- 1) Listar los 10 proyectos más destacados en el portafolio según criterios definidos por el grupo. 

/*Criterio: listar 10 proyectos mas destacados segun comentarios registrados
 con tecnologia de lenguaje javascript y entorno eclipse*/
 
SELECT P.id_proyecto, P.nombre AS 'Proyecto', P.valoracion, T.entorno, T.lenguaje
FROM Proyecto P
JOIN usa U ON P.id_proyecto = U.id_proyecto
JOIN Tecnologia T ON U.id_tecnologia = T.id_tecnologia
WHERE T.entorno LIKE '%Eclipse%' AND T.lenguaje LIKE '%JavaScript%'
GROUP BY P.id_proyecto, P.nombre, P.valoracion, T.entorno, T.lenguaje
ORDER BY P.valoracion DESC
LIMIT 10;


-- 2)  Mostrar un resumen estadístico sobre la cantidad de proyectos, experiencia laboral y educación registrada por cada usuario.experiencia_laboralexperiencia_laboralid_empresa

SELECT 
    pu.id_usuario, pu.nombre, pu.apellido,
    COUNT(DISTINCT p.id_proyecto) AS cantidad_proyectos,
    ROUND(el.anios_experiencia_laboral, 1) AS anios_experiencia_laboral,
    GROUP_CONCAT(DISTINCT fa.nivel_educativo ORDER BY fa.nivel_educativo ASC SEPARATOR ', ') AS tipo_educacion,
    GROUP_CONCAT(DISTINCT fa.estado ORDER BY fa.nivel_educativo ASC SEPARATOR ', ') AS estado_educacion
FROM 
    Perfil_Usuario pu
    LEFT JOIN Educacion e ON pu.id_usuario = e.id_usuario
    LEFT JOIN Formacion_academica fa ON e.id_formacion = fa.id_formacion
    LEFT JOIN Proyecto p ON pu.id_usuario = p.id_usuario
    LEFT JOIN (
        SELECT 
            id_usuario,
            SUM(DATEDIFF(IFNULL(fecha_fin, CURDATE()), fecha_inicio) / 365) AS anios_experiencia_laboral
        FROM Experiencia_Laboral
        GROUP BY id_usuario
    ) el ON pu.id_usuario = el.id_usuario
GROUP BY 
    pu.id_usuario, pu.nombre, pu.apellido;

-- 3) Generar una consulta que permita filtrar proyectos por tecnologías específicas utilizadas.

-- Otra manera de resolver con subconsulta
    
-- 4) Crear una vista que muestre un resumen completo del perfil del usuario con su portafolio asociado. 

CREATE OR REPLACE VIEW Perfil AS
SELECT PU.*, Pr.id_proyecto, Pr.nombre AS 'Nombre Proyecto'
 FROM Perfil_usuario PU
 JOIN Posee P ON PU.id_usuario=P.id_usuario
 JOIN Proyecto Pr ON Pr.id_proyecto=P.id_proyecto;
 
 SELECT * FROM tp.perfil;
 
 /* 5) Detallar por usuario, el grado de las habilidades que posee en base a las que ha desarrollado en
 los proyectos de su porfolio. Esto permitirá comprender si las habilidades declaradas en su perfil son 
 coherentes con las de su experiencia. */
 


-- 6) Elaborar una consulta interesante que permita explorar relaciones entre diferentes entidades en el modelo.

/*Relacionamos las referencias con la experiencia laboral y perfil del usuario, solicitando que nos devuelva a los que no poseen ningun
 comentario sobre la experiencia laboral*/
