# Flutter Web Application Startup Script (PowerShell Version)
# Flutter Web应用启动脚本 (PowerShell版本)

# Set console encoding to UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "Starting Flutter Web Application..." -ForegroundColor Green
Write-Host "正在启动Flutter Web应用..." -ForegroundColor Green

# Clean and get dependencies
Write-Host "Cleaning project..." -ForegroundColor Yellow
Write-Host "清理项目..." -ForegroundColor Yellow
flutter clean

Write-Host "Getting dependencies..." -ForegroundColor Yellow
Write-Host "获取依赖包..." -ForegroundColor Yellow
flutter pub get

# Ensure Web support is enabled
Write-Host "Enabling Web support..." -ForegroundColor Yellow
Write-Host "启用Web支持..." -ForegroundColor Yellow
flutter config --enable-web

# Start development server
Write-Host "Starting Web server..." -ForegroundColor Cyan
Write-Host "启动Web服务器..." -ForegroundColor Cyan
flutter run -d chrome --web-port=3000

Write-Host "Completed" -ForegroundColor Green
Write-Host "完成" -ForegroundColor Green
Read-Host "Press any key to continue... (按任意键继续...)"