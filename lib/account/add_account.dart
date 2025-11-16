import 'package:flutter/material.dart';
import 'package:flutter_application/shared/buildCard.dart';
import 'package:flutter_application/shared/input_field.dart';

class AddAccountPage extends StatefulWidget {
  const AddAccountPage({super.key});

  @override
  State<AddAccountPage> createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController(text: "Nguyễn Văn Anh");
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  final List<String> listRole = ["Admin", "Quản lý", "Nhân viên", "Khách hàng"];
  final List<String> listStatus = ["Hoạt động", "Tạm khóa"];

  String? selectedRole = "Khách hàng";
  String? selectedStatus = "Hoạt động";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm tài khoản", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextField("Họ tên", "Nhập họ và tên", _nameController),
                    SizedBox(height: 12),
                    buildTextField("Email", "Nhập email", _emailController),
                    SizedBox(height: 12),
                    buildTextField(
                      "Số điện thoại",
                      "Nhập số điện thoại",
                      _phoneController,
                    ),
                    SizedBox(height: 12),
                    CustomDropdown(
                      label: "Vai trò",
                      value: selectedRole,
                      items: listRole,
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value;
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    CustomDropdown(
                      label: "Trạng thái",
                      value: selectedStatus,
                      items: listStatus,
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value;
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    buildTextField("Mật khẩu", "******", _passwordController),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildActionBtn(Icons.close, "Hủy", Colors.redAccent, () => Navigator.pop(context)),
                        SizedBox(width: 15),
                        buildActionBtn(Icons.add, "Thêm tài khoản", Colors.blue, (){}),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
