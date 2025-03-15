#!/bin/bash

# Directorio base (asumiendo que estás en el directorio testSmartTechnology)
BASE_DIR="./"

# URLs de los repositorios
BACKEND_REPO="https://github.com/luydevops/TestSmartTechnology_back.git"
FRONTEND_REPO="https://github.com/luydevops/TestSmartTechnology_front.git"

# Crear directorios backend y frontend
mkdir -p "$BASE_DIR/backend"
mkdir -p "$BASE_DIR/frontend"

# Descargar repositorios
git clone "$BACKEND_REPO" "$BASE_DIR/backend"
git clone "$FRONTEND_REPO" "$BASE_DIR/frontend"

echo "Repositorios descargados con éxito."

# Construir los contenedores
docker compose build

# Verificar si la construcción fue exitosa
if [ $? -eq 0 ]; then
  echo "Construcción de contenedores exitosa."

  # Desplegar los contenedores
  docker compose up -d

  # Verificar si el despliegue fue exitoso
  if [ $? -eq 0 ]; then
    echo "Despliegue de contenedores exitoso."

    # Validar las rutas
    if curl -s --head --fail http://localhost:8010 > /dev/null && curl -s --head --fail http://localhost:3010 > /dev/null; then
      echo "Repositorios descargados y desplegados con éxito."
    else
      echo "Error: Una o ambas rutas no responden."
    fi
  else
    echo "Error: Fallo en el despliegue de contenedores."
  fi
else
  echo "Error: Fallo en la construcción de contenedores."
fi