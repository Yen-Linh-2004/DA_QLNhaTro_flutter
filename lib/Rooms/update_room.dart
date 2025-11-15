import 'package:flutter/material.dart';
import 'package:flutter_application/shared/buildCard.dart';

class UpdateRoomPage extends StatefulWidget {
  const UpdateRoomPage({super.key});

  @override
  State<UpdateRoomPage> createState() => _UpdateRoomPageState();
}

class _UpdateRoomPageState extends State<UpdateRoomPage> {
  final TextEditingController _roomController = TextEditingController(
    text: "A101",
  );
  final TextEditingController _areaController = TextEditingController(
    text: "20",
  );
  final TextEditingController _priceController = TextEditingController(
    text: "350000",
  );

  final TextEditingController _nameController = TextEditingController(
    text: "Nguyễn Văn A",
  );
  final TextEditingController _birthDateController = TextEditingController(
    text: "20/05/1995",
  );
  final TextEditingController _placeofbirthController = TextEditingController();
  final TextEditingController _cccdController = TextEditingController(
    text: "123456789",
  );
  final TextEditingController _dateOfIssueController = TextEditingController();
  final TextEditingController _placeOfIssueController = TextEditingController();
  final TextEditingController _phoneOneController = TextEditingController(
    text: "0901234567",
  );
  final TextEditingController _phoneTwoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController(
    text: "123 Đường ABC, Quận 1, TP.HCM",
  );
  final TextEditingController _vehicleNumberController = TextEditingController(
    text: "29A1-12345",
  );
  final TextEditingController _noteController = TextEditingController();

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

  // Trạng thái các checkbox
  bool dien = true;
  bool nuoc = true;
  bool internet = true;
  bool giatSay = true;
  bool guiXe = false;
  bool donPhong = false;

  @override
  void dispose() {
    _roomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Cập nhật thông tin phòng'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          bottom:  TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            indicatorWeight: 2.5,
            labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            tabs: [
              Tab(text: 'Thông tin cơ bản'),
              Tab(text: 'Khách thuê'),
              Tab(text: 'Dịch vụ'),
              Tab(text: 'Thành viên'),
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
                            "Số phòng",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _roomController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nhập số phòng",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Vui lòng nhập số phòng";
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
                            "Tầng",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: selectedFloor,
                            items: floors
                                .map(
                                  (floor) => DropdownMenuItem(
                                    value: floor,
                                    child: Text(floor),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedFloor = value;
                              });
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
                            decoration:  InputDecoration(
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
                            keyboardType:  TextInputType.numberWithOptions(
                              decimal: true,
                            ),
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
                            decoration:  InputDecoration(
                              border: OutlineInputBorder(),
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
                            "Ngày cấp",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _dateOfIssueController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nhập ngày cấp",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Vui lòng nhập ngày cấp";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Nơi cấp",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _placeOfIssueController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nhập nơi cấp",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Vui lòng nhập nơi cấp";
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
                            "Địa chỉ thường trú",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _addressController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nhập địa chỉ thường trú",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Vui lòng nhập địa chỉ thường trú";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Số xe",
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
                          Text(
                            "Ghi chú khác",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _noteController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nhập ghi chú (nếu có)",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Center(
                    child: Padding(
                      padding:  EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding:  EdgeInsets.all(16),
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
                            "Giới tính",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: selectedGender,
                            items: gender
                                .map(
                                  (gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value; // cập nhật giá trị
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
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
                            "Điện thoại",
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
                          Text(
                            "Số xe",
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
                          Text(
                            "Đia chỉ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _noteController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nhập địa chỉ",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Vui lòng nhập địa chỉ";
                              }
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize:  Size(0, 0),
                              ),
                              child:  Text(
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
                ],
              ),
            ),
             SizedBox(height: 20),
            Padding(
              padding:  EdgeInsets.all(12.0),
              child: Row(
                children: [
                  SizedBox(width: 16),
                  buildActionBtn(Icons.close, "Hủy", Colors.red, () => Navigator.pop(context)),
                  buildActionBtn(Icons.add, "Lưu thay đổi", Colors.blue, (){}),
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
