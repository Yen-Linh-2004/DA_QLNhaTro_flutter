import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/customers/detail_customers.dart';
import 'package:flutter_application/provider/khachthueProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/data/model/KhachThue.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  void initState() {
    super.initState();
    // Gọi API khi vào màn hình
    Future.microtask(() {
      Provider.of<KhachThueProvider>(context, listen: false).fetchKhachThue();
    });
  }

  String trangThai(String status) {
    switch (status) {
      case "KHÁCH_CHÍNH":
        return "Khách chính";
      case "ĐÃ_DỌN_ĐI":
        return "Đã dọn đi";
      case "TIỀM_NĂNG":
        return "Tiềm năng";
      case "THÀNH_VIÊN":
        return "Thành viên";
      default:
        return status;
    }
  }


  Color getStatusColor(String? status) {
    switch (status) {
      case "Khách chính":
        return Colors.green;
      case "Đã dọn đi":
        return Colors.red;
      case "Tiềm năng":
        return Colors.orange;
      case "Thành viên":
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  // Color getStatusTextColor(String? status) {
  //   switch (status) {
  //     case "Khách chính":
  //       return Colors.green.shade700;
  //     case "Đã dọn đi":
  //       return Colors.red.shade700;
  //     case "Tiềm năng":
  //       return Colors.orange.shade700;
  //     case "Thành viên":
  //       return Colors.yellow.shade700;
  //     default:
  //       return Colors.black;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<KhachThueProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.khachThueList.isEmpty) {
            return const Center(
              child: Text("Không có dữ liệu khách thuê", style: TextStyle(fontSize: 16)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: provider.khachThueList.length,
            itemBuilder: (context, index) {
              final KhachThue khachThue = provider.khachThueList[index];

              // Fallback null/empty values
              final String displayName = khachThue.hoTen.isNotEmpty ? khachThue.hoTen : "Không có tên";
              final String status = trangThai(khachThue.vaiTro ?? "");

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CustomerDetailPage(
                        khachThueId: khachThue.maKhachThue,
                      ),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.blue.shade600,
                          child: Text(
                            displayName[0].toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                displayName,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (khachThue.cccd != null && khachThue.cccd!.isNotEmpty)
                                Text("CCCD: ${khachThue.cccd}"),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(
                            color: getStatusColor(status),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            status.isNotEmpty ? status : "Chưa xác định",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
