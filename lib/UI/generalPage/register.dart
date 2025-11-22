import 'package:flutter/material.dart';
import 'package:flutter_application/UI/generalPage/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEFF6FF), Color(0xFFE0E7FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Nút quay về
            Positioned(
              top: 40,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children:  [
                    Icon(Icons.arrow_back, color: Colors.blue),
                    SizedBox(width: 6),
                    Text(
                      "Về trang chủ",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Center(
              child: SingleChildScrollView(
                padding:  EdgeInsets.all(20),
                child: Container(
                  padding:  EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow:  [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Icon + Tiêu đề
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child:  Icon(
                          Icons.person_add,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Tạo tài khoản",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Đăng ký tài khoản quản lý phòng trọ",
                        style: TextStyle(color: Colors.black54),
                      ),
                      SizedBox(height: 24),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            buildInput(
                              title: "Họ và tên",
                              icon: Icons.person,
                              controller: fullName,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Vui lòng nhập họ và tên";
                                }
                                if (value.trim().length < 2) {
                                  return "Họ và tên phải ít nhất 2 ký tự";
                                }
                                return null;
                              },
                            ),
                             SizedBox(height: 18),

                            buildInput(
                              title: "Email",
                              icon: Icons.email,
                              controller: email,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Vui lòng nhập email";
                                }
                                final emailRegex = RegExp(
                                  r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
                                );
                                if (!emailRegex.hasMatch(value)) {
                                  return "Email không hợp lệ";
                                }
                                return null;
                              },
                            ),
                             SizedBox(height: 18),

                            buildInput(
                              title: "Số điện thoại",
                              icon: Icons.phone,
                              controller: phone,
                              validator: (value) {
                                final phoneRegex = RegExp(r'^[0-9]{10,11}$');
                                if (value == null || value.isEmpty) {
                                  return "Vui lòng nhập số điện thoại";
                                }
                                if (!phoneRegex.hasMatch(value)) {
                                  return "Số điện thoại không hợp lệ";
                                }
                                return null;
                              },
                            ),
                             SizedBox(height: 18),

                            buildInput(
                              title: "Mật khẩu",
                              icon: Icons.lock,
                              obscureText: true,
                              controller: password,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Vui lòng nhập mật khẩu";
                                }
                                if (value.length < 6) {
                                  return "Mật khẩu phải ít nhất 6 ký tự";
                                }
                                return null;
                              },
                            ),
                             SizedBox(height: 18),

                            buildInput(
                              title: "Xác nhận mật khẩu",
                              icon: Icons.lock,
                              obscureText: true,
                              controller: confirmPassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Vui lòng nhập lại mật khẩu";
                                }
                                if (value != password.text) {
                                  return "Mật khẩu xác nhận không khớp";
                                }
                                return null;
                              },
                            ),
                             SizedBox(height: 24),

                            // Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding:  EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    print("Register: ");
                                    print(fullName.text);
                                    print(email.text);
                                    print(phone.text);
                                    print(password.text);
                                  }
                                },
                                child:  Text(
                                  "Đăng ký",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                       SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text("Đã có tài khoản? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  LoginPage(),
                                ),
                              );
                            },
                            child:  Text(
                              "Đăng nhập ngay",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:  TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
         SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey),

            // ✅ SET NỀN TRẮNG
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
              borderSide:  BorderSide(color: Colors.blue, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
