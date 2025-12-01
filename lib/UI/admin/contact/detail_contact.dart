import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/contact/extension_contract.dart';
import 'package:flutter_application/UI/admin/contact/termination_contract.dart';
import 'package:flutter_application/UI/admin/contact/update_contact.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/provider/HopDongProvider.dart';
import 'package:provider/provider.dart';

class ContractDetailPage extends StatefulWidget {
  final int contractId;

  const ContractDetailPage({super.key, required this.contractId});

  @override
  State<ContractDetailPage> createState() => _ContractDetailPageState();
}

class _ContractDetailPageState extends State<ContractDetailPage> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<HopDongProvider>(context, listen: false);
    provider.fetchHopDongById(widget.contractId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<HopDongProvider>(
          builder: (context, provider, _) {
            return Text(
              provider.HopDongDetail != null
                  ? "Chi tiết hợp đồng ${provider.HopDongDetail?.maHopDong ?? ''}"
                  : "Chi tiết hợp đồng",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<HopDongProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final contract = provider.HopDongDetail;
          if (contract == null) {
            return Center(child: Text("Không tìm thấy dữ liệu hợp đồng"));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // THÔNG TIN HỢP ĐỒNG
                _sectionTitle("Thông tin hợp đồng"),
                SizedBox(height: 10),
                _infoCard([
                  _infoRow("Số hợp đồng", contract.maHopDong.toString()),
                  _infoRow("Ngày ký", contract.ngayKy.toString()),
                  _infoRow("Ngày bắt đầu", contract.ngayBatDau.toString()),
                  _infoRow("Ngày kết thúc", contract.ngayKetThuc.toString()),
                  _infoRow(
                    "Trạng thái",
                    contract.trangThai,
                    color: contract.trangThai == "Đang hiệu lực" ? Colors.green : Colors.red,
                    bold: true,
                  ),
                  _infoRow("Số lần gia hạn", contract.soLanGiaHan.toString()),
                ]),
                SizedBox(height: 22),

                // THÔNG TIN KHÁCH THUÊ & PHÒNG
                _sectionTitle("Thông tin khách thuê & phòng"),
                SizedBox(height: 10),
                _infoCard([
                  _infoRow("Khách thuê", contract.tenKhachThue ?? "", bold: true),
                  _infoRow("Phòng", contract.maPhong.toString()),
                  _infoRow(
                    "Tiền thuê tháng",
                    "${contract.tienThueHangThang}đ",
                    color: Colors.green,
                    bold: true,
                  ),
                  _infoRow(
                    "Tiền cọc",
                    "${contract.tienCoc}đ",
                    color: Colors.red,
                    bold: true,
                  ),
                ]),

                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UpdateContactPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text("Chỉnh sửa",
                            style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const TerminationContractPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text("Chấm dứt",
                            style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          showConfirmDialog(
                            context: context,
                            title: "Xác nhận xóa hợp đồng",
                            message: "Bạn có chắc chắn muốn xóa hợp đồng này không?",
                            confirmColor: Colors.redAccent,
                            icon: Icons.delete_forever,
                            maxHeight: 140,
                            onConfirm: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Đã xóa hợp đồng thành công!"),
                                      backgroundColor: Colors.orange));
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text("Xóa hợp đồng",
                            style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ExtensionContractPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black26,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text("Gia hạn",
                            style: TextStyle(color: Colors.greenAccent, fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _infoCard(List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: children),
      ),
    );
  }

  Widget _infoRow(
    String label,
    String value, {
    bool bold = false,
    Color? color,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(label, style: TextStyle(color: Colors.grey[700])),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
