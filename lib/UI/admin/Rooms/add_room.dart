import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/UI/shared/input_field.dart';
import 'package:flutter_application/provider/PhongTroProvider.dart';
import 'package:provider/provider.dart';

class AddRoomPage extends StatefulWidget {
  const AddRoomPage({super.key});

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _roomNumberController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String? selectedBlock;
  String? selectedFloor;
  String? selectedRoomType;

  final List<String> blocks = ["Dãy A", "Dãy B", "Dãy C"];
  final List<String> floors = ["Tầng 1", "Tầng 2", "Tầng 3"];
  final List<String> roomTypes = ["Phòng đơn", "Phòng đôi", "Phòng vip"];

  @override
  void dispose() {
    _roomNumberController.dispose();
    _areaController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _onAddRoom() async {
    if (_formKey.currentState!.validate()) {
      final roomNumber = _roomNumberController.text.trim();
      final block = selectedBlock!;
      final floor = selectedFloor!;
      final roomType = selectedRoomType!;
      final area = double.parse(_areaController.text.trim());
      final price = int.parse(_priceController.text.trim());

      final provider = Provider.of<PhongTroProvider>(context, listen: false);

      await provider.createPhongTro({
        "tenPhong": roomNumber,
        "tenDay": block,
        "tang": floor,
        "loaiPhong": roomType,
        "dienTich": area,
        "donGiaCoBan": price,
      });

      if (true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Thêm phòng thành công!"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // Đóng page
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PhongTroProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thêm phòng mới",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField("Số phòng", "Nhập số phòng", _roomNumberController, (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập số phòng";
                }
                if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
                  return "Số phòng phải là số nguyên";
                }
                return null;
              }),
              const SizedBox(height: 16),

              // Dãy phòng
              const Text("Dãy phòng", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: selectedBlock,
                items: blocks.map((block) => DropdownMenuItem(value: block, child: Text(block))).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBlock = value;
                  });
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: (value) => value == null ? "Chọn dãy phòng" : null,
              ),
              const SizedBox(height: 16),

              // Loại phòng
              const Text("Loại phòng", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: selectedRoomType,
                items: roomTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRoomType = value;
                  });
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: (value) => value == null ? "Chọn loại phòng" : null,
              ),
              const SizedBox(height: 16),

              // Diện tích
              buildTextField("Diện tích", "Nhập diện tích m²", _areaController, (value) {
                if (value == null || value.trim().isEmpty) return "Vui lòng nhập diện tích";
                if (double.tryParse(value.trim()) == null) return "Diện tích không hợp lệ";
                return null;
              }),
              const SizedBox(height: 16),

              // Giá thuê
              buildTextField("Giá thuê", "Nhập giá thuê", _priceController, (value) {
                if (value == null || value.trim().isEmpty) return "Vui lòng nhập giá thuê";
                if (int.tryParse(value.trim()) == null) return "Giá thuê không hợp lệ";
                return null;
              }),
              const SizedBox(height: 24),

              // Nút hành động
              provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildActionBtn(Icons.close, "Hủy", Colors.red, () => Navigator.pop(context)),
                        const SizedBox(width: 16),
                        buildActionBtn(Icons.add, "Thêm phòng", Colors.blue, _onAddRoom),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
