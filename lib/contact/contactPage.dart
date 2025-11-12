import 'package:flutter/material.dart';
import 'package:flutter_application/contact/add_contact.dart';
import 'package:flutter_application/contact/detail_contact.dart';

class ContractManagementPage extends StatelessWidget {
  const ContractManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> contracts = [
      {
        "id": "HD001",
        "tenant": "Nguyễn Văn A",
        "room": "P101",
        "price": "3.500.000đ",
        "status": "Đang hiệu lực",
        "statusColor": Colors.green,
      },
      {
        "id": "HD002",
        "tenant": "Trần Thị B",
        "room": "P202",
        "price": "3.800.000đ",
        "status": "Sắp hết hạn",
        "statusColor": Colors.orange,
      },
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddContactPage()),
          );
        },
        backgroundColor: Colors.deepPurple,
        label: Text("Tạo hợp đồng mới"),
        icon: Icon(Icons.add),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatCards(),
            SizedBox(height: 16),
            Container(
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Tìm kiếm...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

            // ✅ MUST: Expanded để tránh overflow
            Expanded(
              child: ListView.separated(
                itemCount: contracts.length,
                separatorBuilder: (_, __) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = contracts[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ContractDetailPage()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),

                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.description, color: Colors.blue),
                          ),
                          SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["id"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  item["tenant"],
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "Phòng: ${item["room"]}",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                item["price"],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: item["statusColor"].withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  item["status"],
                                  style: TextStyle(
                                    color: item["statusColor"],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Thống kê
  Widget _buildStatCards() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _statCard(Icons.check_circle, Colors.green, "Đang hiệu lực", "2"),
            SizedBox(width: 15),
            _statCard(Icons.timelapse, Colors.orange, "Sắp hết hạn", "2"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _statCard(Icons.error, Colors.redAccent, "Hết hạn", "1"),
            SizedBox(width: 15),
            _statCard(Icons.refresh, Colors.blueAccent, "Đã gia hạn", "1"),
          ],
        ),
      ],
    );
  }

  Widget _statCard(IconData icon, Color color, String label, String count) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 26),
            SizedBox(height: 6),
            Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
            Text(
              count,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
