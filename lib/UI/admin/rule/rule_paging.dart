import 'package:flutter/material.dart';
import 'package:flutter_application/provider/NoiQuyProvider.dart';
import 'package:flutter_application/provider/ViPhamProvider.dart';
import 'package:provider/provider.dart';

class RuleManagementPage extends StatefulWidget {
  const RuleManagementPage({super.key});

  @override
  State<RuleManagementPage> createState() => _RuleManagementPageState();
}

class _RuleManagementPageState extends State<RuleManagementPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Lấy dữ liệu an toàn sau khi widget mount
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NoiQuyProvider>(context, listen: false).fetchNoiQuy();
      Provider.of<ViPhamProvider>(context, listen: false).fetchViPham();
    });

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      if (_tabController.index == 0) {
        Provider.of<NoiQuyProvider>(context, listen: false).fetchNoiQuy();
      } else {
        Provider.of<ViPhamProvider>(context, listen: false).fetchViPham();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: "Nội quy"),
                Tab(text: "Vi phạm"),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildNoiQuyTab(),
                  _buildViPhamTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= TAB 1 — Nội quy =================
  String formatPhanLoai(String phanLoai) {
    switch (phanLoai.toLowerCase()) {
      case "ve_sinh":
        return "Vệ sinh";
      case "khach_tham":
        return "Khách thăm";
      case "an_toan":
        return "An toàn";
      case "thanh_toan":
        return "Thanh toán";
      case "tieng_on":
        return "Tiếng ồn";
      default:
        return phanLoai;
    }
  }

  Color getPhanLoaiColor(String phanLoai) {
    switch (phanLoai.toLowerCase()) {
      case "ve_sinh":
        return Colors.blue.shade100;
      case "khach_tham":
        return Colors.orange.shade100;
      case "an_toan":
        return Colors.red.shade100;
      case "tieng_on":
        return Colors.amber.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  Widget _buildNoiQuyTab() {
    return Consumer<NoiQuyProvider>(
      
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.NoiQuyList.isEmpty) {
          return const Center(child: Text("Không có dữ liệu"));
        }

        return Column(
          children: [
            // Dashboard tổng hợp
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  _buildStatCard(
                      icon: Icons.description,
                      color: Colors.blue.shade100,
                      title: "Tổng nội quy",
                      value: provider.NoiQuyList.length.toString()),
                  _buildStatCard(
                      icon: Icons.check_circle,
                      color: Colors.green.shade100,
                      title: "Đang áp dụng",
                      value: provider.NoiQuyList
                          .where((e) => e.trangThai)
                          .length
                          .toString()),
                  _buildStatCard(
                      icon: Icons.error_outline,
                      color: Colors.red.shade100,
                      title: "Ngừng áp dụng",
                      value: provider.NoiQuyList
                          .where((e) => !e.trangThai)
                          .length
                          .toString()),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // List nội quy
            Expanded(
              child: ListView.builder(
                itemCount: provider.NoiQuyList.length,
                itemBuilder: (context, i) {
                  final n = provider.NoiQuyList[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4)
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(n.tieuDe,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(n.noiDung,
                            style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildChip(formatPhanLoai(n.phanLoai), getPhanLoaiColor(n.phanLoai)),
                            const SizedBox(width: 8),
                            _buildChip(
                                n.trangThai ? "Đang áp dụng" : "Ngừng",
                                n.trangThai
                                    ? Colors.green.shade100
                                    : Colors.red.shade100),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          children: [
            CircleAvatar(radius: 18, backgroundColor: color, child: Icon(icon)),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 4),
            Text(value,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: const TextStyle(fontSize: 12)),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  // ================= TAB 2 — Vi phạm =================
  String formatMucDo(String mucdo) {
    switch (mucdo) {
      case "nhe":
        return "Nhẹ";
      case "Vua":
        return "Vừa";
      case "nghiem_trong":
        return "Nghiêm trọng";
      case "rat_nghiem_trong":
        return "Rất nghiêm trọng";
      default:
        return mucdo;
    }
  }
  
  Color getMucDoColors(String mucdo) {
    switch (mucdo.toLowerCase()) {
      case "nhe":
        return Colors.green.shade100;
      case "vua":
        return Colors.orange.shade100;
      case "nghiem_trong":
        return Colors.red.shade200;
      case "rat_nghiem_trong":
        return Colors.red.shade400;
      default:
        return Colors.grey.shade400;
    }
  }

  String formatTrangThai(String trangthai) {
    switch (trangthai) {
      case "da_giai_quyet":
        return "Đã giải quyết";
      case "da_canh_cao":
        return "Đã cảnh cáo";
      case "da_bao_cao":
        return "Đã báo cáo";
      case "dang_xu_ly":
        return "Đang xử lý";
      default:
        return trangthai;
    }
  }

  /// Trả về màu sắc tương ứng
  Color getTrangThaiColors (String trangthai) {
    switch (trangthai) {
      case "da_giai_quyet":
        return Colors.green.shade100;
      case "da_canh_cao":
        return Colors.orange.shade100;
      case "da_bao_cao":
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  Widget _buildViPhamTab() {
    return Consumer<ViPhamProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.ViPhamList.isEmpty) {
          return const Center(child: Text("Không có dữ liệu"));
        }
        return ListView.builder(
          itemCount: provider.ViPhamList.length,
          itemBuilder: (context, i) {
            final v = provider.ViPhamList[i];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(v.noiQuy?.tieuDe ?? "Không có nội quy",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    "${v.nguoiBaoCao?["HoTen"] ?? "Không rõ"} - Phòng ${v.khachThue?.tenPhong ?? ""}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildChip(formatMucDo(v.mucDo.name), getMucDoColors(v.mucDo.name)),
                      const SizedBox(width: 8),
                      _buildChip(formatTrangThai(v.trangThai.name), getTrangThaiColors(v.trangThai.name)),
                      const Spacer(),
                      Text(
                        _formatDate(v.ngayBaoCao),
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
