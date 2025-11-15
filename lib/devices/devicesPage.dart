import 'package:flutter/material.dart';
import 'package:flutter_application/devices/add_devices.dart';
import 'package:flutter_application/devices/detail_devices.dart';

class EquipmentManagementPage extends StatelessWidget {
  const EquipmentManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> equipmentList = [
      {
        "name": "Điều hòa Daikin 12000BTU",
        "code": "AC001",
        "category": "Thiết bị điện",
        "room": "P101",
        "price": "8.500.000đ",
        "date": "15/6/2023",
        "status": "Tốt",
        "statusColor": Colors.green,
        "maintenance": "15/7/2024",
      },
      {
        "name": "Tủ lạnh Samsung 180L",
        "code": "RF001",
        "category": "Thiết bị điện",
        "room": "P101",
        "price": "6.200.000đ",
        "date": "20/6/2023",
        "status": "Tốt",
        "statusColor": Colors.green,
        "maintenance": "Không có",
      },
      {
        "name": "Giường đơn",
        "code": "BED001",
        "category": "Nội thất",
        "room": "P101",
        "price": "2.500.000đ",
        "date": "10/5/2023",
        "status": "Tốt",
        "statusColor": Colors.green,
        "maintenance": "Không có",
      },
      {
        "name": "Máy nước nóng Ariston",
        "code": "WH001",
        "category": "Thiết bị điện",
        "room": "P102",
        "price": "3.200.000đ",
        "date": "5/7/2023",
        "status": "Khá",
        "statusColor": Colors.orange,
        "maintenance": "20/4/2024",
      },
      {
        "name": "Tủ quần áo 3 cánh",
        "code": "WD001",
        "category": "Nội thất",
        "room": "P102",
        "price": "1.800.000đ",
        "date": "15/5/2023",
        "status": "Tốt",
        "statusColor": Colors.green,
        "maintenance": "Không có",
      },
      {
        "name": "Bình cứu hỏa",
        "code": "FE001",
        "category": "An toàn",
        "room": "Tầng 1",
        "price": "450.000đ",
        "date": "10/4/2023",
        "status": "Tốt",
        "statusColor": Colors.green,
        "maintenance": "10/4/2024",
      },
    ];

    return Scaffold(
      body: ListView.builder(
        padding:  EdgeInsets.all(12),
        itemCount: equipmentList.length,
        itemBuilder: (context, index) {
          final item = equipmentList[index];

          return Container(
            margin:  EdgeInsets.only(bottom: 12),
            padding:  EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 6,
                  offset:  Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["name"],
                  style:  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  item["code"],
                  style:  TextStyle(fontSize: 12, color: Colors.grey),
                ),
                 SizedBox(height: 6),

                Row(
                  children: [
                    _tag(item["category"], Colors.blue),
                     SizedBox(width: 8),
                    _tag(item["status"], item["statusColor"]),
                  ],
                ),

                 SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phòng: ${item["room"]}",
                      style:  TextStyle(fontSize: 14),
                    ),
                    Text(
                      item["price"],
                      style:  TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                 SizedBox(height: 4),
                Text(
                  "Ngày nhập: ${item["date"]}",
                  style:  TextStyle(fontSize: 12),
                ),
                Text(
                  "Bảo trì: ${item["maintenance"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: item["maintenance"] == "Không có"
                        ? Colors.grey
                        : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                 SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DeviceDetailPage(
                              deviceName: "Điều hòa Daikin 12000BTU",
                              deviceId: "AC001",
                              catalog: "Thiết bị điện",
                              room: "P101",
                              status: "Tốt",
                              dateBuy: "15/6/2023",
                              price: "8.500.000đ",
                              dateWarranty: "15/6/2025",
                              lastMaintenance: "15/1/2024",
                              nextMaintenance: "15/7/2024",
                              note: "Bảo dưỡng định kỳ 6 tháng/lần",
                            ),
                          ),
                        );
                      },
                      child:  Text(
                        "Chi tiết",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child:  Text(
                        "Bảo trì",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          
        },
        backgroundColor: Colors.blue,
        label:  Text("Thêm thiết bị", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        icon:  Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _tag(String text, Color color) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
