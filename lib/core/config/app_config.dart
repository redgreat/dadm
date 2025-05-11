class AppConfig {
  static const String baseUrl = 'http://127.0.0.1:8080'; // 恢复原始API地址，通过前端CORS处理解决跨域问题
  
  // 超时设置
  static const int connectTimeout = 5000; // 毫秒
  static const int receiveTimeout = 3000; // 毫秒
  
  // 缓存设置
  static const int maxCacheAge = 7 * 24 * 60 * 60; // 7天，单位：秒
  static const int maxCacheCount = 100; // 最大缓存条目数
  
  // Token 相关
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
}
