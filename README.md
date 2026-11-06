# Sistema de Pedidos - Desarrollo de Aplicaciones Empresariales Avanzado (PA3)

Repositorio correspondiente a la Práctica Calificada 3 (PA3), enfocado en la implementación de consultas avanzadas utilizando **Spring JDBC** (`NamedParameterJdbcTemplate`), arquitectura dual (REST y MVC con vistas JSP), validaciones de negocio en la capa Service y control de acceso mediante **Spring Security**[cite: 1, 4, 6].

---

## 1. Tecnologías Utilizadas
* **Java** (Versión compatible con Spring Boot)
* **Spring Boot**
* **Spring JDBC** (`NamedParameterJdbcTemplate` para consultas personalizadas)
* **Spring Data JPA / Hibernate** (Para el CRUD base y persistencia general)
* **Spring MVC & JSP** (Interfaz web de reportes y supervisión)
* **Spring Security** (Control de autenticación y roles de laboratorio)
* **MySQL** (Base de datos relacional principal)
* **H2 Database** (Motor embebido destinado exclusivamente a pruebas automatizadas)
* **JUnit 5 / Mockito** (Batería de pruebas automatizadas)

---

## 2. Requisitos y Configuración de Base de Datos

El proyecto utiliza MySQL para su ejecución normal. Sigue estos pasos para aprovisionar el entorno local:

1. Ubícate en la raíz del repositorio donde se encuentra el archivo **`Script_BD_usuario_MySql.sql`**.
2. Ejecuta dicho script en tu servidor MySQL local para crear la base de datos `pedidosdb` y el usuario de laboratorio `spedidos_app`[cite: 3, 6]:
   ```sql
   -- Contenido resumido del script provisto
   CREATE DATABASE IF NOT EXISTS pedidosdb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   CREATE USER IF NOT EXISTS 'spedidos_app'@'localhost' IDENTIFIED BY 'userapp_2026!';
   GRANT ALL PRIVILEGES ON pedidosdb.* TO 'spedidos_app'@'localhost';
   FLUSH PRIVILEGES;

## 3. Carpeta de Trabajo y Archivos del Proyecto

El desarrollo principal de esta PA3 se realizó dentro de la subcarpeta del repositorio:
`ADVANCED-BUSINESS-APPLICATION-DEVELOPMENT/Sesión 5/sistema-pedidos-springboot`

### Archivos Creados / Modificados:
* **Script de BD (Raíz):** `Script_BD_usuario_MySql.sql` (Aprovisionamiento de base de datos y usuario MySQL)[cite: 5].
* **Repositorio JDBC:** `PedidoReporteJdbcRepository.java` (Implementación de consultas avanzadas con `NamedParameterJdbcTemplate`).
* **Capa de Servicio:** `PedidoReporteService.java` y `PedidoReporteServiceImpl.java` (Validaciones de negocio e integración).
* **Controladores:**
    * `PedidoReporteController.java` (API REST que retorna JSON).
    * `PedidoReporteWebController.java` (Controlador Spring MVC).
* **Vista JSP:** `reportes-pedidos.jsp` (Interfaz web del panel de supervisión).
* **Pruebas Automatizadas:** `PedidoReporteJdbcRepositoryTest.java` y `PedidoReporteServiceImplTest.java` (Tests con H2 y JUnit 5).

---

## 4. Variables de Entorno

Para cumplir con las buenas prácticas de seguridad y evitar exponer credenciales reales en el repositorio, las credenciales de conexión son externalizables mediante las siguientes variables de entorno[cite: 5, 6]:

* `DB_URL`: `jdbc:mysql://localhost:3306/pedidosdb?serverTimezone=America/Lima`
* `DB_USERNAME`: `spedidos_app`
* `DB_PASSWORD`: `userapp_2026!`

*(Nota: Si no se configuran de forma externa, el sistema tomará por defecto los valores de respaldo definidos en el archivo `application.properties` para facilitar la ejecución local).*

---

## 5. Orden de Arranque

1. Clona el repositorio y asegúrate de posicionarte en la rama correspondiente (`feature/sistema-pedidos-spring-jdbc`)[cite: 6].
2. Ejecuta el script de aprovisionamiento de MySQL en la raíz del proyecto (`Script_BD_usuario_MySql.sql`)[cite: 5, 6].
3. Levanta el microservicio externo de soporte (`inventario-service`) ubicado en la Sesión 4 para la integración HTTP con el `InventarioRestClient`[cite: 6].
4. Ejecuta la aplicación Spring Boot principal ubicada en `ADVANCED-BUSINESS-APPLICATION-DEVELOPMENT/Sesión 5/sistema-pedidos-springboot` (mediante IntelliJ IDEA o ejecutando `mvn spring-boot:run`).

---

## 6. Usuarios y Roles de Laboratorio

El sistema cuenta con autenticación basada en Spring Security con los siguientes perfiles configurados para pruebas:
* **Rol Operador:** Acceso a operaciones de gestión y registro de pedidos.
* **Rol Consulta:** Acceso a los reportes analíticos y vistas de supervisión.

---

## 7. Rutas Nuevas y Ejemplos de Uso

### API REST (Respuestas en JSON)
* **Búsqueda Avanzada:** `GET /api/v1/pedidos/busqueda-avanzada`
    * *Ejemplo:* `http://localhost:8081/sistema-pedidos/api/v1/pedidos/busqueda-avanzada?cliente=Juan&totalMinimo=100.0`
* **Clientes Frecuentes:** `GET /api/v1/pedidos/clientes-frecuentes`
    * *Ejemplo:* `http://localhost:8081/sistema-pedidos/api/v1/pedidos/clientes-frecuentes?minPedidos=2`

### Interfaz Web (Spring MVC / JSP)
* **Panel de Reportes:** `GET /reportes/pedidos`
    * *Ejemplo:* `http://localhost:8081/sistema-pedidos/reportes/pedidos`

---

## 8. Pruebas Automatizadas y Limitaciones

### Ejecución de Pruebas
Para verificar el correcto funcionamiento del comportamiento de repositorios JDBC (mediante H2) y servicios, ejecuta en la terminal de la Sesión 5[cite: 6]:
```bash
mvn test
```

## 9. Limitaciones

La integración con inventario-service requiere que este se encuentre activo en el puerto configurado (8082) para simular escenarios de validación o indisponibilidad de stock.