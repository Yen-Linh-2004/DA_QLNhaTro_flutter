import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text("Chỉnh sửa yêu cầu")),
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

            // Column(
            //   children: [
            //     ElevatedButton.icon(
            //       onPressed: pickFile,
            //       icon: Icon(Icons.attach_file),
            //       label: Text("Chọn file"),
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.indigo,
            //         foregroundColor: Colors.white,
            //         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //       ),
            //     ),
            //     SizedBox(height: 10),
            //     if (selectedFile != null)
            //       Container(
            //         padding: EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //           border: Border.all(color: Colors.grey.shade300),
            //           borderRadius: BorderRadius.circular(10),
            //           color: Colors.grey.shade100,
            //         ),
            //         child: Row(
            //           children: [
            //             Icon(Icons.insert_drive_file, color: Colors.indigo),
            //             SizedBox(width: 8),
            //             Expanded(
            //               child: Text(
            //                 selectedFile!.name,
            //                 overflow: TextOverflow.ellipsis,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //   ],
            // ),

            // SizedBox(height: 16),
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
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Hủy"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text("Gửi yêu cầu", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
