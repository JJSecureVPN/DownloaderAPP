#!/bin/bash

echo "🔍 Detectando puertos disponibles..."

# Función para encontrar puerto libre
find_free_port() {
    local start_port=$1
    local port=$start_port
    
    while [ $port -lt 65535 ]; do
        if ! lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1; then
            echo $port
            return 0
        fi
        ((port++))
    done
    
    echo "0"
    return 1
}

# Buscar puertos libres
APP_PORT=$(find_free_port 8080)
NGINX_PORT=$(find_free_port $((APP_PORT + 1)))

if [ "$APP_PORT" = "0" ] || [ "$NGINX_PORT" = "0" ]; then
    echo "❌ No se encontraron puertos libres"
    exit 1
fi

echo "✅ Puertos encontrados:"
echo "   🐍 Aplicación: $APP_PORT"
echo "   🌐 Nginx: $NGINX_PORT"

# Crear script de ejecución personalizado
cat > run_auto_port.sh << EOF
#!/bin/bash
echo "🚀 Iniciando APK Store en puerto $APP_PORT..."
cd "\$(dirname "\$0")"
python3 main.py $APP_PORT 0.0.0.0
EOF

chmod +x run_auto_port.sh

# Crear configuración de Nginx
DOMAIN="vps.jhservices.com.ar"
APP_PATH="$(pwd)"

sudo tee /etc/nginx/sites-available/apk-store-auto > /dev/null <<EOF
server {
    listen $NGINX_PORT;
    server_name $DOMAIN;

    location / {
        proxy_pass http://127.0.0.1:$APP_PORT;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        
        client_max_body_size 100M;
        proxy_connect_timeout 600s;
        proxy_send_timeout 600s;
        proxy_read_timeout 600s;
    }

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

echo "📝 Configuración creada:"
echo "   📄 Script: ./run_auto_port.sh"
echo "   ⚙️  Nginx: /etc/nginx/sites-available/apk-store-auto"
echo ""
echo "🎯 URLs de acceso:"
echo "   📱 Directo: http://$DOMAIN:$APP_PORT"
echo "   🌐 Nginx: http://$DOMAIN:$NGINX_PORT"
echo ""
echo "🚀 Para activar, ejecuta:"
echo "   sudo ln -s /etc/nginx/sites-available/apk-store-auto /etc/nginx/sites-enabled/"
echo "   sudo nginx -t && sudo systemctl restart nginx"
echo "   ./run_auto_port.sh"
