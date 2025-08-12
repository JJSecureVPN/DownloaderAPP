@echo off
echo Deteniendo servidor anterior...
taskkill /f /im python.exe 2>nul

echo Iniciando servidor en puerto 5001...
cd /d "c:\Users\JHServices\Documents\Clientes\DownloaderPage-master"
start "DownloaderAPP Server" C:/Python313/python.exe main.py 5001

echo Servidor iniciado! 
echo Accede a: http://localhost:5001
echo.
echo Presiona cualquier tecla para cerrar...
pause >nul
