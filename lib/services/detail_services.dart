import 'package:flutter/material.dart';
import 'package:flutter_application/services/update_service.dart';
import 'package:flutter_application/shared/buildCard.dart';

class ServiceDetailPage extends StatelessWidget {
  final Map<String, dynamic> service;

  const ServiceDetailPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    // Lấy dữ liệu an toàn với fallback
    final name = service["name"] ?? "Chưa có tên";
    final description = service["description"] ?? "Không có mô tả";
    final category = service["category"] ?? "Chưa phân loại";
    final price = service["price"] ?? "Chưa có giá";
    final usage = service["usage"]?.toString() ?? "0";
    final status = service["status"] ?? "Chưa xác định";

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
      appBar: AppBar(
        title: const Text("Chi tiết dịch vụ"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _valueTag(label: "Tên dịch vụ:", value: name, color: Colors.black54),
              const SizedBox(height: 12),
              _valueTag(label: "Mô tả:", value: description, color: Colors.black54),
              const SizedBox(height: 12),
              _smallTagRow(label: "Danh mục", value: category, tagColor: Colors.greenAccent),
              const SizedBox(height: 12),
              _valueTag(label: "Giá:", value: price, color: Colors.green),
              const SizedBox(height: 12),
              _valueTag(label: "Số phòng đang sử dụng", value: usage, color: Colors.black54),
              const SizedBox(height: 12),
              _valueTag(
                label: "Trạng thái",
                value: status,
                color: status == "Hoạt động" ? Colors.green : Colors.red,
              ),
              const SizedBox(height: 24),
              // Nút hành động
              Row(
                children: [
                  buildActionBtn(Icons.edit, "Chỉnh sửa", Colors.blue, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => UpdateServicePage()),
                    );
                  }),
                  const SizedBox(width: 15),
                  buildActionBtn(Icons.pause_circle_filled, "Tạm dừng", Colors.redAccent, () {}),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  buildActionBtn(Icons.delete, "Xóa dữ liệu", Colors.black12, () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _valueTag({
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(fontSize: 15)),
        const Spacer(),
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
    required String label,
    required String value,
    required Color tagColor,
  }) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(fontSize: 15)),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
}
