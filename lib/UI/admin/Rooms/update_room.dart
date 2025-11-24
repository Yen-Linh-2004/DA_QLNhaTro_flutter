import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/UI/shared/input_field.dart';

class UpdateRoomPage extends StatefulWidget {
  const UpdateRoomPage({super.key});

  @override
  State<UpdateRoomPage> createState() => _UpdateRoomPageState();
}

class _UpdateRoomPageState extends State<UpdateRoomPage> {
  final _roomController = TextEditingController(text: "A101");
  final _areaController = TextEditingController(text: "20");
  final _priceController = TextEditingController(text: "350000");

  final _nameController = TextEditingController(text: "Nguyễn Văn A");
  final _birthDateController = TextEditingController(text: "20/05/1995");
  final _placeofbirthController = TextEditingController();
  final _cccdController = TextEditingController(text: "123456789");
  final _placeOfIssueController = TextEditingController();
  final _phoneOneController = TextEditingController(text: "0901234567");
  final _phoneTwoController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController(
    text: "123 Đường ABC, Quận 1, TP.HCM",
  );
  final _vehicleNumberController = TextEditingController(text: "29A1-12345");
  final _noteController = TextEditingController();
  final _decribeController = TextEditingController();
  final _amenitiesController = TextEditingController();

  final List<String> blocks = ["Dãy A", "Dãy B", "Dãy C"];
  final List<String> floors = ["Tầng 1", "Tầng 2", "Tầng 3"];
  final List<String> roomTypes = ["Phòng đơn", "Phòng đôi", "Phòng vip"];
  final List<String> status = ["Trống", "Đã thuê", "Bảo trì"];
  final List<String> gender = ["Nam", "Nữ"];

  String selectedBlock = "Dãy A";
  String? selectedFloor = "Tầng 1";
  String selectedRoomType = "Phòng đơn";
  String selectedStatus = "Đã thuê";
  String? selectedGender = "Nam";
  DateTime selectedBirthDay = DateTime(2025, 1, 1);
  DateTime selectedIssueDate = DateTime(2025, 1, 1);

  // Trạng thái các checkbox
  bool dien = true;
  bool nuoc = true;
  bool internet = true;
  bool giatSay = true;
  bool guiXe = false;
  bool donPhong = false;

  final List<Device> devices = [
    Device(
      name: "Máy lạnh Midea Inverter 1HP",
      code: "MAFA-09CDN8-P1",
      type: "Thiết bị điện",
      status: "Tốt",
      note: "",
    ),
    Device(
      name: "Router Wifi Mercusys",
      code: "MW302R-P1",
      type: "Điện tử",
      status: "Tốt",
      note: "",
    ),
    Device(
      name: "Tủ quần áo",
      code: "WD001-P1",
      type: "Nội thất",
      status: "Bình thường",
      note: "",
    ),
    Device(
      name: "Bảng nội quy",
      code: "NQ001-P1",
      type: "Khác",
      status: "Tốt",
      note: "",
    ),
  ];

  @override
  void dispose() {
    _roomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Cập nhật thông tin phòng',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            unselectedLabelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'Thông tin cơ bản'),
              Tab(text: 'Khách thuê'),
              Tab(text: 'Dịch vụ'),
              Tab(text: 'Thành viên'),
              Tab(text: 'Thiết bị'),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Thông tin cơ bản",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            "Tên phòng",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _roomController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nhập tên phòng trọ",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Vui lòng nhập tên phòng trọ";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Dãy phòng",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: selectedBlock,
                            items: blocks
                                .map(
                                  (block) => DropdownMenuItem(
                                    value: block,
                                    child: Text(block),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),

                          SizedBox(height: 16),
                          Text(
                            "Loại phòng",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: selectedRoomType,
                            items: roomTypes
                                .map(
                                  (type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(type),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Diện tích (m²)",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _areaController,
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: InputDecoration(
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
                          Text(
                            "Đơn giá cơ bản (VNĐ)",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
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
                          SizedBox(height: 16),
                          Text(
                            "Trạng thái",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: selectedStatus,
                            items: status
                                .map(
                                  (status) => DropdownMenuItem(
                                    value: status,
                                    child: Text(status),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),

                          Text(
                            "Thông tin bổ sung",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 12),
                          buildContendField(
                            "Mô tả",
                            "",
                            _decribeController,
                            context,
                          ),
                          SizedBox(height: 16),
                          buildContendField(
                            "Tiện nghi",
                            "",
                            _amenitiesController,
                            context,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Họ tên",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nhập họ tên",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Vui lòng nhập họ tên";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16),
                          Text(
                            "CCCD/CMND",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _cccdController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nhập CCCD/CMND",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Vui lòng nhập CCCD/CMND";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16),
                          Text(
                            "Số điện thoại 1",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _phoneOneController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nhập số điện thoại",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Vui lòng nhập số điện thoại";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Số điện thoại 2",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _phoneTwoController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nhập số điện thoại",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Vui lòng nhập số điện thoại";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16),
                          Text(
                            "Email",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nhập email",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Vui lòng nhập email";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16),
                          Text(
                            "Ngày sinh",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _birthDateController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nhập ngày sinh",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Vui lòng nhập ngày sinh";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16),
                          Text(
                            "Nơi sinh",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _placeofbirthController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nhập nơi sinh",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Vui lòng nhập nơi sinh";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16),
                          Text(
                            "Biển số xe",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _vehicleNumberController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nhập số xe",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Vui lòng nhập số xe";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16),
                          buildContendField(
                            "Địa chỉ thường trú",
                            "Nhập địa chỉ thường trú",
                            _addressController,
                            context,
                          ),

                          SizedBox(height: 16),
                          buildContendField(
                            "Ghi chú",
                            "",
                            _noteController,
                            context,
                          ),

                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size(0, 0),
                              ),
                              child: Text(
                                "Xóa khách thuê chính",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Wrap(
                              //   spacing: 20,
                              //   runSpacing: 10,
                              children: [
                                buildCheckbox(
                                  "Điện",
                                  dien,
                                  (value) => setState(() => dien = value!),
                                ),
                                buildCheckbox(
                                  "Nước",
                                  nuoc,
                                  (value) => setState(() => nuoc = value!),
                                ),
                                buildCheckbox(
                                  "Internet",
                                  internet,
                                  (value) => setState(() => internet = value!),
                                ),
                                buildCheckbox(
                                  "Giặt sấy",
                                  giatSay,
                                  (value) => setState(() => giatSay = value!),
                                ),
                                buildCheckbox(
                                  "Gửi xe",
                                  guiXe,
                                  (value) => setState(() => guiXe = value!),
                                ),
                                buildCheckbox(
                                  "Dọn phòng",
                                  donPhong,
                                  (value) => setState(() => donPhong = value!),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTextField("Họ tên", "", _nameController, null),

                          SizedBox(height: 16),
                          buildDatePickerField(
                            context,
                            "Ngày sinh",
                            selectedBirthDay,
                            (date) {
                              setState(() {
                                selectedBirthDay = date;
                              });
                            },
                          ),

                          SizedBox(height: 16),
                          buildTextField(
                            "Nơi sinh",
                            "",
                            _placeofbirthController,
                            null,
                          ),

                          SizedBox(height: 16),
                          buildTextField(
                            "CCCD/CMND",
                            "",
                            _cccdController,
                            null,
                          ),

                          SizedBox(height: 16),
                          buildDatePickerField(
                            context,
                            "Ngày cấp",
                            selectedIssueDate,
                            (date) {
                              setState(() {
                                selectedIssueDate = date;
                              });
                            },
                          ),

                          SizedBox(height: 16),
                          buildTextField(
                            "Nơi cấp",
                            "",
                            _placeOfIssueController,
                            null,
                          ),

                          SizedBox(height: 16),
                          buildTextField(
                            "Điện thoai 1",
                            "",
                            _phoneOneController,
                            null,
                          ),

                          SizedBox(height: 16),
                          buildTextField(
                            "Điện thoại 2",
                            "",
                            _phoneTwoController,
                            null,
                          ),

                          SizedBox(height: 16),
                          buildTextField("Email", "", _emailController, null),

                          SizedBox(height: 16),
                          buildTextField(
                            "Biến số xe",
                            "",
                            _vehicleNumberController,
                            null,
                          ),

                          SizedBox(height: 16),
                          buildContendField(
                            "Ghi chú",
                            "",
                            _noteController,
                            context,
                          ),

                          SizedBox(height: 16),
                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size(0, 0),
                              ),
                              child: Text(
                                "Xóa thành viên",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                                child: Text('Thêm thành viên'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DeviceListWidget(
                            devices: devices,
                            onDelete: (index) {
                              // Xử lý xóa thiết bị devices[index]
                            },
                            onAdd: () {
                              // Xử lý thêm thiết bị
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: [
                  buildActionBtn(
                    Icons.close,
                    "Hủy",
                    Colors.red,
                    () => Navigator.pop(context),
                  ),
                  SizedBox(width: 16),
                  buildActionBtn(Icons.add, "Lưu thay đổi", Colors.blue, () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget tạo checkbox theo nhãn
  Widget buildCheckbox(String title, bool value, Function(bool?) onChanged) {
    return SizedBox(
      width: 150,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.indigo,
          ),
          Text(title),
        ],
      ),
    );
  }
}

class Device {
  final String name;
  final String code;
  final String type;
  final String status;
  final String note;

  Device({
    required this.name,
    required this.code,
    required this.type,
    required this.status,
    required this.note,
  });
}

class DeviceListWidget extends StatelessWidget {
  final List<Device> devices;
  final void Function(int index, Device updatedDevice)? onChanged;
  final void Function(int index)? onDelete;
  final VoidCallback? onAdd;

  const DeviceListWidget({
    super.key,
    required this.devices,
    this.onChanged,
    this.onDelete,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      itemCount: devices.length + 1,
      separatorBuilder: (_, __) => SizedBox(height: 16),
      itemBuilder: (context, index) {
        if (index == devices.length) {
          return Row(
            children: [
              buildActionBtn(Icons.add, "Thêm thiết bị", Colors.blue, () {}),
            ],
          );
        }

        final device = devices[index];
        return DeviceCardEditable(
          device: device,
          onChanged: (updated) {
            if (onChanged != null) onChanged!(index, updated);
          },
          onDelete: () {
            if (onDelete != null) onDelete!(index);
          },
        );
      },
    );
  }
}

class DeviceCardEditable extends StatefulWidget {
  final Device device;
  final void Function(Device updated)? onChanged;
  final VoidCallback onDelete;

  const DeviceCardEditable({
    super.key,
    required this.device,
    this.onChanged,
    required this.onDelete,
  });

  @override
  State<DeviceCardEditable> createState() => _DeviceCardEditableState();
}

class _DeviceCardEditableState extends State<DeviceCardEditable> {
  late TextEditingController nameController;
  late TextEditingController codeController;
  late TextEditingController typeController;
  late TextEditingController statusController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.device.name);
    codeController = TextEditingController(text: widget.device.code);
    typeController = TextEditingController(text: widget.device.type);
    statusController = TextEditingController(text: widget.device.status);
    noteController = TextEditingController(text: widget.device.note);
  }

  void _onFieldChanged() {
    final updatedDevice = Device(
      name: nameController.text,
      code: codeController.text,
      type: typeController.text,
      status: statusController.text,
      note: noteController.text,
    );
    if (widget.onChanged != null) widget.onChanged!(updatedDevice);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: _buildEditableField('Tên thiết bị', nameController),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: _buildEditableField('Mã TB', codeController),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: widget.onDelete,
                child: Icon(Icons.delete_outline, color: Colors.red, size: 24),
              ),
            ],
          ),
          SizedBox(height: 12),
          // Status and note
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildEditableField('Loại', typeController),
              ),
              SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: _buildEditableField('Tình trạng', statusController),
              ),
              SizedBox(width: 12),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: _buildEditableField('Ghi chú', noteController),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
        SizedBox(height: 6),
        TextFormField(
          controller: controller,
          onChanged: (_) => _onFieldChanged(),
          maxLines: 1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            fillColor: Colors.grey.shade50,
            filled: true,
          ),
        ),
      ],
    );
  }
}
