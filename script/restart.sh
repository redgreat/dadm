# 清理并获取依赖
flutter clean
flutter pub get

# 构建 web 应用
flutter config --enable-web
flutter build web --release

# 运行开发服务器
flutter run -d chrome --web-port=3000 --dart-define=FLUTTER_WEB_USE_SKIA=true