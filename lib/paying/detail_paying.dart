import 'package:flutter/material.dart';

class PayingDetailPage extends StatelessWidget {
  const PayingDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Chi tiết hóa đơn"),
        // backgroundColor: Colors.green.shade700,
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề
             Text(
              "Nguyễn Văn A",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 20),

            // Thông tin cơ bản
            Container(
              width: double.infinity,
              padding:  EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow("Khách thuê:", "Nguyễn Văn A"),
                  buildInfoRow("Phòng:", "A101"),
                  buildInfoRow("Dãy:", "Dãy A"),
                  buildInfoRow("Tháng:", "Tháng 10, 2025"),
                  buildInfoRow("Hạn thanh toán:", "05/11/2025", color: Colors.red),
                  Row(
                    children: [
                       Text("Trạng thái:", style: TextStyle(fontWeight: FontWeight.w600)),
                       SizedBox(width: 8),
                      Container(
                        padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Đã thanh toán",
                          style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  buildInfoRow("Ngày thanh toán:", "2025-11-03", color: Colors.green.shade700),
                  buildInfoRow("Phương thức:", "Chuyển khoản", isBold: true),
                ],
              ),
            ),

             SizedBox(height: 20),

            // Chi tiết thanh toán
            Container(
              width: double.infinity,
              padding:  EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildPaymentRow("Tiền thuê phòng:", "3.500.000đ"),
                  buildPaymentRow("Tiền điện (100kWh):", "350.000đ"),
                  buildPaymentRow("Tiền nước (2 người):", "120.000đ"),
                  buildPaymentRow("Internet (Plan 1):", "50.000đ"),
                  buildPaymentRow("Rác:", "40.000đ"),
                  buildPaymentRow("Gửi xe (2 xe):", "200.000đ"),
                   SizedBox(height: 10),
                   Text(
                    "Chi phí phát sinh:",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  buildPaymentRow("Sửa vòi nước:", "150.000đ"),
                   Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text("Tổng cộng:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("4.410.000đ",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                   SizedBox(height: 4),
                   Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Đã thanh toán: 4.410.000đ",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),

             SizedBox(height: 30),

            // Nút đóng
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  // backgroundColor: Colors.grey.shade200,
                  // foregroundColor: Colors.black87,
                  padding:  EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:  Text("Đóng"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget hàng thông tin cơ bản
  Widget buildInfoRow(String label, String value, {Color? color, bool isBold = false}) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style:  TextStyle(fontWeight: FontWeight.w600)),
          Text(
            value,
            style: TextStyle(
              color: color ?? Colors.black87,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // Widget hàng chi tiết thanh toán
  Widget buildPaymentRow(String label, String value) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label)),
          Text(
            value,
            style:  TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
