import 'package:flutter/material.dart';
import 'package:flutter_application/UI/users/add_report.dart';
import 'package:provider/provider.dart';
import '../../provider/CustomerProvider.dart';

class RulesAndViolationsPage extends StatefulWidget {
  const RulesAndViolationsPage({super.key});

  @override
  State<RulesAndViolationsPage> createState() => _RulesAndViolationsPageState();
}

class _RulesAndViolationsPageState extends State<RulesAndViolationsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async{
     final provider =  Provider.of<CustomerProvider>(context, listen: false);
      await provider.fetchCustomerViolations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Consumer<CustomerProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final violations = provider.vipham;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Lịch sử vi phạm của bạn",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),

                // Nếu không có vi phạm
                if (violations.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "Bạn không có lịch sử vi phạm.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),

                // Danh sách vi phạm
                ...violations.map((v) {
                  return ViolationCard(
                    title: v.noiQuy?.tieuDe ?? "Không rõ nội quy",
                    time: "Ngày báo cáo: ${v.ngayBaoCao}",
                    level: _convertLevel(v.mucDo),
                    status: _convertStatus(v.trangThai),
                    description: v.moTa,
                    note: v.ghiChu,
                  );
                }),

                const SizedBox(height: 20),

                const Text(
                  "Nội quy chung của khu trọ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),

                const RulesCard(),
              ],
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddReportPage()),
          );
        },
        backgroundColor: Colors.blue,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "Báo cáo mới",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  String _convertLevel(String lv) {
    switch (lv) {
      case "nhe":
        return "Nhẹ";
      case "vua":
        return "Vừa";
      case "nghiem_trong":
        return "Nghiêm trọng";
      case "rat_nghiem_trong":
        return "Rất nghiêm trọng";
      default:
        return "Không xác định";
    }
  }

  String _convertStatus(String s) {
    switch (s) {
      case "da_bao_cao":
        return "Đã báo cáo";
      case "da_canh_cao":
        return "Đã cảnh báo";
      case "da_giai_quyet":
        return "Đã giải quyết";
      default:
        return "Không xác định";
    }
  }
}

class ViolationCard extends StatelessWidget {
  final String title;
  final String time;
  final String level;
  final String status;
  final String description;
  final String? note;

  const ViolationCard({
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
    final bool isWarning = status == "Đã cảnh báo";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header title + status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isWarning ? Colors.orange.shade50 : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isWarning ? Colors.orange.shade700 : Colors.green.shade700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(description),
          const SizedBox(height: 6),

          Text("Mức độ: $level",
              style: const TextStyle(color: Color(0xFFBA5E02))),
          const SizedBox(height: 6),

          Text(time, style: const TextStyle(color: Colors.grey)),

          if (note != null) ...[
            const Divider(height: 20),
            Text("Ghi chú từ BQL: $note"),
          ],
        ],
      ),
    );
  }
}

class RulesCard extends StatelessWidget {
  const RulesCard({super.key});

  @override
  Widget build(BuildContext context) {
    const rules = [
      "Giờ giấc sinh hoạt: Không gây tiếng ồn sau 22:00 và trước 6:00 hằng ngày.",
      "Vệ sinh chung: Giữ gìn vệ sinh khu vực chung, không vứt rác bừa bãi.",
      "Khách thăm: Khách thăm phải đăng ký và không được ở qua đêm.",
      "An toàn cháy nổ: Không nấu ăn trong phòng, không sử dụng thiết bị dễ cháy nổ.",
      "Thanh toán tiền thuê: Thanh toán tiền thuê đúng hạn vào đầu tháng."
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          rules.length,
          (i) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text("${i + 1}. ${rules[i]}"),
          ),
        ),
      ),
    );
  }
}
