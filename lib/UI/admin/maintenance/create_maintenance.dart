import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/shared/buildCard.dart';
import 'package:flutter_application/UI/admin/shared/input_field.dart';

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

  String? selectedBlock = "Dãy A";
  String? selectRoom = "A101";
  String? selectedcatalog = "Điện";
  String? selectedLevel = "Trung bình";

  List<String> listblocks = ["Dãy A", "Dãy B", "Dãy C"];
  List<String> listrooms = ["A101", "A102", "A103"];
  List<String> listcatalog = ["Điện", "Nước", "Thiết bị", "Nội thất", "Khác"];
  List<String> listlevel = ["Thấp", "Trung bình", "Cao"];

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _discribeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "Tạo yêu cầu bảo trì mới", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Card(
              margin:  EdgeInsets.symmetric(vertical: 20),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding:  EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                       SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: CustomDropdown(
                          label: "Dãy trọ",
                          value: selectedBlock,
                          items: listblocks,
                          onChanged: (value) {
                            setState(() {
                              selectedBlock = value;
                            });
                          },
                        ),
                      ),
                       SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: CustomDropdown(
                          label: "Phòng trọ",
                          value: selectRoom,
                          items: listrooms,
                          onChanged: (value) {
                            setState(() {
                              selectRoom = value;
                            });
                          },
                        ),
                      ),
                       SizedBox(height: 16),
                      buildTextField(
                          "Người báo cáo", "Tên khách hàng", _nameController),
                       SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: CustomDropdown(
                          label: "Danh mục",
                          value: selectedcatalog,
                          items: listcatalog,
                          onChanged: (value) {
                            setState(() {
                              selectedcatalog = value;
                            });
                          },
                        ),
                      ),
                       SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: CustomDropdown(
                          label: "Mức độ ưu tiên",
                          value: selectedLevel,
                          items: listlevel,
                          onChanged: (value) {
                            setState(() {
                              selectedLevel = value;
                            });
                          },
                        ),
                      ),
                       SizedBox(height: 16),
                      buildTextField(
                          "Tiêu đề", "Mô tả ngắn gọn vấn đề", _titleController),
                       SizedBox(height: 16),
                      buildContendField("Mô tả",
                          "Mô tả chi tiết vấn đề cần sửa chữa...", _discribeController, context),
                       SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: buildActionBtn(Icons.close, "Hủy", Colors.red, () {}),
                          ),
                           SizedBox(width: 16),
                          Expanded(
                            child: buildActionBtn(Icons.add, "Tạo yêu cầu", Colors.blue, () {}),
                          ),
                        ],
                      ),
                       SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
