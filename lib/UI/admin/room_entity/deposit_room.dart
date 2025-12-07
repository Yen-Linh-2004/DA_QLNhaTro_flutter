import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/provider/PhongTroProvider.dart';
import 'package:flutter_application/data/model/PhongTro.dart';

class DepositPage extends StatefulWidget {
  final int idPhong;

  const DepositPage({super.key, required this.idPhong});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _noteController = TextEditingController();

  DateTime selectDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    // Load dữ liệu phòng khi widget được build
    Future.microtask(() {
      Provider.of<PhongTroProvider>(context, listen: false)
          .getPhongTrongById(widget.idPhong);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PhongTroProvider>(context);

    final PhongTro? phong =
        provider.phongTrongList.isNotEmpty ? provider.phongTrongList.first : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          phong != null ? "Đặt cọc phòng ${phong.tenPhong}" : "Đặt cọc phòng",
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : phong == null
              ? const Center(child: Text("Không tìm thấy thông tin phòng"))
              : _buildContent(context, phong),
      bottomSheet: phong == null ? null : _buildBottomActionButtons(context),
    );
  }

  Widget _buildContent(BuildContext context, PhongTro phong) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 100),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Thông Tin Phòng"),
            _buildRoomInfoCard(
              room: phong.tenPhong ?? "",
              area: "${phong.dienTich} m²",
              rent: "${phong.donGiaCoBan} VNĐ",
              deposit: "${phong.tienCoc} VNĐ",
            ),
            const SizedBox(height: 25),
            _buildSectionTitle("Thông Tin Liên Hệ"),
            _buildTextField("Họ và tên:", "Nhập họ và tên", _nameController),
            const SizedBox(height: 12),
            _buildTextField("Số điện thoại:", "Nhập số điện thoại", _phoneController),
            const SizedBox(height: 12),
            _buildTextField("Email:", "Nhập email", _emailController),
            const SizedBox(height: 12),
            _buildDatePickerField("Ngày dự kiến vào ở:", selectDate),
            const SizedBox(height: 14),
            _buildTextField("Ghi chú:", "Ghi chú thêm (không bắt buộc)", _noteController),
            const SizedBox(height: 14),
            _buildImportantNote(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[800]),
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
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.deepPurple[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow("Phòng:", room),
          const SizedBox(height: 8),
          _buildInfoRow("Diện tích:", area),
          const SizedBox(height: 8),
          _buildInfoRow("Giá thuê:", rent),
          const SizedBox(height: 8),
          _buildInfoRow("Tiền cọc:", deposit, isPrice: true),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isPrice = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 18)),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isPrice ? Colors.redAccent : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildImportantNote() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber, width: 1.5),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.warning_amber_outlined, color: Colors.orangeAccent),
            SizedBox(width: 8),
            Text("Lưu ý quan trọng",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.orangeAccent)),
          ]),
          Divider(color: Colors.amber),
          Text("• Tiền cọc hoàn trả khi kết thúc hợp đồng (trừ chi phí phát sinh)"),
          Text("• Có 3 ngày để ký hợp đồng sau khi đặt cọc"),
          Text("• Quá hạn sẽ không hoàn tiền"),
          Text("• Kiểm tra kỹ thông tin trước khi xác nhận"),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDatePickerField(String label, DateTime selectedDate) {
    return InkWell(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (picked != null && picked != selectedDate) {
          setState(() {
            selectDate = picked;
          });
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        child: Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
      ),
    );
  }

  Widget _buildBottomActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
                offset: const Offset(0, -3))
          ]),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.cancel),
                label: const Text("Hủy"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Gửi yêu cầu đặt cọc
                  print("📌 Gửi yêu cầu đặt cọc lên server...");
                },
                icon: const Icon(Icons.check_box),
                label: const Text("Xác nhận đặt cọc"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
