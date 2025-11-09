import 'package:flutter/material.dart';
import 'package:flutter_application/Rooms/update_room.dart';

class RoomDetailPage extends StatefulWidget {
  const RoomDetailPage({super.key});

  @override
  State<RoomDetailPage> createState() => _RoomDetailPage();
}

class _RoomDetailPage extends State<RoomDetailPage> {
  final textStyleLabel = TextStyle(color: Colors.grey[700], fontSize: 14);
  final textStyleValue = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  // Trạng thái các checkbox
  bool dien = true;
  bool nuoc = true;
  bool internet = true;
  bool giatSay = true;
  bool guiXe = false;
  bool donPhong = false;

  final List<Map<String, String>> thanhVienList = [
    {
      "hoTen": "Nguyễn Văn A",
      "ngaySinh": "20/5/1995",
      "gioiTinh": "Nam",
      "cmnd": "123456789",
      "diaChi": "123 Đường ABC, Quận 1, TP.HCM",
      "dienThoai": "0901234567",
      "soXe": "29A1-12345",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chi tiết phòng A101'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          bottom: const TabBar(
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
                  //  --- THÔNG TIN PHÒNG ---
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔹 Khung thông tin phòng
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Thông tin phòng",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  _InfoRow(label: "Số phòng:", value: "A101"),
                                  _InfoRow(label: "Dãy:", value: "Dãy A"),
                                  _InfoRow(label: "Tầng:", value: "1"),
                                  _InfoRow(
                                    label: "Loại phòng:",
                                    value: "Phòng đơn",
                                  ),
                                  _InfoRow(label: "Diện tích:", value: "20m²"),
                                  _InfoRow(
                                    label: "Giá thuê:",
                                    value: "3.500.000đ/tháng",
                                    valueColor: Colors.green,
                                  ),
                                  _InfoRow(
                                    label: "Trạng thái:",
                                    value: "Đã thuê",
                                    valueColor: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // 🔹 Khung tiện nghi
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Tiện nghi",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  _AmenityItem("Điều hoà"),
                                  _AmenityItem("Giường"),
                                  _AmenityItem("Tủ lạnh"),
                                  _AmenityItem("Tủ quần áo"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // --- THÔNG TIN KHÁCH THUÊ ---
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Thông tin khách thuê',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            child: Expanded(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoRow(
                                      'Họ tên:',
                                      'Nguyễn Văn A',
                                      textStyleLabel,
                                      textStyleValue,
                                    ),
                                    _buildInfoRow(
                                      'Ngày sinh:',
                                      '20/5/1995',
                                      textStyleLabel,
                                      textStyleValue,
                                    ),
                                    _buildInfoRow(
                                      'Nơi sinh:',
                                      'Hà Nội',
                                      textStyleLabel,
                                      textStyleValue,
                                    ),
                                    _buildInfoRow(
                                      'CMND/CCCD:',
                                      '123456789',
                                      textStyleLabel,
                                      textStyleValue,
                                    ),
                                    _buildInfoRow(
                                      'Ngày cấp:',
                                      '15/1/2020',
                                      textStyleLabel,
                                      textStyleValue,
                                    ),
                                    _buildInfoRow(
                                      'Nơi cấp:',
                                      'CA Hà Nội',
                                      textStyleLabel,
                                      textStyleValue,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            child: Expanded(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoRow(
                                      'Điện thoại 1:',
                                      '0901234567',
                                      textStyleLabel,
                                      textStyleValue,
                                    ),
                                    _buildInfoRow(
                                      'Điện thoại 2:',
                                      '0987654321',
                                      textStyleLabel,
                                      textStyleValue,
                                    ),
                                    _buildInfoRow(
                                      'Email:',
                                      'nguyenvana@email.com',
                                      textStyleLabel,
                                      textStyleValue,
                                    ),
                                    _buildInfoRow(
                                      'Địa chỉ thường trú:',
                                      '123 Đường ABC, Quận 1, TP.HCM',
                                      textStyleLabel,
                                      textStyleValue,
                                    ),
                                    _buildInfoRow(
                                      'Số xe:',
                                      '29A1-12345',
                                      textStyleLabel,
                                      textStyleValue,
                                    ),
                                    _buildInfoRow(
                                      'Hợp đồng:',
                                      '15/1/2024 - 15/12/2024',
                                      textStyleLabel,
                                      textStyleValue,
                                    ),
                                    _buildInfoRow(
                                      'Ghi chú:',
                                      'Khách hàng thân thiết',
                                      textStyleLabel,
                                      textStyleValue,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // --- THÔNG TIN DỊCH VỤ ---
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Wrap(
                              spacing: 20,
                              runSpacing: 10,
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
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),

                  // --- THÔNG TIN THÀNH VIÊN
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child:
                          // Danh sách thay cho bảng
                          Expanded(
                            child: ListView.builder(
                              itemCount: thanhVienList.length,
                              itemBuilder: (context, index) {
                                final tv = thanhVienList[index];
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tv["hoTen"]!,
                                          style: const TextStyle(
                                            color: Colors.indigo,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        buildRow("Ngày sinh", tv["ngaySinh"]!),
                                        buildRow("Giới tính", tv["gioiTinh"]!),
                                        buildRow("CMND/CCCD", tv["cmnd"]!),
                                        buildRow("Địa chỉ", tv["diaChi"]!),
                                        buildRow(
                                          "Điện thoại",
                                          tv["dienThoai"]!,
                                        ),
                                        buildRow("Số xe", tv["soXe"]!),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpdateRoomPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text(
                    "Chỉnh sửa thông tin",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text(
                    "Xem hợp đồng PDF",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
                // ElevatedButton.icon(
                //   onPressed: () {},
                //   icon: const Icon(Icons.delete),
                //   label: const Text("Xóa phòng"),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.red,
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  static Widget _buildInfoRow(
    String label,
    String value,
    TextStyle labelStyle,
    TextStyle valueStyle,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 110, child: Text(label, style: labelStyle)),
          Expanded(child: Text(value, style: valueStyle)),
        ],
      ),
    );
  }

  static Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildButton(
            'Chỉnh sửa thông tin',
            Colors.blue,
            Icons.edit,
            Colors.white,
          ),
          _buildButton(
            'Xem hợp đồng PDF',
            Colors.green,
            Icons.picture_as_pdf,
            Colors.white,
          ),
          _buildButton('Xóa phòng', Colors.red, Icons.delete, Colors.white),
        ],
      ),
    );
  }

  static Widget _buildButton(
    String text,
    Color color,
    IconData icon,
    Color textColor,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(icon, color: textColor, size: 18),
          label: Text(text, style: TextStyle(color: textColor)),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
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

  // Tab mô phỏng giống giao diện web
  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget buildTab(String title, {bool active = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: active ? FontWeight.w600 : FontWeight.normal,
              color: active ? Colors.indigo : Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 2,
            width: 60,
            color: active ? Colors.indigo : Colors.transparent,
          ),
        ],
      ),
    );
  }
}

/// --- WIDGET PHỤ ---

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: valueColor ?? Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmenityItem extends StatelessWidget {
  final String name;
  const _AmenityItem(this.name);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.check, color: Colors.green, size: 18),
        const SizedBox(width: 8),
        Text(name),
      ],
    );
  }
}
