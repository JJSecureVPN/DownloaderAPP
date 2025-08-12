import os
import json
from datetime import datetime

from flask import Flask, render_template, request, send_from_directory, jsonify


upload_folder = os.path.join(os.getcwd(), 'uploads')


def __clean_folder():
    """Función para limpiar toda la carpeta (solo usar cuando sea necesario)"""
    for file in os.listdir(upload_folder):
        print('[*] ELIMINANDO: {}'.format(file))
        os.remove(os.path.join(upload_folder, file))


def __get_file_info():
    """Obtiene información de todos los archivos APK en uploads"""
    files_info = []
    if os.path.exists(upload_folder):
        for filename in os.listdir(upload_folder):
            if filename.lower().endswith('.apk'):
                file_path = os.path.join(upload_folder, filename)
                stat = os.stat(file_path)
                files_info.append({
                    'filename': filename,
                    'size': stat.st_size,
                    'modified': datetime.fromtimestamp(stat.st_mtime).strftime('%Y-%m-%d %H:%M:%S'),
                    'download_url': request.url_root + 'download/' + filename
                })
    return files_info


def __file_exists(filename):
    """Verifica si un archivo ya existe"""
    return os.path.exists(os.path.join(upload_folder, filename))


def index():
    return render_template('index.html')


def get_files():
    """Endpoint para obtener la lista de archivos existentes"""
    return jsonify(__get_file_info())


def upload():
    file = request.files['file']
    if not file:
        return 'Archivo no encontrado', 400

    if not file.filename.lower().endswith('.apk'):
        return 'Solo se permiten archivos APK', 400

    filename = file.filename.replace(' ', '_')
    file_path = os.path.join(upload_folder, filename)
    
    # Verificar si el archivo ya existe
    if __file_exists(filename):
        action = request.form.get('action', 'replace')  # Por defecto reemplazar
        
        if action == 'keep_both':
            # Generar nombre único agregando timestamp
            name, ext = os.path.splitext(filename)
            timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
            filename = f"{name}_{timestamp}{ext}"
            file_path = os.path.join(upload_folder, filename)
        elif action == 'cancel':
            return jsonify({
                'error': 'Upload cancelled',
                'existing_file': filename
            }), 409
        # Si action == 'replace', simplemente sobrescribimos el archivo
    
    print('[*] SUBIENDO: {}'.format(filename))
    file.save(file_path)
    
    url = request.url_root + 'download/' + filename
    print('[*] URL: {}'.format(url))
    
    return jsonify({
        'success': True,
        'filename': filename,
        'download_url': url,
        'files': __get_file_info()
    })


def delete_file(filename):
    """Endpoint para eliminar un archivo específico"""
    file_path = os.path.join(upload_folder, filename)
    if os.path.exists(file_path):
        os.remove(file_path)
        print('[*] ELIMINADO: {}'.format(filename))
        return jsonify({'success': True, 'message': f'Archivo {filename} eliminado'})
    else:
        return jsonify({'error': 'Archivo no encontrado'}), 404


def clear_all():
    """Endpoint para limpiar todos los archivos"""
    __clean_folder()
    return jsonify({'success': True, 'message': 'Todos los archivos eliminados'})


def download(filename):
    return send_from_directory(upload_folder, filename)


def setup_route(app: Flask):
    app.add_url_rule('/', 'index', index)
    app.add_url_rule('/upload', 'upload', upload, methods=['POST'])
    app.add_url_rule('/files', 'get_files', get_files, methods=['GET'])
    app.add_url_rule('/delete/<filename>', 'delete_file', delete_file, methods=['DELETE'])
    app.add_url_rule('/clear', 'clear_all', clear_all, methods=['POST'])
    app.add_url_rule('/download/<filename>', 'download', download)
