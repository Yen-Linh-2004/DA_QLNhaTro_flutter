import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/UI/shared/input_field.dart';

class ExtensionContractPage extends StatefulWidget {
 const ExtensionContractPage({super.key});

  @override
  State<ExtensionContractPage> createState() => _ExtensionContractPageState();
}

class _ExtensionContractPageState extends State<ExtensionContractPage> {
  final _rentalNewController = TextEditingController();
  final _depositNewController = TextEditingController();
  final _noteController = TextEditingController();

  DateTime selectedDate = DateTime(2025, 1, 1);  // Ngày kết thúc
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gia hạn hợp đồng", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
            infoCard([
              infoRow("Hợp đồng", "HD001"),
              infoRow("Khách thuê", "Nguyễn Văn Hưng"),
              infoRow("Tiền cọc hiện tại", "2.600.000"),
            ]),
            SizedBox(height: 12),
            buildDatePickerField(context, "Ngày chấm dứt", selectedDate, (date) {setState(() { selectedDate = date;  });}),
            SizedBox(height: 12),
            buildTextField("Tiền thuê mới (VND)", "", _rentalNewController, null),
            SizedBox(height: 12),
            buildTextField("Tiền cọc mới (VND)", "", _depositNewController, null),
            SizedBox(height: 12),
            buildContendField("Ghi chú", "", _noteController, context),
            SizedBox(height: 24),
            Row(
              children: [
                buildActionBtn(Icons.close, "Hủy", Colors.red, (){}),
                SizedBox(width: 15),
                buildActionBtn(Icons.update, "Gia hạn", Colors.blue, (){})
              ],
            )
          ],
        ),
      ),
    );
  }

}
