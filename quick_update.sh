#!/bin/bash

# =============================================================================
# 🚀 DownloaderAPP - Script de Actualización Rápida
# =============================================================================
# Versión simplificada para actualización rápida
# =============================================================================

echo "🚀 DownloaderAPP - Actualización Rápida"
echo "======================================="

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Funciones de output
success() { echo -e "${GREEN}✅ $1${NC}"; }
error() { echo -e "${RED}❌ $1${NC}"; }
warning() { echo -e "${YELLOW}⚠️ $1${NC}"; }

# Verificar que estamos en el directorio correcto
if [[ ! -f "main.py" ]]; then
    error "No estás en el directorio de DownloaderAPP"
    exit 1
fi

# 1. Backup rápido
echo "📁 Creando backup..."
if [[ -d "uploads" ]]; then
    cp -r uploads/ "backup_$(date +%Y%m%d_%H%M%S)/"
    success "Backup creado"
else
    warning "No hay datos para respaldar"
fi

# 2. Detener servidor
echo "⏹️ Deteniendo servidor..."
pkill -f "python.*main.py" 2>/dev/null
screen -S downloader -X quit 2>/dev/null
systemctl stop downloader-app 2>/dev/null
success "Servidor detenido"

# 3. Actualizar
echo "⬇️ Actualizando código..."
git pull origin main
if [[ $? -eq 0 ]]; then
    success "Código actualizado"
else
    error "Error actualizando código"
    exit 1
fi

# 4. Verificar datos
if [[ -d "uploads" ]]; then
    APP_COUNT=$(find uploads -name "*.apk" 2>/dev/null | wc -l)
    success "Datos preservados: $APP_COUNT aplicaciones"
else
    warning "No hay datos de usuarios"
fi

# 5. Instalar dependencias
echo "📦 Instalando dependencias..."
python3 -m pip install -r requirements.txt --quiet 2>/dev/null
success "Dependencias actualizadas"

# 6. Iniciar servidor
echo "🚀 Iniciando servidor..."
nohup python3 main.py 5001 > server.log 2>&1 &
sleep 3

# 7. Verificar
if pgrep -f "python.*main.py" > /dev/null; then
    success "Servidor iniciado correctamente"
    echo "🌐 Aplicación disponible en: http://localhost:5001"
else
    error "Error iniciando servidor. Ver: tail -f server.log"
fi

echo ""
success "🎉 Actualización completada"
