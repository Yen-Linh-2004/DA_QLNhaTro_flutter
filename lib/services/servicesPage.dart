import 'package:flutter/material.dart';
import 'package:flutter_application/services/add_service.dart';
import 'package:flutter_application/services/detail_services.dart';

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

    final List<Map<String, dynamic>> serviceUsageList = [
      {
        "name": "Nguyễn Văn A",
        "room": "P101",
        "service": "Giặt sấy",
        "quantity": 3,
        "total": "75.000đ",
        "date": "15/3/2024",
        "status": "Hoàn thành",
      },
      {
        "name": "Trần Thị B",
        "room": "P202",
        "service": "Gửi xe máy",
        "quantity": 1,
        "total": "150.000đ",
        "date": "1/3/2024",
        "status": "Hoàn thành",
      },
      {
        "name": "Phạm Thị D",
        "room": "P301",
        "service": "Dọn phòng",
        "quantity": 2,
        "total": "200.000đ",
        "date": "20/3/2024",
        "status": "Chờ xử lý",
      },
    ];

    return DefaultTabController(
      // ✅ BỔ SUNG QUAN TRỌNG
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Quản lý dịch vụ"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddServicePage(),
                  ),
                );
              },
              icon: const Icon(Icons.add_circle, color: Colors.blue),
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            indicatorWeight: 2.5,
            labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            tabs: [
              Tab(text: 'Danh sách dịch vụ'),
              Tab(text: 'Lịch sử sử dụng'),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            // ---------- TAB 1: Danh sách dịch vụ ----------
            ListView.builder(
              itemCount: services.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final s = services[index];
                final Color statusColor = s["statusColor"];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    title: Text(
                      s["name"],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Text(
                            s["price"],
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
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
                      icon: const Icon(Icons.more_vert),
                    ),
                  ),
                );
              },
            ),

            // ---------- TAB 2: Lịch sử sử dụng dịch vụ ----------
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: serviceUsageList.length,
              itemBuilder: (context, index) {
                final item = serviceUsageList[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item['name']} (${item['room']})",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item["service"],
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            "x${item['quantity']}",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Ngày sử dụng: ${item['date']}",
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item["total"],
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: item["status"] == "Hoàn thành"
                                  ? Colors.green.withOpacity(0.15)
                                  : Colors.orange.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item["status"],
                              style: TextStyle(
                                color: item["status"] == "Hoàn thành"
                                    ? Colors.green
                                    : Colors.orange,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
