import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('找不到路由: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
