import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/UI/shared/input_field.dart';

class CollectMoneyPage extends StatefulWidget{
  const CollectMoneyPage({super.key});
   @override
  State<CollectMoneyPage> createState() => _CollectMoneyPage();
}

class _CollectMoneyPage extends State<CollectMoneyPage> {

  final _moneyController = TextEditingController();
  final _noteController =TextEditingController();
  DateTime selectedDate = DateTime(2025, 1, 1); 
  String? SelectPayment;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Thu tiền - Trần Thị B', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Thông tin hóa đơn", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text("Phòng: A102"),
                      Text("Tháng: tháng 10, 2025"),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text("Tổng tiền: 3.780.000đ", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text("Đã thanh toán: 3.200.000đ", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text("Còn lại: 580.000đ", style: TextStyle( color: Colors.red, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 20),

            buildTextField("Số tiền thu", "Nhập số tiền cần thu", _moneyController, null),
            SizedBox(height: 10),
            // Nút thu toàn bộ & thu một nửa
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue.shade600),
                  ), child:  Text("Thu toàn bộ"),
                ),
                 SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {},
                  child:  Text("Thu một nửa"),
                ),
              ],
            ),
            SizedBox(height: 16),

            CustomDropdown(
              label: "Phương thức thanh toán",  
              value: SelectPayment,
              items: ["Tiền mặt", "Chuyển khoản", "Thẻ"],
              onChanged: (value) {
                setState(() {
                  SelectPayment = value;
                });
              }),
            SizedBox(height: 16),
            // Ngày thanh toán
            buildDatePickerField(context, "Ngày thanh toán", selectedDate, (date) {setState(() { selectedDate = date;  });}),
            SizedBox(height: 16),
            // Ghi chú
            buildContendField("Ghi chú", "Ghi chú thêm về việc thanh toán...", _noteController, context),
            SizedBox(height: 24),

            // Nút hành động
            Row(
              children: [
                buildActionBtn(Icons.close, "Hủy", Colors.red, () => Navigator.pop(context)),
                SizedBox(width: 15),
                buildActionBtn(Icons.check_circle_outline, "Thu tiền", Colors.blue, (){ }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
