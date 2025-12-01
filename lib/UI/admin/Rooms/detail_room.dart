import 'package:flutter/material.dart';
import 'package:flutter_application/provider/PhongTroProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/data/model/PhongTro.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/UI/admin/Rooms/update_room.dart';

class RoomDetailPage extends StatefulWidget {
  final int roomId;

  const RoomDetailPage({required this.roomId, Key? key}) : super(key: key);

  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<PhongTroProvider>(context, listen: false);
      provider.fetchPhongTroById(widget.roomId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chi tiết phòng",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<PhongTroProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingDetail) {
            return const Center(child: CircularProgressIndicator());
          }

          final PhongTro? room = provider.PhongTroDetail;

          if (room == null) {
            return const Center(child: Text("Không tìm thấy dữ liệu phòng"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------- THÔNG TIN PHÒNG ----------
                const Text("Thông tin phòng",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF4FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _buildInfoSection({
                    "Số phòng": room.tenPhong,
                    "Dãy": room.tenDay ?? '--',
                    "Loại phòng": room.tenLoaiPhong ?? '--',
                    "Diện tích": room.dienTich != null ? room.dienTich.toString() : "--",
                    "Giá thuê": "${room.donGiaCoBan ?? 0} đ/tháng",
                    "Trạng thái": room.trangThai.label,
                  }),
                ),
                const SizedBox(height: 16),

                // ---------- TIỆN NGHI ----------
                const Text("Tiện nghi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9F9EE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: (room.tienNghi as List<dynamic>? ?? [])
                        .map((e) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.check, color: Colors.green, size: 18),
                                const SizedBox(width: 6),
                                Text(e.toString(), style: const TextStyle(fontSize: 14)),
                              ],
                            ))
                        .toList(),
                  ),
                ),

                const SizedBox(height: 24),

                // ---------- NÚT HÀNH ĐỘNG ----------
                Row(
                  children: [
                    buildActionBtn(Icons.edit_outlined, "Chỉnh sửa", Colors.blue, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const UpdateRoomPage()),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    buildActionBtn(Icons.shuffle, "Đổi phòng", Colors.orange, () { }),
                    const SizedBox(width: 10),
                    buildActionBtn(Icons.delete, "Xóa phòng", Colors.redAccent, () {
                      showConfirmDialog(
                        context: context,
                        title: "Xác nhận xóa phòng",
                        message: "Bạn có chắc chắn muốn xóa phòng này không?",
                        confirmColor: Colors.redAccent,
                        icon: Icons.delete_forever,
                        maxHeight: 140,
                        onConfirm: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Đã xóa phòng thành công!"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  // ---------------------- WIDGET PHỤ ----------------------
  Widget _buildInfoSection(Map<String, String?> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data.entries
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text("${e.key}:",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black54)),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      e.value ?? '--',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
