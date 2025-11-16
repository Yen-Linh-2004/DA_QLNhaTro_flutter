import 'package:flutter/material.dart';
import 'package:flutter_application/shared/buildCard.dart';

class MaintenanceDetailPage extends StatelessWidget {
  const MaintenanceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Chi tiết yêu cầu bảo trì", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
        padding: EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow("Khách thuê:", "Trần Thị Bé"),
              _buildInfoRow("Khu vực:", "Dãy A - A202"),
              _buildInfoRow("Tiêu đề:", "Vòi nước bồn rửa bát bị rỉ"),
              SizedBox(height: 10),
              _buildLabel("Mô tả:"),
              _buildBoxText("Vòi nước trong bếp bị rỉ nước liên tục"),
              SizedBox(height: 10),
              _buildInfoRowWithTag("Danh mục:", "Nước", Colors.blue),
              _buildInfoRowWithTag("Mức độ:", "Trung bình", Colors.amber[700]!),
              _buildInfoRow("Ngày yêu cầu:", "18/3/2024"),
              _buildInfoRowWithTag("Trạng thái:", "Đang xử lý", Colors.purple),
              _buildInfoRow("Phân công cho:", "Tuấn"),
              _buildInfoRow("Ngày phân công:", "05/11/2025"),
              SizedBox(height: 10),
              _buildLabel("Ghi chú:"),
              _buildBoxText("Đã kiểm tra, cần thay vòi"),
              SizedBox(height: 20),
              Row(
                children: [
                  buildActionBtn(Icons.check, "Hoàn thành", Colors.green, () {}),
                  SizedBox(width: 10),
                  buildActionBtn(Icons.edit, "Chỉnh sửa", Colors.blue, () {}),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  buildActionBtn(Icons.delete, "Xóa yêu cầu", Colors.red, () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// --- Widgets hỗ trợ --- ///
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          Text(value, style:  TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text,
        style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 15));
  }

  Widget _buildBoxText(String text) {
    return Container(
      width: double.infinity,
      padding:  EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style:  TextStyle(fontSize: 15)),
    );
  }

  Widget _buildInfoRowWithTag(String label, String value, Color color) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          Container(
            padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              value,
              style: TextStyle(color: color, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
