# 清理并获取依赖
#!/bin/bash

# 清理并获取依赖
flutter clean
flutter pub get

# 确保Web支持已启用
flutter config --enable-web

# 直接运行开发服务器（不构建release版本）
flutter run -d chrome --web-port=3000