import 'package:flutter/material.dart';
import 'package:flutter_application/shared/buildCard.dart';
import 'package:flutter_application/shared/input_field.dart';

class DepositPage extends StatefulWidget{
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPage();
}
class _DepositPage extends State<DepositPage> {

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _noteController = TextEditingController();

  DateTime selectDate = DateTime(2025, 1, 1); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Đặt cọc phòng B205",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 100), // Khoảng trống cho nút cố định
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- THÔNG TIN PHÒNG ---
              _buildSectionTitle("Thông Tin Phòng"),
              _buildRoomInfoCard(
                room: "B205",
                area: "25m²",
                rent: "2.600.000 VNĐ",
                deposit: "2.600.000 VNĐ",
              ),
              SizedBox(height: 25),

              // --- THÔNG TIN CÁ NHÂN & NGÀY DỰ KIẾN ---
              _buildSectionTitle("Thông Tin Liên Hệ"),

              buildTextField("Họ và tên:", "Nhập họ và tên", _nameController),
              SizedBox(height: 12),
              buildTextField("Số điện thoại:", "Nhập số điện thoại", _phoneController),
              SizedBox(height: 12),
              buildTextField( "Email:","Nhập email",_emailController),
              SizedBox(height: 12),
              buildDatePickerField(context, "Ngày dự kiến vào ở:", selectDate, (date) {setState(() { selectDate = date;  });}),
              SizedBox(height: 14),
              buildContendField("Ghi Chú:", "Ghi chú thêm (không bắt buộc)", _noteController, context),
              SizedBox(height: 14),
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
      padding: EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blue[800],
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
      width: double.maxFinite,
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple[50], // Nền nhẹ
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow("Phòng:  ", room), SizedBox(height: 8),
          _buildInfoRow("Diện tích:  ", area), SizedBox(height: 8),
          _buildInfoRow("Giá thuê:  ", rent), SizedBox(height: 8),
          _buildInfoRow("Tiền cọc:  ", deposit, isPrice: true),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label1, String value1, { bool isPrice = false }) {
    TextStyle valueStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 18,
      color: isPrice ? Colors.redAccent : Colors.black87,
    );
    return Row( 
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label1, style: TextStyle(color: Colors.black, fontSize: 18)),
        Text(value1, style: valueStyle),
      ]
    );
  }

  Widget _buildImportantNote() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.amber[50], // Nền vàng nhạt
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_outlined,
                color: Colors.amber[800],
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                "Lưu ý quan trọng",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.orangeAccent,
                ),
              ),
            ],
          ),
          Divider(color: Colors.amber, height: 15),
          _buildNotePoint(
            "Tiền cọc sẽ được hoàn trả khi kết thúc hợp đồng (trừ các khoản phát sinh)",
          ),
          _buildNotePoint(
            "Sau khi đặt cọc, bạn có 3 ngày để hoàn tất thủ tục ký hợp đồng",
          ),
          _buildNotePoint(
            "Nếu không ký hợp đồng trong thời hạn, tiền cọc sẽ không được hoàn trả",
          ),
          _buildNotePoint("Vui lòng kiểm tra kỹ thông tin trước khi xác nhận"),
        ],
      ),
    );
  }

  Widget _buildNotePoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: TextStyle(fontSize: 15, color: Colors.black87)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.black87,
              ),
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
            offset: Offset(0, -3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SafeArea(
        child: Row(
          children: [
            buildActionBtn(Icons.cancel, "Hủy", Colors.blueGrey, () => Navigator.pop(context)),
            SizedBox(width: 10),
            buildActionBtn(Icons.check_box, "Xác nhận đặt cọc", Colors.blue, (){
              print("Xác nhận đặt cọc");
            }),
          ],
        ),
      ),
    );
  }
}
