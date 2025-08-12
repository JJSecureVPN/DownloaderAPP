#!/bin/bash

# =============================================================================
# 🚀 DownloaderAPP - Instalador Universal de Scripts de Actualización
# =============================================================================
# Este script configura todos los scripts de actualización necesarios
# =============================================================================

echo "🚀 Configurando Scripts de Actualización de DownloaderAPP"
echo "========================================================="

# Detectar sistema operativo
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]]; then
        echo "windows"
    else
        echo "unknown"
    fi
}

OS=$(detect_os)
echo "🖥️ Sistema detectado: $OS"

# Dar permisos de ejecución a scripts
echo "🔧 Configurando permisos..."
chmod +x update_vps.sh 2>/dev/null
chmod +x quick_update.sh 2>/dev/null

echo "✅ Scripts configurados:"
echo ""

case $OS in
    "linux"|"macos")
        echo "🐧 Para Linux/macOS:"
        echo "   • Actualización completa: ./update_vps.sh"
        echo "   • Actualización rápida:   ./quick_update.sh"
        echo ""
        echo "💡 Uso recomendado:"
        echo "   cd /ruta/a/DownloaderAPP"
        echo "   ./update_vps.sh"
        echo ""
        ;;
    "windows")
        echo "🪟 Para Windows:"
        echo "   • PowerShell: ./update_windows.ps1"
        echo "   • Git Bash:   ./update_vps.sh"
        echo ""
        echo "💡 Uso en PowerShell:"
        echo "   cd C:\\ruta\\a\\DownloaderAPP"
        echo "   .\\update_windows.ps1"
        echo ""
        ;;
    *)
        echo "❓ Sistema no reconocido - usa scripts manualmente"
        ;;
esac

echo "📚 Opciones disponibles:"
echo "   --help     Mostrar ayuda detallada"
echo "   --force    Actualizar sin confirmación"
echo "   --no-backup  No crear backup (no recomendado)"
echo ""

echo "🛡️ Garantías de seguridad:"
echo "   ✅ Los datos de usuarios NUNCA se pierden"
echo "   ✅ Backup automático antes de actualizar"
echo "   ✅ Verificación de integridad post-actualización"
echo "   ✅ Rollback automático si hay errores críticos"
echo ""

echo "✅ Configuración completada. ¡Ya puedes actualizar sin riesgo!"
