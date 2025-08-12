# Puertos Alternativos para APK Store
# =====================================

## Puertos HTTP Alternativos:
# 8080 - Puerto HTTP alternativo más común
# 8081 - Segundo puerto HTTP alternativo
# 8082 - Tercer puerto HTTP alternativo
# 8888 - Usado por algunos servicios web
# 9080 - Otro puerto común para aplicaciones web

## Puertos HTTPS Alternativos:
# 8443 - Puerto HTTPS alternativo más común
# 8444 - Segundo puerto HTTPS alternativo
# 9443 - Otro puerto común para HTTPS alternativo

## Puertos para Aplicaciones Python:
# 5000 - Flask por defecto
# 5001 - Tu puerto actual
# 8000 - Django por defecto
# 8080 - Muy común para aplicaciones web
# 3000 - Node.js por defecto (puedes usar)
# 4000 - Otro puerto común

## Configuración recomendada:
# App Python: 8080
# Nginx HTTP: 8081
# Nginx HTTPS: 8443

## Comandos para verificar puertos:
# Verificar si un puerto está en uso:
# netstat -tlnp | grep :8080
# lsof -i :8080

# Ver todos los puertos en uso:
# netstat -tlnp

# Matar proceso en puerto específico:
# sudo kill -9 $(lsof -t -i:8080)

## URLs de acceso con puertos alternativos:
# http://vps.jhservices.com.ar:8080  # Directo a Python
# http://vps.jhservices.com.ar:8081  # A través de Nginx
# https://vps.jhservices.com.ar:8443 # HTTPS alternativo
