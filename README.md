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

### Método 1: Descarga directa (Recomendado)
```bash
wget https://raw.githubusercontent.com/JJSecureVPN/DownloaderAPP/main/installer.sh
sudo bash installer.sh
```

### Método 2: Con curl
```bash
curl -O https://raw.githubusercontent.com/JJSecureVPN/DownloaderAPP/main/installer.sh
sudo bash installer.sh
```

### Método 3: Una línea
```bash
sudo bash <(curl -s https://raw.githubusercontent.com/JJSecureVPN/DownloaderAPP/main/installer.sh)
```

### Método 4: Clonación completa
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

## 📊 Ejemplos de Uso

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
