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

  Color getStatusColor(String status) {
    switch (status) {
      case "KHÁCH_CHÍNH":
        return Colors.green.shade100;
      case "ĐÃ_DỌN_ĐI":
        return Colors.red.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  Color getStatusTextColor(String status) {
    switch (status) {
      case "KHÁCH_CHÍNH":
        return Colors.green.shade700;
      case "ĐÃ_DỌN_ĐI":
        return Colors.red.shade700;
      default:
        return Colors.black;
    }
  }

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
                            khachThue.hoTen.isNotEmpty
                                ? khachThue.hoTen[0].toUpperCase()
                                : "?",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                khachThue.hoTen,
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              if (khachThue.cccd != null &&
                                  khachThue.cccd!.isNotEmpty)
                                Text("CCCD: ${khachThue.cccd}"),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(
                            color: getStatusColor(khachThue.vaiTro),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            khachThue.vaiTro,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: getStatusTextColor(khachThue.vaiTro),
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
