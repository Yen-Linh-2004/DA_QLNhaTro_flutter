import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/shared/buildCard.dart';

class UpdateServicePage extends StatefulWidget {
  const UpdateServicePage({super.key});

  @override
  State<UpdateServicePage> createState() => _UpdateServicePageState();
}

class _UpdateServicePageState extends State<UpdateServicePage> {
  // Controllers
  final TextEditingController _serviceNameControl = TextEditingController();
  final TextEditingController _describeControl = TextEditingController();
  final TextEditingController _priceControl = TextEditingController();
  final TextEditingController _unitControl = TextEditingController();

  String? selectedcatalog = "Khác";

  List<String> catalog = ["Vệ sinh", "Giặt sấy", "Gửi xe", "Internet", "Khác"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFF6F6F8), // nền sáng tổng thể
      appBar: AppBar(
        title:  Text("Cập nhật dịch vụ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
        child: Container(
          padding:  EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset:  Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tên dịch vụ
               SizedBox(height: 10),
               Text("Tên dịch vụ", style: TextStyle(fontWeight: FontWeight.bold)),
               SizedBox(height: 6),
              TextFormField(
                controller: _serviceNameControl,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập tên dịch vụ",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập tên dịch vụ";
                  }
                  return null;
                },
              ),

               SizedBox(height: 16),
              // Mô tả
               Text("Mô tả", style: TextStyle(fontWeight: FontWeight.bold)),
               SizedBox(height: 6),
              TextFormField(
                controller: _describeControl,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập mô tả",
                ),
              ),

               SizedBox(height: 16),
              // Danh mục
               Text("Danh mục", style: TextStyle(fontWeight: FontWeight.bold)),
               SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: selectedcatalog,
                items: catalog
                    .map(
                      (catalog) => DropdownMenuItem(
                        value: catalog,
                        child: Text(catalog),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedcatalog = value; // cập nhật giá trị
                  });
                },
                decoration:  InputDecoration(border: OutlineInputBorder()),
              ),

               SizedBox(height: 16),
              // Giá
               Text("Giá (VND)", style: TextStyle(fontWeight: FontWeight.bold)),
               SizedBox(height: 6),
              TextFormField(
                controller: _priceControl,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập giá của dịch vụ",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập giá của dịch vụ";
                  }
                  return null;
                },
              ),

               SizedBox(height: 16),
              // Đơn vị
               Text("Đơn vị", style: TextStyle(fontWeight: FontWeight.bold)),
               SizedBox(height: 6),
              TextFormField(
                controller: _unitControl,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập đơn vị",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập đơn vị";
                  }
                  return null;
                },
              ),

               SizedBox(height: 24),
              // Nút hành động
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildActionBtn(Icons.close, "Hủy", Colors.red, () => Navigator.pop(context)),
                  SizedBox(width: 16),
                  buildActionBtn(Icons.update, "Lưu thay đổi", Colors.blue, (){}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
