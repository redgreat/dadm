import 'package:dio/dio.dart';
import '../config/app_config.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late final Dio dio;

  factory ApiClient() {
    return _instance;
  }
  ApiClient._internal() {    dio = Dio(BaseOptions(      baseUrl: AppConfig.baseUrl,
      connectTimeout: Duration(milliseconds: AppConfig.connectTimeout),
      receiveTimeout: Duration(milliseconds: AppConfig.receiveTimeout),
      contentType: Headers.formUrlEncodedContentType,
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Origin': 'http://localhost:3000',
        'Access-Control-Allow-Credentials': 'true',
      },    ));

    // 正确设置 withCredentials
    dio.options.validateStatus = (status) => status! < 500;
    dio.options.followRedirects = true;
    dio.options.receiveDataWhenStatusError = true;
    
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        options.validateStatus = (status) => status! < 500;
        // 添加时间戳避免缓存
        if (options.method == 'GET') {
          options.queryParameters['_'] = DateTime.now().millisecondsSinceEpoch.toString();
        }
        
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        if (e.type == DioExceptionType.badResponse) {
          if (e.response?.statusCode == 401) {
            return handler.next(DioException(
              requestOptions: e.requestOptions,
              error: '用户未登录或登录已过期',
            ));
          }
        }
        // 处理网络相关错误
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          return handler.next(DioException(
            requestOptions: e.requestOptions,
            error: '网络连接超时，请检查网络设置',
          ));
        }
        return handler.next(e);
      },
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) {
    return dio.post(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters}) {
    return dio.put(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> delete(String path, {dynamic data, Map<String, dynamic>? queryParameters}) {
    return dio.delete(path, data: data, queryParameters: queryParameters);
  }
}
