import 'package:flutter/material.dart';

class AddServicePage extends StatefulWidget {
  const AddServicePage({super.key});

  @override
  State<AddServicePage> createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  // Controllers
  final TextEditingController _serviceNameControl = TextEditingController();
  final TextEditingController _describeControl = TextEditingController();
  final TextEditingController _priceControl = TextEditingController();
  final TextEditingController _unitControl = TextEditingController();

  String? selectedcatalog = "Khác";

  List<String> catalog = ["Vệ sinh", "Giặc sấy", "Gửi xe", "Interner", "Khác"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm dịch vụ mới"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text("Tên dịch vụ", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: _serviceNameControl,
              decoration: InputDecoration(
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
            Text("Mô tả", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: _describeControl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập mô tả",
              ),
            ),

            SizedBox(height: 16),
            Text("danh mục", style: TextStyle(fontWeight: FontWeight.bold)),
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
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),

            SizedBox(height: 16),
            Text("Giá (VND)", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: _priceControl,
              decoration: InputDecoration(
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
            Text("Đơn vị", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: _unitControl,
              decoration: InputDecoration(
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

            SizedBox(height: 16),
             // Nút hành động
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Hủy"),
                  ),
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text("Thêm dịch vụ", style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
