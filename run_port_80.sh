#!/bin/bash

echo "🔧 Configurando aplicación para ejecutarse en puerto 80..."

# Verificar permisos de root para puerto 80
if [ "$EUID" -ne 0 ]; then
    echo "⚠️  Para usar puerto 80, necesitas ejecutar como root:"
    echo "   sudo $0"
    exit 1
fi

# Parar cualquier servicio en puerto 80
echo "🛑 Deteniendo servicios en puerto 80..."
sudo systemctl stop nginx 2>/dev/null || true
sudo systemctl stop apache2 2>/dev/null || true

# Verificar que el puerto esté libre
if lsof -Pi :80 -sTCP:LISTEN -t >/dev/null ; then
    echo "❌ El puerto 80 está ocupado. Lista de procesos:"
    sudo lsof -Pi :80 -sTCP:LISTEN
    exit 1
fi

# Ejecutar aplicación en puerto 80
echo "🚀 Iniciando aplicación en puerto 80..."
cd "$(dirname "$0")"
python3 main.py 80 0.0.0.0

echo "🌐 Aplicación disponible en: http://vps.jhservices.com.ar"
