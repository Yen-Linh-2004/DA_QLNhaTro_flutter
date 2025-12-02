import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/contact/add_contact.dart';
import 'package:flutter_application/UI/admin/contact/detail_contact.dart';
import 'package:flutter_application/data/model/HopDong.dart';
import 'package:flutter_application/provider/HopDongProvider.dart';
import 'package:provider/provider.dart';

class ContractManagementPage extends StatefulWidget {
  const ContractManagementPage({super.key});

  @override
  State<ContractManagementPage> createState() => _ContractManagementPageState();
}

class _ContractManagementPageState extends State<ContractManagementPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<HopDongProvider>(context, listen: false).fetchHopDong();
    });
  }

  String trangThai(String status) {
    switch (status) {
      case "HetHan":
        return "Hết hạn";
      case "DangHieuLuc":
        return "Đang hiệu lực";
      default:
        return status;
    }
  }

  Color statusColor(String status) {
    switch (status) {
      case "Hết hạn":
        return Colors.red.shade100;
      case "Đang hiệu lực":
        return Colors.green.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  Color statusTextColor(String status) {
    switch (status) {
      case "Hết hạn":
        return Colors.red;
      case "Đang hiệu lực":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddContactPage()),
          );
        },
        backgroundColor: Colors.deepPurple,
        label: const Text(
          "Tạo hợp đồng mới",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 10),
            _buildSearchBox(),
            SizedBox(height: 16),

            Expanded(
              child: Consumer<HopDongProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (provider.HopDongList.isEmpty) {
                    return Center(child: Text("Không có hợp đồng"));
                  }

                  return ListView.separated(
                    itemCount: provider.HopDongList.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = provider.HopDongList[index];
                      return _buildContractCard(item);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return SizedBox(
      height: 50,
      child: TextField(
        decoration: InputDecoration(
          hintText: "Tìm kiếm...",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildContractCard(HopDong item) {
    String statusLabel = trangThai(item.trangThai);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ContractDetailPage(contractId: item.maHopDong)),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.description, color: Colors.blue),
            ),
            SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.soHopDong,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(item.khachThue?.hoTen ?? "Không có tên"),
                  Text(
                    "Phòng: ${item.tenPhong ?? '---'}",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${item.tienThueHangThang.toStringAsFixed(0)} đ",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor(statusLabel),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusLabel,
                    style: TextStyle(
                      color: statusTextColor(statusLabel),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
