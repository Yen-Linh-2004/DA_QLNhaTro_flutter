import 'package:flutter/material.dart';
import 'package:flutter_application/UI/users/RepairRequestDetail/update_repair.dart';
import 'package:flutter_application/data/model/Customer.dart';
import 'package:flutter_application/provider/CustomerProvider.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:provider/provider.dart';

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
    _fetchDetail();
  }

  void _fetchDetail() {
    Future.microtask(() async {
      final provider = Provider.of<CustomerProvider>(context, listen: false);
      await provider.fetchMaintainerRequestById(widget.id);
    });
  }

  String fomatLevel(String key) {
    switch (key) {
      case 'low':
        return 'Thấp';
      case 'medium':
        return 'Trung bình';
      case 'high':
        return 'Cao';
      case 'urgent':
        return 'Khẩn cấp';
      default:
        return key;
    }
  }

  String fomatCatalog(String key) {
    switch (key) {
      case 'electrical':
        return 'Điện';
      case 'plumbing':
        return 'Hệ thống nước';
      case 'appliance':
        return 'Điện lạnh';
      case 'furniture':
        return 'Nội thất';
      case 'other':
        return 'Khác';
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Consumer<CustomerProvider>(
        builder: (context, provider, child) {
          final detail = provider.maintenancedetail;
          if (provider.isLoadingdetail) {
            return const Center(child: CircularProgressIndicator());
          } else if (detail == null) {
            return _buildError();
          } else {
            return _buildContent(detail);
          }
        },
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Không thể tải dữ liệu", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: _fetchDetail, child: const Text("Thử lại")),
        ],
      ),
    );
  }

  Widget _buildContent(YeuCauSuaChuaKhachThue detail) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _infoCard("Thông tin cơ bản", [
            _infoRow("Tiêu đề", detail.tieuDe ?? "--"),
            _infoRow("Danh mục", fomatCatalog(detail.phanLoai) ?? "--"),
            _infoRow(
              "Ưu tiên",
              fomatLevel(detail.mucDoUuTien) ?? "--",
              valueColor: Colors.redAccent,
            ),
            _infoRow(
              "Trạng thái",
              detail.trangThai ?? "--",
              valueColor: _getStatusColor(detail.trangThai),
            ),
          ]),
          const SizedBox(height: 5),
          _infoCard("Thông tin xử lý", [
            _infoRow("Ngày tạo", detail.ngayYeuCau ?? "--"),
            _infoRow("Ngày hoàn thành", detail.ngayHoanThanh ?? "--"),
            _infoRow("Ngày phân công", detail.ngayPhanCong ?? "--"),
          ]),
          const SizedBox(height: 5),
          _infoCard("Chi phí", [
            _infoRow(
              "Chi phí ước tính",
              detail.chiPhiThucTe != null ? "${detail.chiPhiThucTe} VNĐ" : "--",
              valueColor: Colors.teal,
            ),
          ]),
          const SizedBox(height: 5),
          _infoCard("Mô tả vấn đề", [
            Text(detail.moTa ?? "--", style: const TextStyle(fontSize: 15)),
          ]),
          const SizedBox(height: 5),
          _infoCard("Ghi chú", [
            Text(detail.ghiChu ?? "--", style: const TextStyle(fontSize: 15)),
          ]),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildActionBtn(Icons.edit, "Chỉnh sửa", Colors.blue, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UpdateRepairPage(reportId: detail.maYeuCau),
                  ),
                );
              }),
              const SizedBox(width: 16),
              buildActionBtn(Icons.close, "Hủy yêu cầu", Colors.red, () {
                Navigator.pop(context);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String title, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            if (children.isEmpty)
              const Text(
                "Chưa có dữ liệu",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              )
            else
              ...children,
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: valueColor ?? Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case "đang xử lý":
      case "medium":
        return Colors.orange;
      case "hoàn thành":
        return Colors.green;
      case "hủy":
      case "cancelled":
        return Colors.red;
      default:
        return Colors.black87;
    }
  }
}
