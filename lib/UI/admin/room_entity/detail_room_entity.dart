import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/PhongTroProvider.dart';
import 'deposit_room.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';

class RoomEntityDetailPage extends StatefulWidget {
  final int id;
  const RoomEntityDetailPage({super.key, required this.id});

  @override
  State<RoomEntityDetailPage> createState() => _RoomEntityDetailPageState();
}

class _RoomEntityDetailPageState extends State<RoomEntityDetailPage> {
  @override
  void initState() {
    super.initState();

    /// Load API 1 lần duy nhất để lấy phòng theo ID
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PhongTroProvider>().getPhongTrongById(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PhongTroProvider>();
    final room = provider.PhongTrongDetail;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chi tiết phòng trọ",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: Builder(builder: (_) {
        if (provider.isLoadingDetail) {
          return const Center(child: CircularProgressIndicator());
        }

        if (room == null) {
          return const Center(
            child: Text(
              "Không tìm thấy phòng!",
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.only(bottom: 100),
          children: [
            // ========== THÔNG TIN CƠ BẢN ==========
            _buildInfoSection(
              title: "Thông Tin Cơ Bản",
              icon: Icons.info_outline,
              children: [
                _buildBasicInfoRow("Tên phòng", room.tenPhong ?? "--"),
                _buildBasicInfoRow("Dãy", room.tenDay ?? "--"),
                _buildBasicInfoRow(
                    "Diện tích", "${room.dienTich ?? '--'} m²"),
                _buildBasicInfoRow(
                    "Trạng thái", room.trangThai == 1 ? "Còn trống" : "Đã thuê"),
              ],
            ),

            // ========== CHI PHÍ ==========
            _buildInfoSection(
              title: "Chi Phí & Đặt Cọc",
              icon: Icons.monetization_on,
              children: [
                _buildPriceRow(
                  "Giá thuê",
                  "${room.giaThueHienTai ?? '--'} VNĐ/tháng",
                  color: Colors.blue,
                ),
                _buildPriceRow(
                  "Tiền cọc",
                  "${room.tienCoc ?? '--'} VNĐ",
                  color: Colors.orange,
                ),
              ],
            ),

            // ========== MÔ TẢ ==========
            _buildInfoSection(
              title: "Mô Tả",
              icon: Icons.description_outlined,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    room.moTa ?? "Không có mô tả",
                    style: const TextStyle(fontSize: 17),
                  ),
                )
              ],
            ),

            // ========== TIỆN NGHI ==========
            if (room.tienNghi != null && room.tienNghi!.isNotEmpty)
              _buildInfoSection(
                title: "Tiện Nghi",
                icon: Icons.check_circle,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Wrap(
                      spacing: 10,
                      children: room.tienNghi!
                          .map(
                            (e) => Chip(
                              label: Text(
                                e.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.blueGrey,
                            ),
                          )
                          .toList(),
                    ),
                  )
                ],
              ),

            // ========== BUTTON ==========
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  buildActionBtn(Icons.close, "Đóng", Colors.red, () {
                    Navigator.pop(context);
                  }),
                  const SizedBox(width: 10),
                  buildActionBtn(
                    Icons.bookmark_added,
                    "Đặt cọc ngay",
                    Colors.blue,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DepositPage(idPhong: room.maPhong),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  // ========================== SUPPORT WIDGET ==========================

  Widget _buildInfoSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(icon, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ]),
            const Divider(height: 15),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$key:", style: const TextStyle(fontSize: 17)),
          Text(
            value,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String key, String value, {required Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$key:", style: const TextStyle(fontSize: 17)),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
