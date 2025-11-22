import 'package:flutter/material.dart';
import 'package:flutter_application/UI/generalPage/login.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();

    return Scaffold(
      backgroundColor:  Color(0xFFF3F4FF),
      body: Center(
        child: SingleChildScrollView(
          padding:  EdgeInsets.all(16.0),
          child: Container(
            width: 400,
            padding:  EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset:  Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  padding:  EdgeInsets.all(16),
                  decoration:  BoxDecoration(
                    color: Color(0xFF4F46E5),
                    shape: BoxShape.circle,
                  ),
                  child:  Icon(
                    Icons.lock_outline,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                 SizedBox(height: 16),

                // Title
                 Text(
                  "Quên mật khẩu?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                 SizedBox(height: 8),

                 Text(
                  "Nhập email để nhận hướng dẫn khôi phục mật khẩu",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),

                SizedBox(height: 24),

                Form(
                  key: formKey,
                  child: buildInput(
                    title: "Địa chỉ email",
                    icon: Icons.email,
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Vui lòng nhập địa chỉ email";
                      }
                      final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
                      if (!emailRegex.hasMatch(value)) {
                        return "Email không hợp lệ";
                      }
                      return null;
                    },
                  ), 
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Chúng tôi sẽ gửi link khôi phục mật khẩu đến email này",
                    style: TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                ),
                SizedBox(height: 24),

                // Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4F46E5),
                      padding: EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                          print("Register: ");
                          print(emailController.text);
                        }
                    },
                    child: Text(
                      "Gửi email khôi phục",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // Đăng nhập ngay
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Nhớ lại mật khẩu? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        "Đăng nhập ngay",
                        style: TextStyle(
                          color: Color(0xFF4F46E5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),
                Divider(),
                SizedBox(height: 12),

                // Hỗ trợ
                Column(
                  children: [
                    Text(
                      "Cần hỗ trợ?",
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone, color: Color(0xFF4F46E5), size: 18),
                        SizedBox(width: 4),
                        Text(
                          "Hotline",
                          style: TextStyle(color: Color(0xFF4F46E5)),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.email, color: Color(0xFF4F46E5), size: 18),
                        SizedBox(width: 4),
                        Text(
                          "Email hỗ trợ",
                          style: TextStyle(color: Color(0xFF4F46E5)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
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
            filled: true,
            fillColor: Colors.white,
            hintText: "Nhập email đã đăng ký",
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
