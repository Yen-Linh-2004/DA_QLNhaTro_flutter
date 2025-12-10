import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/UI/shared/input_field.dart';
import 'package:flutter_application/provider/CustomerProvider.dart';
import 'package:provider/provider.dart';

class CreateRepairPage extends StatefulWidget {
  const CreateRepairPage({super.key});

  @override
  State<CreateRepairPage> createState() => _CreateRepairPageState();
}

class _CreateRepairPageState extends State<CreateRepairPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _tilteController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String? selectedcatalog = "Chọn danh mục";
  String? selectedLevel = "Chọn mức độ";
  List<String> catalog = ["Chọn danh mục", "electrical", "plumbing", "appliance", "furniture", "other" ];
  final List<String> listLevel = [ "Chọn mức độ", "low", "medium", "high", "urgent" ];

  String fomatLevel(String key) {
    switch (key) {
      case 'low':
        return 'Thấp';
      case 'medium':
        return 'Trung bình';
      case 'high':
        return 'Cao';
      case 'urgent':
        return 'Khẩn cấp';
      default:
        return key;
    }
  }
  String fomatCatalog(String key) {
    switch (key) {
      case 'electrical':
        return 'Điện';
      case 'plumbing':
        return 'Hệ thống nước';
      case 'appliance':
        return 'Điện lạnh';
      case 'furniture':
        return 'Nội thất';
      case 'other':
        return 'Khác';
      default:
        return key;
    }
  }

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

  /// ---------------------- Gửi API ------------------------
  Future<void> _submitRepairRequest() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedcatalog == "Chọn danh mục") {
      return _showMessage("Vui lòng chọn danh mục");
    }

    if (selectedLevel == "Chọn mức độ") {
      return _showMessage("Vui lòng chọn mức độ ưu tiên");
    }

    final provider = Provider.of<CustomerProvider>(context, listen: false);

    final payload = {
      "TieuDe": _tilteController.text.trim(),
      "MoTa": _descriptionController.text.trim(),
      "GhiChu": _noteController.text.trim(),
      "PhanLoai": selectedcatalog,
      "MucDoUuTien": selectedLevel,
    };

    print("📤 Gửi yêu cầu tạo sửa chữa: $payload");

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Đang gửi yêu cầu...")));

    await provider.createReport(payload);

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Tạo yêu cầu thành công!")));

    Navigator.pop(context);
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tạo yêu cầu sửa chữa",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextField(
                      "Tiêu đề yêu cầu",
                      "Nhập tiêu đề yêu cầu",
                      _tilteController,
                      (value) => value!.isEmpty ? "Vui lòng nhập tiêu đề" : null,
                    ),

                    const SizedBox(height: 16),

                    Dropdown(
                      label: "Danh mục",
                      value: selectedcatalog,
                      items: catalog,
                      displayTextMapper: (value) => fomatCatalog(value),
                      onChanged: (value) => setState(() => selectedcatalog = value),
                    ),

                    const SizedBox(height: 16),

                    Dropdown(
                      label: "Mức độ ưu tiên",
                      value: selectedLevel,
                      items: listLevel,
                      displayTextMapper: (value) => fomatLevel(value),
                      onChanged: (value) => setState(() => selectedLevel = value),
                    ),

                    const SizedBox(height: 16),

                    buildContendField(
                      "Mô tả chi tiết",
                      "Mô tả chi tiết vấn đề cần sửa chữa...",
                      _descriptionController,
                      context,
                    ),

                    const SizedBox(height: 16),

                    buildContendField(
                      "Ghi chú thêm",
                      "Nhập ghi chú thêm (nếu cần)",
                      _noteController,
                      context,
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        buildActionBtn(
                          Icons.close,
                          "Hủy",
                          Colors.redAccent,
                          () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 15),
                        buildActionBtn(
                          Icons.send,
                          "Gửi yêu cầu",
                          Colors.blue,
                          _submitRepairRequest,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
