import 'package:flutter/material.dart';
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
    {"day": "A", "phong": "201", "khach": "Nguyễn Văn An", "songuoi": 2, "selected": true},
    {"day": "A", "phong": "203", "khach": "Trần Thị Bình", "songuoi": 2, "selected": true},
    {"day": "A", "phong": "301", "khach": "Lê Văn Cường", "songuoi": 3, "selected": true},
    {"day": "B", "phong": "101", "khach": "Hoàng Văn Em", "songuoi": 1, "selected": false},
    {"day": "B", "phong": "302", "khach": "Phạm Thị Dung", "songuoi": 2, "selected": false},
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
        title:  Text(
          "Cập nhật thông báo",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(20),
        child: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding:  EdgeInsets.all(20),
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
                      onChanged: (value) => setState(() => selectedType = value),
                    ),
                     SizedBox(height: 12),
                    CustomDropdown(
                      label: "Trạng thái",
                      value: selectedStatus,
                      items: listStatus,
                      onChanged: (value) => setState(() => selectedStatus = value),
                    ),
                     SizedBox(height: 12),
                    CustomDropdown(
                      label: "Đối tượng",
                      value: selectedActor,
                      items: listActor,
                      onChanged: (value) => setState(() => selectedActor = value),
                    ),
                     SizedBox(height: 12),
                    buildTextField("Nội dung", "Nhập nội dung", _contentController),
                     SizedBox(height: 20),

                    /// --- Bộ lọc dãy và chọn tất cả
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedDay,
                            decoration: InputDecoration(
                              labelText: "Dãy",
                              contentPadding:  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            items:  [
                              DropdownMenuItem(value: "Tất cả dãy", child: Text("Tất cả dãy")),
                              DropdownMenuItem(value: "A", child: Text("Dãy A")),
                              DropdownMenuItem(value: "B", child: Text("Dãy B")),
                            ],
                            onChanged: (val) => setState(() => selectedDay = val!),
                          ),
                        ),
                         SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectAll = !selectAll;
                              for (var r in rooms) {
                                r["selected"] = selectAll;
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(selectAll ? "Bỏ chọn hết" : "Chọn tất cả", style: TextStyle(color: Colors.white)),
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
                            ...rooms.map((room) => _buildRoomRow(room)).toList(),
                          ],
                        ),
                      ),
                    ),

                     SizedBox(height: 16),

                    /// --- Tổng số phòng đã chọn
                    Container(
                      width: double.infinity,
                      padding:  EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Số phòng đã chọn: $selectedCount",
                        style:  TextStyle(
                          color: Colors.green,
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
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon:  Icon(Icons.close),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.black87,
                            padding:  EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          label:  Text(
                            "Hủy",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(content: Text("Thông báo đã được cập nhật")),
                              );
                            }
                          },
                          icon:  Icon(Icons.save, color: Colors.white,),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding:  EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 3,
                          ),
                          label:  Text(
                            "Cập nhật",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
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
      padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      color: Colors.grey.shade100,
      child:  Row(
        children: [
          SizedBox(width: 30),
          Expanded(flex: 1, child: Text("DÃY", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text("PHÒNG", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 4, child: Text("KHÁCH THUÊ", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text("SỐ NGƯỜI", style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  /// --- Dòng thông tin từng phòng
  Widget _buildRoomRow(Map<String, dynamic> room) {
    return Container(
      color: room["selected"] ? Colors.blue.shade50 : null,
      padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        children: [
          Checkbox(
            value: room["selected"],
            onChanged: (value) => setState(() => room["selected"] = value),
          ),
          Expanded(flex: 1, child: Text(room["day"])),
          Expanded(flex: 2, child: Text(room["phong"], style:  TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 4, child: Text(room["khach"])),
          Expanded(flex: 2, child: Text(room["songuoi"].toString())),
        ],
      ),
    );
  }
}
