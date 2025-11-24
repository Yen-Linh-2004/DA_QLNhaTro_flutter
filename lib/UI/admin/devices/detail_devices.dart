import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/devices/update_device.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';

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
        title:  Text("Chi tiết thiết bị", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            
            Row(
              children: [
                buildActionBtn(Icons.delete, "Xóa", Colors.redAccent, (){
                  showConfirmDialog(
                      context: context,
                      title: "Xác nhận xóa thiết bị",
                      message: "Bạn có chắc chắn muốn xóa thiết bị này không?",
                      confirmColor: Colors.redAccent,
                      icon: Icons.delete_forever,
                      maxHeight: 140,
                      onConfirm: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                          content: Text(
                            "Đã xóa thiết bị thành công!",
                          ),
                          backgroundColor: Colors.red,
                        ));
                      },
                    );
                }),
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
