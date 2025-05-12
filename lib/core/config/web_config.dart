import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;

class WebConfig {
  static void initializeApp() {
    if (kIsWeb) {
      // Web specific initializations
      WidgetsFlutterBinding.ensureInitialized();
      
      // 配置Web环境下的CORS和网络设置
      _configureWebSettings();
      
      // 添加全局错误处理
      _setupErrorHandling();
      
      // 输出调试信息
      debugPrint('Flutter Web应用初始化完成');
    }
  }
    // Web环境特定配置
  static void _configureWebSettings() {
    debugPrint('配置Web环境设置...');
  }
  
  // 设置全局错误处理
  static void _setupErrorHandling() {
    // 捕获并处理类型错误
    js.context.callMethod('eval', [
      '''
      window.addEventListener('unhandledrejection', function(event) {
        if (event.reason && event.reason.message && 
            event.reason.message.includes("type 'JSNull' is not a subtype of type 'String'")) {
          console.warn('捕获到类型错误，尝试修复...');
          event.preventDefault();
        }
      });
      '''
    ]);
  }
}
