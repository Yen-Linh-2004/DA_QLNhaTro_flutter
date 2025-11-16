import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/shared/buildCard.dart';
import 'package:flutter_application/UI/admin/shared/input_field.dart';

class UpdateContactPage extends StatefulWidget {
 const UpdateContactPage({super.key});

  @override
  State<UpdateContactPage> createState() => _UpdateContactPageState();
}

class _UpdateContactPageState extends State<UpdateContactPage> {
  final _contactNumberControl = TextEditingController();
  final _priceController = TextEditingController();
  final _noteController = TextEditingController();

  DateTime selectedDate = DateTime(2025, 1, 1);  // Ngày ký
  DateTime selectedStartDate = DateTime(2025, 1, 1);  // Ngày bắt đầu
  DateTime selectedEndDate = DateTime(2025, 1, 1);  // Ngày ngày kết thúc

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cập nhật hợp đồng", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
            buildTextField("Số hợp đồng", "Nhập số hợp đồng", _contactNumberControl),
            SizedBox(height: 12),
            buildDatePickerField(context, "Ngày ký", selectedDate, (date) {setState(() { selectedDate = date;  });}),
            SizedBox(height: 12),
            buildDatePickerField(context, "Ngày ký", selectedStartDate, (date) {setState(() { selectedStartDate = date;  });}),
            SizedBox(height: 12),
            buildDatePickerField(context, "Ngày ký", selectedEndDate, (date) {setState(() { selectedEndDate = date;  });}),
            SizedBox(height: 12),
            buildTextField("Tiền cọc", "", _priceController),
            SizedBox(height: 12),
            buildContendField("Ghi chú", "", _noteController, context),
            SizedBox(height: 24),
            Row(
              children: [
                buildActionBtn(Icons.close, "Hủy", Colors.red, (){}),
                SizedBox(width: 15),
                buildActionBtn(Icons.edit, "Cập nhật", Colors.blue, (){})
              ],
            )
          ],
        ),
      ),
    );
  }
}
