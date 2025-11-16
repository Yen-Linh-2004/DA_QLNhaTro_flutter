import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/shared/buildCard.dart';

class SendNotificationsPage extends StatelessWidget {
  const SendNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Gửi thông báo thu tiền - Trần Thị B", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thông tin hóa đơn
            Container(
              width: double.infinity,
              padding:  EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.yellow.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.yellow.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Thông tin hóa đơn",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                   SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text("Phòng: A102"),
                      Text("Tháng: tháng 10, 2025"),
                    ],
                  ),
                   SizedBox(height: 6),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children:  [
                      Text(
                        "Số tiền cần thu: 580.000đ",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Hạn thanh toán: 5/11/2025",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  //   ],
                  // ),
                ],
              ),
            ),

             SizedBox(height: 20),

            // Tiêu đề thông báo
             Text(
              "Tiêu đề thông báo *",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: "Nhắc nhở thanh toán - Phòng A102",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

             SizedBox(height: 16),

            // Nội dung thông báo
             Text(
              "Nội dung thông báo *",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 8),
            TextField(
              maxLines: 6,
              decoration: InputDecoration(
                hintText:
                    "Kính gửi Trần Thị B,\n\nBạn có hóa đơn tháng 10, 2025 chưa thanh toán với số tiền 580.000đ.\n\nHạn thanh toán: 5/11/2025",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

             SizedBox(height: 16),

            // Phương thức gửi
             Text(
              "Phương thức gửi",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: "app",
              items:  [
                DropdownMenuItem(
                  value: "app",
                  child: Text("Qua ứng dụng"),
                ),
                DropdownMenuItem(
                  value: "sms",
                  child: Text("Qua SMS"),
                ),
                DropdownMenuItem(
                  value: "email",
                  child: Text("Qua Email"),
                ),
              ],
              onChanged: (value) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

             SizedBox(height: 24),

            // Nút hành động
            Row(
              children: [
                buildActionBtn(Icons.close, "Hủy", Colors.red, () => Navigator.pop(context)),
                SizedBox(width: 12),
                buildActionBtn(Icons.send, "Gửi thông báo", Colors.blue, (){}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
