import 'package:flutter/material.dart';

class AddincidentalCostsPage extends StatefulWidget {
  const AddincidentalCostsPage({super.key});

  @override
  State<AddincidentalCostsPage> createState() => _AddincidentalCostsPageState();
}

class _AddincidentalCostsPageState extends State<AddincidentalCostsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _amountController = TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Thêm chi phí phát sinh"),
        // backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Tiêu đề người thuê ---
               Text(
                "Nguyễn Văn A",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
               SizedBox(height: 16),

              // --- Thông tin hóa đơn ---
              Container(
                width: double.infinity,
                padding:  EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Phòng:", style: TextStyle(fontWeight: FontWeight.w600)),
                        Text("A101"),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tháng:", style: TextStyle(fontWeight: FontWeight.w600)),
                        Text("Tháng 10, 2025"),
                      ],
                    ),
                    Divider(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tổng tiền hiện tại:", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("4.410.000đ",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                    ),
                  ],
                ),
              ),

               SizedBox(height: 24),

              // --- Form nhập ---
               Text("Mô tả chi phí *", style: TextStyle(fontWeight: FontWeight.w600)),
               SizedBox(height: 6),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(
                  hintText: "Nhập mô tả chi phí phát sinh",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding:  EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập mô tả chi phí";
                  }
                  return null;
                },
              ),
               SizedBox(height: 16),

               Text("Số tiền *", style: TextStyle(fontWeight: FontWeight.w600)),
               SizedBox(height: 6),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "0",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding:  EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập số tiền";
                  }
                  if (double.tryParse(value) == null) {
                    return "Số tiền không hợp lệ";
                  }
                  return null;
                },
              ),

               SizedBox(height: 28),

              // --- Nút hành động ---
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding:  EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child:  Text("Hủy", style: TextStyle(fontSize: 16),),
                    ),
                  ),
                   SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Xử lý lưu chi phí ở đây
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text("Đã thêm chi phí thành công!")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        padding:  EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      icon:  Icon(Icons.add, color: Colors.white,),
                      label:  Text("Thêm chi phí", style: TextStyle(color: Colors.white, fontSize: 16),),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
