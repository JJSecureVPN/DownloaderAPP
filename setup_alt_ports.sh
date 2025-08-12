#!/bin/bash

echo "🔧 Configurando APK Store con puertos alternativos..."

# Variables
DOMAIN="vps.jhservices.com.ar"
APP_PORT="8080"      # Puerto de la aplicación Python
NGINX_HTTP="8081"    # Puerto HTTP alternativo
NGINX_HTTPS="8443"   # Puerto HTTPS alternativo
APP_PATH="$(pwd)"

echo "📋 Configuración de puertos:"
echo "   🐍 Aplicación Python: $APP_PORT"
echo "   🌐 Nginx HTTP: $NGINX_HTTP"
echo "   🔒 Nginx HTTPS: $NGINX_HTTPS"

# Verificar puertos disponibles
check_port() {
    local port=$1
    if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1; then
        echo "❌ Puerto $port está en uso"
        lsof -Pi :$port -sTCP:LISTEN
        return 1
    else
        echo "✅ Puerto $port disponible"
        return 0
    fi
}

echo "🔍 Verificando puertos..."
check_port $APP_PORT || exit 1
check_port $NGINX_HTTP || exit 1
check_port $NGINX_HTTPS || exit 1

# Crear configuración de Nginx
echo "📝 Creando configuración de Nginx..."
sudo tee /etc/nginx/sites-available/apk-store-alt > /dev/null <<EOF
server {
    listen $NGINX_HTTP;
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

    # Servir archivos estáticos directamente
    location /static/ {
        alias $APP_PATH/app/static/;
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    location /uploads/ {
        alias $APP_PATH/uploads/;
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
EOF

# Habilitar el sitio
sudo ln -sf /etc/nginx/sites-available/apk-store-alt /etc/nginx/sites-enabled/

# Probar configuración
echo "🔍 Probando configuración de Nginx..."
if sudo nginx -t; then
    echo "✅ Configuración de Nginx válida"
    
    # Reiniciar Nginx
    echo "🔄 Reiniciando Nginx..."
    sudo systemctl restart nginx
    
    echo "🎉 ¡Configuración completada!"
    echo ""
    echo "🚀 Para iniciar la aplicación, ejecuta:"
    echo "   ./run_port_8080.sh"
    echo ""
    echo "🌐 URLs de acceso:"
    echo "   📱 Directo: http://$DOMAIN:$APP_PORT"
    echo "   🌐 Nginx: http://$DOMAIN:$NGINX_HTTP"
    echo ""
    echo "📋 Para configurar SSL, edita el archivo y agrega tus certificados"
    
else
    echo "❌ Error en la configuración de Nginx"
    exit 1
fi
