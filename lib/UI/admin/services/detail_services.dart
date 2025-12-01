import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/services/update_service.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/data/model/DichVu.dart';
import 'package:flutter_application/provider/DichVuProvider.dart';
import 'package:provider/provider.dart';

class ServiceDetailPage extends StatefulWidget {
  final int maDichVu;

  const ServiceDetailPage({super.key, required this.maDichVu});

  @override
  State<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  @override
  void initState() {
    super.initState();

    // Load dữ liệu dịch vụ theo maDichVu
    Future.microtask(() {
      Provider.of<DichVuProvider>(context, listen: false)
          .fetchDichVuById(widget.maDichVu);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DichVuProvider>(
      builder: (context, provider, child) {
        if (provider.isLoadingdetail) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final DichVu? service = provider.DichVuDetail;

        if (service == null) {
          return const Scaffold(
            body: Center(child: Text("Không tìm thấy dữ liệu dịch vụ")),
          );
        }

        return _buildDetail(context, service);
      },
    );
  }

  Widget _buildDetail(BuildContext context, DichVu service) {
    final name = service.tenDichVu;
    final description = service.moTa ?? "Không có mô tả";
    final category = service.danhMuc;
    final price = service.donGiaApDung.toString();
    final usage = service.usageCount?.toString() ?? "0";
    final statusText = service.trangThaiHoatDong ? "Hoạt động" : "Ngưng hoạt động";

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
      appBar: AppBar(
        title: const Text(
          "Chi tiết dịch vụ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _valueTag(label: "Tên dịch vụ:", value: name, color: Colors.black54),
              const SizedBox(height: 12),
              _valueTag(label: "Mô tả:", value: description, color: Colors.black54),
              const SizedBox(height: 12),
              _smallTagRow(label: "Danh mục", value: category, tagColor: Colors.greenAccent),
              const SizedBox(height: 12),
              _valueTag(label: "Giá:", value: price, color: Colors.green),
              const SizedBox(height: 12),
              _valueTag(label: "Số phòng sử dụng", value: usage, color: Colors.black54),
              const SizedBox(height: 12),
              _valueTag(
                label: "Trạng thái",
                value: statusText,
                color: service.trangThaiHoatDong ? Colors.green : Colors.red,
              ),
              const SizedBox(height: 24),

              // Nút hành động
              Row(
                children: [
                  buildActionBtn(Icons.edit, "Chỉnh sửa", Colors.blue, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UpdateServicePage(),
                      ),
                    );
                  }),
                  const SizedBox(width: 15),
                  buildActionBtn(Icons.pause_circle_filled, "Tạm dừng", Colors.redAccent, () {
                    showConfirmDialog(
                      context: context,
                      title: "Xác nhận tạm dừng dịch vụ",
                      message: "Bạn có chắc chắn muốn tạm dừng cho dịch vụ này không?",
                      confirmColor: Colors.red,
                      icon: Icons.flash_on_outlined,
                      maxHeight: 140,
                      onConfirm: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Đã tạm dừng dịch vụ thành công!"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _valueTag({required String label, required String value, required Color color}) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(fontSize: 15)),
        const Spacer(),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }

  Widget _smallTagRow({required String label, required String value, required Color tagColor}) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(fontSize: 15)),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: tagColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: tagColor)),
        ),
      ],
    );
  }
}
