import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/shared/buildCard.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({super.key});

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  // Controllers
  final nameController = TextEditingController();
  final birthDateController = TextEditingController();
  final birthPlaceController = TextEditingController();
  final idController = TextEditingController();
  final issueDateController = TextEditingController();
  final issuePlaceController = TextEditingController();
  final phone1Controller = TextEditingController();
  final phone2Controller = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final vehicleController = TextEditingController();
  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm khách thuê mới", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
        padding: EdgeInsets.all(16),
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
            Text(
              "Địa chỉ thường trú",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập địa chỉ thường trú",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập địa chỉ thường trú";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Text("Số xe", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: vehicleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập số xe",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập số xe";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Text("Ghi chú khác", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: noteController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập ghi chú (nếu có)",
              ),
            ),

            SizedBox(height: 24),
            Row(
              children: [
                buildActionBtn(Icons.close, "Hủy", Colors.red, () => Navigator.pop(context)),
                SizedBox(width: 12),
                buildActionBtn(Icons.add, "Thêm khách thuê", Colors.blue, (){ print("Tên khách: ${nameController.text}"); }),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
