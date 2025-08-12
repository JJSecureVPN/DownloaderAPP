import os
import json
from datetime import datetime
from werkzeug.utils import secure_filename

from flask import Flask, render_template, request, send_from_directory, jsonify


upload_folder = os.path.join(os.getcwd(), 'uploads')
icons_folder = os.path.join(upload_folder, 'icons')
screenshots_folder = os.path.join(upload_folder, 'screenshots')
metadata_file = os.path.join(upload_folder, 'apps_metadata.json')

# Crear carpetas si no existen
for folder in [upload_folder, icons_folder, screenshots_folder]:
    if not os.path.exists(folder):
        os.makedirs(folder)


def __load_metadata():
    """Carga la metadata de las aplicaciones desde el archivo JSON"""
    if os.path.exists(metadata_file):
        try:
            with open(metadata_file, 'r', encoding='utf-8') as f:
                return json.load(f)
        except:
            return {}
    return {}


def __save_metadata(metadata):
    """Guarda la metadata de las aplicaciones en el archivo JSON"""
    with open(metadata_file, 'w', encoding='utf-8') as f:
        json.dump(metadata, f, ensure_ascii=False, indent=2)


def __clean_folder():
    """Función para limpiar toda la carpeta (solo usar cuando sea necesario)"""
    for file in os.listdir(upload_folder):
        print('[*] ELIMINANDO: {}'.format(file))
        os.remove(os.path.join(upload_folder, file))


def __get_file_info():
    """Obtiene información de todos los archivos APK en uploads con metadata"""
    metadata = __load_metadata()
    files_info = []
    
    if os.path.exists(upload_folder):
        for filename in os.listdir(upload_folder):
            if filename.lower().endswith('.apk'):
                file_path = os.path.join(upload_folder, filename)
                stat = os.stat(file_path)
                
                # Obtener metadata guardada o usar valores por defecto
                file_metadata = metadata.get(filename, {})
                
                file_info = {
                    'filename': filename,
                    'name': file_metadata.get('name', filename.replace('.apk', '')),
                    'developer': file_metadata.get('developer', 'Desarrollador Anónimo'),
                    'description': file_metadata.get('description', 'Sin descripción disponible'),
                    'category': file_metadata.get('category', 'other'),
                    'version': file_metadata.get('version', '1.0'),
                    'icon': file_metadata.get('icon', ''),
                    'screenshots': file_metadata.get('screenshots', []),
                    'size': stat.st_size,
                    'modified': datetime.fromtimestamp(stat.st_mtime).strftime('%Y-%m-%d %H:%M:%S'),
                    'upload_date': file_metadata.get('upload_date', datetime.fromtimestamp(stat.st_mtime).strftime('%Y-%m-%d %H:%M:%S')),
                    'downloads': file_metadata.get('downloads', 0),
                    'downloads_today': file_metadata.get('downloads_today', 0),
                    'downloads_week': file_metadata.get('downloads_week', 0),
                    'rating': file_metadata.get('rating', 0),
                    'download_url': request.url_root + 'download/' + filename
                }
                files_info.append(file_info)
    
    return files_info


def __file_exists(filename):
    """Verifica si un archivo ya existe"""
    return os.path.exists(os.path.join(upload_folder, filename))


def index():
    """Página principal - redirige a la tienda"""
    return store()


def upload_page():
    """Página de subida para desarrolladores"""
    return render_template('index.html')


def store():
    """Página principal de la tienda"""
    return render_template('store.html')


def app_detail(filename):
    """Página de detalle de una aplicación"""
    return render_template('app-detail.html')


def get_files():
    """Endpoint para obtener la lista de archivos existentes"""
    return jsonify(__get_file_info())


def get_apps():
    """API endpoint para obtener todas las apps (alias de get_files)"""
    return jsonify(__get_file_info())


def get_app_detail(filename):
    """API endpoint para obtener detalles de una app específica"""
    metadata = __load_metadata()
    file_path = os.path.join(upload_folder, filename)
    
    if not os.path.exists(file_path) or not filename.lower().endswith('.apk'):
        return jsonify({'error': 'App not found'}), 404
    
    stat = os.stat(file_path)
    file_metadata = metadata.get(filename, {})
    
    app_info = {
        'filename': filename,
        'name': file_metadata.get('name', filename.replace('.apk', '')),
        'developer': file_metadata.get('developer', 'Desarrollador Anónimo'),
        'description': file_metadata.get('description', 'Sin descripción disponible'),
        'category': file_metadata.get('category', 'other'),
        'version': file_metadata.get('version', '1.0'),
        'icon': file_metadata.get('icon', ''),
        'screenshots': file_metadata.get('screenshots', []),
        'size': stat.st_size,
        'modified': datetime.fromtimestamp(stat.st_mtime).strftime('%Y-%m-%d %H:%M:%S'),
        'upload_date': file_metadata.get('upload_date', datetime.fromtimestamp(stat.st_mtime).strftime('%Y-%m-%d %H:%M:%S')),
        'downloads': file_metadata.get('downloads', 0),
        'downloads_today': file_metadata.get('downloads_today', 0),
        'downloads_week': file_metadata.get('downloads_week', 0),
        'rating': file_metadata.get('rating', 0),
        'download_url': request.url_root + 'download/' + filename
    }
    
    return jsonify(app_info)


def increment_download_count(filename):
    """Incrementa el contador de descargas de una app"""
    metadata = __load_metadata()
    
    if filename not in metadata:
        metadata[filename] = {}
    
    metadata[filename]['downloads'] = metadata[filename].get('downloads', 0) + 1
    metadata[filename]['downloads_today'] = metadata[filename].get('downloads_today', 0) + 1
    metadata[filename]['downloads_week'] = metadata[filename].get('downloads_week', 0) + 1
    
    __save_metadata(metadata)
    
    return jsonify({'success': True})


def upload():
    file = request.files.get('file')
    if not file or not file.filename:
        return jsonify({'error': 'Archivo no encontrado'}), 400

    if not file.filename.lower().endswith('.apk'):
        return jsonify({'error': 'Solo se permiten archivos APK'}), 400

    filename = secure_filename(file.filename.replace(' ', '_'))
    file_path = os.path.join(upload_folder, filename)
    
    # Verificar si el archivo ya existe
    if __file_exists(filename):
        action = request.form.get('action', 'replace')
        
        if action == 'keep_both':
            name, ext = os.path.splitext(filename)
            timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
            filename = f"{name}_{timestamp}{ext}"
            file_path = os.path.join(upload_folder, filename)
        elif action == 'cancel':
            return jsonify({
                'error': 'Upload cancelled',
                'existing_file': filename
            }), 409
    
    # Guardar archivo APK
    print(f'[*] SUBIENDO: {filename}')
    file.save(file_path)
    
    # Procesar metadata
    metadata = __load_metadata()
    app_metadata = {
        'name': request.form.get('app_name', filename.replace('.apk', '')),
        'developer': request.form.get('developer', 'Desarrollador Anónimo'),
        'description': request.form.get('description', ''),
        'category': request.form.get('category', 'other'),
        'version': request.form.get('version', '1.0'),
        'upload_date': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        'downloads': 0,
        'downloads_today': 0,
        'downloads_week': 0,
        'rating': 0,
        'icon': '',
        'screenshots': []
    }
    
    # Procesar icono si se subió
    icon_file = request.files.get('icon')
    if icon_file and icon_file.filename:
        icon_filename = secure_filename(f"{filename}_{icon_file.filename}")
        icon_path = os.path.join(icons_folder, icon_filename)
        icon_file.save(icon_path)
        app_metadata['icon'] = icon_filename
        print(f'[*] ICONO GUARDADO: {icon_filename}')
    
    # Procesar screenshots si se subieron
    screenshots_files = request.files.getlist('screenshots')
    screenshot_names = []
    for i, screenshot_file in enumerate(screenshots_files[:5]):  # Máximo 5
        if screenshot_file and screenshot_file.filename:
            screenshot_filename = secure_filename(f"{filename}_screenshot_{i+1}_{screenshot_file.filename}")
            screenshot_path = os.path.join(screenshots_folder, screenshot_filename)
            screenshot_file.save(screenshot_path)
            screenshot_names.append(screenshot_filename)
            print(f'[*] SCREENSHOT GUARDADO: {screenshot_filename}')
    
    app_metadata['screenshots'] = screenshot_names
    
    # Guardar metadata
    metadata[filename] = app_metadata
    __save_metadata(metadata)
    
    url = request.url_root + 'download/' + filename
    print(f'[*] URL: {url}')
    
    return jsonify({
        'success': True,
        'filename': filename,
        'download_url': url,
        'app_info': app_metadata,
        'files': __get_file_info()
    })


def delete_file(filename):
    """Endpoint para eliminar un archivo específico"""
    file_path = os.path.join(upload_folder, filename)
    if os.path.exists(file_path):
        # Eliminar archivo APK
        os.remove(file_path)
        print(f'[*] ELIMINADO: {filename}')
        
        # Eliminar metadata y archivos relacionados
        metadata = __load_metadata()
        if filename in metadata:
            app_data = metadata[filename]
            
            # Eliminar icono
            if app_data.get('icon'):
                icon_path = os.path.join(icons_folder, app_data['icon'])
                if os.path.exists(icon_path):
                    os.remove(icon_path)
                    print(f'[*] ICONO ELIMINADO: {app_data["icon"]}')
            
            # Eliminar screenshots
            for screenshot in app_data.get('screenshots', []):
                screenshot_path = os.path.join(screenshots_folder, screenshot)
                if os.path.exists(screenshot_path):
                    os.remove(screenshot_path)
                    print(f'[*] SCREENSHOT ELIMINADO: {screenshot}')
            
            # Eliminar metadata
            del metadata[filename]
            __save_metadata(metadata)
        
        return jsonify({'success': True, 'message': f'Archivo {filename} eliminado'})
    else:
        return jsonify({'error': 'Archivo no encontrado'}), 404


def clear_all():
    """Endpoint para limpiar todos los archivos"""
    metadata = __load_metadata()
    
    # Eliminar todos los APKs
    for file in os.listdir(upload_folder):
        if file.endswith('.apk'):
            file_path = os.path.join(upload_folder, file)
            os.remove(file_path)
            print(f'[*] ELIMINANDO: {file}')
    
    # Eliminar todos los iconos
    if os.path.exists(icons_folder):
        for icon in os.listdir(icons_folder):
            icon_path = os.path.join(icons_folder, icon)
            os.remove(icon_path)
            print(f'[*] ICONO ELIMINADO: {icon}')
    
    # Eliminar todos los screenshots
    if os.path.exists(screenshots_folder):
        for screenshot in os.listdir(screenshots_folder):
            screenshot_path = os.path.join(screenshots_folder, screenshot)
            os.remove(screenshot_path)
            print(f'[*] SCREENSHOT ELIMINADO: {screenshot}')
    
    # Limpiar metadata
    __save_metadata({})
    
    return jsonify({'success': True, 'message': 'Todos los archivos eliminados'})


def download(filename):
    return send_from_directory(upload_folder, filename)


def setup_route(app: Flask):
    # Rutas principales
    app.add_url_rule('/', 'index', index)  # Página principal -> Tienda
    app.add_url_rule('/store', 'store', store)  # Tienda
    app.add_url_rule('/upload', 'upload_page', upload_page)  # Portal desarrolladores
    app.add_url_rule('/developers', 'developers', upload_page)  # Alias para desarrolladores
    app.add_url_rule('/app/<filename>', 'app_detail', app_detail)
    
    # API endpoints
    app.add_url_rule('/upload', 'upload', upload, methods=['POST'])
    app.add_url_rule('/files', 'get_files', get_files, methods=['GET'])
    app.add_url_rule('/api/apps', 'get_apps', get_apps, methods=['GET'])
    app.add_url_rule('/api/apps/<filename>', 'get_app_detail', get_app_detail, methods=['GET'])
    app.add_url_rule('/api/apps/<filename>/download', 'increment_download', increment_download_count, methods=['POST'])
    app.add_url_rule('/delete/<filename>', 'delete_file', delete_file, methods=['DELETE'])
    app.add_url_rule('/clear', 'clear_all', clear_all, methods=['POST'])
    app.add_url_rule('/download/<filename>', 'download', download)
