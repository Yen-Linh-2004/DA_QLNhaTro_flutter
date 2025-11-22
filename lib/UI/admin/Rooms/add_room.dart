import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/UI/shared/input_field.dart';
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

  String? selectedBlock = "Dãy A";
  String? selectedFloor = "Tầng 1";
  String? selectedRoomType = "Phòng đơn";

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

  void _onAddRoom() {
    if (_formKey.currentState!.validate()) {
      final roomNumber = _roomNumberController.text.trim();
      final block = selectedBlock!;
      final floor = selectedFloor!;
      final roomType = selectedRoomType!;
      final area = double.parse(_areaController.text.trim());
      final price = int.parse(_priceController.text.trim());

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:  Text("Thêm phòng thành công"),
          content: Text(
              "Phòng $roomNumber đã được thêm vào $block, $floor, loại $roomType, diện tích $area m², giá thuê $price VNĐ."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop();
                Navigator.of(context)
                    .pop();
              },
              child:  Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm phòng mới", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
        padding:  EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField("Số phòng", "Nhập số phòng", _roomNumberController, (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập số phòng";
                }
                // Kiểm tra số hợp lệ (chỉ cho phép số)
                if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
                  return "Số phòng phải là số nguyên";
                }
                return null;
              }),
              SizedBox(height: 16),
              buildTextField("Phòng", "Nhập tên phòng", _roomNumberController, null),
             
              SizedBox(height: 16),
              // Dãy phòng
              Text("Dãy phòng", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: selectedBlock,
                items: blocks
                    .map((block) => DropdownMenuItem(
                          value: block,
                          child: Text(block),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBlock = value;
                  });
                },
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 16),
              // Tầng
              Text("Tầng", style: TextStyle(fontWeight: FontWeight.bold)),
               SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: selectedFloor,
                items: floors
                    .map((floor) => DropdownMenuItem(
                          value: floor,
                          child: Text(floor),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedFloor = value;
                  });
                },
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),

               SizedBox(height: 16),
              // Loại phòng
               Text(
                "Loại phòng",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
               SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: selectedRoomType,
                items: roomTypes
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRoomType = value;
                  });
                },
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),

               SizedBox(height: 16),
              // Diện tích
               Text(
                "Diện tích (m²)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
               SizedBox(height: 6),
              TextFormField(
                controller: _areaController,
                keyboardType:
                     TextInputType.numberWithOptions(decimal: true),
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập diện tích",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập diện tích";
                  }
                  final number = double.tryParse(value);
                  if (number == null || number <= 0) {
                    return "Diện tích không hợp lệ";
                  }
                  return null;
                },
              ),
               SizedBox(height: 16),
              // Giá thuê
               Text(
                "Giá thuê (VNĐ)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
               SizedBox(height: 6),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập giá thuê",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập giá thuê";
                  }
                  final number = int.tryParse(value);
                  if (number == null || number <= 0) {
                    return "Giá thuê không hợp lệ";
                  }
                  return null;
                },
              ),

              SizedBox(height: 24),

              // Nút hành động
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildActionBtn(Icons.close, "Hủy", Colors.red, () => Navigator.pop(context)),
                  SizedBox(width: 16),
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
