import 'package:flutter/material.dart';
import 'package:flutter_application/shared/buildCard.dart';
import 'package:flutter_application/shared/input_field.dart';

class UpdateDevicesPage extends StatefulWidget {
  const UpdateDevicesPage({super.key});

  @override
  State<UpdateDevicesPage> createState() => _UpdateDevicesPageState();
}

class _UpdateDevicesPageState extends State<UpdateDevicesPage> {
  final _formKey = GlobalKey<FormState>();

  final _deviceIdController = TextEditingController();
  final _devicesNameController = TextEditingController();
  final _dateBuyController = TextEditingController();
  final _priceController = TextEditingController();
  final _manufacturerController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime selectedDate = DateTime(2025, 1, 1);

  String? selectedCatalog;
  String? selectedRoom;
  String? selectedFloor;
  String? selectStatus;

  final List<String> rooms = ["A101", "A102", "B101"];
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
      appBar: AppBar(title: Text("Cập nhật thiết bị")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mã thiết bị",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              TextFormField(
                controller: _deviceIdController,
                decoration: InputDecoration(
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

              SizedBox(height: 12),
              Text(
                "Tên thiết bị",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              TextFormField(
                controller: _devicesNameController,
                decoration: InputDecoration(
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

              SizedBox(height: 16),
              Text("Danh mục", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: selectedCatalog,
                items: catalog
                    .map(
                      (c) => DropdownMenuItem<String>(value: c, child: Text(c)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCatalog = value; // cập nhật giá trị đúng biến
                  });
                },
                decoration: InputDecoration(
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

              SizedBox(height: 16),
              CustomDropdown(
                label: "Dãy",
                value: selectedFloor,
                items: ["Dãy A", "Dãy B", "Dãy C"],
                onChanged: (value) {
                  setState(() {
                    selectedFloor = value;
                  });
                },
              ),

              SizedBox(height: 16),
              Text("Phòng", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: selectedRoom,
                items: rooms
                    .map(
                      (r) => DropdownMenuItem<String>(value: r, child: Text(r)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRoom = value; // gán đúng biến selectedRoom
                  });
                },
                decoration: InputDecoration(border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng chọn phòng";
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),
              buildDatePickerField(context, "Ngày mua", selectedDate, (date) {
                setState(() {
                  selectedDate = date;
                });
              }),
              SizedBox(height: 16),
              Text(
                "Giá mua (VNĐ)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
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
              SizedBox(height: 16),
              CustomDropdown(
                label: "Tình trạng",
                value: selectStatus,
                items: ["Tốt", "Bình thường", "Kém", "Hỏng"],
                onChanged: (value) {
                  setState(() {
                    selectStatus = value;
                  });
                },
              ),
              SizedBox(height: 16),
              buildTextField(
                "Hãng sản xuất",
                "Nhập hãng sản suất của thiết bị",
                _manufacturerController,
              ),
              SizedBox(height: 16),
              buildContendField("Ghi chú", "", _noteController, context),

              SizedBox(height: 24),

              // Nút hành động
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildActionBtn(
                    Icons.close,
                    "Hủy",
                    Colors.red,
                    () => Navigator.pop(context),
                  ),
                  SizedBox(width: 15),
                  buildActionBtn(
                    Icons.update,
                    "Lưu thay đổi",
                    Colors.blue,
                    () {},
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
