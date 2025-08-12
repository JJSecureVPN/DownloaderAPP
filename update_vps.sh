#!/bin/bash

echo "🔄 Iniciando actualización del DownloaderAPP..."

# 1. Crear backup de uploads
echo "📁 Creando backup de uploads..."
cp -r uploads/ uploads_backup_$(date +%Y%m%d_%H%M%S)/

# 2. Buscar y detener proceso de Python
echo "⏹️ Deteniendo servidor..."
PID=$(ps aux | grep "python.*main.py" | grep -v grep | awk '{print $2}')
if [ ! -z "$PID" ]; then
    kill $PID
    echo "✅ Servidor detenido (PID: $PID)"
    sleep 3
else
    echo "ℹ️ No se encontró servidor corriendo"
fi

# 3. Actualizar código
echo "⬇️ Actualizando código desde GitHub..."
git pull origin main

# 4. Verificar que uploads sigue ahí
echo "🔍 Verificando datos de usuarios..."
if [ -d "uploads" ] && [ "$(ls -A uploads)" ]; then
    echo "✅ Datos de usuarios preservados"
    ls -la uploads/
else
    echo "⚠️ ¡ADVERTENCIA! Carpeta uploads vacía o inexistente"
fi

# 5. Instalar dependencias si es necesario
echo "📦 Verificando dependencias..."
pip install -r requirements.txt --quiet

# 6. Reiniciar servidor
echo "🚀 Reiniciando servidor..."
nohup python main.py > server.log 2>&1 &
sleep 2

# 7. Verificar que está corriendo
NEW_PID=$(ps aux | grep "python.*main.py" | grep -v grep | awk '{print $2}')
if [ ! -z "$NEW_PID" ]; then
    echo "✅ Servidor reiniciado exitosamente (PID: $NEW_PID)"
    echo "🌐 Aplicación disponible en: http://tu-vps-ip:5001"
else
    echo "❌ Error al reiniciar servidor"
    echo "📋 Ver logs: tail -f server.log"
fi

echo "🎉 Actualización completada"
