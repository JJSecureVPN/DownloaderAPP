#!/bin/bash

# Script de instalación público para DownloaderAPP
# Este script puede estar en un repositorio público separado

echo "🚀 Instalando DownloaderAPP..."

# Verificar dependencias
dependencies=(git python3 pip3)
for dep in "${dependencies[@]}"; do
    if ! command -v $dep >/dev/null 2>&1; then
        echo "📦 Instalando $dep..."
        sudo apt update && sudo apt install $dep -y
    fi
done

# Crear directorio temporal
TEMP_DIR=$(mktemp -d)
cd $TEMP_DIR

# Descargar archivos necesarios (desde repositorio privado con token si es necesario)
echo "📥 Descargando archivos..."

# Aquí puedes usar un token personal o descargar un ZIP público
# Por ejemplo, usando GitHub CLI o wget con autenticación

# Crear estructura básica
mkdir -p DownloaderAPP/{app/{routes,static/css,templates},uploads}

# Crear archivos necesarios inline (código embebido en el script)
cat > DownloaderAPP/main.py << 'EOF'
import sys
from gevent.pywsgi import WSGIServer
from app import create_app

try:
    port = int(sys.argv[1] if len(sys.argv) > 1 else 5001)
    host = sys.argv[2] if len(sys.argv) > 2 else '0.0.0.0'
    print('[*] Iniciando servidor en {}:{}'.format(host, port))
    
    http_server = WSGIServer((host, port), create_app())
    http_server.serve_forever()
except KeyboardInterrupt:
    print('[+] Servidor cerrado')
EOF

# Aquí puedes embeber todos los archivos necesarios...
# (El código completo de la aplicación)

echo "⚙️ Configurando aplicación..."
cd DownloaderAPP

# Instalar dependencias
pip3 install flask gevent

# Configurar permisos
chmod +x main.py

# Preguntar puerto
read -p 'Puerto (5001): ' -e -i 5001 port

# Iniciar aplicación
echo "🎉 ¡Instalación completada!"
echo "🌐 Iniciando servidor en puerto $port..."

# Opción 1: Ejecutar directamente
python3 main.py $port &

# Opción 2: Con screen/tmux si está disponible
# screen -dmS downloader python3 main.py $port

echo "✅ Servidor ejecutándose en: http://$(curl -4s https://api.ipify.org 2>/dev/null || echo 'localhost'):$port"
