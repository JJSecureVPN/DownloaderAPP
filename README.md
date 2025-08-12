# 🚀 APK Store - Tienda de Aplicaciones Completa

[![Version](https://img.shields.io/badge/version-3.0-blue.svg)](https://github.com/JJSecureVPN/DownloaderAPP)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Ubuntu%20%7C%20Debian-lightgrey.svg)](#)
[![Domain](https://img.shields.io/badge/domain-vps.jhservices.com.ar-orange.svg)](#)

> **Mini Play Store completa con tienda visual, portal de desarrolladores y gestión avanzada de aplicaciones**

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
- **`/`** - **🏪 Tienda Principal** (página de inicio)
- **`/store`** - Tienda (alias)
- **`/app/{filename}`** - Detalle de aplicación específica

### **Para Desarrolladores:**
- **`/upload`** - **💻 Portal Desarrolladores**
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

### Método 3: Clonación completa
```bash
git clone https://github.com/JJSecureVPN/DownloaderAPP.git
cd DownloaderAPP
sudo bash installer.sh
```

## 📁 Estructura del Proyecto

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

## 🔄 Actualización

Para actualizar a la última versión:

```bash
# Detener servidor
screen -S downloader -X quit

# Ejecutar instalador nuevamente
wget https://raw.githubusercontent.com/JJSecureVPN/DownloaderAPP/main/installer.sh
sudo bash installer.sh
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
- ✨ **Navegación clara** (tienda vs desarrolladores)

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
- 📈 **Analytics avanzados** de descargas
- 🔔 **Sistema de notificaciones** para desarrolladores
- 💰 **Soporte para apps premium** (pagadas)

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.

---

<div align="center">

**🚀 Desarrollado con ❤️ por [@JHServices](https://github.com/JJSecureVPN)**

**🏪 Crea tu propia Play Store en minutos**

[![GitHub](https://img.shields.io/badge/GitHub-JJSecureVPN-blue?style=flat-square&logo=github)](https://github.com/JJSecureVPN)
[![Domain](https://img.shields.io/badge/Domain-vps.jhservices.com.ar-orange?style=flat-square&logo=internet-explorer)](http://vps.jhservices.com.ar)

</div>

## ✨ Características Principales

### 🔄 **Sistema de Gestión Persistente**
- **Almacenamiento permanente**: Los archivos no se eliminan automáticamente
- **Gestión de duplicados**: Modal interactivo con opciones de resolución
- **Control total**: Elimina archivos individualmente o en lote

### 📱 **Interfaz Moderna**
- **Drag & Drop**: Arrastra archivos directamente al navegador
- **Responsive**: Optimizado para móviles y escritorio
- **Animaciones**: Efectos visuales suaves y profesionales
- **Tema moderno**: Gradientes y efectos de cristal

### 🛠️ **API REST Completa**
- `GET /files` - Lista todos los archivos disponibles
- `POST /upload` - Subir archivo con gestión de duplicados
- `DELETE /delete/<filename>` - Eliminar archivo específico
- `POST /clear` - Limpiar todos los archivos
- `GET /download/<filename>` - Descargar archivo

### 🔒 **Gestión de Duplicados**
Cuando subes un archivo que ya existe, obtienes 3 opciones:
- **🔄 Reemplazar**: Sobrescribe el archivo existente
- **📁 Mantener ambos**: Guarda con timestamp único
- **❌ Cancelar**: Cancela la operación

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

### Método 3: Una línea (puede no funcionar en algunos servidores)
```bash
sudo bash <(curl -s https://raw.githubusercontent.com/JJSecureVPN/DownloaderAPP/main/installer.sh)
```

### Método 4: Clonación completa
```bash
git clone https://github.com/JJSecureVPN/DownloaderAPP.git
cd DownloaderAPP
sudo bash installer.sh
```

## 📋 Requisitos del Sistema

- **OS**: Linux (Ubuntu 18.04+, Debian 9+, CentOS 7+)
- **Python**: 3.6 o superior
- **Permisos**: Root/sudo
- **Memoria**: Mínimo 512MB RAM
- **Espacio**: 100MB libres

## 🎯 Proceso de Instalación

El instalador automático realizará:

1. **📦 Instalación de dependencias**
   - Git, Python3, pip3, screen, curl

2. **📁 Creación del proyecto**
   - Estructura completa de directorios
   - Archivos Python con toda la lógica
   - Templates HTML y CSS modernos

3. **🐍 Configuración de Python**
   - Instalación de Flask y Gevent
   - Configuración del entorno virtual

4. **🚀 Inicio del servidor**
   - Configuración del puerto personalizado
   - Ejecución en screen session
   - URLs de acceso automáticas

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

# Ver archivos subidos
ls DownloaderAPP/uploads/
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

- **URL Local**: `http://localhost:PUERTO`
- **URL con Dominio**: `http://vps.jhservices.com.ar:PUERTO`
- **URL con IP Pública**: `http://TU_IP_PUBLICA:PUERTO`

## 📱 Uso de la Aplicación

### Subir Archivos
1. Arrastra un archivo APK al área de subida
2. O haz clic para seleccionar desde el explorador
3. Si el archivo existe, elige qué hacer en el modal
4. Copia el enlace de descarga generado

### Gestionar Archivos
- **Ver lista**: Se muestra automáticamente si hay archivos
- **Copiar enlace**: Botón 📋 junto a cada archivo
- **Descargar**: Botón ⬇️ para descarga directa
- **Eliminar**: Botón 🗑️ para eliminar específico
- **Limpiar todo**: Botón para eliminar todos los archivos

## 🛡️ Seguridad

- ✅ Solo acepta archivos `.apk`
- ✅ Validación de tipos de archivo
- ✅ Sanitización de nombres de archivo
- ✅ Control de duplicados
- ✅ Gestión de errores completa

## 🔄 Actualización

Para actualizar a la última versión:

```bash
# Detener servidor
screen -S downloader -X quit

# Ejecutar instalador nuevamente
wget https://raw.githubusercontent.com/JJSecureVPN/DownloaderAPP/main/installer.sh
sudo bash installer.sh
```

## 🐛 Solución de Problemas

### Error de instalación con curl
Si el comando `bash <(curl ...)` falla con errores como `/dev/fd/63: No such file or directory`:
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

### v2.0 (Actual)
- ✨ Sistema de gestión de archivos persistente
- ✨ Modal para resolución de duplicados
- ✨ API REST completa
- ✨ Interfaz moderna con animaciones
- ✨ Gestión individual y masiva de archivos
- ✨ Información detallada de archivos (tamaño, fecha)
- ✨ Nomenclatura inteligente para duplicados

### v1.0
- 📱 Subida básica de archivos APK
- 🌐 Interfaz web simple
- 🔗 Generación de enlaces de descarga

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.

---

<div align="center">

**🚀 Desarrollado con ❤️ por [@JHServices](https://github.com/JJSecureVPN)**

[![GitHub](https://img.shields.io/badge/GitHub-JJSecureVPN-blue?style=flat-square&logo=github)](https://github.com/JJSecureVPN)
[![Domain](https://img.shields.io/badge/Domain-vps.jhservices.com.ar-orange?style=flat-square&logo=internet-explorer)](http://vps.jhservices.com.ar)

</div>
