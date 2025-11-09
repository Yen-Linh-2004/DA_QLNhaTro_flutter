import 'package:flutter/material.dart';

class UpdateTypeRoomPage extends StatefulWidget {
  const UpdateTypeRoomPage({super.key});

  @override
  State<UpdateTypeRoomPage> createState() => _UpdateTypeRoomPage();
}

class _UpdateTypeRoomPage extends State<UpdateTypeRoomPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTypeRoomController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _changeRoomController = TextEditingController();
  final TextEditingController _discribeController = TextEditingController();
  final TextEditingController _amenitiesController = TextEditingController();
  
  @override
  void dispose() {
    _nameTypeRoomController.dispose();
    _priceController.dispose();
    _changeRoomController.dispose();
    _discribeController.dispose();
    _amenitiesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cập nhập loại phòng")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tên loại phòng",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              TextFormField(
                controller: _nameTypeRoomController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập tên loại phòng",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập tên loại phòng";
                  }
                  return null;
                },
              ),

              SizedBox(height: 12),
              Text(
                "Giá cơ bản (VNĐ)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập giá của loại phòng",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập giá của loại phòng";
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),
              Text("Diện tích", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              TextFormField(
                controller: _changeRoomController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập diện tích của loại phòng",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập diện tích của loại phòng";
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),
              Text("Mô tả", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              TextFormField(
                controller: _discribeController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập mô tả về loại phòng",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập mô tả về loại phòng";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              const Text(
                "Tiện nghi",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _amenitiesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập tiện nghi của loại phòng",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập tiện nghi của loại phòng";
                  }
                  return null;
                },
              ),
             
              SizedBox(height: 24),
              // Nút hành động
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Hủy"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final newDevice = {
                          "id": _nameTypeRoomController.text.trim(),
                          "name": _discribeController.text.trim(),
                          "price": _priceController.text.trim(),
                          "area": _changeRoomController.text.trim(),
                          "amenities": _amenitiesController.text.trim(),
                        };
                        Navigator.of(context).pop(newDevice);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "Lưu thay đổi",
                      style: TextStyle(color: Colors.white),
                    ),
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
