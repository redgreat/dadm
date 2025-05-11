class LoginRequest {
  final String loginName;
  final String password;

  LoginRequest({required this.loginName, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'loginName': loginName,
      'password': password,
    };
  }
}

class LoginResponse {
  final String alert;
  final int logined;

  LoginResponse({
    required this.alert,
    required this.logined,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    // 安全地处理可能为null的字段
    String alertMessage = '';
    if (json['Alert'] != null) {
      alertMessage = json['Alert'].toString();
    } else if (json['message'] != null) {
      alertMessage = json['message'].toString();
    }
    
    // 安全地处理logined字段
    int loginStatus = 0;
    if (json['logined'] != null) {
      if (json['logined'] is int) {
        loginStatus = json['logined'];
      } else if (json['logined'] == true) {
        loginStatus = 1;
      }
    }
    
    return LoginResponse(
      alert: alertMessage,
      logined: loginStatus,
    );
  }

  bool get isSuccess => logined == 1;
}
