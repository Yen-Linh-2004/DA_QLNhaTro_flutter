import 'package:flutter/material.dart';
import 'package:flutter_application/shared/buildCard.dart';
import 'package:flutter_application/shared/input_field.dart';

class AddMaintenancePage extends StatefulWidget {
  const AddMaintenancePage({super.key});

  @override
  State<AddMaintenancePage> createState() => _AddMaintenancePageState();
}

class _AddMaintenancePageState extends State<AddMaintenancePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController(text: "Nguyễn Văn Anh");
  final _titleController = TextEditingController();
  final _discribeController = TextEditingController();

  String? selectedBlock= "Dãy A";
  String? selectedStatus = "Hoạt động";
  String? selectRoom = "A101";
  String? selectedcatalog = "Điện";
  String? selectedLevel = "Trung bình";

  List<String> listblocks = ["Dãy A", "Dãy B", "Dãy C"];
  List<String> listrooms = ["A101", "A102", "A103"];
  List<String> listcatalog = ["Điện", "Nước", "Thiết bị","Nội thất", "Khác"];
  List<String> listlevel = ["Thấp", "Trung bình", "Cao"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tạo yêu cầu bảo trì mới", style: TextStyle(fontWeight: FontWeight.bold)),
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
                    CustomDropdown(
                      label: "Dãy trọ",
                      value: selectedBlock,
                      items: listblocks,
                      onChanged: (value) {
                        setState(() {
                          selectedBlock = value;
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    CustomDropdown(
                      label: "Phòng trọ",
                      value: selectRoom,
                      items: listrooms,
                      onChanged: (value) {
                        setState(() {
                          selectRoom = value;
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    buildTextField("Người báo cáo", "Tên khách hàng", _nameController),
                    SizedBox(height: 12),
                    CustomDropdown(
                      label: "Danh mục",
                      value: selectedcatalog,
                      items: listcatalog,
                      onChanged: (value) {
                        setState(() {
                          selectedcatalog = value;
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    CustomDropdown(
                      label: "Mức độ ưu tiên",
                      value: selectedLevel,
                      items: listlevel,
                      onChanged: (value) {
                        setState(() {
                          selectedLevel = value;
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    buildTextField("Tiêu đề", "Mô tả ngắn gọn vấn đề", _titleController),
                    SizedBox(height: 12),
                    buildContendField("Mô tả",  "Mô tả chi tiết vấn đề cần sửa chữa...", _discribeController, context),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        buildActionBtn(Icons.close, "Hủy", Colors.red, (){}),
                        SizedBox(width: 10),
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
