import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/input_field.dart';
import 'package:flutter_application/provider/CustomerProvider.dart';
import 'package:provider/provider.dart';

class UpdateRepairPage extends StatefulWidget {
  final int reportId;

  const UpdateRepairPage({super.key, required this.reportId});

  @override
  State<UpdateRepairPage> createState() => _UpdateRepairPageState();
}

class _UpdateRepairPageState extends State<UpdateRepairPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String? selectedCatalog;
  String? selectedLevel;
  List<String> catalog = ["Chọn danh mục", "electrical", "plumbing", "appliance", "furniture", "other" ];
  final List<String> level = [ "Chọn mức độ", "low", "medium", "high", "urgent" ];

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

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  void _loadDetail() {
    Future.microtask(() async {
      final provider = Provider.of<CustomerProvider>(context, listen: false);
      await provider.fetchMaintainerRequestById(widget.reportId);
      final detail = provider.maintenancedetail;
      if (detail != null) {
        _titleController.text = detail.tieuDe ?? "";
        _descriptionController.text = detail.moTa ?? "";
        _noteController.text = detail.ghiChu ?? "";

        selectedCatalog = catalog.contains(detail.phanLoai) ? detail.phanLoai : catalog.first;
        selectedLevel = level.contains(detail.mucDoUuTien) ? detail.mucDoUuTien : level.first;

        setState(() {});
      }
    });
  }

  Future<void> _submitUpdate() async {
    final payload = {
      "TieuDe": _titleController.text,
      "MoTa": _descriptionController.text,
      "GhiChu": _noteController.text,
      "PhanLoai": selectedCatalog,
      "MucDoUuTien": selectedLevel,
    };

    final provider = Provider.of<CustomerProvider>(context, listen: false);

    try {
      await provider.updateReport(widget.reportId, payload);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Cập nhật thành công")));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Lỗi: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chỉnh sửa yêu cầu"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<CustomerProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingdetail) {
            return const Center(child: CircularProgressIndicator());
          }

          final detail = provider.maintenancedetail;
          if (detail == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Không thể tải dữ liệu"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _loadDetail,
                    child: const Text("Thử lại"),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField("Tiêu đề yêu cầu", _titleController, "Nhập tiêu đề"),
                const SizedBox(height: 16),

                Dropdown(
                  label: "Danh mục",
                  value: selectedCatalog,
                  items: catalog,
                  displayTextMapper: (value) => fomatCatalog(value),
                  onChanged: (value) => setState(() => selectedCatalog = value),
                ),

                const SizedBox(height: 16),

                Dropdown(
                  label: "Mức độ ưu tiên",
                  value: selectedLevel,
                  items: level,
                  displayTextMapper: (value) => fomatLevel(value),
                  onChanged: (value) => setState(() => selectedLevel = value),
                ),
                const SizedBox(height: 16),

                _buildTextField("Ghi chú thêm", _noteController, "Nhập ghi chú", maxLines: 2),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                        child: _buildActionButton(Icons.close, "Hủy", Colors.redAccent,
                            () => Navigator.pop(context))),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _buildActionButton(Icons.send, "Cập nhật", Colors.blue,
                            _submitUpdate)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String hint,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hint,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        backgroundColor: color,
      ),
    );
  }
}
