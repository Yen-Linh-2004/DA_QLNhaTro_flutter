import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/provider/LoaiPhongProvider.dart';
import 'package:provider/provider.dart';

class AddTypeRoomPage extends StatefulWidget {
  const AddTypeRoomPage({super.key});

  @override
  State<AddTypeRoomPage> createState() => _AddTypeRoomPageState();
}

class _AddTypeRoomPageState extends State<AddTypeRoomPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _area = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  final TextEditingController _amenities = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    _area.dispose();
    _desc.dispose();
    _amenities.dispose();
    super.dispose();
  }

  Future<void> _submit(BuildContext context) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final provider = context.read<LoaiPhongProvider>();

    // Tách tiện nghi
    List<String> amenList = _amenities.text
      .split(',')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();

    final price = int.tryParse(_price.text.trim());
    if (price == null || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đơn giá phải lớn hơn 0")),
      );
      return;
    }

    final payload = {
      "tenLoaiPhong": _name.text.trim(),
      "donGiaCoBan": price,
      "dienTich": int.tryParse(_area.text.trim()) ?? 0,
      "moTa": _desc.text.trim(),
      "tienNghi": amenList,
    };

    print(" PAYLOAD GỬI LÊN BACKEND: $payload");

    try {
      await provider.createLoaiPhong(payload);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("🎉 Thêm loại phòng thành công!")),
      );

      Navigator.pop(context);

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi khi tạo loại phòng: $e")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<LoaiPhongProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Thêm loại phòng mới",
                style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.blue,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          body: Stack(
            children: [
              _buildForm(context),

              if (provider.isLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(child: CircularProgressIndicator()),
                )
            ],
          ),
        );
      },
    );
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInput("Tên loại phòng", _name,
                "Nhập tên loại phòng", false),
            buildInput("Giá cơ bản (VNĐ)", _price,
                "Nhập giá", true),
            buildInput("Diện tích (m²)", _area,
                "Nhập diện tích", false),
            buildInput("Mô tả", _desc,
                "Nhập mô tả", false, maxLines: 3),
            buildInput("Tiện nghi (phân tách bằng dấu phẩy)", _amenities,
                "VD: wifi, máy lạnh, giường", false, maxLines: 3),

            const SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildActionBtn(Icons.close, "Hủy", Colors.red, () => Navigator.pop(context)),
                SizedBox(width: 10),
                buildActionBtn(Icons.add, "Thêm loại phòng", Colors.blue, () => _submit(context)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildInput(String label, TextEditingController controller, String hint, bool isNumber, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          validator: (value) => value == null || value.trim().isEmpty ? "Không được bỏ trống" : null,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hint,
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
