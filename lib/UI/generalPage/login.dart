import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/main_page.dart';
import 'package:flutter_application/UI/generalPage/forgot_password.dart';
import 'package:flutter_application/UI/users/usemain.dart';
import 'package:flutter_application/provider/AuthProvider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _tenController = TextEditingController();
  final _passwordController = TextEditingController();
  bool rememberMe = false;

  void _submitLogin() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.login(
        _tenController.text.trim(),
        _passwordController.text.trim(),
      );

      if (authProvider.isAuthenticated) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Đăng nhập thành công')));
        Navigator.pushReplacement(
          context,
          // MaterialPageRoute(builder: (_) => MainPage()),
          MaterialPageRoute(builder: (_) => TenantHomePage()),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Đăng nhập thất bại')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            width: 400,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock_outline, size: 64, color: Colors.blue),
                  const SizedBox(height: 12),
                  const Text("Quản lý phòng trọ",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text("Đăng nhập vào hệ thống"),
                  const SizedBox(height: 32),
                  // Username
                  buildInput(
                    title: "Tên đăng nhập",
                    icon: Icons.person,
                    controller: _tenController,
                    validator: (value) =>
                        value == null || value.isEmpty ? "Vui lòng nhập tên đăng nhập" : null,
                    onFieldSubmitted: (_) => _submitLogin(), // Enter key
                  ),
                  const SizedBox(height: 16),
                  // Password
                  buildInput(
                    title: "Mật khẩu",
                    icon: Icons.lock,
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Vui lòng nhập mật khẩu";
                      if (value.length < 6) return "Mật khẩu ít nhất 6 ký tự";
                      return null;
                    },
                    onFieldSubmitted: (_) => _submitLogin(),
                  ),
                  const SizedBox(height: 4),
                  // Remember + Forgot
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() => rememberMe = value ?? false);
                            },
                          ),
                          const Text("Ghi nhớ đăng nhập",
                              style: TextStyle(fontSize: 11, color: Colors.black45)),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: const Text('Quên mật khẩu?', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: authProvider.isLoading ? null : _submitLogin,
                      child: authProvider.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Đăng nhập",
                              style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Chưa có tài khoản? "),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(builder: (_) => const RegisterPage()),
                      //     );
                      //   },
                      //   child: const Text("Đăng ký ngay", style: TextStyle(color: Colors.blue)),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInput({
    required String title,
    required IconData icon,
    required TextEditingController controller,
    String? Function(String?)? validator,
    bool obscureText = false,
    void Function(String)? onFieldSubmitted,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
