import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/data/model/ThietBi.dart';
import 'package:flutter_application/provider/ThietBiProvider.dart';
import 'package:flutter_application/UI/admin/devices/update_device.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';

class DeviceDetailPage extends StatefulWidget {
  final int deviceId; // Chuyển sang String để đồng bộ với Provider
  const DeviceDetailPage({super.key, required this.deviceId});

  @override
  State<DeviceDetailPage> createState() => _DeviceDetailPageState();
}

class _DeviceDetailPageState extends State<DeviceDetailPage> {
  @override
  void initState() {
    super.initState();

    // Load chi tiết thiết bị từ Provider
    Future.microtask(() {
      Provider.of<ThietBiProvider>(context, listen: false)
          .fetchThietBiById(widget.deviceId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThietBiProvider>(
      builder: (context, provider, child) {
        if (provider.isLoadingDetail) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final ThietBi? device = provider.ThietBiDetail;

        if (device == null) {
          return const Scaffold(
            body: Center(child: Text("Không tìm thấy thiết bị")),
          );
        }

        return _buildDetail(context, device);
      },
    );
  }

  Widget _buildDetail(BuildContext context, ThietBi device) {
    final statusText = device.tinhTrang.toLowerCase() == 'active'
        ? "Hoạt động"
        : "Ngưng hoạt động";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết thiết bị",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.devices, color: Colors.blueAccent),
                        SizedBox(width: 8),
                        Text("Thông tin cơ bản",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _infoRow("Tên thiết bị:", device.tenThietBi),
                    _infoRow("Mã thiết bị:", device.maThietBi.toString()),
                    _infoTagRow(
                        "Danh mục:", device.loaiThietBi ?? "-", Colors.orangeAccent.shade100),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.build, color: Colors.blueAccent),
                        SizedBox(width: 8),
                        Text("Mua sắm & Bảo trì",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _infoRow("Ngày mua:", device.ngayMua.toString()),
                    _infoRow("Giá mua:", device.giaMua?.toString() ?? "-", highlight: Colors.green),
                    _infoRow("Trạng thái:", statusText),
                    _infoRow("Ngày bảo hành:", device.baoHanh ?? "-"),
                    _infoRow("Lần bảo trì cuối:", device.baoTriLanCuoi?.toString() ?? "-"),
                    _infoRow("Lần bảo trì kế tiếp:", device.baoTriLanSau?.toString() ?? "-"),
                    _infoRow("Ghi chú:", device.ghiChu ?? "-"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                buildActionBtn(Icons.delete, "Xóa", Colors.redAccent, () {
                  showConfirmDialog(
                    context: context,
                    title: "Xác nhận xóa thiết bị",
                    message: "Bạn có chắc chắn muốn xóa thiết bị này không?",
                    confirmColor: Colors.redAccent,
                    icon: Icons.delete_forever,
                    maxHeight: 140,
                    onConfirm: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Đã xóa thiết bị thành công!"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                  );
                }),
                const SizedBox(width: 15),
                buildActionBtn(Icons.edit, "Chỉnh sửa", Colors.blue, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => UpdateDevicesPage()),
                  );
                }),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, {Color? highlight}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: highlight ?? Colors.black87,
                fontSize: 14,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTagRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
