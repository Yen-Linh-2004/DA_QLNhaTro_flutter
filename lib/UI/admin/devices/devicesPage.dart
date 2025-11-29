import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/ThietBi.dart';
import 'package:flutter_application/provider/ThietBiProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/UI/admin/devices/add_devices.dart';
import 'package:flutter_application/UI/admin/devices/detail_devices.dart';

class EquipmentManagementPage extends StatefulWidget {
  const EquipmentManagementPage({super.key});

  @override
  State<EquipmentManagementPage> createState() => _EquipmentManagementPageState();
}

class _EquipmentManagementPageState extends State<EquipmentManagementPage> {
  @override
  void initState() {
    super.initState();
    // Gọi API load dữ liệu
    Future.microtask(() {
      Provider.of<ThietBiProvider>(context, listen: false).fetchThietBi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Consumer<ThietBiProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final List<ThietBi> equipmentList = provider.ThietBiList;

            if (equipmentList.isEmpty) {
              return const Center(child: Text("Không có thiết bị nào!"));
            }

            return ListView.builder(
              itemCount: equipmentList.length,
              itemBuilder: (context, index) {
                final item = equipmentList[index];
                final statusColor = item.loaiThietBi == true ? Colors.green : Colors.red;
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => DeviceDetailPage(
                    //       deviceName: item.tenThietBi ?? "",
                    //       deviceId: ${item.maThietBi?.toStringAsFixed(0) ?? '0'},
                    //       catalog: item.loaiThietBi ?? "",
                    //       room: item.phongTro ?? "",
                    //       status: statusText,
                    //       dateBuy: item.ngayMua ?? "",
                    //       price: "${item.giaMua?.toStringAsFixed(0) ?? '0'} đ",
                    //       lastMaintenance: item.baoTriLanCuoi ?? "",
                    //       nextMaintenance: item.baoTriLanSau ?? "",
                    //       note: item.ghiChu ?? "",
                    //     ),
                    //   ),
                    // );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.tenThietBi ?? "", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(item.maThietBi?.toString() ?? "--", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            _tag(item.loaiThietBi ?? "", Colors.blue),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Mã: ${item.maThietBiCode}", style: const TextStyle(fontSize: 14)),
                            Text("${(item.giaMua ?? 0).toDouble().toStringAsFixed(0)} đ",
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddDevicesPage()),
          );
        },
        backgroundColor: Colors.blue,
        label: const Text(
          "Thêm thiết bị",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
