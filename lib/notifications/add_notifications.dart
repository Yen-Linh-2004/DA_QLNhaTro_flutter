import 'package:flutter/material.dart';
import 'package:flutter_application/shared/input_field.dart';

class AddNotificationsPage extends StatefulWidget {
  const AddNotificationsPage({super.key});

  @override
  State<AddNotificationsPage> createState() => _AddNotificationsPageState();
}

class _AddNotificationsPageState extends State<AddNotificationsPage> {
  final _formKey = GlobalKey<FormState>();

  final _tilterController = TextEditingController();
  final _contendController = TextEditingController();

  final List<String> listType = ["Thông báo trung", "Khẩn cấp", "Bảo trì", "Thanh toán"];
  final List<String> listStatus = ["Lưu bản nháp", "Gửi ngay", "Lên lịch gửi"];
  final List<String> listActor = ["Tất cả khách thuê", "Phòng cụ thể"];

  String? selectedTye = "Thông báo trung";
  String? selectedStatus = "Lưu bản nháp";
  String? selectAtor = "Tất cả khách thuê";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F6F9),
      appBar: AppBar(
        title: Text(
          "Tạo thông báo mới",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 2,
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
                    buildTextField(
                      "Tiêu đề",
                      "Nhập tiêu đề",
                      _tilterController,
                    ),
                    SizedBox(height: 12),
                    CustomDropdown(
                      label: "Loại thông báo",
                      value: selectedTye,
                      items: listType,
                      onChanged: (value) {
                        setState(() {
                          selectedTye = value;
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    CustomDropdown(
                      label: "Trạng thái",
                      value: selectedStatus,
                      items: listStatus,
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value;
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    CustomDropdown(
                      label: "Trạng thái",
                      value: selectedStatus,
                      items: listStatus,
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value;
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    CustomDropdown(
                      label: "Đối tượng",
                      value: selectAtor,
                      items: listActor,
                      onChanged: (value) {
                        setState(() {
                          selectAtor = value;
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    buildTextField(
                      "Nội dung",
                      "Nhập nội dung",
                      _contendController,
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 3,
                          ),
                          label: Text(
                            "Hủy",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Thông báo đã được thêm"),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 3,
                          ),
                          label: Text(
                            "Thêm thông báo",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
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
}
