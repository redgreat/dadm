import 'package:dio/dio.dart';
import '../config/app_config.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late final Dio dio;

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: Duration(milliseconds: AppConfig.connectTimeout),
      receiveTimeout: Duration(milliseconds: AppConfig.receiveTimeout),
      headers: {
        'Accept': '*/*',
        'Accept-Language': 'zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2',
        'Content-Type': 'application/json; charset=UTF-8',
        'X-Requested-With': 'XMLHttpRequest',
        // 客户端不应设置CORS头部，这些应由服务器设置
      },
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ));

    // 添加拦截器
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // 处理 CORS 预检请求
        if (options.method == 'OPTIONS') {
          return handler.resolve(Response(
            requestOptions: options,
            statusCode: 200,
          ));
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        if (e.type == DioExceptionType.badResponse) {
          if (e.response?.statusCode == 401) {
            // 处理未授权错误
            return handler.next(DioException(
              requestOptions: e.requestOptions,
              error: '用户未登录或登录已过期',
            ));
          } else if (e.response?.statusCode == 403) {
            return handler.next(DioException(
              requestOptions: e.requestOptions,
              error: '没有访问权限',
            ));
          }
        } else if (e.type == DioExceptionType.connectionTimeout) {
          return handler.next(DioException(
            requestOptions: e.requestOptions,
            error: '连接超时，请检查网络',
          ));
        } else if (e.type == DioExceptionType.connectionError) {
          return handler.next(DioException(
            requestOptions: e.requestOptions,
            error: '无法连接到服务器，请检查网络或服务器是否正常',
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
