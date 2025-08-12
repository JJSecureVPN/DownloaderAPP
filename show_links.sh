#!/bin/bash

# APK Store - Mostrar Enlaces
# Script para mostrar los enlaces de acceso después de la instalación

# Obtener puerto del proceso en ejecución
port=$(ps aux | grep "python3 main.py" | grep -v grep | awk '{print $NF}' | head -1)

if [ -z "$port" ]; then
    echo "❌ APK Store no está en ejecución"
    echo "💡 Para iniciarlo: cd DownloaderAPP && screen -dmS downloader python3 main.py 5001"
    exit 1
fi

# Obtener IP pública
echo "🌍 Obteniendo IP pública..."
public_ip=$(curl -4s --max-time 10 https://api.ipify.org 2>/dev/null || echo "IP_NO_DISPONIBLE")

echo ""
echo "📱 APK STORE - ENLACES DE ACCESO"
echo "=================================="
echo ""
echo "🏪 TIENDA PÚBLICA (Para usuarios finales):"
echo "   🏠 Local:    http://localhost:$port"
if [ "$public_ip" != "IP_NO_DISPONIBLE" ]; then
    echo "   🌐 Público:  http://$public_ip:$port"
fi
echo "   🔗 Dominio:  http://vps.jhservices.com.ar:$port"
echo ""
echo "💻 PORTAL DESARROLLADORES (Para subir apps):"
echo "   🏠 Local:    http://localhost:$port/upload"
if [ "$public_ip" != "IP_NO_DISPONIBLE" ]; then
    echo "   🌐 Público:  http://$public_ip:$port/upload"
fi
echo "   🔗 Dominio:  http://vps.jhservices.com.ar:$port/upload"
echo ""
echo "📋 INFORMACIÓN:"
echo "   • La TIENDA es pública - compártela con usuarios"
echo "   • El PORTAL es privado - solo para desarrolladores"
echo "   • Puerto en uso: $port"
echo "   • Estado: ✅ Activo"
echo ""
echo "🛠️  COMANDOS ÚTILES:"
echo "   Ver logs:     screen -r downloader"
echo "   Detener:      screen -S downloader -X quit"
echo "   Reiniciar:    cd DownloaderAPP && screen -dmS downloader python3 main.py $port"
echo "   Mostrar info: bash show_links.sh"
echo ""
