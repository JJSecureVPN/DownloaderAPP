# 🚀 APK Store - Tienda de Aplicaciones Completa

[![Version](https://img.shields.io/badge/version-3.0-blue.svg)](https://github.com/JJSecureVPN/DownloaderAPP)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Ubuntu%20%7C%20Debian-lightgrey.svg)](#)
[![Domain](https://img.shields.io/badge/domain-vps.jhservices.com.ar-orange.svg)](#)

> **🏪 Mini Play Store completa con tienda visual, portal de desarrolladores y gestión avanzada de aplicaciones**

## 🌟 ¿Qué es APK Store?

**APK Store** es una plataforma completa que permite a cualquier persona crear su propia tienda de aplicaciones Android tipo Play Store. Con una interfaz moderna y funcionalidades avanzadas, cualquiera puede subir su aplicación y mostrarla de forma profesional.

## ✨ Características Principales

### 🏪 **Tienda Visual (Play Store Style)**
- **Página principal** con vista de cards atractiva
- **Búsqueda y filtros** por categoría, nombre, desarrollador
- **Estadísticas en tiempo real** (apps, descargas, desarrolladores)
- **Diseño responsive** optimizado para móviles y desktop

### 📱 **Páginas de Detalle de Apps**
- **Información completa** de cada aplicación
- **Gallery de screenshots** (hasta 5 imágenes)
- **Estadísticas de descarga** (total, hoy, semana)
- **Acciones múltiples** (descargar, compartir, reportar)
- **Información técnica** detallada

### 💻 **Portal para Desarrolladores**
- **Formulario completo** para subir aplicaciones
- **Campos de metadata** (nombre, descripción, categoría, versión)
- **Subida de iconos** y screenshots
- **Preview en tiempo real** de imágenes
- **Validación** de campos requeridos

### 🗂️ **Sistema de Gestión Avanzado**
- **Metadata persistente** en archivos JSON
- **Contadores automáticos** de descargas
- **Gestión de archivos multimedia** (iconos, screenshots)
- **Categorización** por tipo de aplicación
- **Sin base de datos** - todo en archivos simples

## 🌐 URLs y Navegación

### **Para Usuarios Finales:**
- **`/`** - 🏪 **Tienda Principal** (página de inicio)
- **`/store`** - Tienda (alias)
- **`/app/{filename}`** - Detalle de aplicación específica

### **Para Desarrolladores:**
- **`/upload`** - 💻 **Portal Desarrolladores**
- **`/developers`** - Portal (alias)

### **APIs Disponibles:**
- **`GET /api/apps`** - Lista todas las aplicaciones
- **`GET /api/apps/{filename}`** - Detalle de aplicación
- **`POST /api/apps/{filename}/download`** - Incrementar descargas

## 🚀 Instalación Rápida

### 🌐 Instalación en VPS (Recomendado para Producción)

#### **🔧 Método 1: Instalación Completa Automática (⭐ RECOMENDADO)**

Conecta a tu VPS y ejecuta:

```bash
# 1. Conectar al VPS
ssh tu_usuario@vps.jhservices.com.ar

# 2. Instalación completa en una línea
sudo bash <(curl -s https://raw.githubusercontent.com/JJSecureVPN/DownloaderAPP/main/installer.sh)

# 3. Configurar para acceso sin puerto
cd DownloaderAPK
./update_vps.sh

# ✅ Resultado: http://vps.jhservices.com.ar (¡Sin puerto!)
```

#### **🔧 Método 2: Clonación Manual (Control Total)**

```bash
# 1. Conectar al VPS
ssh tu_usuario@vps.jhservices.com.ar

# 2. Instalar dependencias básicas
sudo apt update && sudo apt install -y git python3 python3-pip curl wget screen nginx

# 3. Clonar el repositorio
git clone https://github.com/JJSecureVPN/DownloaderAPP.git
cd DownloaderAPP

# 4. Instalar dependencias de Python
pip3 install -r requirements.txt

# 5. Configurar permisos de scripts
chmod +x *.sh

# 6. Ejecutar configuración completa
./update_vps.sh

# ✅ Resultado: http://vps.jhservices.com.ar (¡Sin puerto!)
```

#### **🔧 Método 3: Descarga Directa del Script**

```bash
# 1. Conectar al VPS
ssh tu_usuario@vps.jhservices.com.ar

# 2. Descargar e instalar
wget https://raw.githubusercontent.com/JJSecureVPN/DownloaderAPP/main/installer.sh
sudo bash installer.sh

# 3. Entrar al directorio y configurar
cd DownloaderAPP
./update_vps.sh

# ✅ Resultado: http://vps.jhservices.com.ar (¡Sin puerto!)
```

#### **📋 Instrucciones Detalladas para VPS**

**Paso 1: Conectar al VPS**
```bash
# Reemplaza con tu información de VPS
ssh root@vps.jhservices.com.ar
# O con usuario no-root:
ssh tu_usuario@vps.jhservices.com.ar
```

**Paso 2: Preparar el Sistema**
```bash
# Actualizar paquetes del sistema
sudo apt update && sudo apt upgrade -y

# Instalar dependencias esenciales
sudo apt install -y python3 python3-pip git curl wget screen nginx ufw

# Configurar firewall básico
sudo ufw allow ssh
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 8080
sudo ufw --force enable
```

**Paso 3: Clonar y Configurar la Aplicación**
```bash
# Clonar el repositorio
git clone https://github.com/JJSecureVPN/DownloaderAPP.git
cd DownloaderAPP

# Instalar dependencias de Python
sudo pip3 install -r requirements.txt

# Dar permisos de ejecución a todos los scripts
chmod +x *.sh
```

**Paso 4: Configuración Automática Completa**
```bash
# Ejecutar script de configuración completa
./update_vps.sh

# Este script automáticamente:
# ✅ Configura la aplicación en puerto 8080
# ✅ Instala y configura Nginx como proxy
# ✅ Crea backup de seguridad
# ✅ Configura systemd service
# ✅ Inicia todos los servicios
```

**Paso 5: Verificar la Instalación**
```bash
# Verificar que la aplicación está corriendo
ps aux | grep python
systemctl status nginx

# Probar acceso local
curl http://localhost:8080/api/apps
curl http://localhost/api/apps

# Verificar puertos
netstat -tulpn | grep :80
netstat -tulpn | grep :8080
```

**Paso 6: Acceso Final**
- 🌐 **Con Nginx (Sin Puerto)**: `http://vps.jhservices.com.ar`
- 🔗 **Directo (Con Puerto)**: `http://vps.jhservices.com.ar:8080`
- 🏪 **Tienda**: `http://vps.jhservices.com.ar/store`
- 💻 **Portal Desarrolladores**: `http://vps.jhservices.com.ar/upload`

### 💻 Instalación Local (Desarrollo)

#### **Método 1: Descarga directa (Recomendado)**
```bash
wget https://raw.githubusercontent.com/JJSecureVPN/DownloaderAPP/main/installer.sh
sudo bash installer.sh
```

#### **Método 2: Con curl**
```bash
curl -O https://raw.githubusercontent.com/JJSecureVPN/DownloaderAPP/main/installer.sh
sudo bash installer.sh
```

#### **Método 3: Una línea**
```bash
sudo bash <(curl -s https://raw.githubusercontent.com/JJSecureVPN/DownloaderAPP/main/installer.sh)
```

#### **Método 4: Clonación completa**
```bash
git clone https://github.com/JJSecureVPN/DownloaderAPP.git
cd DownloaderAPP
sudo bash installer.sh
```

## � Requisitos del Sistema

- **OS**: Linux (Ubuntu 18.04+, Debian 9+, CentOS 7+)
- **Python**: 3.6 o superior
- **Permisos**: Root/sudo
- **Memoria**: Mínimo 512MB RAM
- **Espacio**: 100MB libres

## �📁 Estructura del Proyecto

```
APK-Store/
├── 📁 app/
│   ├── 📁 templates/
│   │   ├── store.html          # 🏪 Tienda principal
│   │   ├── app-detail.html     # 📱 Detalle de aplicación
│   │   └── index.html          # 💻 Portal desarrolladores
│   ├── 📁 static/
│   │   └── 📁 css/
│   │       ├── store.css       # Estilos de la tienda
│   │       ├── app-detail.css  # Estilos de detalle
│   │       └── style.css       # Estilos del portal
│   └── 📁 routes/
│       └── index.py            # Rutas y APIs
├── 📁 uploads/
│   ├── *.apk                   # 📦 Archivos APK
│   ├── 📁 icons/               # 🖼️ Iconos de aplicaciones
│   ├── 📁 screenshots/         # 📸 Capturas de pantalla
│   └── apps_metadata.json     # 📋 Metadata de aplicaciones
└── main.py                     # 🚀 Servidor principal
```

## 📱 Cómo Usar la Plataforma

### **👤 Como Usuario (Descargar Apps):**

1. **Visita la tienda**: Ve a `http://tu-servidor.com/`
2. **Explora aplicaciones**: Usa filtros y búsqueda
3. **Ve los detalles**: Haz clic en cualquier app
4. **Descarga**: Haz clic en "Descargar APK"

### **👨‍💻 Como Desarrollador (Subir Apps):**

1. **Ve al portal**: `http://tu-servidor.com/upload`
2. **Selecciona tu APK**: Arrastra o selecciona el archivo
3. **Completa la información**:
   - ✅ **Nombre de la aplicación** (requerido)
   - ✅ **Desarrollador** (requerido)
   - ✅ **Descripción** (opcional pero recomendado)
   - ✅ **Categoría** (Juegos, Productividad, etc.)
   - ✅ **Versión** (1.0.0, etc.)
   - ✅ **Icono** (imagen opcional)
   - ✅ **Screenshots** (hasta 5 imágenes)
4. **Subir**: Tu app aparecerá automáticamente en la tienda

### **📊 Categorías Disponibles:**
- 🎮 **Juegos**
- 📊 **Productividad**
- 👥 **Social**
- 🛠️ **Herramientas**
- 🎬 **Entretenimiento**
- 📚 **Educación**
- 📦 **Otros**

## 🎯 Características Técnicas

### **🔄 Sistema de Gestión de Archivos**
- **Almacenamiento persistente**: Los archivos no se eliminan automáticamente
- **Gestión de duplicados**: Opciones de reemplazar o mantener ambos
- **Metadata JSON**: Sin necesidad de base de datos compleja
- **Contadores automáticos**: Estadísticas de descarga en tiempo real

### **🖼️ Gestión Multimedia**
- **Iconos**: Formato de imagen para cada aplicación
- **Screenshots**: Hasta 5 capturas de pantalla por app
- **Preview**: Vista previa en tiempo real durante la subida
- **Optimización**: Almacenamiento organizado por tipo

### **🔍 Búsqueda y Filtros**
- **Búsqueda en tiempo real** por nombre, desarrollador, descripción
- **Filtros por categoría** con iconos visuales
- **Ordenamiento** por fecha, nombre, popularidad
- **Resultados instantáneos** sin recarga de página

## 🛡️ Seguridad y Validación

- ✅ **Solo archivos APK** permitidos
- ✅ **Validación de campos** requeridos
- ✅ **Sanitización de nombres** de archivo
- ✅ **Control de duplicados** con opciones
- ✅ **Límites de archivos** (5 screenshots máximo)
- ✅ **Gestión de errores** completa

## 🔧 Gestión del Servidor

### 🚀 **Comandos con Scripts Automáticos (Recomendado)**
```bash
# Actualizar aplicación (mantiene datos, configura Nginx para acceso sin puerto)
./update_vps.sh

# Después de ejecutar update_vps.sh, acceso:
# ✅ SIN PUERTO: http://vps.jhservices.com.ar
# ✅ CON PUERTO: http://vps.jhservices.com.ar:8080

# Actualización rápida
./quick_update.sh

# Configuración inicial de scripts
./setup_update_scripts.sh

# Ejecutar en puerto 8080
./run_port_8080.sh

# Configurar Nginx + puerto alternativo
./setup_alt_ports.sh

# Detectar puertos libres automáticamente
./detect_free_ports.sh

# En Windows
PowerShell -ExecutionPolicy Bypass -File .\update_windows.ps1
```

### 📋 **Comandos Básicos Manuales**
```bash
# Ver logs del servidor
screen -r downloader

# Detener servidor
screen -S downloader -X quit

# Reiniciar servidor en puerto 8080 (nuevo)
cd DownloaderAPP
screen -dmS downloader python3 main.py 8080

# Ver aplicaciones subidas
ls DownloaderAPP/uploads/*.apk

# Ver logs de actualización
tail -f update.log
```

### 🔄 **Cambiar Puerto**
```bash
# Detener servidor actual
screen -S downloader -X quit

# Puerto 8080 (recomendado)
cd DownloaderAPP
screen -dmS downloader python3 main.py 8080

# Otros puertos disponibles
screen -dmS downloader python3 main.py 8081  # Puerto alternativo
screen -dmS downloader python3 main.py 5001  # Puerto anterior (compatibilidad)
```

### 🌐 **Configuración con Nginx (Sin Puerto en URL)**
```bash
# Método automático (recomendado)
./setup_nginx.sh

# Método manual
sudo apt install nginx
sudo nano /etc/nginx/sites-available/apk-store
# (Copiar configuración de nginx-config.conf)
sudo ln -s /etc/nginx/sites-available/apk-store /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl restart nginx

# Aplicación corre en 8080, Nginx en 80/443
# Acceso sin puerto: http://vps.jhservices.com.ar
```

### 🔒 **Configuración SSL/HTTPS**
```bash
# Obtener certificado SSL gratuito
./setup_ssl.sh

# O manual con certbot
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d vps.jhservices.com.ar

# Resultado: https://vps.jhservices.com.ar (¡Sin puerto!)
```

### 🛠️ **Verificación de Puertos**
```bash
# Ver qué puertos están en uso
netstat -tulpn | grep :8080
netstat -tulpn | grep :80
netstat -tulpn | grep :443

# Ver procesos de la aplicación
ps aux | grep python
ps aux | grep nginx

# Verificar conectividad
curl http://localhost:8080/api/apps
curl http://vps.jhservices.com.ar:8080/api/apps
```

### � **Mantenimiento con Scripts**
```bash
# Hacer backup manual
cp -r uploads/ uploads_backup_$(date +%Y%m%d_%H%M%S)/

# Verificar integridad de datos
ls -la uploads/
cat uploads/apps_metadata.json | jq .

# Limpiar backups antiguos (mantener últimos 5)
ls -t uploads_backup_* | tail -n +6 | xargs rm -rf

# Verificar estado del servidor
ps aux | grep python
netstat -tulpn | grep :8080  # Puerto actualizado
lsof -i :8080  # Verificar proceso en puerto 8080
```

## 🌐 URLs de Acceso y Configuración de Puertos

### 🚀 **Configuración de Puertos (Actualizada)**

**APK Store** ahora usa el puerto **8080** por defecto para evitar conflictos comunes. Tienes varias opciones:

#### **📡 Acceso Directo (Puerto 8080 - Nuevo Por Defecto)**
- **🏪 Tienda Principal**: `http://vps.jhservices.com.ar:8080/`
- **💻 Portal Desarrolladores**: `http://vps.jhservices.com.ar:8080/upload`
- **📱 Detalle de App**: `http://vps.jhservices.com.ar:8080/app/nombre-app.apk`
- **🔌 API**: `http://vps.jhservices.com.ar:8080/api/apps`

#### **🌐 Con Proxy Reverso (Sin Puerto en URL) ⭐ NUEVO**
Si configuras Nginx automáticamente, puedes acceder **sin especificar puerto**:
- **🏪 Tienda**: `http://vps.jhservices.com.ar/` ← **¡SIN PUERTO!**
- **💻 Portal**: `http://vps.jhservices.com.ar/upload` ← **¡SIN PUERTO!**
- **🔒 HTTPS**: `https://vps.jhservices.com.ar/` (con SSL configurado)

### 🔧 **Scripts de Configuración de Puertos (Actualizados)**

#### **1. Actualización Automática con Nginx (⭐ RECOMENDADO)**
```bash
# Script completo que configura todo automáticamente
./update_vps.sh

# Esto hace:
# ✅ Actualiza la aplicación al puerto 8080
# ✅ Configura Nginx automáticamente para puerto 80
# ✅ Resultado: http://vps.jhservices.com.ar (¡SIN PUERTO!)
```

#### **2. Ejecutar Solo en Puerto 8080**
```bash
# Opción A: Script automático
./run_port_8080.sh

# Opción B: Manual
python3 main.py 8080 0.0.0.0

# Acceso: http://vps.jhservices.com.ar:8080
```

#### **3. Configurar Nginx Independientemente**
```bash
# Para configurar Nginx sin actualizar la app
./setup_nginx.sh

# O usar puertos alternativos si 80/443 están ocupados
./setup_alt_ports.sh
```

#### **4. Detectar Puertos Libres Automáticamente**
```bash
# El script encuentra puertos libres automáticamente
./detect_free_ports.sh

# Configura automáticamente sin conflictos
```

#### **5. Configurar SSL/HTTPS**
```bash
# Después de configurar Nginx
./setup_ssl.sh

# Resultado: https://vps.jhservices.com.ar (¡HTTPS sin puerto!)
```

### 📊 **Tabla de Puertos Disponibles (Actualizada)**

| Puerto | Uso | URL de Acceso | Comando | Estado |
|--------|-----|---------------|---------|---------|
| **8080** | Aplicación directa | `http://vps.jhservices.com.ar:8080` | `python3 main.py 8080` | ⭐ **NUEVO POR DEFECTO** |
| **80** | Nginx → 8080 | `http://vps.jhservices.com.ar` | `./update_vps.sh` | 🎯 **SIN PUERTO** |
| **443** | HTTPS → 8080 | `https://vps.jhservices.com.ar` | `./setup_ssl.sh` | 🔒 **HTTPS SIN PUERTO** |
| **8081** | Nginx alternativo | `http://vps.jhservices.com.ar:8081` | `./setup_alt_ports.sh` | 🔄 Si 80 está ocupado |
| **8443** | HTTPS alternativo | `https://vps.jhservices.com.ar:8443` | Con certificados SSL | 🔒 Si 443 está ocupado |
| **5001** | Puerto anterior | `http://vps.jhservices.com.ar:5001` | `python3 main.py 5001` | 📦 Compatibilidad |

### ⚙️ **Configuración Avanzada (Actualizada)**

#### **Configuración Automática con update_vps.sh (⭐ RECOMENDADO)**
```bash
# 🚀 UN SOLO COMANDO para todo:
./update_vps.sh

# Esto automáticamente:
# ✅ Actualiza el código
# ✅ Configura la aplicación en puerto 8080
# ✅ Instala y configura Nginx para puerto 80
# ✅ Resultado: http://vps.jhservices.com.ar (¡SIN PUERTO!)
```

#### **Nginx como Proxy Reverso Manual (Si el automático falla)**
```bash
# 1. La aplicación corre en 8080 internamente
python3 main.py 8080 0.0.0.0 &

# 2. Nginx redirige puerto 80 → 8080
sudo ./setup_nginx.sh

# 3. Acceso final sin puerto: http://vps.jhservices.com.ar
```

#### **SSL/HTTPS Gratuito con Let's Encrypt**
```bash
# 1. Primero ejecuta la actualización completa
./update_vps.sh

# 2. Luego agrega SSL automáticamente
./setup_ssl.sh

# 3. Resultado final: https://vps.jhservices.com.ar (¡HTTPS sin puerto!)
```

#### **Para Desarrollo/Testing (Método Simple)**
```bash
# Solo puerto 8080 directo (sin Nginx)
./run_port_8080.sh

# Acceso: http://vps.jhservices.com.ar:8080
```

#### **Verificar la Configuración Final**
```bash
# Verificar que todo funciona correctamente
curl http://vps.jhservices.com.ar/api/apps          # Sin puerto
curl http://vps.jhservices.com.ar:8080/api/apps     # Con puerto directo
curl https://vps.jhservices.com.ar/api/apps         # HTTPS (si SSL está configurado)
```

Después de cualquier configuración de puertos, accede a:

## � Instalación Paso a Paso en VPS (Guía Completa)

### 🎯 Objetivo Final
Después de esta instalación tendrás:
- ✅ APK Store accesible en `http://vps.jhservices.com.ar` (sin puerto)
- ✅ Portal de desarrolladores en `http://vps.jhservices.com.ar/upload`
- ✅ Nginx configurado como proxy reverso
- ✅ Aplicación corriendo en puerto 8080 internamente
- ✅ SSL/HTTPS opcional disponible
- ✅ Systemd service para auto-inicio

### 🔧 Paso 1: Preparar el VPS

#### **1.1 Conectar al VPS**
```bash
# Conectar vía SSH (reemplaza con tu información)
ssh root@vps.jhservices.com.ar
# O con usuario específico:
ssh tu_usuario@vps.jhservices.com.ar
```

#### **1.2 Actualizar Sistema**
```bash
# Actualizar lista de paquetes
sudo apt update && sudo apt upgrade -y

# Instalar dependencias básicas
sudo apt install -y python3 python3-pip git curl wget screen nginx ufw htop nano
```

#### **1.3 Configurar Firewall**
```bash
# Configurar firewall básico
sudo ufw allow ssh         # Puerto 22 (SSH)
sudo ufw allow 80          # Puerto 80 (HTTP)
sudo ufw allow 443         # Puerto 443 (HTTPS)
sudo ufw allow 8080        # Puerto 8080 (Aplicación)
sudo ufw --force enable

# Verificar estado
sudo ufw status
```

### 🔧 Paso 2: Descargar e Instalar la Aplicación

#### **2.1 Clonar Repositorio**
```bash
# Ir al directorio home
cd ~

# Clonar el repositorio
git clone https://github.com/JJSecureVPN/DownloaderAPP.git

# Entrar al directorio
cd DownloaderAPP

# Verificar contenido
ls -la
```

#### **2.2 Instalar Dependencias de Python**
```bash
# Instalar dependencias desde requirements.txt
sudo pip3 install -r requirements.txt

# Verificar instalación
python3 -c "import flask; print('Flask instalado correctamente')"
```

#### **2.3 Configurar Permisos**
```bash
# Dar permisos de ejecución a scripts
chmod +x *.sh

# Verificar permisos
ls -la *.sh
```

### 🔧 Paso 3: Configuración Automática Completa

#### **3.1 Ejecutar Script de Configuración Principal**
```bash
# Ejecutar configuración completa
./update_vps.sh

# Este script automáticamente:
# ✅ Configura la aplicación en puerto 8080
# ✅ Instala y configura Nginx
# ✅ Crea configuración de proxy reverso
# ✅ Configura systemd service
# ✅ Inicia todos los servicios
# ✅ Crea backups de seguridad
```

#### **3.2 Verificar Instalación**
```bash
# Verificar que la aplicación está corriendo
ps aux | grep python

# Verificar Nginx
sudo systemctl status nginx

# Verificar puertos
sudo netstat -tulpn | grep :80
sudo netstat -tulpn | grep :8080

# Probar acceso local
curl http://localhost:8080/api/apps
curl http://localhost/api/apps
```

### 🔧 Paso 4: Verificación y Pruebas

#### **4.1 Probar Acceso Externo**
```bash
# Desde tu computadora local, probar:
curl http://vps.jhservices.com.ar/api/apps

# O abrir en navegador:
# http://vps.jhservices.com.ar
# http://vps.jhservices.com.ar/upload
```

#### **4.2 Verificar Logs**
```bash
# Ver logs de la aplicación
tail -f server.log

# Ver logs de Nginx
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log

# Ver logs del sistema
sudo journalctl -u nginx -f
```

#### **4.3 Verificar Estructura de Archivos**
```bash
# Verificar estructura del proyecto
tree DownloaderAPP/
# O si no tienes tree:
find DownloaderAPP/ -type f -name "*.py" -o -name "*.html" -o -name "*.css"

# Verificar carpeta uploads (datos de usuarios)
ls -la uploads/
```

### 🔧 Paso 5: Configuración SSL/HTTPS (Opcional)

#### **5.1 Instalar Certbot**
```bash
# Instalar certbot para SSL gratuito
sudo apt install certbot python3-certbot-nginx -y
```

#### **5.2 Obtener Certificado SSL**
```bash
# Obtener certificado para tu dominio
sudo certbot --nginx -d vps.jhservices.com.ar

# Seguir las instrucciones del wizard
# Al final tendrás HTTPS automático
```

#### **5.3 Configurar Renovación Automática**
```bash
# Configurar cron para renovación automática
sudo crontab -e

# Agregar esta línea:
0 12 * * * /usr/bin/certbot renew --quiet

# Verificar renovación
sudo certbot renew --dry-run
```

### 🔧 Paso 6: Configuración de Systemd (Auto-inicio)

#### **6.1 Verificar Service**
```bash
# Verificar que el service está activo
sudo systemctl status downloader-app

# Si no está activo, activarlo
sudo systemctl enable downloader-app
sudo systemctl start downloader-app
```

#### **6.2 Comandos de Gestión del Service**
```bash
# Iniciar aplicación
sudo systemctl start downloader-app

# Detener aplicación
sudo systemctl stop downloader-app

# Reiniciar aplicación
sudo systemctl restart downloader-app

# Ver logs del service
sudo journalctl -u downloader-app -f

# Ver estado detallado
sudo systemctl status downloader-app -l
```

### 🔧 Paso 7: Verificación Final

#### **7.1 Lista de Verificación Completa**
```bash
# ✅ 1. Aplicación corriendo en puerto 8080
curl http://localhost:8080/api/apps

# ✅ 2. Nginx proxy funcionando en puerto 80
curl http://localhost/api/apps

# ✅ 3. Acceso externo sin puerto
curl http://vps.jhservices.com.ar/api/apps

# ✅ 4. HTTPS funcionando (si configuraste SSL)
curl https://vps.jhservices.com.ar/api/apps

# ✅ 5. Services activos y habilitados
sudo systemctl is-active nginx
sudo systemctl is-active downloader-app
sudo systemctl is-enabled downloader-app
```

#### **7.2 URLs Finales de Acceso**
Después de la instalación completa, tu APK Store estará disponible en:

- 🏪 **Tienda Principal**: `http://vps.jhservices.com.ar/`
- 💻 **Portal Desarrolladores**: `http://vps.jhservices.com.ar/upload`
- 📱 **Detalle de App**: `http://vps.jhservices.com.ar/app/nombre-app.apk`
- 🔌 **API**: `http://vps.jhservices.com.ar/api/apps`
- 🔒 **HTTPS** (si configuraste SSL): `https://vps.jhservices.com.ar/`

#### **7.3 Acceso con Puerto (Directo)**
También puedes acceder directamente al puerto 8080:
- `http://vps.jhservices.com.ar:8080/`

### 🔧 Paso 8: Mantenimiento y Actualizaciones

#### **8.1 Actualizar la Aplicación**
```bash
# Actualización completa (mantiene datos)
cd DownloaderAPP
./update_vps.sh

# Actualización rápida para cambios menores
./quick_update.sh
```

#### **8.2 Backup Manual**
```bash
# Crear backup de datos de usuarios
cd DownloaderAPP
cp -r uploads/ uploads_backup_$(date +%Y%m%d_%H%M%S)/

# Listar backups
ls -la uploads_backup_*
```

#### **8.3 Monitoreo del Sistema**
```bash
# Ver recursos del sistema
htop

# Ver uso de disco
df -h

# Ver logs en tiempo real
tail -f server.log
sudo tail -f /var/log/nginx/access.log
```

### 🚨 Comandos de Emergencia

#### **Si algo sale mal durante la instalación:**
```bash
# Detener todos los servicios
sudo systemctl stop nginx
sudo systemctl stop downloader-app
sudo screen -S downloader -X quit

# Limpiar y reiniciar
cd DownloaderAPP
git reset --hard HEAD
git pull origin main
./update_vps.sh

# Reiniciar servicios
sudo systemctl restart nginx
sudo systemctl restart downloader-app
```

#### **Reinstalación completa:**
```bash
# Backup de datos
cp -r DownloaderAPP/uploads/ ~/uploads_backup/

# Eliminar instalación actual
rm -rf DownloaderAPP/

# Reinstalar desde cero
git clone https://github.com/JJSecureVPN/DownloaderAPP.git
cd DownloaderAPP
chmod +x *.sh
sudo pip3 install -r requirements.txt
./update_vps.sh

# Restaurar datos
cp -r ~/uploads_backup/* uploads/
```

### **Subir una Aplicación:**
1. Ve a `/upload`
2. Selecciona tu archivo APK
3. Llena: "Mi App Genial", "Tu Nombre", "Una app increíble..."
4. Sube icono y screenshots
5. ¡Tu app aparece inmediatamente en la tienda!

### **Ver Estadísticas:**
- Total de aplicaciones disponibles
- Total de descargas globales
- Número de desarrolladores activos
- Estadísticas por aplicación individual

## 🔄 Actualización sin Perder Datos

### � **Scripts de Actualización Automática (Recomendado)**

Tenemos múltiples scripts para diferentes necesidades:

#### **1. Script Completo y Robusto** (`update_vps.sh`)
```bash
cd DownloaderAPP
./update_vps.sh
```
- ✅ **Backup automático** con timestamp
- ✅ **Detección inteligente** de procesos
- ✅ **Verificación de conexión** a GitHub
- ✅ **Restauración automática** en caso de error
- ✅ **Logs detallados** del proceso
- ✅ **Verificación post-actualización**

#### **2. Script Rápido** (`quick_update.sh`)
```bash
cd DownloaderAPP
./quick_update.sh
```
- ⚡ **Actualización express** para cambios menores
- ⚡ **Proceso optimizado** sin verificaciones extensas
- ⚡ **Ideal para actualizaciones frecuentes**

#### **3. Script para Windows** (`update_windows.ps1`)
```powershell
cd DownloaderAPP
PowerShell -ExecutionPolicy Bypass -File .\update_windows.ps1
```
- 🪟 **Compatible con Windows** y PowerShell
- 🪟 **Detección de procesos Python** en Windows
- 🪟 **Backup con nombres Windows-friendly**

#### **4. Configuración Inicial** (`setup_update_scripts.sh`)
```bash
cd DownloaderAPP
./setup_update_scripts.sh
```
- 🔧 **Configura permisos** de todos los scripts
- 🔧 **Prepara el entorno** para actualizaciones
- 🔧 **Solo necesitas ejecutarlo una vez**

### 🛡️ **Características de Seguridad de los Scripts:**

- 🔒 **Backup automático** antes de cualquier cambio
- 🔒 **Verificación de conectividad** a GitHub
- 🔒 **Rollback automático** si algo falla
- 🔒 **Preservación garantizada** de datos de usuarios
- 🔒 **Logs detallados** para debugging
- 🔒 **Verificación de integridad** post-actualización

### 🔧 **Actualización Manual Paso a Paso**

Si prefieres hacerlo manualmente:

```bash
# 1. Crear backup preventivo (opcional pero recomendado)
cd DownloaderAPP
cp -r uploads/ uploads_backup_$(date +%Y%m%d_%H%M%S)/

# 2. Detener servidor
screen -S downloader -X quit
# O si usas otro método:
# sudo systemctl stop downloader-app
# kill $(ps aux | grep "python.*main.py" | awk '{print $2}')

# 3. Actualizar código desde GitHub
git pull origin main

# 4. Verificar que los datos siguen ahí
ls -la uploads/
cat uploads/apps_metadata.json

# 5. Instalar nuevas dependencias (si las hay)
pip3 install -r requirements.txt

# 6. Reiniciar servidor
screen -dmS downloader python3 main.py 5001
# O con systemd: sudo systemctl start downloader-app
```

### 🔒 **¿Por qué NO se pierden los datos?**

- ✅ **Protección automática**: La carpeta `uploads/` está en `.gitignore`
- ✅ **Git solo actualiza código**: Nunca toca archivos de datos de usuarios
- ✅ **Backup automático**: Los scripts crean respaldos antes de actualizar
- ✅ **Separación total**: Código y datos están completamente separados
- ✅ **Rollback automático**: Si algo falla, se restaura el estado anterior

### 📁 **Datos que se Conservan Siempre:**

- 📦 **Archivos APK** subidos por usuarios
- 🖼️ **Iconos** de aplicaciones
- 📸 **Screenshots** de aplicaciones  
- 📋 **Metadata** (apps_metadata.json)
- 📊 **Contadores de descarga**
- ⭐ **Calificaciones** y estadísticas
- 📝 **Logs del servidor**
- ⚙️ **Configuraciones personalizadas**

### 🚀 **Configuración con Systemd (Más Profesional)**

Para un manejo más profesional del servicio:

```bash
# 1. Configurar servicio automáticamente
cd DownloaderAPP
sudo ./setup_update_scripts.sh

# 2. Usar systemd para actualizaciones
sudo systemctl stop downloader-app
git pull origin main
sudo systemctl start downloader-app

# 3. O usar el script con systemd
./update_vps.sh --systemd
```

### 📊 **Verificar Actualización Exitosa**

Los scripts automáticamente verifican, pero puedes hacerlo manualmente:

```bash
# 1. Verificar que el servidor está corriendo
ps aux | grep python
systemctl status downloader-app  # Si usas systemd

# 2. Verificar que los datos siguen ahí
ls -la uploads/
wc -l uploads/apps_metadata.json

# 3. Probar la aplicación
curl http://localhost:5001/api/apps

# 4. Ver logs si hay problemas
tail -f server.log
tail -f update.log  # Logs de actualización
```

### 🆘 **Solución de Problemas en Actualización**

#### **Si el script falla:**
```bash
# 1. Ver logs de la actualización
cat update.log

# 2. Restaurar backup automáticamente
./restore_backup.sh  # (incluido en update_vps.sh)

# 3. Verificar conectividad
ping github.com
git remote -v
```

#### **Si el servidor no arranca:**
```bash
# 1. Verificar dependencias
pip3 install -r requirements.txt

# 2. Verificar puertos
netstat -tulpn | grep :5001

# 3. Arrancar en modo debug
python3 main.py 5001 --debug
```

#### **Si faltan datos:**
```bash
# 1. Verificar backups disponibles
ls -la uploads_backup_*/

# 2. Restaurar último backup
cp -r uploads_backup_YYYYMMDD_HHMMSS/* uploads/

# 3. Verificar integridad
ls -la uploads/
cat uploads/apps_metadata.json
```

##  Solución de Problemas

### 🔧 Problemas en VPS (Específicos de Servidor)

#### **🚨 Error: "No se puede conectar al puerto 80"**
```bash
# Verificar si Nginx está corriendo
sudo systemctl status nginx

# Si no está instalado, instalarlo
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

# Verificar configuración
sudo nginx -t
sudo systemctl restart nginx
```

#### **🚨 Error: "Puerto 8080 ocupado"**
```bash
# Ver qué proceso usa el puerto
sudo netstat -tulpn | grep :8080
sudo lsof -i :8080

# Matar proceso si es necesario
sudo kill -9 $(sudo lsof -t -i:8080)

# Reiniciar aplicación
cd DownloaderAPP
./update_vps.sh
```

#### **🚨 Error: "git: command not found"**
```bash
# Instalar git
sudo apt update
sudo apt install git -y

# Verificar instalación
git --version
```

#### **🚨 Error: "Permission denied"**
```bash
# Dar permisos correctos
cd DownloaderAPP
chmod +x *.sh
sudo chown -R $USER:$USER .

# Si usas root, asegurar permisos
chmod 755 *.sh
```

#### **🚨 Error: "Nginx 404 Not Found"**
```bash
# Verificar configuración de Nginx
sudo cat /etc/nginx/sites-available/apk-store

# Reconfigurar Nginx automáticamente
cd DownloaderAPP
./setup_nginx.sh

# Verificar sintaxis y reiniciar
sudo nginx -t
sudo systemctl restart nginx
```

#### **🚨 Error: "No module named 'flask'"**
```bash
# Instalar dependencias de Python
cd DownloaderAPP
sudo pip3 install -r requirements.txt

# O instalar Flask específicamente
sudo pip3 install Flask==2.3.3 gevent==23.7.0
```

#### **🚨 Error: "Screen not found"**
```bash
# Instalar screen
sudo apt install screen -y

# Verificar sesiones activas
screen -ls

# Reconectar a sesión existente
screen -r downloader
```

#### **🚨 Error de SSL/HTTPS**
```bash
# Instalar certbot para SSL gratuito
sudo apt install certbot python3-certbot-nginx -y

# Obtener certificado SSL
sudo certbot --nginx -d vps.jhservices.com.ar

# Renovar certificados automáticamente
sudo crontab -e
# Agregar: 0 12 * * * /usr/bin/certbot renew --quiet
```

### 🔧 Problemas Generales

### Error de instalación con curl
Si el comando `bash <(curl ...)` falla:
```bash
# Usar método alternativo con wget
wget https://raw.githubusercontent.com/JJSecureVPN/DownloaderAPP/main/installer.sh
sudo bash installer.sh
```

### Error de permisos
```bash
sudo chown -R $USER:$USER DownloaderAPP/
chmod +x DownloaderAPP/main.py
```

### Puerto ocupado
```bash
# Verificar qué usa el puerto
sudo netstat -tulpn | grep :5001

# Cambiar a otro puerto
cd DownloaderAPP
screen -dmS downloader python3 main.py 8080
```

### Dependencias faltantes
```bash
sudo apt update
sudo apt install python3 python3-pip git screen curl -y
pip3 install Flask==2.3.3 gevent==23.7.0
```

### 🆘 Comandos de Diagnóstico para VPS

#### **Verificación Completa del Sistema**
```bash
# Estado de todos los servicios
sudo systemctl status nginx
sudo systemctl status downloader-app
ps aux | grep python

# Estado de puertos
sudo netstat -tulpn | grep :80
sudo netstat -tulpn | grep :8080
sudo netstat -tulpn | grep :443

# Espacio en disco
df -h
du -sh DownloaderAPP/

# Memoria y CPU
free -h
top -bn1 | head -20

# Logs del sistema
sudo journalctl -u nginx -n 50
sudo journalctl -u downloader-app -n 50
```

#### **Logs de la Aplicación**
```bash
# Ver logs en tiempo real
tail -f DownloaderAPP/server.log
tail -f DownloaderAPP/update.log

# Logs de Nginx
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log

# Logs del sistema
sudo journalctl -f
```

#### **Reinicio Completo del Sistema**
```bash
# Reiniciar aplicación solamente
cd DownloaderAPP
./update_vps.sh

# Reiniciar todos los servicios
sudo systemctl restart nginx
sudo systemctl restart downloader-app

# Reinicio completo del VPS (último recurso)
sudo reboot
```

#### **Backup y Restauración**
```bash
# Crear backup manual
cd DownloaderAPP
cp -r uploads/ uploads_backup_$(date +%Y%m%d_%H%M%S)/

# Restaurar último backup
ls -la uploads_backup_*
cp -r uploads_backup_YYYYMMDD_HHMMSS/* uploads/

# Verificar integridad de datos
ls -la uploads/
cat uploads/apps_metadata.json | jq .
```

## 📞 Soporte

- **GitHub Issues**: [Reportar problema](https://github.com/JJSecureVPN/DownloaderAPP/issues)
- **Desarrollador**: @JHServices
- **Dominio**: vps.jhservices.com.ar

## 📝 Changelog

### v3.0 (Actual) - **APK Store Completa**
- ✨ **Tienda visual** tipo Play Store
- ✨ **Páginas de detalle** de aplicaciones
- ✨ **Portal para desarrolladores** con metadata
- ✨ **Sistema multimedia** (iconos, screenshots)
- ✨ **Búsqueda y filtros** avanzados
- ✨ **Estadísticas** en tiempo real
- ✨ **Upload completo** con todos los metadatos

### v2.0 - **Sistema Básico**
- ✨ Sistema de gestión de archivos persistente
- ✨ Modal para resolución de duplicados
- ✨ API REST completa
- ✨ Interfaz moderna con animaciones

### v1.0 - **Subida Básica**
- 📱 Subida básica de archivos APK
- 🌐 Interfaz web simple
- 🔗 Generación de enlaces de descarga

## 🎯 Próximas Funcionalidades

- 👥 **Sistema de usuarios** y autenticación
- ⭐ **Reseñas y calificaciones** de aplicaciones
- � **Analytics avanzados** de descargas
- 🔔 **Sistema de notificaciones** para desarrolladores
- � **Soporte para apps premium** (pagadas)

## � Archivos del Proyecto

### 📁 **Scripts de Automatización**
- `update_vps.sh` - Script principal de actualización (robusto y seguro)
- `quick_update.sh` - Actualización rápida para cambios menores
- `update_windows.ps1` - Script de actualización para Windows/PowerShell
- `setup_update_scripts.sh` - Configuración inicial de permisos y entorno

### ⚙️ **Archivos de Configuración**
- `downloader-app.service` - Configuración de servicio systemd
- `requirements.txt` - Dependencias de Python
- `installer.sh` - Instalador automático para VPS
- `.gitignore` - Protección de datos de usuarios

### 🔧 **Archivos Principales**
- `main.py` - Servidor Flask principal
- `debug_server.py` - Servidor en modo debug
- `restart_server.bat` - Script de reinicio para Windows

### 📝 **Documentación**
- `README.md` - Esta documentación completa
- `show_links.sh` - Script para mostrar enlaces útiles

### 📂 **Estructura de Datos**
- `uploads/` - Carpeta protegida con datos de usuarios
  - `*.apk` - Archivos de aplicaciones
  - `icons/` - Iconos de aplicaciones
  - `screenshots/` - Capturas de pantalla
  - `apps_metadata.json` - Metadatos y estadísticas

## �📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.

---

<div align="center">

**🚀 Desarrollado con ❤️ por [@JHServices](https://github.com/JJSecureVPN)**

**🏪 Crea tu propia Play Store en minutos**

[![GitHub](https://img.shields.io/badge/GitHub-JJSecureVPN-blue?style=flat-square&logo=github)](https://github.com/JJSecureVPN)
[![Domain](https://img.shields.io/badge/Domain-vps.jhservices.com.ar-orange?style=flat-square&logo=internet-explorer)](http://vps.jhservices.com.ar)

</div>
