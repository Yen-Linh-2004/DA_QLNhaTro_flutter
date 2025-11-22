import 'package:flutter/material.dart';
import 'package:flutter_application/UI/users/add_report.dart';

class RulesAndViolationsPage extends StatelessWidget {
  const RulesAndViolationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // -------------------------------
            // PHẦN: Lịch sử vi phạm
            // -------------------------------
            Text("Lịch sử vi phạm của bạn", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18 ),),
            SizedBox(height: 5),
            ViolationCard(
              title: "Giờ giấc sinh hoạt",
              time: "Ngày báo cáo: 2024-03-15",
              level: "Vừa",
              status: "Đã cảnh báo",
              description:
              "Mở nhạc to sau 23:00, ảnh hưởng đến phòng bên cạnh.",
              note:
              "Đã nhắc nhở, khách thuê cam kết không tái phạm.",
            ),
            ViolationCard(
              title: "Vệ sinh chung",
              time: "Ngày báo cáo: 2024-02-10",
              level: "Nhẹ",
              status: "Đã giải quyết",
              description: "Để rác ngoài hành lang 2 ngày.",
            ),
            SizedBox(height: 8),

            // -------------------------------
            // PHẦN: Nội quy chung
            // -------------------------------
            Text("Nội quy chung của khu trọ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 5),
            RulesCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddReportPage()),
          );
        },
        backgroundColor: Colors.blue,
        label:  Text("Báo cáo mới", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        icon:  Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class ViolationCard extends StatelessWidget {
  final String title, time, level, status, description;
  final String? note;

   ViolationCard({
    super.key,
    required this.title,
    required this.time,
    required this.level,
    required this.status,
    required this.description,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(bottom: 16),
      padding:  EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3)
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                style:  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
              Container(
                padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: status.contains("cảnh báo")
                      ? Colors.blue.shade50
                      : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: status.contains("cảnh báo")
                        ? Colors.blue
                        : Colors.green,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),

           SizedBox(height: 8),

          Text(description),
           SizedBox(height: 6),

          Text("Mức độ: $level",
              style: TextStyle(color: Colors.orange.shade700)),

           SizedBox(height: 6),

          Text(time, style:  TextStyle(color: Colors.grey)),

          if (note != null) ...[
             Divider(height: 20),
            Text("Ghi chú từ BQL: $note"),
          ]
        ],
      ),
    );
  }
}

class RulesCard extends StatelessWidget {
   RulesCard({super.key});

  @override
  Widget build(BuildContext context) {
    const rules = [
      "Giờ giấc sinh hoạt: Không gây tiếng ồn sau 22:00 và trước 6:00 hằng ngày.",
      "Vệ sinh chung: Giữ gìn vệ sinh khu vực chung, không vứt rác bừa bãi.",
      "Khách thăm: Khách thăm phải đăng ký và không được ở qua đêm.",
      "An toàn cháy nổ: Không nấu ăn trong phòng, không sử dụng thiết bị dễ cháy nổ.",
      "Khác: Các vấn đề khác không thuộc danh mục trên."
    ];

    return Container(
      padding:  EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3)
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < rules.length; i++)
            Padding(
              padding:  EdgeInsets.only(bottom: 10),
              child: Text("${i + 1}. ${rules[i]}"),
            )
        ],
      ),
    );
  }
}
