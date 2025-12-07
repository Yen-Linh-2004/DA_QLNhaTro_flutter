import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/provider/LoaiPhongProvider.dart';

class UpdateTypeRoomPage extends StatefulWidget {
  final int maLoaiPhong;               
  final String tenLoaiPhong;
  final String donGiaCoBan;
  final String dienTich;
  final String moTa;
  final List<String> tienNghi;

  const UpdateTypeRoomPage({
    super.key,
    required this.maLoaiPhong,
    required this.tenLoaiPhong,
    required this.donGiaCoBan,
    required this.dienTich,
    required this.moTa,
    required this.tienNghi,
  });

  @override
  State<UpdateTypeRoomPage> createState() => _UpdateTypeRoomPageState();
}

class _UpdateTypeRoomPageState extends State<UpdateTypeRoomPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _name;
  late TextEditingController _price;
  late TextEditingController _area;
  late TextEditingController _desc;
  late TextEditingController _amenities;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.tenLoaiPhong);
    _price = TextEditingController(text: widget.donGiaCoBan.toString());
    _area = TextEditingController(text: widget.dienTich);
    _desc = TextEditingController(text: widget.moTa);
    _amenities = TextEditingController(text: widget.tienNghi.join(", "));
  }

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

    List<String> amenList = _amenities.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final payload = {
      "TenLoaiPhong": _name.text.trim(),
      "DonGiaCoBan": int.tryParse(_price.text.trim()) ?? 0,
      "DienTich": int.tryParse(_area.text.trim()) ?? 0,
      "MoTa": _desc.text.trim(),
      "TienNghi": amenList,
    };

    try {
      await provider.updateLoaiPhong(widget.maLoaiPhong, payload);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cập nhật thành công!")),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoaiPhongProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cập nhật loại phòng",
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
            _input("Tên loại phòng", _name, false),
            _input("Giá cơ bản (VNĐ)", _price, true),
            _input("Diện tích", _area, false),
            _input("Mô tả", _desc, false, maxLines: 3),
            _input("Tiện nghi (phân tách bằng dấu phẩy)", _amenities, false,
                maxLines: 3),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _submit(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text("Lưu thay đổi", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  Widget _input(String label, TextEditingController controller, bool isNumber,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          validator: (value) =>
              value == null || value.trim().isEmpty ? "Không được bỏ trống" : null,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
