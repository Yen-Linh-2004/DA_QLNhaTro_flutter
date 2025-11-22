import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';

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

  List<String> catalog = ["Vệ sinh", "Giặc sấy", "Gửi xe", "Internet", "Khác"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFF6F6F8),
      appBar: AppBar(title:  Text("Thêm dịch vụ mới", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
          padding:  EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset:  Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(height: 10),
               Text("Tên dịch vụ", style: TextStyle(fontWeight: FontWeight.bold)),
               SizedBox(height: 6),
              TextFormField(
                controller: _serviceNameControl,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập tên dịch vụ",
                ),
              ),

               SizedBox(height: 16),
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
                    selectedcatalog = value;
                  });
                },
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),

               SizedBox(height: 16),
               Text("Giá (VND)", style: TextStyle(fontWeight: FontWeight.bold)),
               SizedBox(height: 6),
              TextFormField(
                controller: _priceControl,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập giá của dịch vụ",
                ),
              ),

               SizedBox(height: 16),
               Text("Đơn vị", style: TextStyle(fontWeight: FontWeight.bold)),
               SizedBox(height: 6),
              TextFormField(
                controller: _unitControl,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập đơn vị",
                ),
              ),

               SizedBox(height: 24),
              // Nút hành động
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildActionBtn(Icons.close, "Hủy", Colors.red, () => Navigator.pop(context)),
                  SizedBox(width: 15),
                  buildActionBtn(Icons.add, "Thêm dịch vụ", Colors.blue, () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
