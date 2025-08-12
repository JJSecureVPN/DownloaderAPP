#!/bin/bash

echo "🚀 Iniciando APK Store en puerto 8080..."

# Verificar que el puerto esté libre
if lsof -Pi :8080 -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "⚠️  El puerto 8080 está en uso. Intentando liberar..."
    
    # Intentar parar el proceso que use el puerto
    PID=$(lsof -Pi :8080 -sTCP:LISTEN -t)
    if [ ! -z "$PID" ]; then
        echo "🛑 Deteniendo proceso $PID en puerto 8080..."
        kill -15 $PID 2>/dev/null || kill -9 $PID 2>/dev/null
        sleep 2
    fi
fi

# Verificar nuevamente
if lsof -Pi :8080 -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "❌ No se pudo liberar el puerto 8080"
    echo "📋 Procesos actuales en el puerto:"
    lsof -Pi :8080 -sTCP:LISTEN
    exit 1
fi

# Ir al directorio de la aplicación
cd "$(dirname "$0")"

echo "📁 Directorio actual: $(pwd)"
echo "🌐 Iniciando servidor en puerto 8080..."

# Ejecutar aplicación
python3 main.py 8080 0.0.0.0

echo "✅ Aplicación disponible en:"
echo "   🔗 http://vps.jhservices.com.ar:8080"
echo "   🔗 http://$(hostname -I | awk '{print $1}'):8080"
