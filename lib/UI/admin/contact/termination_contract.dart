import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/shared/buildCard.dart';
import 'package:flutter_application/UI/admin/shared/input_field.dart';

class TerminationContractPage extends StatefulWidget {
 const TerminationContractPage({super.key});

  @override
  State<TerminationContractPage> createState() => _TerminationContractPageState();
}

class _TerminationContractPageState extends State<TerminationContractPage> {
  final _priceController = TextEditingController();
  final _noteController = TextEditingController();

  DateTime selectedDate = DateTime(2025, 1, 1);  
  String? selectReason;
  
  List<String> reasons = ["Khách thuê yêu cầu", "Vi phạm hợp đồng", "Chậm thanh toán", "Làm hỏng tài sản", "Chủ nhà yêu cầu", "Lý do khác"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chấm dứt hợp đồng", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
            CustomDropdown(
              label: "Lý do",
              value: selectReason,
              items: reasons,
              onChanged: (value) {
                setState(() {
                  selectReason = value;
                });
              },
            ),
            SizedBox(height: 12),
            buildTextField("Số tiền cọc hoàn trả (VND)", "", _priceController),
            SizedBox(height: 12),
            buildContendField("Ghi chú", "", _noteController, context),
            SizedBox(height: 24),
            Row(
              children: [
                buildActionBtn(Icons.close, "Hủy", Colors.red, (){}),
                SizedBox(width: 15),
                buildActionBtn(Icons.assignment_turned_in, "Chấm dứt", Colors.orange, (){})
              ],
            )
          ],
        ),
      ),
    );
  }

}
