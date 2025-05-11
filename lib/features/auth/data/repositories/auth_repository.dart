import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/config/app_config.dart';
import '../models/login_model.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<LoginResponse> login(String loginName, String password) async {
    try {
      // 创建登录请求
      final request = LoginRequest(loginName: loginName, password: password);
      
      // 使用ApiClient发送请求，注意ApiClient的post方法不支持options参数
      final response = await _apiClient.post(
        '/login',
        data: request.toJson(),
      );
      
      // ApiClient已经在内部配置了必要的头部和验证
      
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? e.message ?? '登录失败');
    }
  }

  Future<void> logout() async {
    try {
      await _apiClient.post('/logout');
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
