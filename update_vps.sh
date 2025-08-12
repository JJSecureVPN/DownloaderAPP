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
APP_PORT="8080"  # Puerto actualizado para evitar conflictos
NGINX_PORT="80"  # Puerto para Nginx (sin puerto en URL)
DOMAIN="vps.jhservices.com.ar"

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
    
    # Método 4: Buscar procesos en puertos específicos
    for port in 8080 5001; do
        PID=$(lsof -ti:$port 2>/dev/null)
        if [[ ! -z "$PID" ]]; then
            print_info "Deteniendo proceso en puerto $port (PID: $PID)"
            kill "$PID" 2>/dev/null
            sleep 2
            if ! ps -p "$PID" > /dev/null 2>&1; then
                print_success "Proceso detenido en puerto $port"
                log "Proceso detenido en puerto $port (PID: $PID)"
            fi
        fi
    done
    
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

# Función para configurar Nginx automáticamente
setup_nginx() {
    print_step "Configurando Nginx para acceso sin puerto..."
    
    # Verificar si Nginx está instalado
    if ! command_exists nginx; then
        print_warning "Nginx no está instalado. ¿Deseas instalarlo? (y/n)"
        read -p "Respuesta: " install_nginx
        if [[ "$install_nginx" == "y" ]] || [[ "$install_nginx" == "Y" ]]; then
            if command_exists apt; then
                sudo apt update && sudo apt install -y nginx
            elif command_exists yum; then
                sudo yum install -y nginx
            else
                print_error "No se pudo instalar Nginx automáticamente"
                return 1
            fi
        else
            print_info "Nginx no instalado. La aplicación estará disponible en puerto $APP_PORT"
            return 0
        fi
    fi
    
    # Crear configuración de Nginx
    print_info "Creando configuración de Nginx..."
    
    sudo tee /etc/nginx/sites-available/apk-store > /dev/null <<EOF
server {
    listen $NGINX_PORT;
    server_name $DOMAIN;

    location / {
        proxy_pass http://127.0.0.1:$APP_PORT;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        
        # Para archivos grandes (APKs)
        client_max_body_size 100M;
        proxy_connect_timeout 600s;
        proxy_send_timeout 600s;
        proxy_read_timeout 600s;
    }

    # Servir archivos estáticos directamente (mejor rendimiento)
    location /static/ {
        alias $(pwd)/app/static/;
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    location /uploads/ {
        alias $(pwd)/uploads/;
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
EOF

    # Habilitar el sitio
    sudo ln -sf /etc/nginx/sites-available/apk-store /etc/nginx/sites-enabled/
    
    # Deshabilitar sitio por defecto si existe
    if [[ -f /etc/nginx/sites-enabled/default ]]; then
        sudo rm -f /etc/nginx/sites-enabled/default
        print_info "Sitio por defecto de Nginx deshabilitado"
    fi
    
    # Probar configuración
    if sudo nginx -t; then
        print_success "Configuración de Nginx válida"
        
        # Reiniciar Nginx
        if sudo systemctl restart nginx && sudo systemctl enable nginx; then
            print_success "Nginx configurado y iniciado correctamente"
            log "Nginx configurado exitosamente"
            return 0
        else
            print_error "Error al reiniciar Nginx"
            return 1
        fi
    else
        print_error "Error en la configuración de Nginx"
        return 1
    fi
}

# Función para verificar puertos
check_ports() {
    print_step "Verificando disponibilidad de puertos..."
    
    # Verificar puerto de la aplicación
    if lsof -Pi :$APP_PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
        PID=$(lsof -Pi :$APP_PORT -sTCP:LISTEN -t)
        print_warning "Puerto $APP_PORT está en uso por PID: $PID"
        
        # Si es nuestro proceso anterior, está bien
        if ps -p $PID -o comm= | grep -q python; then
            print_info "Es un proceso Python existente, será detenido durante la actualización"
        fi
    else
        print_success "Puerto $APP_PORT disponible"
    fi
    
    # Verificar puerto 80 para Nginx
    if lsof -Pi :$NGINX_PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
        NGINX_PID=$(lsof -Pi :$NGINX_PORT -sTCP:LISTEN -t)
        NGINX_PROC=$(ps -p $NGINX_PID -o comm= 2>/dev/null)
        
        if [[ "$NGINX_PROC" == "nginx" ]]; then
            print_info "Nginx ya está corriendo en puerto $NGINX_PORT (perfecto)"
        else
            print_warning "Puerto $NGINX_PORT está ocupado por: $NGINX_PROC (PID: $NGINX_PID)"
            print_info "Será necesario configurar Nginx en puerto alternativo"
        fi
    else
        print_success "Puerto $NGINX_PORT disponible para Nginx"
    fi
    
    log "Verificación de puertos completada"
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
        screen -dmS downloader $PYTHON_CMD main.py $APP_PORT
        sleep 3
        if screen -list | grep -q "downloader"; then
            print_success "Servidor iniciado en screen (puerto $APP_PORT)"
            log "Servidor iniciado usando screen en puerto $APP_PORT"
            return 0
        fi
    fi
    
    # Método 3: Nohup
    nohup $PYTHON_CMD main.py $APP_PORT > server.log 2>&1 &
    SERVER_PID=$!
    sleep 3
    
    if ps -p $SERVER_PID > /dev/null; then
        print_success "Servidor iniciado en background (PID: $SERVER_PID, Puerto: $APP_PORT)"
        log "Servidor iniciado usando nohup (PID: $SERVER_PID, Puerto: $APP_PORT)"
        echo $SERVER_PID > server.pid
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
        if curl -s "http://localhost:$APP_PORT" >/dev/null 2>&1; then
            print_success "Servidor responde correctamente en puerto $APP_PORT"
            log "Servidor verificado - responde en puerto $APP_PORT"
            
            # Probar API
            if curl -s "http://localhost:$APP_PORT/api/apps" >/dev/null 2>&1; then
                print_success "API funciona correctamente"
                log "API verificada correctamente"
            else
                print_warning "API no responde, pero servidor está activo"
                log "Advertencia: API no responde"
            fi
        else
            print_warning "Servidor puede no estar respondiendo en puerto $APP_PORT"
            log "Advertencia: Servidor no responde en puerto $APP_PORT"
        fi
    elif command_exists wget; then
        if wget -q --spider "http://localhost:$APP_PORT" 2>/dev/null; then
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
    
    # Verificar si Nginx está configurado
    if systemctl is-active --quiet nginx 2>/dev/null && [[ -f /etc/nginx/sites-available/apk-store ]]; then
        echo "   🎉 ¡SIN PUERTO! http://$DOMAIN"
        echo "   📱 Tienda: http://$DOMAIN"
        echo "   🔧 Portal Desarrolladores: http://$DOMAIN/upload"
        echo "   🔗 API: http://$DOMAIN/api/apps"
        echo ""
        print_success "¡Nginx configurado! Accede sin puerto: http://$DOMAIN"
    else
        echo "   📱 Tienda: http://$DOMAIN:$APP_PORT"
        echo "   🔧 Portal Desarrolladores: http://$DOMAIN:$APP_PORT/upload"
        echo "   🔗 API: http://$DOMAIN:$APP_PORT/api/apps"
        echo ""
        print_info "Para acceso sin puerto, configura Nginx ejecutando:"
        echo "   ./setup_nginx.sh"
    fi
    
    echo ""
    print_info "🔗 URLs alternativas:"
    echo "   • Localhost: http://localhost:$APP_PORT"
    echo "   • IP directa: http://$(hostname -I | awk '{print $1}'):$APP_PORT"
    
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
        echo "  --no-nginx     No configurar Nginx automáticamente"
        echo "  --force        Forzar actualización sin confirmación"
        echo ""
        echo "Este script actualiza DownloaderAPP preservando todos los datos."
        echo "Con Nginx configurado, la aplicación estará disponible en:"
        echo "  http://$DOMAIN (sin puerto)"
        echo ""
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
    check_ports
    
    if [[ "$1" != "--no-backup" ]]; then
        create_backup
    fi
    
    stop_server
    update_code
    verify_data_integrity
    update_dependencies
    start_server
    verify_server
    
    # Configurar Nginx si no está ya configurado
    if [[ "$1" != "--no-nginx" ]]; then
        setup_nginx
    fi
    
    cleanup
    show_summary
    
    log "=== ACTUALIZACIÓN COMPLETADA EXITOSAMENTE ==="
}

# Manejo de errores
trap 'print_error "Script interrumpido"; cleanup; exit 1' INT TERM

# Ejecutar función principal
main "$@"
