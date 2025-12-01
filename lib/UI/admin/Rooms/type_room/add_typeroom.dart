import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/provider/loaiPhongProvider.dart';
import 'package:provider/provider.dart';

class AddTypeRoomPage extends StatefulWidget {
  const AddTypeRoomPage({super.key});

  @override
  State<AddTypeRoomPage> createState() => _AddTypeRoomPage();
}

class _AddTypeRoomPage extends State<AddTypeRoomPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTypeRoomController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _discribeController = TextEditingController();
  final TextEditingController _amenitiesController = TextEditingController();

  @override
  void dispose() {
    _nameTypeRoomController.dispose();
    _priceController.dispose();
    _areaController.dispose();
    _discribeController.dispose();
    _amenitiesController.dispose();
    super.dispose();
  }

  Future<void> _submitForm(BuildContext context) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final newLoaiPhong = {
      "name": _nameTypeRoomController.text.trim(),
      "price": int.tryParse(_priceController.text.trim()) ?? 0,
      "area": _areaController.text.trim(),
      "description": _discribeController.text.trim(),
      "amenities": _amenitiesController.text.trim(),
    };

    final provider = Provider.of<LoaiPhongProvider>(context, listen: false);

    try {
      await provider.createLoaiPhong(newLoaiPhong);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Thêm loại phòng thành công!")),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lỗi: Không thể thêm loại phòng!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thêm loại phòng mới",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      /// Dùng Consumer → KHÔNG BAO GIỜ LỖI provider not found
      body: Consumer<LoaiPhongProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              _buildFormContent(context),
              if (provider.isLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFormContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Tên loại phòng:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextFormField(
              controller: _nameTypeRoomController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập tên loại phòng",
              ),
              validator: (value) =>
                  value == null || value.trim().isEmpty ? "Vui lòng nhập tên loại phòng" : null,
            ),
            const SizedBox(height: 12),

            const Text("Giá cơ bản (VNĐ):", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập giá của loại phòng",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập giá của loại phòng";
                }
                if (int.tryParse(value.trim()) == null) {
                  return "Giá phải là số hợp lệ";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),
            const Text("Diện tích:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextFormField(
              controller: _areaController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập diện tích loại phòng",
              ),
              validator: (value) =>
                  value == null || value.trim().isEmpty ? "Vui lòng nhập diện tích" : null,
            ),

            const SizedBox(height: 16),
            const Text("Mô tả:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextFormField(
              controller: _discribeController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập mô tả về loại phòng",
              ),
              validator: (value) =>
                  value == null || value.trim().isEmpty ? "Vui lòng nhập mô tả" : null,
            ),

            const SizedBox(height: 16),
            const Text("Tiện nghi:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextFormField(
              controller: _amenitiesController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập tiện nghi của loại phòng",
              ),
              validator: (value) =>
                  value == null || value.trim().isEmpty ? "Vui lòng nhập tiện nghi" : null,
            ),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildActionBtn(Icons.close, "Hủy", Colors.red, () => Navigator.pop(context)),
                const SizedBox(width: 15),
                buildActionBtn(Icons.add, "Thêm loại phòng", Colors.blue, () {
                  _submitForm(context);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
