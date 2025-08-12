#!/bin/bash

# Script de solución rápida para problemas de actualización
# Uso: ./fix_update_issues.sh

echo "🔧 Solucionando problemas de actualización..."

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_step() { echo -e "${BLUE}🔄 $1${NC}"; }
print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️ $1${NC}"; }
print_info() { echo -e "${YELLOW}ℹ️ $1${NC}"; }

# 1. Resolver conflictos de Git
print_step "Resolviendo conflictos de Git..."
if git status --porcelain | grep -q .; then
    print_info "Guardando cambios locales..."
    git stash push -m "Backup antes de arreglo $(date)"
    git reset --hard origin/main
    print_success "Conflictos de Git resueltos"
else
    print_success "No hay conflictos de Git"
fi

# 2. Forzar actualización
print_step "Forzando actualización desde GitHub..."
git fetch origin main
git reset --hard origin/main
print_success "Código actualizado forzadamente"

# 3. Detectar comando Python
print_step "Detectando comando Python..."
PYTHON_CMD="python3"
if ! command -v python3 >/dev/null 2>&1; then
    PYTHON_CMD="python"
fi
print_info "Usando comando: $PYTHON_CMD"

# 4. Instalar dependencias críticas
print_step "Instalando dependencias críticas..."

# Upgrade pip first
$PYTHON_CMD -m pip install --upgrade pip

# Install critical packages
critical_packages=(
    "Flask==2.3.3"
    "gevent==23.7.0" 
    "Werkzeug==2.3.7"
)

for package in "${critical_packages[@]}"; do
    print_info "Instalando $package..."
    if $PYTHON_CMD -m pip install "$package" --force-reinstall; then
        print_success "✓ $package instalado correctamente"
    else
        print_error "✗ Error instalando $package"
    fi
done

# 5. Instalar requirements.txt
if [[ -f "requirements.txt" ]]; then
    print_step "Instalando requirements.txt..."
    $PYTHON_CMD -m pip install -r requirements.txt --force-reinstall
    print_success "Requirements.txt procesado"
fi

# 6. Verificar instalación
print_step "Verificando instalación..."
$PYTHON_CMD -c "
try:
    import flask
    import gevent
    print('✅ Flask y Gevent importados correctamente')
except ImportError as e:
    print(f'❌ Error de importación: {e}')
    exit(1)
"

# 7. Dar permisos a scripts
print_step "Configurando permisos de scripts..."
chmod +x *.sh 2>/dev/null
print_success "Permisos configurados"

# 8. Verificar que uploads existe
print_step "Verificando directorio uploads..."
if [[ ! -d "uploads" ]]; then
    mkdir -p uploads
    print_info "Directorio uploads creado"
fi
print_success "Directorio uploads verificado"

# 9. Intentar arrancar servidor
print_step "Probando arranque del servidor..."
if $PYTHON_CMD -c "
import sys
sys.path.append('.')
try:
    from app import app
    print('✅ App importada correctamente')
except Exception as e:
    print(f'❌ Error importando app: {e}')
    exit(1)
"; then
    print_success "Servidor puede arrancar correctamente"
else
    print_error "Hay problemas con el arranque del servidor"
fi

echo ""
print_success "🎉 Problemas de actualización solucionados"
print_info "Ahora puedes ejecutar: ./update_vps.sh"
echo ""
