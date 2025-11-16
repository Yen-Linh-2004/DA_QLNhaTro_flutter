import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/account/add_account.dart';
import 'package:flutter_application/UI/admin/account/update_account.dart';
import 'package:flutter_application/UI/admin/shared/buildCard.dart';

class AccountManagementPage extends StatelessWidget {
  const AccountManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final accounts = [
      {
        'email': 'admin@tro.com',
        'phone': '0901234567',
        'role': 'Admin',
        'status': 'Hoạt động',
        'lastLogin': '2024-01-20 09:30',
      },
      {
        'email': 'manager@tro.com',
        'phone': '0912345678',
        'role': 'Quản lý',
        'status': 'Hoạt động',
        'lastLogin': '2024-01-20 08:15',
      },
      {
        'email': 'khach@email.com',
        'phone': '0923456789',
        'role': 'Khách hàng',
        'status': 'Hoạt động',
        'lastLogin': '2024-01-19 20:45',
      },
      {
        'email': 'staff@tro.com',
        'phone': '0934567890',
        'role': 'Nhân viên',
        'status': 'Tạm khóa',
        'lastLogin': '2024-01-18 17:30',
      },
    ];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 10),

            // Danh sách tài khoản
            Expanded(
              child: ListView.builder(
                itemCount: accounts.length,
                itemBuilder: (context, index) {
                  final acc = accounts[index];
                  final isActive = acc['status'] == 'Hoạt động';
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email + vai trò
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    acc['email']!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    acc['phone']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 10),
                              decoration: BoxDecoration(
                                color: _getRoleColor(acc['role']!),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                acc['role']!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),

                        // Trạng thái + Lần đăng nhập
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStatusChip(acc['status']!),
                            Text(
                              acc['lastLogin']!,
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey),
                            ),
                          ],
                        ),
                        Divider(height: 16),

                        // Các thao tác
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => UpdateAccountPage()),
                                );
                              },
                              tooltip: 'Chỉnh sửa',
                            ),
                            IconButton(
                              icon:
                                  Icon(Icons.vpn_key, color: Colors.amber),
                              onPressed: () {},
                              tooltip: 'Đổi mật khẩu',
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                  showConfirmDialog(
                                  context: context,
                                  title: "Xác nhận xóa tài khoản",
                                  message: "Bạn có chắc chắn muốn xóa tài khoản này không?",
                                  confirmColor: Colors.redAccent,
                                  icon: Icons.delete_forever,
                                  maxHeight: 140,
                                  onConfirm: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                      content: Text(
                                        "Đã xóa tài khoản thành công!",
                                      ),
                                      backgroundColor: Colors.red,
                                    ));
                                  },
                                );
                              },
                              tooltip: 'Xóa tài khoản',
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAccountPage()),
          );
        },
        icon: Icon(Icons.add),
        label: Text("Thêm tài khoản"),
      ),
    );
  }

  // Màu sắc vai trò
  Color _getRoleColor(String role) {
    switch (role) {
      case 'Admin':
        return Colors.redAccent;
      case 'Quản lý':
        return Colors.blueAccent;
      case 'Khách hàng':
        return Colors.purple;
      case 'Nhân viên':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  // Chip trạng thái
  Widget _buildStatusChip(String status) {
    bool active = status == 'Hoạt động';
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: active ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: active ? Colors.green.shade800 : Colors.red.shade800,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
