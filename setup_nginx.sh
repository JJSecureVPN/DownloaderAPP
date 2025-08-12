#!/bin/bash

echo "🚀 Configurando Nginx para APK Store..."

# Variables
DOMAIN="vps.jhservices.com.ar"
APP_PORT="8080"  # Cambiado de 5001 a 8080
APP_PATH="/home/$(whoami)/DownloaderPage-master"

# Crear configuración de Nginx
sudo tee /etc/nginx/sites-available/apk-store > /dev/null <<EOF
server {
    listen 80;
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
sudo ln -sf /etc/nginx/sites-available/apk-store /etc/nginx/sites-enabled/

# Eliminar sitio por defecto si existe
sudo rm -f /etc/nginx/sites-enabled/default

# Probar configuración
echo "🔍 Probando configuración de Nginx..."
if sudo nginx -t; then
    echo "✅ Configuración de Nginx válida"
    
    # Reiniciar Nginx
    echo "🔄 Reiniciando Nginx..."
    sudo systemctl restart nginx
    sudo systemctl enable nginx
    
    echo "🎉 ¡Nginx configurado exitosamente!"
    echo "🌐 Tu aplicación estará disponible en: http://$DOMAIN"
    echo ""
    echo "📋 Para agregar SSL (HTTPS), ejecuta:"
    echo "   sudo apt install certbot python3-certbot-nginx"
    echo "   sudo certbot --nginx -d $DOMAIN"
    
else
    echo "❌ Error en la configuración de Nginx"
    exit 1
fi
