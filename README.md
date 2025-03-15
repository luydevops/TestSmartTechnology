¡Claro! Puedo ayudarte a crear un archivo `README.md` para tu proyecto. Un archivo `README.md` es clave para que otros (o tú mismo en el futuro) comprendan qué hace el proyecto, cómo configurarlo y cómo utilizarlo.

Aquí tienes una estructura básica que podrías usar, adaptada a tu proyecto que tiene un backend con FastAPI y un frontend en Next.js:


```markdown
## Dockerización

El proyecto utiliza **Docker** para contenerizar los diferentes servicios que componen el sistema. Se han definido tres contenedores para manejar el backend (Python/FastAPI), la base de datos (PostgreSQL) y el frontend (React.js/Next.js), lo que permite un despliegue eficiente y aislado de cada componente.

### Contenedores

1. **Contenedor Backend (Python/FastAPI):**
   - Este contenedor ejecuta el backend desarrollado con **FastAPI**. El servidor de **FastAPI** gestiona las solicitudes HTTP y se comunica con la base de datos PostgreSQL.
   - El contenedor usa el archivo `Dockerfile` ubicado en la carpeta `/backend` para construir la imagen de Docker.
   - La configuración del contenedor está definida en el archivo `docker-compose.yml` bajo el servicio `python`.

2. **Contenedor de Base de Datos (PostgreSQL):**
   - Se utiliza un contenedor separado para ejecutar **PostgreSQL**, que es el sistema de gestión de base de datos del proyecto. La base de datos está configurada con un esquema para manejar los usuarios y las credenciales.
   - Este contenedor se configura bajo el servicio `PostgreSQL` en el archivo `docker-compose.yml`.

3. **Contenedor Frontend (React.js/Next.js):**
   - El frontend está desarrollado con **Next.js** y **React.js**. Este contenedor ejecuta el servidor de desarrollo para el frontend y está configurado para usar **Bootstrap** en el diseño.
   - El contenedor se configura bajo el servicio `rectjs` en el archivo `docker-compose.yml`.

### Docker Compose

El archivo `docker-compose.yml` se encuentra en la raíz del proyecto y permite levantar todos los contenedores con un solo comando. A continuación, un ejemplo de cómo se estructura el archivo para los tres servicios:

```yaml
version: '3.8'
name: ${DOCKER_PROYECT}
services:  
  python:
    build:
      dockerfile: ${PYTHIN_FILE}
    container_name: ${PYTHIN_CONTAINER_NAME}
    working_dir: ${WORKING_DIR}
    depends_on:
      - PostgreSQL
    deploy:
      resources:
        limits:
          cpus: ${PYTHIN_LIMITS_CPUS}
          memory: ${PYTHIN_LIMITS_MEMORY}
        reservations:
          cpus: ${DEFOULT_RESERVATIONS_CPUS}
          memory: ${PYTHIN_RESERVATIONS_MEMORY}
    expose:
      - ${PYTHIN_PORT}
    ports:
      - ${PYTHIN_PORT}:3000
    command: ${PYTHIN_COMMAND}
    volumes:
      - ../src/back:${PYTHIN_VOLUME}
    networks:
      - serv-bridge
      - db_network-sql

  PostgreSQL:
    image: ${POSTGRESQL_IMAGE}
    container_name: ${DB_CONTAINER_NAME}
    restart: always
    deploy:
      resources:
        limits:
          cpus: ${DEFOULT_LIMITS_CPUS}
          memory: ${DEFOULT_LIMITS_MEMORY}
        reservations:
          cpus: ${DEFOULT_RESERVATIONS_CPUS}
          memory: ${DEFOULT_RESERVATIONS_MEMORY}
    expose:
      - ${DB_PORT}
    ports:
      - ${DB_PORT}:5432
    volumes: 
      - ${DB_DATA_VOLUME}
    environment:
      POSTGRES_DB: ${DB_DATABASE}
      POSTGRES_PASSWORD: ${DB_ROOT_PASSWORD}
      POSTGRES_USER: root
    networks:
      - serv-bridge
      - db_network-sql

  rectjs:
    build:
      dockerfile: ${REACTJS_FILE}
    container_name: ${REACTJS_CONTAINER_NAME}
    working_dir: ${WORKING_DIR}
    deploy:
      resources:
        limits:
          cpus: ${DEFOULT_LIMITS_CPUS}
          memory: ${DEFOULT_LIMITS_MEMORY}
        reservations:
          cpus: ${DEFOULT_RESERVATIONS_CPUS}
          memory: ${DEFOULT_RESERVATIONS_MEMORY}
    tty: true
    expose:
      - ${REACTJS_PORT}
    ports:
      - ${REACTJS_PORT}:3000
    command: ${REACTJS_COMMAND}
    volumes:
      - ../src/front:${REACTJS_VOLUME}
    environment:
      - CHOKIDAR_USEPOLLING=true
    depends_on:
      - PostgreSQL
    networks:
      - serv-bridge
      - db_network-sql

networks:
  serv-bridge:
    driver: bridge
  db_network-sql:
    external: true
```

### ¿Cómo funciona?

1. **Backend**: El contenedor de backend expone el puerto configurado en `${PYTHIN_PORT}`, donde las peticiones llegan al API Gateway, que gestiona las rutas y la autenticación JWT. Este contenedor depende de la base de datos (contenedor `PostgreSQL`), que debe estar listo para funcionar antes de iniciar el backend.
   
2. **Base de Datos**: El contenedor de PostgreSQL está configurado con las variables de entorno necesarias para crear un usuario y una base de datos. Este contenedor expone el puerto `5432` para la conexión de la base de datos con el backend.

3. **Frontend**: El contenedor de frontend expone el puerto configurado en `${REACTJS_PORT}`, donde se puede acceder a la interfaz de usuario del dashboard, que se conecta al backend para gestionar usuarios.

### Variables de Entorno

El archivo `docker-compose.yml` utiliza variables de entorno que puedes definir en un archivo `.env` para personalizar configuraciones como los nombres de los contenedores, puertos, límites de recursos y volúmenes compartidos. Asegúrate de tener un archivo `.env` con las siguientes variables definidas:

```env
DOCKER_PROYECT=testSmartTechnology
PYTHIN_FILE=./backend/Dockerfile
PYTHIN_CONTAINER_NAME=backend
WORKING_DIR=/usr/src/app
PYTHIN_PORT=8010
PYTHIN_COMMAND=python3 main.py
PYTHIN_VOLUME=/src/back
POSTGRESQL_IMAGE=postgres:13
DB_CONTAINER_NAME=postgresql
DB_PORT=5432
DB_DATABASE=testdb
DB_ROOT_PASSWORD=rootpassword
DB_DATA_VOLUME=./db_data
REACTJS_FILE=./frontend/Dockerfile
REACTJS_CONTAINER_NAME=frontend
REACTJS_PORT=3010
REACTJS_COMMAND=npm run dev
REACTJS_VOLUME=/src/front
```

### Comandos Docker

Con Docker y Docker Compose instalados, puedes usar los siguientes comandos para levantar el proyecto:

1. Para construir y levantar todos los contenedores:

   ```bash
   docker-compose up --build
   ```

2. Para detener los contenedores:

   ```bash
   docker-compose down
   ```

3. Para ver los logs de los contenedores:

   ```bash
   docker-compose logs -f
   ```

4. Para ejecutar comandos dentro del contenedor (por ejemplo, acceder al contenedor de backend):

   ```bash
   docker exec -it backend /bin/bash
   ```


```markdown
# testSmartTechnology

## Descripción

Este es un proyecto de ejemplo que consiste en una API Gateway construida con **FastAPI** y un microservicio de base de datos usando **PostgreSQL**. El frontend está desarrollado con **Next.js** y utiliza **Bootstrap** para el diseño. El backend y el frontend están desplegados en contenedores Docker.

### Funcionalidades:

- **Backend API Gateway**: Gestiona la autenticación JWT, validaciones y reenvío de solicitudes a un microservicio de base de datos.
- **Microservicio de Base de Datos**: Maneja operaciones de base de datos usando **PostgreSQL**.
- **Frontend**: Dashboard con un menú lateral para gestionar usuarios.

## Tecnologías

- **Backend**:
  - FastAPI
  - PostgreSQL
  - Docker Compose
  - JWT para autenticación
- **Frontend**:
  - Next.js
  - React.js (con Bootstrap para diseño)

## Estructura del Proyecto


/testSmartTechnology
├── /deploy
│   ├── /DockerFiles
│   │   ├── /Python
│   │   └── /Node
│   ├── .env
│   ├── docker-compose.yml
│   ├── README.md
│   └── main.py
├── /backend
│   ├── /app
│   ├── /docker-compose.yml
│   ├── /Dockerfile
│   └── main.py
├── /frontend
│   ├── /views
│   ├── /pages
│   ├── /components
│   ├── /docker-compose.yml
│   ├── /Dockerfile
│   └── index.tsx
└── README.md
```

## Instalación

1. **Clona el repositorio:**

   ```bash
   git clone https://github.com/luydevops/TestSmartTechnology.git
   cd testSmartTechnology/deploy
   ```

2. **Backend (FastAPI y PostgreSQL):**

   Navega a la carpeta del backend y construye los contenedores Docker:

   ```bash
   cd backend
   docker-compose up --build
   ```

   Esto levantará el servidor de FastAPI y la base de datos PostgreSQL en los puertos configurados.

   **Configuración de CORS**: En el archivo `src/main.py`, se configuran los dominios permitidos para las solicitudes CORS (Cross-Origin Resource Sharing). Si necesitas permitir solicitudes desde diferentes dominios, puedes agregar o modificar los dominios dentro de esta configuración en la línea correspondiente:

   ```python
   from fastapi.middleware.cors import CORSMiddleware

   app.add_middleware(
       CORSMiddleware,
       allow_origins=["*"],  # Aquí puedes agregar los dominios que deseas permitir.
       allow_credentials=True,
       allow_methods=["*"],
       allow_headers=["*"],
   )
   ```

   El frontend estará accesible en `http://localhost:3010/`.

3. **Frontend (Next.js):**

   Navega a la carpeta del frontend y corre el proyecto:

   ```bash
   cd frontend
   docker-compose up --build
   ```

   El frontend estará accesible en `http://localhost:3010/`.

## Rutas

### Backend

- **POST /gateway/login/**: Endpoint para login y obtener un token JWT.
- **GET /gateway/usuarios/**: Obtener lista de usuarios.
- **POST /gateway/usuarios/**: Crear un nuevo usuario.

### Frontend

- **/**: Página principal .
- **/login**: Página principal delogin.
- **/dashboard/logou**: Página principal de logout.
- **/dashboard/usuarios**: Ver lista de usuarios.
- **/dashboard/crear-usuario**: Formulario para crear un usuario.

## Autenticación

Las rutas del backend requieren autenticación mediante un **JWT**. Para acceder a las rutas protegidas, primero debes obtener el token realizando una solicitud POST a `/gateway/login/` con las credenciales adecuadas.

## Contribución

1. Haz un fork del repositorio.
2. Crea tu rama (`git checkout -b feature/nueva-caracteristica`).
3. Haz tus cambios y confirma (`git commit -am 'Añadir nueva característica'`).
4. Empuja a la rama (`git push origin feature/nueva-caracteristica`).
5. Crea un pull request.

## Licencia

Este proyecto está bajo la **Licencia MIT** - consulta el archivo [LICENSE](LICENSE) para más detalles.

```

### Explicación:

- **Descripción**: Resume qué hace el proyecto y sus principales características.
- **Tecnologías**: Enumera las tecnologías principales usadas en el backend y frontend.
- **Estructura del Proyecto**: Muestra la estructura de carpetas.
- **Instalación**: Instrucciones sobre cómo clonar e instalar el proyecto.
- **Rutas**: Define las rutas del backend y frontend.
- **Autenticación**: Explica cómo funciona la autenticación JWT.
- **Contribución**: Explica cómo contribuir al proyecto.
- **Licencia**: Especifica la licencia, en este caso **MIT**.

Puedes ajustarlo según lo necesites. ¡Avísame si quieres agregar algo más!