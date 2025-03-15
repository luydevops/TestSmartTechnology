# Usa una imagen base de Ubuntu 22.04 LTS
FROM ubuntu:22.04

# Establece el directorio de trabajo
#WORKDIR /app

# Actualiza los repositorios e instala dependencias básicas
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Instala Node.js (última versión LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs
	
#RUN apt-get update && apt-get install -y npm


# Instala herramientas adicionales
RUN apt-get update && apt-get install -y \
    unzip \
    nano \
    tree \
    wget \
    psmisc \
    cron \
    supervisor

# Comando por defecto para iniciar el servidor de desarrollo de React
CMD ["tail", "-f", "/dev/null"]
