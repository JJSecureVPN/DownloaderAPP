#!/bin/bash

echo "🔒 Configurando SSL con Let's Encrypt..."

DOMAIN="vps.jhservices.com.ar"

# Verificar que Nginx esté configurado
if [ ! -f /etc/nginx/sites-available/apk-store ]; then
    echo "❌ Primero ejecuta setup_nginx.sh"
    exit 1
fi

# Instalar Certbot si no está instalado
if ! command -v certbot &> /dev/null; then
    echo "📦 Instalando Certbot..."
    sudo apt update
    sudo apt install -y certbot python3-certbot-nginx
fi

# Obtener certificado SSL
echo "🔐 Obteniendo certificado SSL para $DOMAIN..."
sudo certbot --nginx -d $DOMAIN --non-interactive --agree-tos --email admin@jhservices.com.ar

# Configurar renovación automática
echo "⏰ Configurando renovación automática..."
(crontab -l 2>/dev/null; echo "0 12 * * * /usr/bin/certbot renew --quiet") | crontab -

if [ $? -eq 0 ]; then
    echo "🎉 ¡SSL configurado exitosamente!"
    echo "🔒 Tu aplicación estará disponible en: https://$DOMAIN"
    echo "🔄 Los certificados se renovarán automáticamente"
else
    echo "❌ Error configurando SSL"
    echo "🔍 Verifica que el dominio $DOMAIN apunte a esta IP"
fi
