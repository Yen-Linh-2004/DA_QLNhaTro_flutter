import 'package:flutter/material.dart';
import 'package:flutter_application/provider/TaiKhoanProvider.dart';
import 'package:provider/provider.dart';
import 'add_account.dart';
import 'update_account.dart';

class AccountManagementPage extends StatefulWidget {
  const AccountManagementPage({super.key});

  @override
  State<AccountManagementPage> createState() => _AccountManagementPageState();
}

class _AccountManagementPageState extends State<AccountManagementPage> {
  @override
  void initState() {
    super.initState();
    // Gọi fetch tài khoản sau khi widget được mount
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<TaiKhoanProvider>(context, listen: false);
      provider.fetchTaiKhoan();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Quản lý tài khoản")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Consumer<TaiKhoanProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.TaiKhoanList.isEmpty) {
              return const Center(child: Text("Chưa có tài khoản nào"));
            }

            return ListView.builder(
              itemCount: provider.TaiKhoanList.length,
              itemBuilder: (context, index) {
                final acc = provider.TaiKhoanList[index];
                return _buildAccountCard(acc);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddAccountPage()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Thêm tài khoản"),
      ),
    );
  }

  // Null-safe card hiển thị thông tin tài khoản
  Widget _buildAccountCard(acc) {
    final name = acc.nhanVien?.hoTen ?? acc.khachThue?.hoTen ?? acc.TenDangNhap ?? "-";
    final email = acc.nhanVien?.email ?? acc.khachThue?.email ?? "-";
    final phone = acc.nhanVien?.sdt ?? acc.khachThue?.sdt2 ?? acc.khachThue.sdt1 ??"-";
    final role = acc.TenQuyen ?? "-";
    final status = acc.TrangThaiTaiKhoan ?? "-";

    final isActive = status == "Hoạt động";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 5,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email + phone + role
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(email,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey)),
                    Text(phone,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                  color: _getRoleColor(role),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(role,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusChip(status),
              Text("-", style: const TextStyle(fontSize: 13, color: Colors.grey)),
            ],
          ),
          const Divider(height: 16),
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const UpdateAccountPage()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.vpn_key, color: Colors.amber),
                onPressed: () {
                  // TODO: đặt lại mật khẩu
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // TODO: xóa tài khoản
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Màu role
  Color _getRoleColor(String role) {
    switch (role) {
      case 'Admin':
        return Colors.redAccent;
      case 'Quản lý':
        return Colors.blueAccent;
      case 'Khách thuê':
        return Colors.purple;
      case 'Nhân viên':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  // Chip trạng thái
  Widget _buildStatusChip(String status) {
    final active = status == "Hoạt động";
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: active ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
            color: active ? Colors.green.shade800 : Colors.red.shade800,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
