import 'package:flutter/material.dart';

class CreateContractPage extends StatelessWidget {
 const CreateContractPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tạo hợp đồng từ đặt phòng", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
            _sectionTitle("Thông tin đặt phòng"),
            _infoBox(children: [
              _infoRow("Khách hàng:", "Nguyễn Thị Thanh Hải"),
              _infoRow("Phòng:", "A207"),
              _infoRow("Ngày nhận phòng:", "23/4/2024"),
              _infoRow("Thời hạn:", "6 tháng"),
            ]),

            SizedBox(height: 16),
            _sectionTitle("Thông tin khách thuê & phòng"),
            TextField(
              decoration: _inputStyle("Khách thuê"),
            ),
            SizedBox(height: 12),
            DropdownButtonFormField(
              decoration: _inputStyle("Phòng"),
              items: [
                DropdownMenuItem(value: "A207", child: Text("A207 - Phòng gốc")),
                DropdownMenuItem(value: "A208", child: Text("A208")),
              ],
              onChanged: (value) {},
            ),

            SizedBox(height: 16),
            _sectionTitle("Chi tiết hợp đồng"),
            TextField(decoration: _inputStyle("Số hợp đồng")),
            SizedBox(height: 12),
            _datePickerField("Ngày ký hợp đồng"),
            SizedBox(height: 12),
            _datePickerField("Ngày bắt đầu"),
            SizedBox(height: 12),
            _datePickerField("Ngày kết thúc"),
            SizedBox(height: 12),
            TextField(
              decoration: _inputStyle("Tiền cọc (VNĐ)"),
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 20),
            _sectionTitle("Thông tin phòng"),
            _infoBox(children: [
              _infoRow("Tiền thuê:", "2.600.000đ/Tháng"),
              _infoRow("Tiền cọc:", "2.600.000đ"),
              _infoRow("Điện:", "3.500đ/kWh"),
              _infoRow("Nước:", "60.000đ/Người/Tháng"),
              _infoRow("Wifi:", "50.000đ/Phòng/Tháng"),
              _infoRow("Rác:", "40.000đ/Phòng/Tháng"),
              _infoRow("Giữ xe:", "100.000đ/Phòng/Tháng"),
            ]),

            SizedBox(height: 20),
            _sectionTitle("Dịch vụ bổ sung"),
            CheckboxListTile(
              value: true,
              title: Text("Điện - 3.800đ/kWh"),
              onChanged: (_) {},
            ),
            CheckboxListTile(
              value: true,
              title: Text("Nước - 15.000đ/m³"),
              onChanged: (_) {},
            ),
            CheckboxListTile(
              value: false,
              title: Text("Internet - 50.000đ/Tháng"),
              onChanged: (_) {},
            ),
            CheckboxListTile(
              value: false,
              title: Text("Internet - 100.000đ/Tháng"),
              onChanged: (_) {},
            ),
            CheckboxListTile(
              value: false,
              title: Text("Rác - 40.000đ/Tháng"),
              onChanged: (_) {},
            ),
            CheckboxListTile(
              value: false,
              title: Text("Giữ xe - 100.000đ/Tháng"),
              onChanged: (_) {},
            ),

            SizedBox(height: 16),
            TextField(
              maxLines: 3,
              decoration: _inputStyle("Ghi chú"),
            ),

            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Hủy"),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {},
                    child: Text("Tạo hợp đồng", style:  TextStyle(color: Colors.white),),
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
        padding: EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      );

  static InputDecoration _inputStyle(String label) => InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      );

  static Widget _datePickerField(String label) => TextField(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        readOnly: true,
      );

  static Widget _infoBox({required List<Widget> children}) => Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFF4F8FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: children),
      );
}

class _infoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  _infoRow(this.label, this.value, {this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
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
