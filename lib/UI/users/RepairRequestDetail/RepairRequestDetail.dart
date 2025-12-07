import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/Customer.dart';
import 'package:flutter_application/provider/CustomerProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';

class RepairRequestDetailPage extends StatefulWidget {
  final int id; 

  const RepairRequestDetailPage({super.key, required this.id});

  @override
  State<RepairRequestDetailPage> createState() =>
      _RepairRequestDetailPageState();
}

class _RepairRequestDetailPageState extends State<RepairRequestDetailPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CustomerProvider>(context, listen: false)
          .fetchMaintainerRequestById(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvider>(context);
    final detail = provider.maintenancedetail;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Chi tiết yêu cầu bảo trì",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          : detail == null
              ? _buildError(context)
              : _buildContent(detail),
    );
  }

  // ❌ UI khi lỗi hoặc không có dữ liệu
  Widget _buildError(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Không thể tải dữ liệu", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Provider.of<CustomerProvider>(context, listen: false)
                  .fetchMaintainerRequestById(widget.id);
            },
            child: const Text("Thử lại"),
          )
        ],
      ),
    );
  }

  // ✅ UI hiển thị nội dung thật từ API
  Widget _buildContent(YeuCauSuaChuaKhachThue detail) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _infoCard("Thông tin cơ bản", [
            _infoRow("Tiêu đề", detail.tieuDe ?? "—"),
            _infoRow("Danh mục", detail.phanLoai ?? "—"),
            _infoRow("Ưu tiên", detail.mucDoUuTien ?? "—",
                valueColor: Colors.redAccent),
            _infoRow("Trạng thái", detail.trangThai ?? "—",
                valueColor: Colors.orange),
          ]),

          const SizedBox(height: 12),

          _infoCard("Thông tin xử lý", [
            _infoRow("Ngày tạo", detail.ngayYeuCau ?? "—"),
            _infoRow("Ngày cập nhật", detail.ngayHoanThanh ?? "—"),
          ]),

          const SizedBox(height: 12),

          _infoCard("Chi phí", [
            _infoRow("Chi phí ước tính",
                "${detail.chiPhiThucTe?.toString() ?? '--'} VNĐ",
                valueColor: Colors.teal),
          ]),

          const SizedBox(height: 12),

          _infoCard("Mô tả vấn đề", [
            Text(
              detail.moTa ?? "Không có mô tả",
              style: const TextStyle(fontSize: 15),
            )
          ]),

          const SizedBox(height: 12),

          _infoCard("Ghi chú", [
            Text(
              detail.ghiChu ?? "Không có ghi chú",
              style: const TextStyle(fontSize: 15),
            )
          ]),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildActionBtn(Icons.edit, "Chỉnh sửa", Colors.blue, () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) =>
                //         UpdateRepairPage(id: detail.id ?? 0),
                //   ),
                // );
              }),

              buildActionBtn(Icons.close, "Hủy yêu cầu", Colors.red, () {
                Navigator.pop(context);
              }),
            ],
          ),
        ],
      ),
    );
  }

  // ----------- Widget hỗ trợ -----------

  Widget _infoCard(String title, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...children
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(
            value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: valueColor ?? Colors.black87),
          )
        ],
      ),
    );
  }
}
