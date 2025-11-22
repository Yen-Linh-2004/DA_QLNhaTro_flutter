import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';

class UpdateRepairPage extends StatefulWidget {
  const UpdateRepairPage({super.key}); 

  @override
  State<UpdateRepairPage> createState() => _UpdateRepairPageState();
}

class _UpdateRepairPageState extends State<UpdateRepairPage> {
  final TextEditingController _tilteController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String? selectedcatalog = "Điện";
  String? selectedLevel = "Trung bình";
  List<String> catalog = ["Điện", "Hệ thống nước", "Điện lạnh", "Khác"];
  List<String> level = ["Thấp", "Trung bình", "Cao"];

  PlatformFile? selectedFile;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ["jpg", "png", "jpeg", "pdf", "doc", "docx"],
    );

    if (result != null) {
      setState(() {
        selectedFile = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chỉnh sửa yêu cầu", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
            SizedBox(height: 10),
            Text("Tiêu đề yêu cầu", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),

            TextFormField(
              controller: _tilteController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập tiêu đề yêu cầu",
              ),
            ),

            SizedBox(height: 16),
            Text("Danh mục", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),

            DropdownButtonFormField(
              value: selectedcatalog,
              items: catalog
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => selectedcatalog = value),
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),

            SizedBox(height: 16),
            Text("Mô tả chi tiết", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),

            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập mô tả chi tiết",
              ),
            ),

            SizedBox(height: 16),
            Text("Mức độ ưu tiên", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),

            DropdownButtonFormField(
              value: selectedLevel,
              items: level
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => selectedLevel = value),
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),

            SizedBox(height: 16),

            Text("Ghi chú thêm", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),

            TextFormField(
              controller: _noteController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),

            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildActionBtn(Icons.close, "Hủy", Colors.redAccent, () => Navigator.pop(context)),
                SizedBox(width: 15),
                buildActionBtn(Icons.send, "Gửi yêu cầu", Colors.blue, (){}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
