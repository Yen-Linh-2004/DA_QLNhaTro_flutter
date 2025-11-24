import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/Rooms/type_room/LoaiPhong.dart';
import 'package:flutter_application/provider/AuthProvider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _tenController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tenController,
              decoration: const InputDecoration(labelText: 'Tên đăng nhập'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Mật khẩu'),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            authProvider.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      await authProvider.login(_tenController.text.trim(), _passwordController.text.trim());

                      if (authProvider.isAuthenticated) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đăng nhập thành công')),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => TypeRoomPage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đăng nhập thất bại')),
                        );
                      }
                    },
                    child: const Text('Đăng nhập'),
                  ),
          ],
        ),
      ),
    );
  }
}
