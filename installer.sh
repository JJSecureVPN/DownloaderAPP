#!/bin/bash

# APK Store - Instalador Automático
# Versión: 3.0
# Repositorio: https://github.com/JJSecureVPN/DownloaderAPP

set -e

echo "🚀 Iniciando instalación de APK Store..."

# Configuración
url='https://github.com/JJSecureVPN/DownloaderAPP.git'
dependencies=(git python3 python3-pip screen curl)

# Función para mostrar errores
error_exit() {
    echo "❌ Error: $1" >&2
    exit 1
}

# Verificar si se ejecuta como root
if [[ $EUID -ne 0 ]]; then
   error_exit "Este script debe ejecutarse como root. Usa: sudo $0"
fi

# Actualizar paquetes
echo "📦 Actualizando lista de paquetes..."
apt update &>/dev/null || error_exit "No se pudo actualizar la lista de paquetes"

# Instalar dependencias
echo "🔧 Verificando e instalando dependencias..."
for dependence in "${dependencies[@]}"; do
    if ! command -v $dependence >/dev/null 2>&1; then
        echo "   → Instalando $dependence..."
        apt install $dependence -y &>/dev/null || error_exit "No se pudo instalar $dependence"
    else
        echo "   ✅ $dependence ya está instalado"
    fi
done

# Limpiar instalación anterior si existe
if [ -d "DownloaderAPP" ]; then
    echo "🧹 Eliminando instalación anterior..."
    screen -S downloader -X quit &>/dev/null || true
    rm -rf DownloaderAPP
fi

# Clonar repositorio
echo "📥 Descargando APK Store..."
git clone $url &>/dev/null || error_exit "No se pudo clonar el repositorio"

# Configurar proyecto
cd DownloaderAPP || error_exit "No se pudo acceder al directorio DownloaderAPP"

# Crear directorio de uploads si no existe
mkdir -p uploads

# Instalar dependencias de Python
echo "🐍 Instalando dependencias de Python..."
pip3 install -r requirements.txt &>/dev/null || error_exit "No se pudieron instalar las dependencias de Python"

# Solicitar puerto
echo ""
read -p "🌐 Puerto para el servidor (por defecto 5001): " -e -i 5001 port

# Validar puerto
if ! [[ "$port" =~ ^[0-9]+$ ]] || [ "$port" -lt 1024 ] || [ "$port" -gt 65535 ]; then
    echo "⚠️  Puerto inválido, usando 5001 por defecto"
    port=5001
fi

# Verificar si el puerto está en uso
if netstat -tuln | grep -q ":$port "; then
    echo "⚠️  El puerto $port está en uso. Intentando detener procesos..."
    fuser -k $port/tcp &>/dev/null || true
    sleep 2
fi

# Iniciar servidor
echo "🚀 Iniciando servidor en puerto $port..."
screen -dmS downloader python3 main.py $port || error_exit "No se pudo iniciar el servidor"

# Esperar a que el servidor inicie
sleep 3

# Verificar que el servidor esté corriendo
if ! screen -list | grep -q "downloader"; then
    error_exit "El servidor no se inició correctamente"
fi

# Obtener IP pública
echo "🌍 Obteniendo IP pública..."
public_ip=$(curl -4s --max-time 10 https://api.ipify.org 2>/dev/null || echo "IP_NO_DISPONIBLE")

echo ""
echo "✅ ¡APK Store instalado exitosamente!"
echo ""
echo "🎯 ENLACES DE ACCESO:"
echo ""
echo "🏪 TIENDA PÚBLICA (Para usuarios finales):"
echo "   🏠 Local:    http://localhost:$port/store"
if [ "$public_ip" != "IP_NO_DISPONIBLE" ]; then
    echo "   🌐 Público:  http://$public_ip:$port/store"
fi
echo "   🔗 Dominio:  http://vps.jhservices.com.ar:$port/store"
echo ""
echo "💻 PORTAL DESARROLLADORES (Para subir apps):"
echo "   🏠 Local:    http://localhost:$port/"
if [ "$public_ip" != "IP_NO_DISPONIBLE" ]; then
    echo "   🌐 Público:  http://$public_ip:$port/"
fi
echo "   🔗 Dominio:  http://vps.jhservices.com.ar:$port/"
echo ""
echo "ℹ️  INFORMACIÓN IMPORTANTE:"
echo "   • La TIENDA (/store) es pública - cualquiera puede ver y descargar apps"
echo "   • El PORTAL (/) es privado - solo comparte el enlace con desarrolladores"
echo "   • Las apps subidas aparecen automáticamente en la tienda"
echo ""
echo "🛠️  COMANDOS ÚTILES:"
echo "   Ver logs:    screen -r downloader"
echo "   Detener:     screen -S downloader -X quit"
echo "   Reiniciar:   cd DownloaderAPP && screen -dmS downloader python3 main.py $port"
echo ""
echo "📁 Archivos subidos se guardarán en: $(pwd)/uploads/"
