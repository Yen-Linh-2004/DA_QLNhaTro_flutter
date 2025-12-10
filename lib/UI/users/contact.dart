import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../provider/CustomerProvider.dart';
class ContractPage extends StatefulWidget {
  const ContractPage({super.key});

  @override
  State<ContractPage> createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {
  static const Color primaryColor = Colors.teal;
  static const Color highlightColor = Colors.deepOrange;

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final customerProvider = Provider.of<CustomerProvider>(context, listen: false);
      await customerProvider.fetchContactInfo();
    });
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Consumer<CustomerProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.ContactList == null || provider.ContactList!.isEmpty) {
            return const Center(child: Text("Không có hợp đồng"));
          }

          final contract = provider.ContactList!.first;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildContractInfo(contract),
                const SizedBox(height: 20),
                _buildImportantNotice(contract),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContractInfo(contract) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(Icons.description_outlined, "Thông tin cơ bản"),
          const Divider(height: 16, color: Colors.black12),

          _infoRow("Số hợp đồng:", contract.soHopDong ?? ""),
          _infoRow("Phòng:", contract.tenPhong ?? ""),
          _infoRow("Người thuê:", contract.tenKhachThue ?? ""),
          _infoRow("Số điện thoại:", contract.sdt ?? ""),

          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Text("Trạng thái: ", style: TextStyle(color: Colors.black54)),
                Chip(
                  label: Text(
                    contract.trangThai ?? "",
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  backgroundColor: (contract.trangThai == "DangHieuLuc")
                      ? Colors.green.shade600
                      : Colors.grey,
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
          _contractDuration(contract),
          const SizedBox(height: 20),

          _monthlyCost(contract),
          const SizedBox(height: 20),

          _depositSection(contract),
        ],
      ),
    );
  }

  Widget _contractDuration(contract) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.calendar_month, color: primaryColor, size: 20),
              SizedBox(width: 6),
              Text("Thời hạn hợp đồng",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: primaryColor)),
            ],
          ),
          const Divider(color: Colors.black12, height: 16),

          _durationRow("Ngày ký:", formatDate(contract.ngayKy)),
          _durationRow("Bắt đầu:", formatDate(contract.ngayBatDau)),
          _durationRow("Kết thúc:", formatDate(contract.ngayKetThuc)),
        ],
      ),
    );
  }

  Widget _monthlyCost(contract) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.payments_outlined, color: Colors.green.shade700, size: 20),
              const SizedBox(width: 6),
              Text("Chi phí hàng tháng",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green.shade700)),
            ],
          ),
          const Divider(color: Colors.black12, height: 16),

          _infoRow("Tiền thuê:", formatCurrency(contract.tienThueHangThang)),

          const SizedBox(height: 10),
          _serviceSection(contract),
        ],
      ),
    );
  }

  Widget _serviceSection(contract) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Dịch vụ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const Divider(height: 10, color: Colors.black12),

          ...contract.dichVu!.map((svc) => _infoRow(
                "${svc.tenDichVu}:",
                "${formatCurrency(svc.donGiaApDung)} x ${svc.soLuong} ${svc.donViTinh}",
                isSmall: true,
              )),
        ],
      ),
    );
  }

  Widget _depositSection(contract) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: highlightColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_balance_wallet_outlined, color: highlightColor, size: 20),
              const SizedBox(width: 6),
              Text("Tiền cọc", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: highlightColor)),
            ],
          ),

          const Divider(height: 16, color: Colors.black12),
          _infoRow("Số tiền:", formatCurrency(contract.tienCoc), color: highlightColor, isBold: true),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.lightbulb_outline, size: 14, color: Colors.black54),
              SizedBox(width: 4),
              Text("Tiền cọc = 1 tháng tiền thuê", style: TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImportantNotice(contract) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 250, 235),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_outlined, color: Colors.orange.shade700),
              const SizedBox(width: 8),
              Text("Lưu ý quan trọng",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange.shade700, fontSize: 16)),
            ],
          ),
          Divider(height: 15, color: Colors.amberAccent),
          _notePoint("Hợp đồng sẽ hết hạn vào ${formatDate(contract.ngayKetThuc)}"),
          _notePoint("Liên hệ quản lý trước 30 ngày để gia hạn"),
          _notePoint("Tiền cọc được hoàn trả khi kết thúc hợp đồng (trừ phát sinh)"),
          _notePoint("Mọi thay đổi cần có văn bản xác nhận"),
        ],
      ),
    );
  }

  Widget _notePoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• "),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  // Format tiền
  String formatCurrency(num? value) {
    if (value == null) return "0 ₫";
    return "${value.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.')} ₫";
  }

  static Widget _infoRow(String label, String value,
      {Color? color, bool isBold = false, bool isSmall = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text(label, style: const TextStyle(color: Colors.black54))),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: color ?? Colors.black87,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: isSmall ? 14 : 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _durationRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label)),
          Text(value),
        ],
      ),
    );
  }

  Widget _sectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 20, color: primaryColor),
        const SizedBox(width: 6),
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor)),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4)),
      ],
    );
  }
}
