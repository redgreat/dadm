import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_bloc_state.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../data/repositories/auth_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _loginNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository: AuthRepository()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthAuthenticated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                  Navigator.pushReplacementNamed(context, '/');
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Icon(
                                Icons.account_circle,
                                size: 100,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(height: 32),
                              Text(
                                'EADM 系统登录',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 32),
                              CustomTextField(
                                controller: _loginNameController,
                                labelText: '用户名',
                                prefixIcon: const Icon(Icons.person),
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '请输入用户名';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                controller: _passwordController,
                                labelText: '密码',
                                obscureText: _obscurePassword,
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                textInputAction: TextInputAction.done,
                                onSubmitted: (_) => _handleLogin(context),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '请输入密码';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                                  ),
                                  const Text('记住我'),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      // TODO: 实现忘记密码功能
                                    },
                                    child: const Text('忘记密码？'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: state is AuthLoading
                                      ? null
                                      : () => _handleLogin(context),
                                  child: state is AuthLoading
                                      ? const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(),
                                        )
                                      : const Text(
                                          '登录',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _handleLogin(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            LoginButtonPressed(
              loginName: _loginNameController.text,
              password: _passwordController.text,
            ),
          );
    }
  }
}
