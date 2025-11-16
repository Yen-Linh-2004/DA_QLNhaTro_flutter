import 'package:flutter/material.dart';
import 'package:flutter_application/users/RepairRequestDetail/RepairRequestDetail.dart';
import 'package:flutter_application/users/RepairRequestDetail/creater_repair.dart';
import 'package:flutter_application/users/RepairRequestDetail/update_repair.dart';

class RepairRequestPage extends StatelessWidget {
  const RepairRequestPage({Key? key});

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

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // --- Tilte ---
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Yêu cầu sửa chữa",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateRepairPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_circle_outline),
                      tooltip: "Tạo yêu cầu mới",
                    ),
                  ],
                ),
                Text(
                  "Quản lý yêu cầu bảo trì và sửa chữa",
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            // // Thống kê nhanh
            // Row(
            //   children: [
            //     buildSummaryCard("Chờ xử lý", "1", Colors.orange, Icons.access_time),
            //     buildSummaryCard("Đang xử lý", "1", Colors.blue, Icons.engineering),
            //   ],
            // ),
            // Row(
            //   children: [
            //     buildSummaryCard("Hoàn thành", "1", Colors.green, Icons.check_circle),
            //     buildSummaryCard("Ưu tiên cao", "1", Colors.red, Icons.warning),
            //   ],
            // ),
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
                    margin: EdgeInsets.symmetric(vertical: 6),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  r["title"]!,
                                  style: TextStyle(
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
                          SizedBox(height: 4),
                          Text(r["desc"]!),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Danh mục: ${r["category"]}"),
                              Text(
                                "Ngày: ${r["date"]}",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Chip(
                                label: Text(r["status"]!),
                                backgroundColor: statusColor.withOpacity(0.15),
                                labelStyle: TextStyle(color: statusColor),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>const RepairRequestDetailPage(),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.visibility_outlined,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  
                                  if (r["status"] == "Chờ xử lý") ...[
                                    IconButton(
                                      onPressed: (){},
                                      icon: Icon( Icons.cancel, color: Colors.red, size: 22)
                                    )  
                                  ],
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const UpdateRepairPage(),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit_outlined,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  IconButton(
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => const RegisterPage(),
                                      //   ),
                                      // );
                                    },
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: Colors.redAccent,
                                    ),
                                  ),
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
