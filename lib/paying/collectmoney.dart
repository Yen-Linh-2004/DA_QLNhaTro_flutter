import 'package:flutter/material.dart';

class collectmoneyPage extends StatelessWidget {
  const collectmoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Thu tiền - Trần Thị B'),
        // backgroundColor: Colors.green.shade600,
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
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text("Tổng tiền: 3.780.000đ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Đã thanh toán: 3.200.000đ",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold)),
                    ],
                  ),
                   SizedBox(height: 6),
                   Text(
                    "Còn lại: 580.000đ",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

             SizedBox(height: 20),

            // Số tiền thu
             Text(
              "Số tiền thu *",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Nhập số tiền cần thu",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

             SizedBox(height: 10),

            // Nút thu toàn bộ & thu một nửa
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue.shade600),
                  ),
                  child:  Text("Thu toàn bộ"),
                ),
                 SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {},
                  child:  Text("Thu một nửa"),
                ),
              ],
            ),

             SizedBox(height: 16),

            // Phương thức thanh toán
             Text(
              "Phương thức thanh toán",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 8),
            DropdownButtonFormField<String>(
              items:  [
                DropdownMenuItem(value: "cash", child: Text("Tiền mặt")),
                DropdownMenuItem(value: "bank", child: Text("Chuyển khoản")),
                DropdownMenuItem(value: "card", child: Text("Thẻ")),
              ],
              onChanged: (value) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

             SizedBox(height: 16),

            // Ngày thanh toán
             Text(
              "Ngày thanh toán",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 8),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Chọn ngày thanh toán",
                suffixIcon:  Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onTap: () {
                // mở date picker tại đây
              },
            ),

             SizedBox(height: 16),

            // Ghi chú
             Text(
              "Ghi chú",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 8),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Ghi chú thêm về việc thanh toán...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

             SizedBox(height: 24),

            // Nút hành động
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:  EdgeInsets.symmetric(vertical: 18),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child:  Text("Hủy", style: TextStyle(fontSize: 16),),
                  ),
                ),
                 SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon:  Icon(Icons.check_circle_outline, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:  EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    label:  Text(
                      "Thu tiền",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
