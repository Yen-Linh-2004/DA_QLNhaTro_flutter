import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/services/add_service.dart';
import 'package:flutter_application/UI/admin/services/detail_services.dart';

class ServiceManagementPage extends StatelessWidget {
  const ServiceManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        "name": "Giặt sấy",
        "price": "25.000đ/kg",
        "status": "Hoạt động",
        "statusColor": Colors.green,
      },
      {
        "name": "Gửi xe máy",
        "price": "150.000đ/tháng",
        "status": "Hoạt động",
        "statusColor": Colors.green,
      },
      {
        "name": "Internet WiFi",
        "price": "200.000đ/tháng",
        "status": "Hoạt động",
        "statusColor": Colors.green,
      },
      {
        "name": "Dọn phòng",
        "price": "100.000đ/lần",
        "status": "Hoạt động",
        "statusColor": Colors.green,
      },
      {
        "name": "Gửi xe ô tô",
        "price": "500.000đ/tháng",
        "status": "Tạm dừng",
        "statusColor": Colors.red,
      },
    ];

    return Scaffold(
      backgroundColor:  Color(0xFFF6F6F8),
      body: ListView.builder(
        itemCount: services.length,
        padding:  EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final s = services[index];
          final Color statusColor = s["statusColor"];

          return Container(
            margin:  EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 6,
                  offset:  Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              contentPadding:  EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              title: Text(
                s["name"],
                style:  TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Padding(
                padding:  EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Text(
                      s["price"],
                      style:  TextStyle(fontSize: 14),
                    ),
                     SizedBox(width: 10),
                    Container(
                      padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        s["status"],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ServiceDetailPage(
                        service: {
                          "name": s["name"],
                          "price": s["price"],
                          "status": s["status"],
                        },
                      ),
                    ),
                  );
                },
                icon:  Icon(Icons.more_vert),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddServicePage()),
          );
        },
        backgroundColor: Colors.blue,
        icon:  Icon(Icons.add, color: Colors.white,),
        label:  Text("Thêm dịch vụ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
