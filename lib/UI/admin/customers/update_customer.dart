import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/UI/shared/input_field.dart';

class UpdateCustomerPage extends StatefulWidget {
  const UpdateCustomerPage({super.key});

  @override
  State<UpdateCustomerPage> createState() => _UpdateCustomerPageState();
}

class _UpdateCustomerPageState extends State<UpdateCustomerPage> {
  // Controllers
  final nameController = TextEditingController(text: "Nguyễn Văn A");
  final birthDateController = TextEditingController(text: "01/01/1990");
  final birthPlaceController = TextEditingController(text: "Hồ Chí Minh");
  final idController = TextEditingController(text: "123456789");
  final issueDateController = TextEditingController(text: "01/01/2010");
  final issuePlaceController = TextEditingController(text: "Bộ Công An");
  final phone1Controller = TextEditingController(text: "0901234567");
  final phone2Controller = TextEditingController(text: "0987654321");
  final emailController = TextEditingController(text: "nguyenvana@gmail.com");
  final addressController = TextEditingController(text: "123 Đường ABC, Quận 1");
  final vehicleController = TextEditingController(text: "29A-12345");
  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Cập nhật thông tin khách thuê", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Thông tin cá nhân",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Họ tên", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập họ tên",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập họ tên";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Text("Ngày sinh", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: birthDateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập ngày sinh",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập ngày sinh";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Text("Nơi sinh", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: birthPlaceController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập nơi sinh",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập nơi sinh";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Text("CCCD/CMND", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: idController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập CCCD/CMND",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập CCCD/CMND";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Text("Ngày cấp", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: issueDateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập ngày cấp",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập ngày cấp";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Text("Nơi cấp", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: issuePlaceController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập nơi cấp",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập nơi cấp";
                }
                return null;
              },
            ),
             SizedBox(height: 20),

            Text(
              "Thông tin liên hệ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Số điện thoại 1",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            TextFormField(
              controller: phone1Controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập số điện thoại",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập số điện thoại";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Text(
              "Số điện thoại 2",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            TextFormField(
              controller: phone2Controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập số điện thoại",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập số điện thoại";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập email",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập email";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            buildContendField("Địa chỉ thường trú", "", addressController, context),

            SizedBox(height: 16),
            Text("Biển số xe", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: vehicleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập biện số xe",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập biện số xe";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            buildContendField("Ghi chú khác", "Nhập ghi chú (nếu cần)", noteController, context),

            SizedBox(height: 24),
            Row(
              children: [
                buildActionBtn(Icons.close,"Hủy", Colors.red, () => Navigator.pop(context)),
                SizedBox(width: 16),
                buildActionBtn(Icons.save, "Lưu thay đổi", Colors.blue, () {}),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

}
