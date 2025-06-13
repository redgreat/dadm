import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../models/login_model.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<LoginResponse> login(String loginName, String password) async {
    try {
      // 创建登录请求
      final request = LoginRequest(loginName: loginName, password: password);
        // 转换为表单格式
      final formData = {
        'loginName': loginName,
        'password': password,
      };
      
      // 发送登录请求
      final response = await _apiClient.post('/login', data: formData);
      
      // 后端返回的是数组格式，取第一个元素
      final responseData = response.data is List ? response.data[0] : response.data;
      
      return LoginResponse.fromJson(responseData);
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
