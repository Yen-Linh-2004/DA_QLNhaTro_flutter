import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/UI/users/RepairRequestDetail/RepairRequestDetail.dart';
import 'package:flutter_application/UI/users/RepairRequestDetail/creater_repair.dart';
import 'package:flutter_application/UI/users/RepairRequestDetail/update_repair.dart';
import 'package:flutter_application/provider/CustomerProvider.dart';
import 'package:provider/provider.dart';

class RepairRequestPage extends StatefulWidget {
  const RepairRequestPage({Key? key}) : super(key: key);

  @override
  State<RepairRequestPage> createState() => _RepairRequestPageState();
}

class _RepairRequestPageState extends State<RepairRequestPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async{
     final provider =  Provider.of<CustomerProvider>(context, listen: false);
        await provider.fetchMaintenanceRequest();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CustomerProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final requests = provider.maintenance;

          return Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Expanded(
                  child: requests.isEmpty
                      ? Center(
                          child: Text("Bạn chưa có yêu cầu sửa chữa nào."),
                        )
                      : ListView.builder(
                          itemCount: requests.length,
                          itemBuilder: (context, index) {
                            final r = requests[index];

                            final priorityColor =
                                _getPriorityColor(r.mucDoUuTien);
                            final statusColor = _getStatusColor(r.trangThai);

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
                                    // ----------------- TITLE + PRIORITY -----------------
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            r.tieuDe,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Chip(
                                          label: Text(_convertPriority(r.mucDoUuTien)),
                                          backgroundColor:
                                              priorityColor.withOpacity(0.2),
                                          labelStyle: TextStyle(
                                            color: priorityColor,
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 4),
                                    Text(r.moTa),

                                    SizedBox(height: 8),

                                    // ----------------- CATEGORY + DATE -----------------
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Danh mục: ${_convertCategory(r.phanLoai)}"),
                                        Text(
                                          "Ngày: ${r.ngayYeuCau}",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 8),

                                    // ----------------- STATUS + BUTTONS -----------------
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Chip(
                                          label:
                                              Text(_convertStatus(r.trangThai)),
                                          backgroundColor:
                                              statusColor.withOpacity(0.15),
                                          labelStyle:
                                              TextStyle(color: statusColor),
                                        ),

                                        Row(
                                          children: [
                                            // Xem chi tiết
                                            IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => RepairRequestDetailPage(id: r.maYeuCau),
                                                  ),
                                                );
                                              },
                                              icon: Icon(
                                                Icons.visibility_outlined,
                                                color: Colors.blueGrey,
                                              ),
                                            ),

                                            SizedBox(width: 10),

                                            // Chỉ cho sửa nếu pending
                                            if (r.trangThai == "pending") ...[
                                              IconButton(
                                                onPressed: () {
                                                  showConfirmDialog(
                                                    context: context,
                                                    title: "Xác nhận hủy yêu cầu",
                                                    message:
                                                        "Bạn có chắc chắn muốn hủy yêu cầu sửa chữa này không?",
                                                    confirmColor: Colors.orange,
                                                    icon: Icons.cancel_outlined,
                                                    maxHeight: 140,
                                                    onConfirm: () {
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              "Đã hủy yêu cầu!"),
                                                          backgroundColor:
                                                              Colors.orange,
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: Icon(Icons.cancel,
                                                    color: Colors.orange,
                                                    size: 22),
                                              ),
                                            ],

                                            // Update
                                            IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateRepairPage(reportId: r.maYeuCau),
                                                  ),
                                                );
                                              },
                                              icon: Icon(
                                                Icons.edit_outlined,
                                                color: Colors.blueAccent,
                                              ),
                                            ),

                                            SizedBox(width: 10),

                                            // Delete
                                            IconButton(
                                              onPressed: () {
                                                showConfirmDialog(
                                                  context: context,
                                                  title:
                                                      "Xác nhận xóa yêu cầu sửa chữa",
                                                  message:
                                                      "Bạn có chắc chắn muốn xóa yêu cầu này không?",
                                                  confirmColor:
                                                      Colors.redAccent,
                                                  icon: Icons.delete_forever,
                                                  maxHeight: 140,
                                                  onConfirm: () {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            "Đã xóa yêu cầu!"),
                                                        backgroundColor:
                                                            Colors.redAccent,
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              icon: Icon(
                                                Icons.delete_outline,
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                          ],
                                        )
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
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateRepairPage()),
          );
        },
        backgroundColor: Colors.blue,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          "Tạo yêu cầu",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  // ---------------------- Helpers ----------------------

  Color _getPriorityColor(String pri) {
    switch (pri) {
      case "urgent":
        return Colors.red;
      case "high":
        return Colors.orange;
      case "medium":
        return Colors.blue;
      default:
        return Colors.green;
    }
  }

  Color _getStatusColor(String st) {
    switch (st) {
      case "pending":
        return Colors.orange;
      case "in_progress":
        return Colors.blue;
      case "completed":
        return Colors.green;
      case "cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _convertPriority(String p) {
    switch (p) {
      case "urgent":
        return "Khẩn cấp";
      case "high":
        return "Cao";
      case "medium":
        return "Trung bình";
      default:
        return "Thấp";
    }
  }

  String _convertStatus(String s) {
    switch (s) {
      case "pending":
        return "Chờ xử lý";
      case "in_progress":
        return "Đang xử lý";
      case "completed":
        return "Hoàn thành";
      case "cancelled":
        return "Đã hủy";
      default:
        return "Không xác định";
    }
  }

  String _convertCategory(String c) {
    switch (c) {
      case "electrical":
        return "Điện";
      case "plumbing":
        return "Nước";
      case "appliance":
        return "Thiết bị";
      case "furniture":
        return "Nội thất";
      default:
        return "Khác";
    }
  }
}
