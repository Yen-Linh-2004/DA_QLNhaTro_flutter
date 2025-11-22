import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';

class AddTypeRoomPage extends StatefulWidget {
  const AddTypeRoomPage({super.key});

  @override
  State<AddTypeRoomPage> createState() => _AddTypeRoomPage();
}

class _AddTypeRoomPage extends State<AddTypeRoomPage> {
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
      appBar: AppBar(
        title:  Text("Thêm loại phòng mới", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
              Text(
                "Tên loại phòng:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              TextFormField(
                controller: _nameTypeRoomController,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập tên loại phòng:",
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
                "Giá cơ bản (VNĐ):",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              TextFormField(
                controller: _priceController,
                decoration:  InputDecoration(
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
              Text("Diện tích:", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              TextFormField(
                controller: _changeRoomController,
                decoration:  InputDecoration(
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
              Text("Mô tả:", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              TextFormField(
                controller: _discribeController,
                maxLines: 3,
                decoration:  InputDecoration(
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

               SizedBox(height: 16),
               Text(
                "Tiện nghi:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
               SizedBox(height: 6),
              TextFormField(
                controller: _amenitiesController,
                maxLines: 3,
                decoration:  InputDecoration(
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
                  buildActionBtn(Icons.close, "Hủy", Colors.red, () => Navigator.pop(context)),
                  SizedBox(width: 15),
                  buildActionBtn(Icons.add, "Thêm loại phòng", Colors.blue, (){
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
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
