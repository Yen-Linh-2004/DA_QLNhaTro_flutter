import 'package:flutter/material.dart';

class AddDevicesPage extends StatefulWidget {
  const AddDevicesPage({super.key});

  @override
  State<AddDevicesPage> createState() => _AddDevicesPageState();
}

class _AddDevicesPageState extends State<AddDevicesPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _deviceIdController = TextEditingController();
  final TextEditingController _devicesNameController = TextEditingController();
  final TextEditingController _dateBuyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String? selectedCatalog; // nullable, ban đầu chưa chọn
  String? selectedRoom; // nullable, ban đầu chưa chọn

  final List<String> rooms = ["A101", "A102", "B101"];
  final List<String> status = ["Tốt", "Khá", "Kém", "Hỏng"];
  final List<String> catalog = [
    "Nội thất",
    "Thiết bị điện",
    "Điện tử",
    "An toàn",
    "Khác",
  ];

  @override
  void dispose() {
    _deviceIdController.dispose();
    _devicesNameController.dispose();
    _dateBuyController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thêm thiết bị mới")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Mã thiết bị",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _deviceIdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập mã thiết bị",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập mã thiết bị";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),
              const Text(
                "Tên thiết bị",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _devicesNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập tên của thiết bị",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập tên của thiết bị";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              const Text("Danh mục", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: selectedCatalog,
                items: catalog
                    .map(
                      (c) => DropdownMenuItem<String>(
                        value: c,
                        child: Text(c),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCatalog = value; // cập nhật giá trị đúng biến
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng chọn danh mục";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              const Text("Phòng", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: selectedRoom,
                items: rooms
                    .map(
                      (r) => DropdownMenuItem<String>(
                        value: r,
                        child: Text(r),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRoom = value; // gán đúng biến selectedRoom
                  });
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng chọn phòng";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              const Text(
                "Ngày mua",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _dateBuyController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập ngày mua vào (dd/mm/yyyy)",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập ngày mua vào";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              const Text(
                "Giá mua (VNĐ)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập giá mua",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập giá mua";
                  }
                  final number = int.tryParse(value.replaceAll(',', ''));
                  if (number == null || number <= 0) {
                    return "Giá mua không hợp lệ";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Nút hành động
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Hủy"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // xử lý thêm thiết bị
                        final newDevice = {
                          "id": _deviceIdController.text.trim(),
                          "name": _devicesNameController.text.trim(),
                          "catalog": selectedCatalog,
                          "room": selectedRoom,
                          "dateBuy": _dateBuyController.text.trim(),
                          "price": _priceController.text.trim(),
                        };
                        // TODO: lưu newDevice vào DB hoặc trả về
                        Navigator.of(context).pop(newDevice);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "Thêm Thiết bị",
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
