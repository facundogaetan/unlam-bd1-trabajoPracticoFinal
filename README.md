Enunciado y Requisitos 
El proyecto CeVe Bien se presenta como una plataforma web destinada a 
desarrolladores web, permitiéndoles cargar y gestionar sus currículos y portafolios de 
proyectos, trabajos y cursos. La finalidad de esta iniciativa es ofrecer un espacio donde los 
profesionales puedan crear un perfil completo que resalte tanto sus habilidades técnicas 
como su experiencia laboral. Los alumnos deberán diseñar un modelo de datos que 
contemple diversas secciones del currículum. 
En primer lugar, el perfil del usuario incluirá datos personales esenciales como 
nombre, dirección, correo electrónico y número de teléfono. Además, se deberá registrar la 
experiencia laboral del usuario, detallando cada puesto ocupado con información sobre la 
empresa, el cargo desempeñado, las fechas de inicio y fin, así como una descripción de las 
funciones y logros alcanzados. La sección de educación es igualmente importante, donde se 
incluirán detalles sobre la formación académica, como el nombre de la institución, el título 
obtenido y las fechas correspondientes. En cuanto a las habilidades del usuario, se espera 
que se registren tanto las blandas como las duras, permitiendo establecer una jerarquía o 
nivel de dominio en cada una. 
Una parte fundamental del proyecto es el portafolio de proyectos. Esta sección 
permitirá a los usuarios detallar cada proyecto en el que han trabajado, incluyendo el 
nombre del proyecto, una descripción del objetivo, las fechas de inicio y fin, así como 
imágenes y videos que acompañen al contenido. Cada elemento del portafolio debe ser 
descrito con características específicas que faciliten la comprensión del trabajo realizado.
Asimismo, se deben registrar las habilidades desarrolladas/ganadas por proyecto.
Se podrá referenciar a otras personas en los proyectos como en los trabajos, sea que 
fueron compañeros, supervisores/jefes o clientes, y así admitir que esas personas hagan una 
devolución o comentario sobre el proyecto y/o el usuario. Será opcional dejar un contacto 
de los mismo o el enlace a la cuenta si resulta ser otro usuario del sitio.
El equipo que desarrolla la página web deja en claro que el Modelo de Datos deberá 
permitir almacenar y acceder a la siguiente información:
• Curriculum detallado.
• Cronología de proyectos.
• Tiempo dedicado a cada proyecto del portafolio.
• Listar habilidades duras y blandas con su grado de habilidad.
• Permitir búsquedas de perfiles por combinación de habilidades y seniority

Estructura del Trabajo Práctico 
Se deberán resolver y entregar los siguientes ítems:
A) Modelo conceptual mediante un DER. Las restricciones que no puedan expresarse en el 
DER pueden ir en lenguaje natural. Pueden utilizar la herramienta online draw.io para 
graficarlo y documentarlo.
B) Modelo lógico mediante el MR correspondiente. Se debe consignar todas las relaciones 
que surjan del DER, todos los atributos, todas las claves primarias y todas las claves 
foráneas.
C) Modelo físico con un script de creación de estructuras e inserción de datos en MySQL 
(DML y DDL).
D) Respuesta a las siguientes consultas, formuladas en un script SQL:
i. Listar los 10 proyectos más destacados en el portafolio según criterios definidos 
por el grupo. 
ii. Mostrar un resumen estadístico sobre la cantidad de proyectos, experiencia 
laboral y educación registrada por cada usuario. 
iii. Generar una consulta que permita filtrar proyectos por tecnologías específicas 
utilizadas. 
iv. Crear una vista que muestre un resumen completo del perfil del usuario con su 
portafolio asociado. 
v. Detallar por usuario, el grado de las habilidades que posee en base a las que ha 
desarrollado en los proyectos de su porfolio. Esto permitirá comprender si las 
habilidades declaradas en su perfil son coherentes con las de su experiencia.
vi. Elaborar una consulta interesante que permita explorar relaciones entre 
diferentes entidades en el modelo. Además, expresarla en lenguaje natural
