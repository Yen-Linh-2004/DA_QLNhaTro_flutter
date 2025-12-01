import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/customers/update_customer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/provider/khachthueProvider.dart';
import 'package:flutter_application/data/model/KhachThue.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:intl/intl.dart';

class CustomerDetailPage extends StatefulWidget {
  final int khachThueId; 
  const CustomerDetailPage({required this.khachThueId, Key? key}) : super(key: key);

  @override
  State<CustomerDetailPage> createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  @override
  void initState() {
    super.initState();
    // Fetch dữ liệu khi mở trang
    Future.microtask(() {
      Provider.of<KhachThueProvider>(context, listen: false)
          .fetchKhachThueById(widget.khachThueId);
    });
  }

  // ---------------------- FORMAT DATE ----------------------
  String formatDate(dynamic date) {
    if (date == null) return "";
    
    DateTime? dt;

    if (date is String) {
      try {
        dt = DateTime.parse(date);
      } catch (e) {
        print("Lỗi parse String -> DateTime: $e");
        return date;
      }
    } else if (date is DateTime) {
      dt = date;
    } else {
      return date.toString();
    }

    return DateFormat('dd/MM/yyyy').format(dt);
  }

  // ---------------------- BUILD ----------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chi tiết khách thuê",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<KhachThueProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final KhachThue? khachThue = provider.khachThueDetail;

          if (khachThue == null) {
            return const Center(child: Text("Không tìm thấy khách thuê!"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------- THÔNG TIN CÁ NHÂN ----------
                const Text("Thông tin cá nhân",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF4FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _buildInfoSection({
                    "Họ tên": khachThue.hoTen,
                    "Ngày sinh": formatDate(khachThue.ngaySinh),
                    "Nơi sinh": khachThue.noiSinh ?? '--',
                    "CMND/CCCD": khachThue.cccd ?? '--',
                    "Ngày cấp": formatDate(khachThue.ngayCapCCCD),
                    "Nơi cấp": khachThue.noiCapCCCD ?? '--',
                  }),
                ),
                const SizedBox(height: 16),

                // ---------- THÔNG TIN LIÊN HỆ ----------
                const Text("Thông tin liên hệ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9F9EE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _buildInfoSection({
                    "Điện thoại 1": khachThue.sdt1 ?? '--',
                    "Điện thoại 2": khachThue.sdt2 ?? '--',
                    "Email": khachThue.email ?? '--',
                    "Địa chỉ thường trú": khachThue.diaChiThuongTru ?? '--',
                    "Số xe": khachThue.bienSoXe ?? '--',
                    "Ghi chú": khachThue.ghiChu ?? '--',
                  }),
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    buildActionBtn(Icons.update, "Chỉnh sửa", Colors.blue, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => UpdateCustomerPage()),
                        );
                    }),
                    const SizedBox(width: 10),
                    buildActionBtn(Icons.close, "Xóa", Colors.redAccent, () {
                      showConfirmDialog(
                        context: context,
                        title: "Xác nhận xóa khách thuê",
                        message: "Bạn có chắc chắn muốn xóa khách thuê này không?",
                        confirmColor: Colors.redAccent,
                        icon: Icons.delete_forever,
                        maxHeight: 140,
                        onConfirm: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Đã xóa khách thuê thành công!"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  // ---------------------- WIDGET PHỤ ----------------------
  Widget _buildInfoSection(Map<String, String?> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data.entries
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text("${e.key}:",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black54)),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      e.value ?? '--',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
