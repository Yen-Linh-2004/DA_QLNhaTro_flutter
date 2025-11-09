import 'package:flutter/material.dart';

class DeviceDetailPage extends StatelessWidget {
  final String deviceName;
  final String deviceId;
  final String catalog;
  final String room;
  final String status;
  final String dateBuy;
  final String price;
  final String dateWarranty;
  final String lastMaintenance;
  final String nextMaintenance;
  final String note;

  const DeviceDetailPage({
    super.key,
    required this.deviceName,
    required this.deviceId,
    required this.catalog,
    required this.room,
    required this.status,
    required this.dateBuy,
    required this.price,
    required this.dateWarranty,
    required this.lastMaintenance,
    required this.nextMaintenance,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chi tiết thiết bị")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Thông tin cơ bản",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _infoRow("Tên thiết bị:", deviceName),
            _infoRow("Mã thiết bị:", deviceId),
            _infoTagRow("Danh mục:", catalog),
            _infoRow("Phòng:", room),
            _infoTagRow("Tình trạng:", status),

            const SizedBox(height: 20),
            const Text("Thông tin mua sắm & bảo trì",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _infoRow("Ngày mua:", dateBuy),
            _infoRow("Giá mua:", price, highlight: Colors.green),
            _infoRow("Bảo hành đến:", dateWarranty),
            _infoRow("Bảo trì lần cuối:", lastMaintenance),
            _infoRow("Bảo trì tiếp theo:", nextMaintenance, highlight: Colors.red),

            const SizedBox(height: 20),
            const Text("Ghi chú",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Text(note.isEmpty ? "Không có ghi chú" : note),
            ),

            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text("Chỉnh sửa"),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text("Tạo yêu cầu bảo trì"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text("Xóa thiết bị"),
            ),
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
          Expanded(child: Text(label)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: highlight,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTagRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
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
