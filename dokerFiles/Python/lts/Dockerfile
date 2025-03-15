# Usa una imagen base de Ubuntu 22.04 LTS
FROM ubuntu:22.04

# Establece el directorio de trabajo
#WORKDIR /app

# Actualiza los repositorios e instala las dependencias básicas
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    libpq-dev \
    curl \
    git \
    unzip \
    nano \
    && rm -rf /var/lib/apt/lists/*


# Instala herramientas adicionales
RUN apt-get update && apt-get install -y \
    tree \
    wget \
    psmisc \
    cron \
    supervisor
	
RUN pip install fastapi uvicorn SQLAlchemy psycopg2-binary pydantic python-dotenv httpx passlib[bcrypt] pydantic-settings pydantic[email]

RUN pip install "python-jose[cryptography]"


# Comando por defecto para ejecutar la app Python (ajústalo a tu app)
CMD ["tail", "-f", "/dev/null"]

