import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/YeuCauBaoTri.dart';
import 'package:flutter_application/UI/admin/maintenance/create_maintenance.dart';
import 'package:flutter_application/UI/admin/maintenance/detail_maintenance.dart';
import 'package:flutter_application/UI/admin/maintenance/staff_assignment.dart';
import 'package:flutter_application/UI/admin/maintenance/update_status.dart';
import 'package:flutter_application/provider/BaoTriProvider.dart';
import 'package:provider/provider.dart';

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({super.key});

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  @override
  void initState() {
    super.initState();
    // Gọi fetchBaoTri khi khởi tạo widget
    Future.microtask(() {
      Provider.of<BaoTriProvider>(context, listen: false).fetchBaoTri();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<BaoTriProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.BaoTriList.isEmpty) {
              return const Center(child: Text("Không có dữ liệu"));
            }

            final requests = provider.BaoTriList;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _statusGrid(requests.cast<YeuCauBaoTri>()),
                  const SizedBox(height: 16),
                  ...requests.map((r) => _maintenanceCard(r as YeuCauBaoTri, context)),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMaintenancePage()),
          ).then((_) {
            // Refresh data sau khi tạo mới
            Provider.of<BaoTriProvider>(context, listen: false).fetchBaoTri();
          });
        },
        backgroundColor: Colors.purple,
        label: const Text(
          "Tạo yêu cầu",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _statusGrid(List<YeuCauBaoTri> requests) {
    final counts = {
      "Chờ phân công": requests
          .where((e) => e.status == MaintenanceStatus.pending)
          .length,
      "Đang xử lý": requests
          .where((e) => e.status == MaintenanceStatus.processing)
          .length,
      "Đã hoàn thành": requests
          .where((e) => e.status == MaintenanceStatus.completed)
          .length,
    };

    final colors = {
      "Chờ phân công": Colors.grey,
      "Đang xử lý": Colors.orange,
      "Đã hoàn thành": Colors.green,
    };

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.2,
      ),
      itemCount: counts.keys.length,
      itemBuilder: (context, i) {
        String key = counts.keys.elementAt(i);
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: colors[key]!.withOpacity(.15),
                child: Icon(Icons.circle, color: colors[key], size: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${counts[key]}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      key,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _maintenanceCard(YeuCauBaoTri item, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "Ngày yêu cầu: ${item.requestDate != null ? _formatDate(item.requestDate!) : "N/A"}",
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text("👤 ${item.tenantName ?? "Không rõ"} – ${item.room ?? ""}"),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _chip(item.category.displayName, item.category.color),
              _chip(item.priority.displayName, item.priority.color),
              _chip(item.status.displayName, item.status.color),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Phân công: ${item.assignedTo != null ? item.assignedTo : "Chưa phân công"}",
            style: TextStyle(color: Colors.grey.shade800),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MaintenanceDetailPage()),
                    );
                  },
                  icon: Icon(Icons.visibility_outlined, size: 22, color: Colors.grey.shade600)),
              IconButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => UpdatestatusPage()),
                    // );
                  },
                  icon: const Icon(Icons.edit_outlined, size: 22, color: Colors.blue)),
              IconButton(
                  onPressed: () {
                    // Xử lý xóa
                  },
                  icon: const Icon(Icons.delete_outline, size: 22, color: Colors.red)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StaffAssignmentPage()),
                    );
                  },
                  icon: const Icon(Icons.person_add, size: 22, color: Colors.blue)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 12)),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
}
