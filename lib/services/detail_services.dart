import 'package:flutter/material.dart';

class ServiceDetailPage extends StatelessWidget {
  final Map<String, dynamic> service;

  const ServiceDetailPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFF6F6F8),
      appBar: AppBar(
        title:  Text("Chi tiết dịch vụ"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),

      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: Container(
          padding:  EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset:  Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tên dịch vụ
              Text(
                service["name"],
                style:  TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

               SizedBox(height: 12),

              // Giá
              _valueTag(
                icon: Icons.payments_rounded,
                label: "Giá",
                value: service["price"],
                color: Colors.green,
              ),

               SizedBox(height: 12),

              // Danh mục
              _smallTagRow(
                icon: Icons.category_rounded,
                label: "Danh mục",
                value: service["category"] ?? "Chưa phân loại",
                tagColor: Colors.purple,
              ),

               SizedBox(height: 12),

              // Trạng thái
              _smallTagRow(
                icon: Icons.check_circle,
                label: "Trạng thái",
                value: service["status"],
                tagColor:
                    service["status"] == "Hoạt động" ? Colors.green : Colors.red,
              ),

               SizedBox(height: 18),

              // Mô tả
              _sectionTitle("Mô tả"),
              _descriptionBox(service["description"] ?? "Không có mô tả"),

               SizedBox(height: 18),

              // Số lần sử dụng
              _sectionTitle("Số lần sử dụng"),
              Text(
                (service["usage"] ?? 0).toString(),
                style:  TextStyle(fontSize: 16),
              ),

               SizedBox(height: 32),

              // Nút hành động
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon:  Icon(Icons.edit, size: 18),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.blue,
                        padding:  EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      label:  Text("Chỉnh sửa"),
                    ),
                  ),
                   SizedBox(width: 14),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon:  Icon(Icons.pause_circle_filled, size: 18),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.red,
                        padding:  EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      label:  Text("Tạm dừng"),
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

  Widget _valueTag({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey.shade700),
         SizedBox(width: 10),
        Text(label, style:  TextStyle(fontSize: 15)),
         Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _smallTagRow({
    required IconData icon,
    required String label,
    required String value,
    required Color tagColor,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey.shade700),
         SizedBox(width: 10),
        Text(label, style:  TextStyle(fontSize: 15)),
         Spacer(),
        Container(
          padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: tagColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: tagColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style:  TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    );
  }

  Widget _descriptionBox(String text) {
    return Container(
      width: double.infinity,
      margin:  EdgeInsets.only(top: 6),
      padding:  EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style:  TextStyle(fontSize: 14)),
    );
  }
}
