@echo off
echo 正在启动Flutter Web应用...

REM 清理并获取依赖
call flutter clean
call flutter pub get

REM 确保Web支持已启用
call flutter config --enable-web

REM 直接运行开发服务器
echo 启动Web服务器...
call flutter run -d chrome --web-port=3000

echo 完成
pause