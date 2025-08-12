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

### Comandos Básicos
```bash
# Ver logs del servidor
screen -r downloader

# Detener servidor
screen -S downloader -X quit

# Reiniciar servidor
cd DownloaderAPP
screen -dmS downloader python3 main.py 5001

# Ver aplicaciones subidas
ls DownloaderAPP/uploads/*.apk
```

### Cambiar Puerto
```bash
# Detener servidor actual
screen -S downloader -X quit

# Iniciar en nuevo puerto (ejemplo: 8080)
cd DownloaderAPP
screen -dmS downloader python3 main.py 8080
```

## 🌐 URLs de Acceso

Después de la instalación, accede a:

- **🏪 Tienda Principal**: `http://tu-servidor.com/`
- **💻 Portal Desarrolladores**: `http://tu-servidor.com/upload`
- **📱 Detalle de App**: `http://tu-servidor.com/app/nombre-app.apk`

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

### 🛡️ **Actualización Automática (Recomendado)**

Para actualizar a la última versión **SIN PERDER** las aplicaciones subidas por usuarios:

```bash
# Método 1: Script automático (más seguro)
cd DownloaderAPP
./update_vps.sh
```

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
- ✅ **Backup automático**: El script crea respaldos antes de actualizar
- ✅ **Separación total**: Código y datos están completamente separados

### 📁 **Datos que se Conservan Siempre:**

- 📦 **Archivos APK** subidos por usuarios
- 🖼️ **Iconos** de aplicaciones
- 📸 **Screenshots** de aplicaciones  
- 📋 **Metadata** (apps_metadata.json)
- 📊 **Contadores de descarga**
- ⭐ **Calificaciones** y estadísticas

### 🚀 **Configuración con Systemd (Más Profesional)**

Para un manejo más profesional del servicio:

```bash
# 1. Copiar archivo de servicio
sudo cp downloader-app.service /etc/systemd/system/

# 2. Editar rutas en el archivo
sudo nano /etc/systemd/system/downloader-app.service
# Cambiar: WorkingDirectory=/ruta/a/tu/DownloaderAPP
# Cambiar: User=tu-usuario

# 3. Habilitar y iniciar servicio
sudo systemctl daemon-reload
sudo systemctl enable downloader-app
sudo systemctl start downloader-app

# 4. Para actualizar en el futuro:
sudo systemctl stop downloader-app
git pull origin main
sudo systemctl start downloader-app
```

### 📊 **Verificar Actualización Exitosa**

Después de actualizar, verifica que todo funciona:

```bash
# 1. Verificar que el servidor está corriendo
ps aux | grep python

# 2. Verificar que los datos siguen ahí
ls -la uploads/
wc -l uploads/apps_metadata.json

# 3. Probar la aplicación
curl http://localhost:5001/api/apps

# 4. Ver logs si hay problemas
tail -f server.log
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

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.

---

<div align="center">

**🚀 Desarrollado con ❤️ por [@JHServices](https://github.com/JJSecureVPN)**

**🏪 Crea tu propia Play Store en minutos**

[![GitHub](https://img.shields.io/badge/GitHub-JJSecureVPN-blue?style=flat-square&logo=github)](https://github.com/JJSecureVPN)
[![Domain](https://img.shields.io/badge/Domain-vps.jhservices.com.ar-orange?style=flat-square&logo=internet-explorer)](http://vps.jhservices.com.ar)

</div>
