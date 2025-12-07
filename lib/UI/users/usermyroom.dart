import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/Khachthue.dart';
import 'package:provider/provider.dart';
import '../../provider/CustomerProvider.dart';
import '../../data/model/Customer.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CustomerProvider>(context, listen: false).fetchRoomInfo();
      Provider.of<CustomerProvider>(context, listen: false).fetchRoomStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Consumer<CustomerProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.RoomList.isEmpty) {
            return const Center(child: Text("Không có dữ liệu phòng"));
          }

          if (provider.roomStatusList.isEmpty) {
            return const Center(child: Text("Không có dữ liệu phòng tổng hợp"));
          }

          final room = provider.RoomList.first;
          final khachchinh = provider.roomStatusList.expand((e) => e.danhSachNguoiThue).where((tv) => tv.vaiTro == "KHÁCH_CHÍNH").toList();
          final thanhVien = provider.roomStatusList.expand((e) => e.danhSachNguoiThue).where((tv) => tv.vaiTro == "THÀNH_VIÊN").toList();
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 6,
              radius: const Radius.circular(12),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    // ==== THÔNG TIN PHÒNG ====
                    _sectionTitle("Thông tin phòng", Icons.home_outlined),
                    _roomInfoCard(room),

                    const SizedBox(height: 20),

                    // ==== NGƯỜI THUÊ CHÍNH ====
                    _sectionTitle("Người thuê chính", Icons.person_pin_outlined),
                    _mainTenantCard(khachchinh),

                    const SizedBox(height: 20),

                    // ==== DANH SÁCH THÀNH VIÊN ====
                    _sectionTitle("Thành viên trong phòng", Icons.group_outlined),
                    SizedBox(height: 10),
                    _membersCard(thanhVien),
                  ],
                ),
              )
            )
          );
        },
      ),
    );
  }

  // ============================
  //  COMPONENTS
  // ============================

  Widget _sectionTitle(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 24),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // ======= CARD: THÔNG TIN PHÒNG =======
  Widget _roomInfoCard(ThongTinPhong room) {
    final phong = room.phongTro;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(phong.tenPhong,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue.shade800)),
              // Chip(
              //   label: Text(phong.trangThai.name, style: const TextStyle(color: Colors.white)),
              //   backgroundColor: Colors.green,
              // )
            ],
          ),

          const SizedBox(height: 12),
          const Divider(),
          _infoRow("Tầng:", "Tầng 5", Icons.layers_outlined),
          _infoRow("Diện tích:", "${phong.dienTich} m²", Icons.square_foot),
          _infoRow("Loại phòng:", "Phòng góc 2 cửa số", Icons.house_outlined),
          _infoRow("Ngày vào ở:", "28/04/2025", Icons.date_range),
          const SizedBox(height: 10),

          _infoRow(
            "Giá thuê:",
            "2.700.000₫/tháng",
            Icons.monetization_on,
            color: Colors.green.shade700,
            bold: true,
          ),
          _infoRow(
            "Tiền cọc:",
            "2.700.000₫",
            Icons.monetization_on,
            color: Colors.green.shade700,
            bold: true,
          )
        ],
      ),
    );
  }

  // ======= CARD: NGƯỜI THUÊ CHÍNH =======
  Widget _mainTenantCard(KhachThue kh) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _box(color: Colors.blue.shade50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(kh.hoTen,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Chip(
                label: Text("Chủ hợp đồng", style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.blue,
              )
            ],
          ),

          const Divider(),
          _detail(Icons.phone, kh.sdt1 ?? "Không có số điện thoại"),
          _detail(Icons.email_outlined, kh.email ?? "Không có email"),
        ],
      ),
    );
  }

  // ======= CARD: DANH SÁCH THÀNH VIÊN PHÒNG =======
 Widget _membersCard(List<KhachThue> members) {
    if (members.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(18),
        decoration: _box(),
        child: const Text("Không có thành viên trong phòng"),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _box(),
      child: Column(
        children: members.map((tv) {
          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.orange.shade100,
                  child: Text(
                    tv.hoTen[0].toUpperCase(),
                    style: TextStyle(
                        color: Colors.orange.shade800,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(tv.hoTen,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Số điện thoại: ${tv.sdt1}", style: const TextStyle(fontSize: 13, color: Colors.black54)),
                    Text("Email: ${tv.email}", style: const TextStyle(fontSize: 13, color: Colors.black54)),
                  ],
                ),
                trailing:
                    const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ),
              const Divider(),
            ],
          );
        }).toList(),
      ),
    );
  }

  // ====================================
  //             SUPPORT UI
  // ====================================

  Widget _infoRow(String label, String value, IconData icon,
      {Color? color, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(label)),
          Text(
            value,
            style: TextStyle(
              color: color ?? Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.black54),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    );
  }

  BoxDecoration _box({Color color = Colors.white}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 3)),
      ],
    );
  }

  String _currency(double v) {
    return "${v.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => '.')} đ";
  }
}
