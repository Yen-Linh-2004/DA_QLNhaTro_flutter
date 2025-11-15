import 'package:flutter/material.dart';
import 'package:flutter_application/devices/update_device.dart';
import 'package:flutter_application/shared/buildCard.dart';

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
      appBar: AppBar(
        title:  Text("Chi tiết thiết bị", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 3,
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding:  EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                      children: [
                        Icon(Icons.devices, color: Colors.blueAccent),
                        SizedBox(width: 8),
                        Text("Thông tin cơ bản", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                     SizedBox(height: 12),
                    _infoRow("Tên thiết bị:", deviceName),
                    _infoRow("Mã thiết bị:", deviceId),
                    _infoTagRow("Danh mục:", catalog, Colors.orangeAccent.shade100),
                    _infoRow("Phòng:", room),
                    _infoTagRow("Tình trạng:", status, Colors.greenAccent.shade100),
                  ],
                ),
              ),
            ),
             SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding:  EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                      children: [
                        Icon(Icons.build, color: Colors.blueAccent),
                        SizedBox(width: 8),
                        Text("Mua sắm & Bảo trì", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                     SizedBox(height: 12),
                    _infoRow("Ngày mua:", dateBuy),
                    _infoRow("Giá mua:", price, highlight: Colors.green),
                    _infoRow("Bảo hành đến:", dateWarranty),
                    _infoRow("Bảo trì lần cuối:", lastMaintenance),
                    _infoRow("Bảo trì tiếp theo:", nextMaintenance, highlight: Colors.red),
                  ],
                ),
              ),
            ),
             SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding:  EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                      children: [
                        Icon(Icons.notes, color: Colors.blueAccent),
                        SizedBox(width: 8),
                        Text("Ghi chú", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                     SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding:  EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        note.isEmpty ? "Không có ghi chú" : note,
                        style:  TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
             SizedBox(height: 30),
            Row(
              children: [
                buildActionBtn(Icons.delete, "Xóa", Colors.redAccent, (){}),
                SizedBox(width: 15),
                buildActionBtn(Icons.edit, "Chỉnh sửa", Colors.blue, (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => UpdateDevicesPage()),
                  );
                }),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, {Color? highlight}) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style:  TextStyle(fontSize: 14))),
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
      padding:  EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style:  TextStyle(fontSize: 14))),
          Container(
            padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
