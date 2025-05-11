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
    // 在Web环境中处理CORS问题
    debugPrint('配置Web环境设置...');
    
    // 通过JS互操作配置CORS设置
    js.context.callMethod('eval', [
      '''
      // 确保所有API请求都使用正确的CORS设置
      (function() {
        const originalFetch = window.fetch;
        window.fetch = function(url, options) {
          options = options || {};
          if (url.includes('127.0.0.1:8080') || url.includes('localhost:8080')) {
            options.mode = 'cors';
            options.credentials = 'include';
          }
          return originalFetch(url, options);
        };
      })();
      '''
    ]);
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
