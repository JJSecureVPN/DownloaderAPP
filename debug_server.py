#!/usr/bin/env python3
"""
Servidor de debug para el proyecto DownloaderPage
"""
import sys
from app import create_app

if __name__ == '__main__':
    port = int(sys.argv[1] if len(sys.argv) > 1 else 5001)
    host = sys.argv[2] if len(sys.argv) > 2 else '127.0.0.1'
    
    print(f'[*] Iniciando servidor de debug en {host}:{port}')
    
    app = create_app()
    app.run(host=host, port=port, debug=True)
