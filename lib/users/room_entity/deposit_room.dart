import 'package:flutter/material.dart';

class DepositPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Đặt cọc phòng B205",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        // centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        // Nút Đóng (X)
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.close, color: Colors.grey),
        //     onPressed: () => Navigator.pop(context),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100), // Khoảng trống cho nút cố định
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // --- 1. THÔNG TIN PHÒNG ---
              _buildSectionTitle("Thông Tin Phòng"),
              _buildRoomInfoCard(
                room: "B205",
                area: "25m²",
                rent: "2.600.000 VNĐ",
                deposit: "2.600.000 VNĐ",
              ),
              
              const SizedBox(height: 25),

              // --- 2. THÔNG TIN CÁ NHÂN & NGÀY DỰ KIẾN ---
              _buildSectionTitle("Thông Tin Liên Hệ"),
              
              // Họ và Tên & Số điện thoại (Trên cùng 1 hàng)
              Row(
                children: <Widget>[
                  Expanded(
                    child: _buildTextField(
                      label: "Họ và tên *",
                      hintText: "Nhập họ và tên",
                      icon: Icons.person_outline,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildTextField(
                      label: "Số điện thoại *",
                      hintText: "Nhập số điện thoại",
                      keyboardType: TextInputType.phone,
                      icon: Icons.phone_android_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Email
              _buildTextField(
                label: "Email",
                hintText: "Nhập email",
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 15),

              // Ngày dự kiến vào ở
              _buildDateField(
                label: "Ngày dự kiến vào ở *",
                hintText: "mm/dd/yyyy",
              ),
              const SizedBox(height: 25),

              // --- 3. GHI CHÚ ---
              _buildSectionTitle("Ghi Chú"),
              _buildNoteField(),
              
              const SizedBox(height: 25),

              // --- 4. LƯU Ý QUAN TRỌNG ---
              _buildImportantNote(),
            ],
          ),
        ),
      ),
      // --- NÚT HÀNH ĐỘNG CỐ ĐỊNH ---
      bottomSheet: _buildBottomActionButtons(context),
    );
  }

  // --- WIDGET BUILDING FUNCTIONS ---

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple[800],
        ),
      ),
    );
  }

  Widget _buildRoomInfoCard({
    required String room,
    required String area,
    required String rent,
    required String deposit,
  }) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple[50], // Nền nhẹ
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          _buildInfoRow("Phòng:", room, "Diện tích:", area),
          const SizedBox(height: 8),
          _buildInfoRow("Giá thuê:", rent, "Tiền cọc:", deposit, isPrice: true),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label1, String value1, String label2, String value2, {bool isPrice = false}) {
    TextStyle valueStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: isPrice ? Colors.redAccent : Colors.black87,
    );
    return Row(
      children: <Widget>[
        Expanded(
          child: RichText(
            text: TextSpan(
              text: label1 + " ",
              style: const TextStyle(color: Colors.black54, fontSize: 15),
              children: <TextSpan>[
                TextSpan(text: value1, style: valueStyle),
              ],
            ),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: label2 + " ",
              style: const TextStyle(color: Colors.black54, fontSize: 15),
              children: <TextSpan>[
                TextSpan(text: value2, style: valueStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildTextField({
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
  }) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: icon != null ? Icon(icon, color: Colors.deepPurple) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
    );
  }
  
  Widget _buildDateField({required String label, required String hintText}) {
    return TextField(
      readOnly: true, // Không cho phép nhập trực tiếp
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        suffixIcon: const Icon(Icons.calendar_today_outlined, color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
      onTap: () {
        // Mở DatePicker khi người dùng nhấn
      },
    );
  }

  Widget _buildNoteField() {
    return TextField(
      maxLines: 4,
      decoration: InputDecoration(
        hintText: "Ghi chú thêm (không bắt buộc)",
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
        ),
        contentPadding: EdgeInsets.all(15),
      ),
    );
  }

  Widget _buildImportantNote() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.amber[50], // Nền vàng nhạt
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.warning_amber_outlined, color: Colors.amber[800], size: 24),
              const SizedBox(width: 8),
              Text(
                "Lưu ý quan trọng",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.amber[800],
                ),
              ),
            ],
          ),
          const Divider(color: Colors.amber, height: 15),
          _buildNotePoint("Tiền cọc sẽ được hoàn trả khi kết thúc hợp đồng (trừ các khoản phát sinh)"),
          _buildNotePoint("Sau khi đặt cọc, bạn có 3 ngày để hoàn tất thủ tục ký hợp đồng"),
          _buildNotePoint("Nếu không ký hợp đồng trong thời hạn, tiền cọc sẽ không được hoàn trả"),
          _buildNotePoint("Vui lòng kiểm tra kỹ thông tin trước khi xác nhận"),
        ],
      ),
    );
  }

  Widget _buildNotePoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("• ", style: TextStyle(fontSize: 15, color: Colors.black87)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.4, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionButtons(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SafeArea(
        child: Row(
          children: <Widget>[
            // Nút Hủy (Outline Button)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  side: const BorderSide(color: Colors.deepPurple, width: 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  "Hủy",
                  style: TextStyle(fontSize: 16, color: Colors.deepPurple, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Nút Xác nhận đặt cọc (Elevated Button)
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý logic đặt cọc
                  print("Xác nhận đặt cọc");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                ),
                child: const Text(
                  "Xác nhận đặt cọc",
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}