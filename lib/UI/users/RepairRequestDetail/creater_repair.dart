import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/UI/shared/input_field.dart';

class CreateRepairPage extends StatefulWidget {
  const CreateRepairPage({super.key}); 

  @override
  State<CreateRepairPage> createState() => _CreateRepairPageState();
}

class _CreateRepairPageState extends State<CreateRepairPage> {
  final TextEditingController _tilteController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String? selectedcatalog = "Chọn danh mục";
  String? selectedLevel = "Chọn mức độ";
  List<String> catalog = ["Chọn danh mục" ,"Điện", "Hệ thống nước", "Điện lạnh", "Khác"];
  List<String> level = ["Chọn mức độ", "Thấp", "Trung bình", "Cao"];

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
      appBar: AppBar(title: Text("Tạo yêu cầu sửa chữa", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
            buildTextField("Tiêu đề yêu cầu", "Nhập tiêu đề yêu cầu", _tilteController, null),
           
            SizedBox(height: 16),
            CustomDropdown(label: "Danh mục", value: selectedcatalog, items: catalog, onChanged: (value) => setState(() => selectedcatalog = value)),
            
            SizedBox(height: 16),
            CustomDropdown(label: "Mức độ ưu tiên", value: selectedLevel, items: level, onChanged: (value) => setState(() => selectedLevel = value)),
           
            SizedBox(height: 16),
            buildContendField("Mô tả chi tiết",  "Mô tả chi tiết vấn đề cần sửa chữa...", _descriptionController, context),
                      
            SizedBox(height: 16),
            buildContendField("Ghi chú thêm", "nhập ghi chú thêm (nếu cần)", _noteController, context),
            
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
