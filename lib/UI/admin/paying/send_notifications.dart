import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/UI/shared/input_field.dart';

class SendNotificationsPage extends StatefulWidget {
  const SendNotificationsPage({super.key});

  @override
  State<SendNotificationsPage> createState() => _SendNotificationsPage();
}

class _SendNotificationsPage extends State<SendNotificationsPage> {
  
  final _titleController = TextEditingController();
  final _contendController = TextEditingController();
  String? selectSend;


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
            buildTextField("Tiêu đề thông báo", "Nhắc nhở thanh toán - Phòng A102", _titleController, null),
             SizedBox(height: 16),

            // Nội dung thông báo
            buildContendField( 
              "Nội dung tiêu đề", 
              "Kính gửi Trần Thị B, Bạn có hóa đơn tháng 10, 2025 chưa thanh toán với số tiền 580.000đ.Hạn thanh toán: 5/11/2025", 
              _contendController,
              context
            ),
            SizedBox(height: 16),

            // Phương thức gửi
            CustomDropdown(
              label: "Phương thức gửi", 
              value: selectSend, 
              items: ["Qua ứng dụng", "Quan SMS", "Qua email"], 
              onChanged: (value) {
                setState(() {
                  selectSend = value;
                });
              },
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
