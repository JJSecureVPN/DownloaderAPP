# =============================================================================
# 🚀 DownloaderAPP - Script de Actualización para Windows PowerShell
# =============================================================================
# Autor: @JHServices
# Para usar en Windows con PowerShell
# =============================================================================

Write-Host "🚀 DownloaderAPP - Actualización Windows" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# Funciones de output
function Write-Success { Write-Host "✅ $args" -ForegroundColor Green }
function Write-Error { Write-Host "❌ $args" -ForegroundColor Red }
function Write-Warning { Write-Host "⚠️ $args" -ForegroundColor Yellow }
function Write-Info { Write-Host "ℹ️ $args" -ForegroundColor Blue }

# Verificar que estamos en el directorio correcto
if (-not (Test-Path "main.py")) {
    Write-Error "No estás en el directorio de DownloaderAPP"
    exit 1
}

try {
    # 1. Backup
    Write-Host "📁 Creando backup..." -ForegroundColor Magenta
    if (Test-Path "uploads") {
        $backupName = "backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        Copy-Item -Recurse "uploads" $backupName
        Write-Success "Backup creado en: $backupName"
        
        $appCount = (Get-ChildItem -Path "uploads" -Filter "*.apk" -Recurse).Count
        Write-Info "Aplicaciones respaldadas: $appCount"
    } else {
        Write-Warning "No hay datos para respaldar"
    }

    # 2. Detener servidor
    Write-Host "⏹️ Deteniendo servidor..." -ForegroundColor Magenta
    $pythonProcesses = Get-Process | Where-Object { $_.ProcessName -like "*python*" -and $_.CommandLine -like "*main.py*" }
    
    if ($pythonProcesses) {
        $pythonProcesses | Stop-Process -Force
        Start-Sleep -Seconds 2
        Write-Success "Servidor detenido"
    } else {
        Write-Info "No se encontró servidor corriendo"
    }

    # 3. Actualizar código
    Write-Host "⬇️ Actualizando código desde GitHub..." -ForegroundColor Magenta
    
    # Verificar estado de git
    $gitStatus = git status --porcelain
    if ($gitStatus) {
        Write-Warning "Hay cambios locales, creando stash..."
        git stash push -m "Auto-stash Windows update $(Get-Date)"
    }
    
    git pull origin main
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Código actualizado exitosamente"
        
        # Mostrar últimos cambios
        $commits = git log --oneline -3 --pretty=format:"   • %s"
        if ($commits) {
            Write-Info "📝 Últimos cambios:"
            $commits | ForEach-Object { Write-Host $_ -ForegroundColor Gray }
        }
    } else {
        Write-Error "Error actualizando código"
        exit 1
    }

    # 4. Verificar datos
    Write-Host "🔍 Verificando integridad de datos..." -ForegroundColor Magenta
    if (Test-Path "uploads") {
        $apkCount = (Get-ChildItem -Path "uploads" -Filter "*.apk" -Recurse).Count
        $iconCount = if (Test-Path "uploads/icons") { (Get-ChildItem -Path "uploads/icons" -Filter "*.png").Count } else { 0 }
        $screenshotCount = if (Test-Path "uploads/screenshots") { (Get-ChildItem -Path "uploads/screenshots" -Filter "*.png").Count } else { 0 }
        
        Write-Success "Datos verificados:"
        Write-Info "   📦 $apkCount aplicaciones"
        Write-Info "   🖼️ $iconCount iconos"
        Write-Info "   📸 $screenshotCount screenshots"
        
        # Verificar metadata
        if (Test-Path "uploads/apps_metadata.json") {
            try {
                $metadata = Get-Content "uploads/apps_metadata.json" | ConvertFrom-Json
                $metadataCount = ($metadata | Get-Member -MemberType NoteProperty).Count
                Write-Info "   📋 $metadataCount aplicaciones en metadata"
            } catch {
                Write-Warning "Archivo metadata JSON puede estar corrupto"
            }
        }
    } else {
        Write-Warning "No hay datos de usuarios"
    }

    # 5. Instalar dependencias
    Write-Host "📦 Instalando dependencias..." -ForegroundColor Magenta
    if (Test-Path "requirements.txt") {
        # Detectar Python
        $pythonCmd = if (Get-Command python -ErrorAction SilentlyContinue) { "python" } else { "python3" }
        
        & $pythonCmd -m pip install -r requirements.txt --quiet --disable-pip-version-check
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Dependencias actualizadas"
        } else {
            Write-Warning "Algunas dependencias pueden no haberse instalado"
        }
    }

    # 6. Iniciar servidor
    Write-Host "🚀 Iniciando servidor..." -ForegroundColor Magenta
    
    # Detectar Python
    $pythonCmd = if (Get-Command python -ErrorAction SilentlyContinue) { "python" } else { "python3" }
    
    # Iniciar en background
    Start-Process -FilePath $pythonCmd -ArgumentList "main.py", "5001" -WindowStyle Hidden -RedirectStandardOutput "server.log" -RedirectStandardError "server_error.log"
    
    Start-Sleep -Seconds 5

    # 7. Verificar servidor
    Write-Host "🔍 Verificando servidor..." -ForegroundColor Magenta
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:5001" -TimeoutSec 10 -UseBasicParsing
        if ($response.StatusCode -eq 200) {
            Write-Success "Servidor responde correctamente en puerto 5001"
            
            # Probar API
            try {
                $apiResponse = Invoke-WebRequest -Uri "http://localhost:5001/api/apps" -TimeoutSec 5 -UseBasicParsing
                Write-Success "API funciona correctamente"
            } catch {
                Write-Warning "API no responde, pero servidor está activo"
            }
        }
    } catch {
        Write-Warning "No se pudo verificar el servidor automáticamente"
        Write-Info "Verifica manualmente: http://localhost:5001"
    }

    # 8. Resumen
    Write-Host "`n" -NoNewline
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host "📊 RESUMEN DE ACTUALIZACIÓN" -ForegroundColor Cyan
    Write-Host "============================================" -ForegroundColor Cyan
    
    Write-Success "Actualización completada exitosamente"
    
    Write-Host "`n🌐 Acceso a la aplicación:" -ForegroundColor Blue
    Write-Host "   • Tienda: http://localhost:5001/" -ForegroundColor Gray
    Write-Host "   • Portal Desarrolladores: http://localhost:5001/upload" -ForegroundColor Gray
    Write-Host "   • API: http://localhost:5001/api/apps" -ForegroundColor Gray
    
    if (Test-Path "server.log") {
        Write-Host "`n🔧 Para ver logs del servidor: Get-Content server.log -Wait" -ForegroundColor Blue
    }
    
    Write-Host "`n" -NoNewline
    Write-Success "¡Todo listo! Tu aplicación está actualizada y funcionando."

} catch {
    Write-Error "Error durante la actualización: $_"
    Write-Info "Revisa los logs para más detalles"
    exit 1
}
