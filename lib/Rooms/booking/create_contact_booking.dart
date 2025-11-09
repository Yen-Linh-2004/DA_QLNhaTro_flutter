import 'package:flutter/material.dart';

class CreateContractPage extends StatelessWidget {
  const CreateContractPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tạo hợp đồng từ đặt phòng"),
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
            _sectionTitle("Thông tin đặt phòng"),
            _infoBox(children: const [
              _infoRow("Khách hàng:", "Nguyễn Thị Thanh Hải"),
              _infoRow("Phòng:", "A207"),
              _infoRow("Ngày nhận phòng:", "23/4/2024"),
              _infoRow("Thời hạn:", "6 tháng"),
            ]),

            const SizedBox(height: 16),
            _sectionTitle("Thông tin khách thuê & phòng"),
            TextField(
              decoration: _inputStyle("Khách thuê"),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField(
              decoration: _inputStyle("Phòng"),
              items: const [
                DropdownMenuItem(value: "A207", child: Text("A207 - Phòng gốc")),
                DropdownMenuItem(value: "A208", child: Text("A208")),
              ],
              onChanged: (value) {},
            ),

            const SizedBox(height: 16),
            _sectionTitle("Chi tiết hợp đồng"),
            TextField(decoration: _inputStyle("Số hợp đồng")),
            const SizedBox(height: 12),
            _datePickerField("Ngày ký hợp đồng"),
            const SizedBox(height: 12),
            _datePickerField("Ngày bắt đầu"),
            const SizedBox(height: 12),
            _datePickerField("Ngày kết thúc"),
            const SizedBox(height: 12),
            TextField(
              decoration: _inputStyle("Tiền cọc (VNĐ)"),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),
            _sectionTitle("Thông tin phòng"),
            _infoBox(children: const [
              _infoRow("Tiền thuê:", "2.600.000đ/Tháng"),
              _infoRow("Tiền cọc:", "2.600.000đ"),
              _infoRow("Điện:", "3.500đ/kWh"),
              _infoRow("Nước:", "60.000đ/Người/Tháng"),
              _infoRow("Wifi:", "50.000đ/Phòng/Tháng"),
              _infoRow("Rác:", "40.000đ/Phòng/Tháng"),
              _infoRow("Giữ xe:", "100.000đ/Phòng/Tháng"),
            ]),

            const SizedBox(height: 20),
            _sectionTitle("Dịch vụ bổ sung"),
            CheckboxListTile(
              value: true,
              title: const Text("Điện - 3.800đ/kWh"),
              onChanged: (_) {},
            ),
            CheckboxListTile(
              value: true,
              title: const Text("Nước - 15.000đ/m³"),
              onChanged: (_) {},
            ),
            CheckboxListTile(
              value: false,
              title: const Text("Internet - 50.000đ/Tháng"),
              onChanged: (_) {},
            ),
            CheckboxListTile(
              value: false,
              title: const Text("Internet - 100.000đ/Tháng"),
              onChanged: (_) {},
            ),
            CheckboxListTile(
              value: false,
              title: const Text("Rác - 40.000đ/Tháng"),
              onChanged: (_) {},
            ),
            CheckboxListTile(
              value: false,
              title: const Text("Giữ xe - 100.000đ/Tháng"),
              onChanged: (_) {},
            ),

            const SizedBox(height: 16),
            TextField(
              maxLines: 3,
              decoration: _inputStyle("Ghi chú"),
            ),

            const SizedBox(height: 24),
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
                    child: const Text("Tạo hợp đồng", style:  TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────── UI Helpers ───────────────────────────

  static Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      );

  static InputDecoration _inputStyle(String label) => InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      );

  static Widget _datePickerField(String label) => TextField(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        readOnly: true,
      );

  static Widget _infoBox({required List<Widget> children}) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F8FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: children),
      );
}

class _infoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _infoRow(this.label, this.value, {this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color ?? Colors.black)),
        ],
      ),
    );
  }
}
