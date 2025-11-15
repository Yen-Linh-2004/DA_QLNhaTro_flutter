import 'package:flutter/material.dart';
import 'package:flutter_application/shared/buildCard.dart';

class BillPage extends StatelessWidget {
  const BillPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(  
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hóa Đơn Tháng 10, 2025', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Ngày lập: 1/11/2025'),
            Text('Hạn thanh toán: 5/11/2025'),
            SizedBox(height: 20),
            BillItem(title: "Tiền thuê phòng", unit: "tháng", price: 2600000),
            BillItem(title: "Điện", unit: "kWh", price: 297500),
            BillItem(title: "Nước", unit: "Người", price: 120000),
            BillItem(title: "Internet (gói cơ bản)", unit: "Phòng", price: 50000),
            BillItem(title: "Rác", unit: "Phòng", price: 40000),
            BillItem(title: "Gửi xe", unit: "Phòng", price: 100000),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tạm tính', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('3,207,500 đ', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Công nợ kỳ trước', style: TextStyle(fontSize: 16)),
                Text('0 đ', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Giảm trừ', style: TextStyle(fontSize: 16)),
                Text('0 đ', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Phí trễ hạn', style: TextStyle(fontSize: 16)),
                Text('0 đ', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cần thanh toán', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('3,207,500 đ', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildActionBtn(Icons.payment, "Thanh toán ngay", Colors.blue, (){}),
                SizedBox(width: 15),
                buildActionBtn(Icons.picture_as_pdf, "Tải PDF", Colors.green, (){}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BillItem extends StatelessWidget {
  final String title;
  final String unit;
  final double price;

  const BillItem({
    required this.title,
    required this.unit,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          Row(
            children: [
              Text(unit, style: TextStyle(fontSize: 16)),
              SizedBox(width: 8),
              Text('${price.toStringAsFixed(0)} đ', style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
