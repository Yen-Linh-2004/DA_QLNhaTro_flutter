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
      backgroundColor:  Color(0xFFF6F6F8),
      appBar: AppBar(
        title:  Text("Chi tiết dịch vụ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
              _valueTag(label: "Tên dịch vụ:", value: name, color: Colors.black54),
               SizedBox(height: 12),
              _valueTag(label: "Mô tả:", value: description, color: Colors.black54),
               SizedBox(height: 12),
              _smallTagRow(label: "Danh mục", value: category, tagColor: Colors.greenAccent),
               SizedBox(height: 12),
              _valueTag(label: "Giá:", value: price, color: Colors.green),
               SizedBox(height: 12),
              _valueTag(label: "Số phòng đang sử dụng", value: usage, color: Colors.black54),
               SizedBox(height: 12),
              _valueTag(
                label: "Trạng thái",
                value: status,
                color: status == "Hoạt động" ? Colors.green : Colors.red,
              ),
               SizedBox(height: 24),
              // Nút hành động
              Row(
                children: [
                  buildActionBtn(Icons.edit, "Chỉnh sửa", Colors.blue, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => UpdateServicePage()),
                    );
                  }),
                   SizedBox(width: 15),
                  buildActionBtn(Icons.pause_circle_filled, "Tạm dừng", Colors.redAccent, () {}),
                ],
              ),
               SizedBox(height: 12),
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
    required String label,
    required String value,
    required Color tagColor,
  }) {
    return Row(
      children: [
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
}
