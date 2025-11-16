import 'package:flutter/material.dart';
import 'package:flutter_application/shared/buildCard.dart';
import 'package:flutter_application/shared/input_field.dart';

class UpdateNotificationsPage extends StatefulWidget {
  const UpdateNotificationsPage({super.key});

  @override
  State<UpdateNotificationsPage> createState() =>
      _UpdateNotificationsPageState();
}

class _UpdateNotificationsPageState extends State<UpdateNotificationsPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  final List<String> listType = [
    "Thông báo thường",
    "Khẩn cấp",
    "Bảo trì",
    "Thanh toán",
  ];
  final List<String> listStatus = ["Lưu bản nháp", "Gửi ngay", "Lên lịch gửi"];
  final List<String> listActor = ["Tất cả khách thuê", "Phòng cụ thể"];

  String? selectedType = "Thông báo thường";
  String? selectedStatus = "Lưu bản nháp";
  String? selectedActor = "Tất cả khách thuê";
  String selectedDay = 'Tất cả dãy';
  bool selectAll = false;

  final List<Map<String, dynamic>> rooms = [
    {
      "day": "A",
      "phong": "201",
      "khach": "Nguyễn Văn An",
      "songuoi": 2,
      "selected": true,
    },
    {
      "day": "A",
      "phong": "203",
      "khach": "Trần Thị Bình",
      "songuoi": 2,
      "selected": true,
    },
    {
      "day": "A",
      "phong": "301",
      "khach": "Lê Văn Cường",
      "songuoi": 3,
      "selected": true,
    },
    {
      "day": "B",
      "phong": "101",
      "khach": "Hoàng Văn Em",
      "songuoi": 1,
      "selected": false,
    },
    {
      "day": "B",
      "phong": "302",
      "khach": "Phạm Thị Dung",
      "songuoi": 2,
      "selected": false,
    },
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int selectedCount = rooms.where((r) => r["selected"]).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Cập nhật thông báo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
        padding: EdgeInsets.all(20),
        child: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextField("Tiêu đề", "Nhập tiêu đề", _titleController),
                    SizedBox(height: 12),
                    CustomDropdown(
                      label: "Loại thông báo",
                      value: selectedType,
                      items: listType,
                      onChanged: (value) =>
                          setState(() => selectedType = value),
                    ),
                    SizedBox(height: 12),
                    CustomDropdown(
                      label: "Trạng thái",
                      value: selectedStatus,
                      items: listStatus,
                      onChanged: (value) =>
                          setState(() => selectedStatus = value),
                    ),
                    SizedBox(height: 12),
                    CustomDropdown(
                      label: "Đối tượng",
                      value: selectedActor,
                      items: listActor,
                      onChanged: (value) =>
                          setState(() => selectedActor = value),
                    ),
                    SizedBox(height: 12),
                    buildTextField(
                      "Nội dung",
                      "Nhập nội dung",
                      _contentController,
                    ),
                    SizedBox(height: 20),

                    /// --- Bộ lọc dãy và chọn tất cả
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedDay,
                            decoration: InputDecoration(
                              labelText: "Dãy",
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            items: [
                              DropdownMenuItem(
                                value: "Tất cả dãy",
                                child: Text("Tất cả dãy"),
                              ),
                              DropdownMenuItem(
                                value: "A",
                                child: Text("Dãy A"),
                              ),
                              DropdownMenuItem(
                                value: "B",
                                child: Text("Dãy B"),
                              ),
                            ],
                            onChanged: (val) =>
                                setState(() => selectedDay = val!),
                          ),
                        ),
                        SizedBox(width: 12),
                        buildActionBtn(Icons.group_add, "Chọn tất cả", Colors.blue,
                          () {
                            setState(() {
                              selectAll = !selectAll;
                              for (var r in rooms) {
                                r["selected"] = selectAll;
                              }
                            });
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    /// --- Danh sách phòng
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ListView(
                          children: [
                            _buildHeaderRow(),
                            Divider(height: 1),
                            ...rooms
                                .map((room) => _buildRoomRow(room))
                                .toList(),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    /// --- Tổng số phòng đã chọn
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Số phòng đã chọn: $selectedCount",
                        style: TextStyle(
                          color: Colors
                          
                          .green,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    SizedBox(height: 24),

                    /// --- Nút hành động
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildActionBtn(Icons.close, "Hủy", Colors.red, () => Navigator.pop(context)),
                        SizedBox(width: 15),
                        buildActionBtn(
                          Icons.save,
                          "Cập nhật",
                          Colors.blue,
                          () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// --- Header danh sách phòng
  Widget _buildHeaderRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      color: Colors.grey.shade100,
      child: Row(
        children: [
          SizedBox(width: 30),
          Expanded(
            flex: 1,
            child: Text("DÃY", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 2,
            child: Text("PHÒNG", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 4,
            child: Text(
              "KHÁCH THUÊ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "SỐ NGƯỜI",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  /// --- Dòng thông tin từng phòng
  Widget _buildRoomRow(Map<String, dynamic> room) {
    return Container(
      color: room["selected"] ? Colors.blue.shade50 : null,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        children: [
          Checkbox(
            value: room["selected"],
            onChanged: (value) => setState(() => room["selected"] = value),
          ),
          Expanded(flex: 1, child: Text(room["day"])),
          Expanded(
            flex: 2,
            child: Text(
              room["phong"],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(flex: 4, child: Text(room["khach"])),
          Expanded(flex: 2, child: Text(room["songuoi"].toString())),
        ],
      ),
    );
  }
}
