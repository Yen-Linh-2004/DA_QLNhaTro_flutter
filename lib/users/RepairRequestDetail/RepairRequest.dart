import 'package:flutter/material.dart';

class RepairRequestPage extends StatelessWidget {
  const RepairRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final requests = [
      {
        "title": "Điều hòa không hoạt động",
        "desc": "Điều hòa phòng 101A không thể bật, có thể do hỏng nguồn.",
        "category": "Điện lạnh",
        "priority": "Cao",
        "status": "Chờ xử lý",
        "date": "2024-12-10",
      },
      {
        "title": "Vòi nước bồn rửa bát bị rò",
        "desc": "Vòi nước trong bếp bị rò rỉ, nước chảy liên tục.",
        "category": "Hệ thống nước",
        "priority": "Trung bình",
        "status": "Đang xử lý",
        "date": "2024-12-08",
      },
      {
        "title": "Bóng đèn phòng ngủ cháy",
        "desc": "Bóng đèn LED phòng ngủ bị cháy, cần thay mới.",
        "category": "Điện",
        "priority": "Thấp",
        "status": "Hoàn thành",
        "date": "2024-12-05",
      },
    ];

    Widget buildSummaryCard(String label, String value, Color color, IconData icon) {
      return Expanded(
        child: Card(
          color: color.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Icon(icon, color: color),
                const SizedBox(height: 8),
                Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Yêu cầu sửa chữa"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_outline),
            tooltip: "Tạo yêu cầu mới",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Thống kê nhanh
            Row(
              children: [
                buildSummaryCard("Chờ xử lý", "1", Colors.orange, Icons.access_time),
                buildSummaryCard("Đang xử lý", "1", Colors.blue, Icons.engineering),
              ],
            ),
            Row(
              children: [
                buildSummaryCard("Hoàn thành", "1", Colors.green, Icons.check_circle),
                buildSummaryCard("Ưu tiên cao", "1", Colors.red, Icons.warning),
              ],
            ),
            const SizedBox(height: 8),

            // Danh sách yêu cầu
            Expanded(
              child: ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final r = requests[index];
                  Color statusColor;
                  switch (r["status"]) {
                    case "Chờ xử lý":
                      statusColor = Colors.orange;
                      break;
                    case "Đang xử lý":
                      statusColor = Colors.blue;
                      break;
                    case "Hoàn thành":
                      statusColor = Colors.green;
                      break;
                    default:
                      statusColor = Colors.grey;
                  }

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  r["title"]!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Chip(
                                label: Text(r["priority"]!),
                                backgroundColor: r["priority"] == "Cao"
                                    ? Colors.red.withOpacity(0.2)
                                    : r["priority"] == "Trung bình"
                                        ? Colors.orange.withOpacity(0.2)
                                        : Colors.green.withOpacity(0.2),
                                labelStyle: TextStyle(
                                  color: r["priority"] == "Cao"
                                      ? Colors.red
                                      : r["priority"] == "Trung bình"
                                          ? Colors.orange
                                          : Colors.green,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(r["desc"]!),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Danh mục: ${r["category"]}"),
                              Text("Ngày: ${r["date"]}", style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Chip(
                                label: Text(r["status"]!),
                                backgroundColor: statusColor.withOpacity(0.15),
                                labelStyle: TextStyle(color: statusColor),
                              ),
                              Row(
                                children: const [
                                  Icon(Icons.visibility_outlined, color: Colors.blueGrey),
                                  SizedBox(width: 10),
                                  Icon(Icons.edit_outlined, color: Colors.blueAccent),
                                  SizedBox(width: 10),
                                  Icon(Icons.delete_outline, color: Colors.redAccent),
                                ],
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
}
