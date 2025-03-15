#!/bin/bash

# Directorio base
BASE_DIR="testSmartTechnology/"

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