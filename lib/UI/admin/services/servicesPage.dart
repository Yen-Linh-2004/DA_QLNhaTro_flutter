import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/provider/DichVuProvider.dart';
import 'package:flutter_application/data/model/DichVu.dart';
import 'package:flutter_application/UI/admin/services/add_service.dart';
import 'package:flutter_application/UI/admin/services/detail_services.dart';

class ServiceManagementPage extends StatefulWidget {
  const ServiceManagementPage({super.key});

  @override
  State<ServiceManagementPage> createState() => _ServiceManagementPageState();
}

class _ServiceManagementPageState extends State<ServiceManagementPage> {
  @override
  void initState() {
    super.initState();
    // Lấy dữ liệu từ API khi page khởi tạo
    Future.microtask(() {
      Provider.of<DichVuProvider>(context, listen: false).fetchDichVu();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
      body: Consumer<DichVuProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<DichVu> services = provider.DichVuList;

          if (services.isEmpty) {
            return const Center(child: Text("Không có dịch vụ nào!"));
          }

          return ListView.builder(
            itemCount: services.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              final s = services[index];

              // Xác định màu trạng thái
              Color statusColor = (s.trangThaiHoatDong == "Hoạt động")
                  ? Colors.green
                  : Colors.red;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  title: Text(
                    s.tenDichVu ?? "Dịch vụ không tên",
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
                          "${s.donGia?.toStringAsFixed(0) ?? '0'} đ",
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            s.trangThaiHoatDong == true ? "Hoạt động" : "Tạm dừng",
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
                              "name": s.tenDichVu,
                              "price":
                                  "${s.donGia?.toStringAsFixed(0) ?? '0'} đ",
                              "status": s.trangThaiHoatDong,
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddServicePage()),
          );
        },
        backgroundColor: Colors.blue,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          "Thêm dịch vụ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
