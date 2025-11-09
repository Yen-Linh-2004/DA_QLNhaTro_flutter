import 'package:flutter/material.dart';

class RefundFullPage extends StatefulWidget {
  const RefundFullPage({super.key});
  @override
  State<RefundFullPage> createState() => _RefundFullPage();
}

class _RefundFullPage extends State<RefundFullPage> {
  String? selectedReason = "Chọn lý do"; 
  final List<String> reason = [
    "Chọn lý do",
    "Khách hàng hủy đặt phòng",
    "Phòng không còn trống",
    "Sự cố bảo trì",
    "Vi phạm chính sách",
    "Đặt phòng trùng lặp"
    "Lý do khác",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hoàn tiền đầy đủ"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thông tin đặt phòng
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F8FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Thông tin đặt phòng",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 12),
                  _InfoRow(label: "Khách hàng:", value: "Nguyễn Thị Thanh Hải"),
                  _InfoRow(label: "Phòng:", value: "A207"),
                  _InfoRow(
                    label: "Tiền cọc gốc:",
                    value: "2.600.000đ",
                    valueColor: Colors.green,
                  ),
                  _InfoRow(label: "Ngày đặt:", value: "10/3/2024"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text("Số tiền hoàn *"),
            const SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Nhập số tiền hoàn",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Tối đa: 2.600.000đ",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),

            const SizedBox(height: 20),
            const Text("Lý do hoàn tiền *"),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedReason,
              items: reason
                  .map(
                    (r) => DropdownMenuItem<String>(value: r, child: Text(r)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedReason = value; // gán đúng biến selectedRoom
                });
              },
              decoration: InputDecoration(border: OutlineInputBorder( borderRadius: BorderRadius.circular(8),)),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng lý do hoàn tiền";
                }
                return null;
              },
            ),

            const SizedBox(height: 20),
            const Text("Ghi chú thêm"),
            const SizedBox(height: 8),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Nhập ghi chú...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 25),
            // Tóm tắt hoàn tiền
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFCE8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Tóm tắt hoàn tiền",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 12),
                  _InfoRow(label: "Tiền cọc gốc:", value: "2.600.000đ"),
                  _InfoRow(
                    label: "Số tiền hoàn:",
                    value: "2.600.000đ",
                    valueColor: Colors.green,
                  ),
                  _InfoRow(
                    label: "Số tiền giữ lại:",
                    value: "0đ",
                    valueColor: Colors.red,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Xác nhận hoàn tiền",
                      style: TextStyle(color: Colors.white),
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

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black87)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
