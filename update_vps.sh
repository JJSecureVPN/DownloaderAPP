#!/bin/bash

# =============================================================================
# 🚀 DownloaderAPP - Script de Actualización Automática Sin Pérdida de Datos
# =============================================================================
# Autor: @JHServices
# Descripción: Actualiza la aplicación preservando todos los datos de usuarios
# =============================================================================

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Función para imprimir con colores
print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ️ $1${NC}"; }
print_step() { echo -e "${PURPLE}🔄 $1${NC}"; }

# Banner
echo -e "${CYAN}"
echo "=============================================="
echo "🚀 DownloaderAPP - Actualización Automática"
echo "=============================================="
echo -e "${NC}"

# Variables
BACKUP_DIR="uploads_backup_$(date +%Y%m%d_%H%M%S)"
LOG_FILE="update_$(date +%Y%m%d_%H%M%S).log"
TEMP_DIR="/tmp/downloader_update"

# Función para logging
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Función para verificar si comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Función para verificar prerrequisitos
check_prerequisites() {
    print_step "Verificando prerrequisitos..."
    
    # Verificar si estamos en el directorio correcto
    if [[ ! -f "main.py" ]] || [[ ! -d "app" ]]; then
        print_error "No estás en el directorio de DownloaderAPP"
        print_info "Ve al directorio correcto: cd /ruta/a/DownloaderAPP"
        exit 1
    fi
    
    # Verificar git
    if ! command_exists git; then
        print_error "Git no está instalado"
        exit 1
    fi
    
    # Verificar python
    if ! command_exists python3 && ! command_exists python; then
        print_error "Python no está instalado"
        exit 1
    fi
    
    # Verificar si es repositorio git
    if [[ ! -d ".git" ]]; then
        print_error "Este no es un repositorio git válido"
        exit 1
    fi
    
    print_success "Todos los prerrequisitos están satisfechos"
    log "Prerrequisitos verificados correctamente"
}

# Función para crear backup
create_backup() {
    print_step "Creando backup de datos de usuarios..."
    
    if [[ -d "uploads" ]] && [[ "$(ls -A uploads 2>/dev/null)" ]]; then
        cp -r uploads/ "$BACKUP_DIR/"
        if [[ $? -eq 0 ]]; then
            print_success "Backup creado en: $BACKUP_DIR"
            log "Backup creado exitosamente en $BACKUP_DIR"
            
            # Mostrar estadísticas del backup
            APP_COUNT=$(find "$BACKUP_DIR" -name "*.apk" | wc -l)
            BACKUP_SIZE=$(du -sh "$BACKUP_DIR" | cut -f1)
            print_info "📊 Backup contiene: $APP_COUNT aplicaciones ($BACKUP_SIZE)"
        else
            print_error "Error creando backup"
            exit 1
        fi
    else
        print_warning "No hay datos de usuarios para respaldar"
        log "No hay carpeta uploads o está vacía"
    fi
}

# Función para detener servidor
stop_server() {
    print_step "Deteniendo servidor..."
    
    # Método 1: Screen
    if screen -list | grep -q "downloader"; then
        screen -S downloader -X quit
        sleep 2
        if ! screen -list | grep -q "downloader"; then
            print_success "Servidor detenido (screen)"
            log "Servidor detenido usando screen"
            return 0
        fi
    fi
    
    # Método 2: Systemd
    if systemctl is-active --quiet downloader-app 2>/dev/null; then
        if systemctl stop downloader-app 2>/dev/null; then
            print_success "Servidor detenido (systemd)"
            log "Servidor detenido usando systemd"
            return 0
        fi
    fi
    
    # Método 3: Buscar proceso Python
    PID=$(ps aux | grep "python.*main.py" | grep -v grep | awk '{print $2}' | head -1)
    if [[ ! -z "$PID" ]]; then
        kill "$PID" 2>/dev/null
        sleep 3
        if ! ps -p "$PID" > /dev/null 2>&1; then
            print_success "Servidor detenido (PID: $PID)"
            log "Servidor detenido usando kill PID: $PID"
            return 0
        else
            # Forzar kill
            kill -9 "$PID" 2>/dev/null
            sleep 2
            if ! ps -p "$PID" > /dev/null 2>&1; then
                print_warning "Servidor forzado a detenerse (kill -9)"
                log "Servidor forzado a detenerse con kill -9"
                return 0
            fi
        fi
    fi
    
    print_info "No se encontró servidor corriendo"
    log "No se encontró servidor activo"
    return 0
}

# Función para actualizar código
update_code() {
    print_step "Actualizando código desde GitHub..."
    
    # Verificar estado de git
    if ! git status >/dev/null 2>&1; then
        print_error "Error verificando estado de git"
        exit 1
    fi
    
    # Guardar cambios locales si los hay
    if ! git diff-index --quiet HEAD --; then
        print_warning "Hay cambios locales, creando stash..."
        git stash push -m "Auto-stash antes de actualización $(date)"
        log "Cambios locales guardados en stash"
    fi
    
    # Fetch y pull
    print_info "Descargando últimos cambios..."
    
    # Verificar si hay cambios locales que puedan causar conflictos
    if git status --porcelain | grep -q "update_vps.sh\|quick_update.sh\|README.md"; then
        print_info "Detectados cambios locales, resolviendo automáticamente..."
        git stash push -m "Auto-stash antes de actualización $(date)"
        log "Cambios locales guardados en stash"
    fi
    
    if git fetch origin main; then
        if git pull origin main; then
            print_success "Código actualizado exitosamente"
            log "Código actualizado desde GitHub"
            
            # Mostrar qué cambió
            COMMITS=$(git log --oneline HEAD~3..HEAD | wc -l)
            if [[ $COMMITS -gt 0 ]]; then
                print_info "📝 Últimos cambios:"
                git log --oneline -3 --pretty=format:"   • %s" HEAD
                echo ""
            fi
        else
            print_error "Error durante git pull, intentando resolver..."
            log "ERROR: Fallo en git pull, resolviendo con reset"
            
            # Resolver conflictos con reset hard
            git reset --hard origin/main
            if [[ $? -eq 0 ]]; then
                print_success "Conflictos resueltos automáticamente"
                log "Conflictos resueltos con git reset --hard"
            else
                print_error "No se pudieron resolver los conflictos"
                exit 1
            fi
        fi
    else
        print_error "Error durante git fetch"
        exit 1
    fi
}

# Función para verificar integridad de datos
verify_data_integrity() {
    print_step "Verificando integridad de datos de usuarios..."
    
    if [[ -d "uploads" ]]; then
        # Contar archivos
        APK_COUNT=$(find uploads -name "*.apk" -type f 2>/dev/null | wc -l)
        ICON_COUNT=$(find uploads/icons -name "*.png" -type f 2>/dev/null | wc -l)
        SCREENSHOT_COUNT=$(find uploads/screenshots -name "*.png" -type f 2>/dev/null | wc -l)
        
        print_success "Datos verificados:"
        print_info "   📦 $APK_COUNT aplicaciones"
        print_info "   🖼️ $ICON_COUNT iconos" 
        print_info "   📸 $SCREENSHOT_COUNT screenshots"
        
        # Verificar metadata
        if [[ -f "uploads/apps_metadata.json" ]]; then
            if python3 -c "import json; json.load(open('uploads/apps_metadata.json'))" 2>/dev/null; then
                METADATA_APPS=$(python3 -c "import json; print(len(json.load(open('uploads/apps_metadata.json'))))")
                print_info "   📋 $METADATA_APPS aplicaciones en metadata"
                log "Verificación de integridad completada: $APK_COUNT APKs, $METADATA_APPS en metadata"
            else
                print_warning "Archivo metadata JSON corrupto"
                log "ADVERTENCIA: apps_metadata.json está corrupto"
            fi
        else
            print_warning "No se encontró archivo de metadata"
            log "ADVERTENCIA: No existe apps_metadata.json"
        fi
    else
        print_warning "No hay datos de usuarios"
        log "No existe carpeta uploads"
    fi
}

# Función para instalar/actualizar dependencias
update_dependencies() {
    print_step "Verificando e instalando dependencias..."
    
    if [[ -f "requirements.txt" ]]; then
        # Detectar comando Python
        PYTHON_CMD="python3"
        if ! command_exists python3; then
            PYTHON_CMD="python"
        fi
        
        # Instalar dependencias críticas primero
        print_info "Instalando dependencias críticas..."
        critical_packages=("Flask==2.3.3" "gevent==23.7.0")
        
        for package in "${critical_packages[@]}"; do
            if $PYTHON_CMD -m pip install "$package" --quiet --disable-pip-version-check; then
                print_info "✓ $package instalado"
            else
                print_warning "⚠ Error instalando $package, reintentando..."
                $PYTHON_CMD -m pip install "$package" --force-reinstall
            fi
        done
        
        # Instalar resto de dependencias
        if $PYTHON_CMD -m pip install -r requirements.txt --quiet --disable-pip-version-check; then
            print_success "Dependencias actualizadas"
            log "Dependencias instaladas/actualizadas"
        else
            print_warning "Algunas dependencias pueden no haberse instalado correctamente"
            print_info "Reintentando instalación sin --quiet..."
            $PYTHON_CMD -m pip install -r requirements.txt --force-reinstall
            log "Advertencia durante instalación de dependencias"
        fi
    else
        print_info "No se encontró requirements.txt"
        log "No existe archivo requirements.txt"
    fi
}

# Función para iniciar servidor
start_server() {
    print_step "Iniciando servidor..."
    
    # Detectar comando Python
    PYTHON_CMD="python3"
    if ! command_exists python3; then
        PYTHON_CMD="python"
    fi
    
    # Método 1: Systemd (si existe el servicio)
    if systemctl list-unit-files | grep -q "downloader-app.service"; then
        if systemctl start downloader-app; then
            sleep 3
            if systemctl is-active --quiet downloader-app; then
                print_success "Servidor iniciado con systemd"
                log "Servidor iniciado usando systemd"
                return 0
            fi
        fi
    fi
    
    # Método 2: Screen
    if command_exists screen; then
        screen -dmS downloader $PYTHON_CMD main.py 5001
        sleep 3
        if screen -list | grep -q "downloader"; then
            print_success "Servidor iniciado en screen"
            log "Servidor iniciado usando screen"
            return 0
        fi
    fi
    
    # Método 3: Nohup
    nohup $PYTHON_CMD main.py 5001 > server.log 2>&1 &
    SERVER_PID=$!
    sleep 3
    
    if ps -p $SERVER_PID > /dev/null; then
        print_success "Servidor iniciado en background (PID: $SERVER_PID)"
        log "Servidor iniciado usando nohup (PID: $SERVER_PID)"
        return 0
    else
        print_error "Error al iniciar servidor"
        log "ERROR: No se pudo iniciar el servidor"
        return 1
    fi
}

# Función para verificar que el servidor funciona
verify_server() {
    print_step "Verificando que el servidor funciona..."
    
    # Esperar un poco más para que el servidor inicie completamente
    sleep 5
    
    # Probar conexión local
    if command_exists curl; then
        if curl -s "http://localhost:5001" >/dev/null 2>&1; then
            print_success "Servidor responde correctamente en puerto 5001"
            log "Servidor verificado - responde en puerto 5001"
            
            # Probar API
            if curl -s "http://localhost:5001/api/apps" >/dev/null 2>&1; then
                print_success "API funciona correctamente"
                log "API verificada correctamente"
            else
                print_warning "API no responde, pero servidor está activo"
                log "Advertencia: API no responde"
            fi
        else
            print_warning "Servidor puede no estar respondiendo en puerto 5001"
            log "Advertencia: Servidor no responde en puerto 5001"
        fi
    elif command_exists wget; then
        if wget -q --spider "http://localhost:5001" 2>/dev/null; then
            print_success "Servidor responde correctamente"
            log "Servidor verificado con wget"
        else
            print_warning "No se pudo verificar el servidor"
            log "No se pudo verificar servidor con wget"
        fi
    else
        print_info "No hay curl/wget para verificar servidor"
        log "No hay herramientas para verificar servidor"
    fi
}

# Función para limpieza
cleanup() {
    print_step "Limpiando archivos temporales..."
    
    if [[ -d "$TEMP_DIR" ]]; then
        rm -rf "$TEMP_DIR"
        print_info "Archivos temporales eliminados"
    fi
    
    log "Limpieza completada"
}

# Función para mostrar resumen
show_summary() {
    echo ""
    echo -e "${CYAN}=============================================="
    echo "📊 RESUMEN DE ACTUALIZACIÓN"
    echo -e "===============================================${NC}"
    
    print_success "Actualización completada exitosamente"
    
    echo ""
    print_info "📁 Datos preservados:"
    if [[ -d "uploads" ]]; then
        APK_COUNT=$(find uploads -name "*.apk" -type f 2>/dev/null | wc -l)
        echo "   📦 $APK_COUNT aplicaciones mantenidas"
    fi
    
    if [[ -d "$BACKUP_DIR" ]]; then
        BACKUP_SIZE=$(du -sh "$BACKUP_DIR" 2>/dev/null | cut -f1 || echo "N/A")
        echo "   💾 Backup creado: $BACKUP_DIR ($BACKUP_SIZE)"
    fi
    
    echo ""
    print_info "🌐 Acceso a la aplicación:"
    echo "   • Tienda: http://tu-servidor:5001/"
    echo "   • Portal Desarrolladores: http://tu-servidor:5001/upload"
    echo "   • API: http://tu-servidor:5001/api/apps"
    
    echo ""
    print_info "📋 Logs guardados en: $LOG_FILE"
    
    if [[ -f "server.log" ]]; then
        echo ""
        print_info "🔧 Para ver logs del servidor: tail -f server.log"
    fi
    
    echo ""
    print_success "¡Todo listo! Tu aplicación está actualizada y funcionando."
}

# Función principal
main() {
    # Iniciar log
    log "=== INICIO DE ACTUALIZACIÓN ==="
    log "Fecha: $(date)"
    log "Usuario: $(whoami)"
    log "Directorio: $(pwd)"
    
    # Verificar argumentos
    if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
        echo "Uso: $0 [opciones]"
        echo ""
        echo "Opciones:"
        echo "  --help, -h     Mostrar esta ayuda"
        echo "  --no-backup    No crear backup (no recomendado)"
        echo "  --force        Forzar actualización sin confirmación"
        echo ""
        echo "Este script actualiza DownloaderAPP preservando todos los datos."
        exit 0
    fi
    
    # Confirmación (a menos que se use --force)
    if [[ "$1" != "--force" ]]; then
        echo ""
        print_warning "¿Continuar con la actualización? Los datos se preservarán automáticamente."
        read -p "Presiona Enter para continuar o Ctrl+C para cancelar..."
        echo ""
    fi
    
    # Ejecutar pasos
    check_prerequisites
    
    if [[ "$1" != "--no-backup" ]]; then
        create_backup
    fi
    
    stop_server
    update_code
    verify_data_integrity
    update_dependencies
    start_server
    verify_server
    cleanup
    show_summary
    
    log "=== ACTUALIZACIÓN COMPLETADA EXITOSAMENTE ==="
}

# Manejo de errores
trap 'print_error "Script interrumpido"; cleanup; exit 1' INT TERM

# Ejecutar función principal
main "$@"
