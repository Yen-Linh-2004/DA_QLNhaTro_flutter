import 'package:flutter/material.dart';

class CreateBookingPage extends StatefulWidget {
  const CreateBookingPage({super.key});

  @override
  State<CreateBookingPage> createState() => _CreateBookingPageState();
}

class _CreateBookingPageState extends State<CreateBookingPage> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController depositCtrl = TextEditingController();
  final TextEditingController noteCtrl = TextEditingController();

  String? selectedRoom;
  String? selectedMonth;
  DateTime? selectedDate;

  final List<String> roomList = [
    "A101",
    "A102",
    "B201",
  ];

  final List<String> months = [
    "1 tháng",
    "3 tháng",
    "6 tháng",
    "12 tháng",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tạo đặt phòng mới")
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Thông tin khách hàng", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildLabel("Họ tên"),
            _buildInput(nameCtrl, hint: "Nguyễn Văn A"),

            _buildLabel("Số điện thoại"),
            _buildInput(phoneCtrl, hint: "0901234567", keyboard: TextInputType.phone),

            _buildLabel("Email"),
            _buildInput(emailCtrl, hint: "email@example.com", keyboard: TextInputType.emailAddress),
            
            SizedBox(height: 12),
            Text("Thông tin đặt phòng", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            
            _buildLabel("Phòng"),
            _buildDropdown(
              value: selectedRoom,
              items: roomList,
              onChanged: (v) => setState(() => selectedRoom = v),
              hint: "Chọn phòng trống",
            ),

            _buildLabel("Ngày nhận phòng"),
            GestureDetector(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2035),
                );
                setState(() => selectedDate = date);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate == null
                          ? "mm/dd/yyyy"
                          : "${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}",
                      style: const TextStyle(fontSize: 15),
                    ),
                    const Icon(Icons.calendar_today_outlined, size: 18),
                  ],
                ),
              ),
            ),

            _buildLabel("Thời hạn thuê (tháng)"),
            _buildDropdown(
              value: selectedMonth,
              items: months,
              onChanged: (v) => setState(() => selectedMonth = v),
              hint: "Chọn thời hạn",
            ),

            _buildLabel("Tiền cọc (VND)"),
            _buildInput(depositCtrl, hint: "7000000", keyboard: TextInputType.number),

            _buildLabel("Ghi chú"),
            _buildInput(noteCtrl, hint: "Nhập ghi chú (tùy chọn)", keyboard: TextInputType.text),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Hủy"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Tạo đặt phòng"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 14),
      child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildInput(TextEditingController controller,
      {String? hint, TextInputType keyboard = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required String hint,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint),
          isExpanded: true,
          onChanged: onChanged,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        ),
      ),
    );
  }
}
