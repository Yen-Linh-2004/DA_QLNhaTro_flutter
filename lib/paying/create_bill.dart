import 'package:flutter/material.dart';
import 'package:flutter_application/shared/input_field.dart';

class CreateBillPage extends StatefulWidget {
  const CreateBillPage({super.key});

  @override
  State<CreateBillPage> createState() => _CreateBillPageState();
}

class _CreateBillPageState extends State<CreateBillPage> {
  String? selectedDay;
  String? selectedPhong;
  int dien = 0;
  int nguoi = 0;
  int planInternet = 1;
  int xe = 0;
  int tong = 0;

  final _describeController = TextEditingController();
  final _costNumberController = TextEditingController();
  final _electricityController = TextEditingController();
  final _peopleController = TextEditingController();
  final _coreGarbageController = TextEditingController();
  final _coreVehicleController = TextEditingController();
  String? selectedInternet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Tạo hóa đơn mới"),
        // backgroundColor: Colors.blue.shade700,
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chọn phòng
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropdown(
                    label: "Chọn dãy",
                    value: selectedDay,
                    items:  ["Dãy A", "Dãy B", "Dãy C"],
                    onChanged: (value) {
                      setState(() {
                        selectedDay = value;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  CustomDropdown(
                    label: "Chọn phòng (kèm theo tên):",
                    value: selectedPhong,
                    items: ["A101 - Nguyễn Văn A", "B201 - Lê Văn C", "C301 - Vũ Đình E"],
                    onChanged: (value) {
                      setState(() {
                        selectedPhong = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Mức tiêu thụ & dịch vụ
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Mức tiêu thụ & Dịch vụ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField("Điện (kWh)", "Điện (kWh)", _electricityController),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buildTextField("Số người", "Nhập số người", _peopleController),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: CustomDropdown(
                          label: "Internet", 
                          value: selectedInternet, 
                          items: ["0đ (Plan 1)", "0đ (Plan 2)"],
                          onChanged: (value) => setState(() => selectedInternet = value),
                        ), 
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buildTextField("Rác", "0đ", _coreGarbageController),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buildTextField("Gửi xe", "0đ - xe", _coreVehicleController)
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Chi tiết chi phí
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Chi tiết chi phí",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tiền thuê phòng:"),
                      Text("0đ"),
                    ],
                  ), 
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tiền điện:"),
                      Text("0đ"),
                    ],
                  ), 
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tiền nước:"),
                      Text("0đ"),
                    ],
                  ), 
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Internet:"),
                      Text("0đ"),
                    ],
                  ), 
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rác:"),
                      Text("0đ"),
                    ],
                  ), 
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Gửi xe (0 xe):"),
                      Text("0đ"),
                    ],
                  ), 
                  SizedBox(height: 8),
                  Divider(height: 16),
                  Text("Tổng cộng: 0đ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.purple)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Chi phí phát sinh
            Container(
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(padding: EdgeInsetsGeometry.all(14),
              child: Column(
                children: [
                  buildTextField("Mô tả phí mới", "Ví dụ: Vệ sinh máy lạnh, sơn lại cửa,...", _describeController),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField("Số tiền (VND)", "0", _costNumberController)
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                        ),
                        child:  Text("+", style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ],
              ),)
            ),
                

            const SizedBox(height: 20),

            // Nút hành động
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Hủy"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.receipt_long),
                    label: const Text("Tạo hóa đơn"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 16),
                      minimumSize: const Size(double.infinity, 50),
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
