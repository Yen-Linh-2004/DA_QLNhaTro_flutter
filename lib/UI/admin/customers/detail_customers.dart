import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/customers/update_customer.dart';
import 'package:flutter_application/UI/admin/shared/buildCard.dart';

class CustomerDetailPage extends StatelessWidget {
  // const CustomerDetailPage({super.key, required Map<String, dynamic> tenants});
  const CustomerDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nguyễn Văn A", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- THÔNG TIN CÁ NHÂN ----------
            Text("Thông tin cá nhân",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _buildInfoSection({
                "Họ tên": "Nguyễn Văn A",
                "Ngày sinh": "20/5/1995",
                "Nơi sinh": "Hà Nội",
                "CMND/CCCD": "123456789",
                "Ngày cấp": "15/1/2020",
                "Nơi cấp": "CA Hà Nội",
              }),
            ),

            SizedBox(height: 16),

            // ---------- THÔNG TIN LIÊN HỆ ----------
            Text("Thông tin liên hệ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFE9F9EE),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _buildInfoSection({
                "Điện thoại 1": "0901234567",
                "Điện thoại 2": "0987654321",
                "Email": "nguyenvana@email.com",
                "Địa chỉ thường trú": "123 Đường ABC, Quận 1, TP.HCM",
                "Số xe": "29A1-12345",
                "Ghi chú": "Khách hàng thân thiết",
              }),
            ),
            SizedBox(height: 24),

            // ---------- CÁC NÚT HÀNH ĐỘNG ----------
            Row(
              children: [
                buildActionBtn(Icons.update, "Chỉnh sửa", Colors.blue, (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateCustomerPage(),
                    ),
                  );
                }),
                SizedBox(width: 10),
                buildActionBtn(Icons.close, "Xóa", Colors.redAccent, (){
                    showConfirmDialog(
                        context: context,
                        title: "Xác nhận xóa khách thuê",
                        message: "Bạn có chắc chắn muốn xóa khách thuê này không?",
                        confirmColor: Colors.redAccent,
                        icon: Icons.delete_forever,
                        maxHeight: 140,
                        onConfirm: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                            content: Text(
                              "Đã xóa khách thuê thành công!",
                            ),
                            backgroundColor: Colors.red,
                          ));
                        },
                      );
                }),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ---------------------- WIDGET PHỤ ----------------------
  Widget _buildInfoSection(Map<String, String> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data.entries
        .map((e) => Padding(
              padding: EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text("${e.key}:",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black54)),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      e.value,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ))
        .toList(),
    );
  }
}
