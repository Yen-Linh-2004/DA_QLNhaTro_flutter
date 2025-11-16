import 'package:flutter/material.dart';

class UpdateBookingPage extends StatefulWidget {
  const UpdateBookingPage({super.key});

  @override
  State<UpdateBookingPage> createState() => _UpdateBookingPage();
}

class _UpdateBookingPage extends State<UpdateBookingPage> {
  final TextEditingController _moneyNumberController = TextEditingController(text: "500 0000");
  final TextEditingController _nameController = TextEditingController(text: "Nguyễn Văn A");
  final TextEditingController _phoneController = TextEditingController(text: "123456789");
  final TextEditingController _emailController = TextEditingController(text: "nguyenvana@gmail.com");
  final TextEditingController _checkInDateController = TextEditingController(text: "18/11/2025");
  final TextEditingController _noteController = TextEditingController(text: "Khách yêu cầu phòng tầng 1");

  String? selectedRoom = "A101";
  List<String> rooms = ["A101", "A102", "B201", "B202" ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Cập nhật thông tin đặt phòng", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Thông tin khách hàng", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("Họ tên", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              TextFormField(
                controller: _nameController,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập họ tên",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập họ tên";
                  }
                  return null;
                },
              ), 
              SizedBox(height: 16),
            Text(
              "Số điện thoại",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập số điện thoại",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập số điện thoại";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập email",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập email";
                }
                return null;
              },
            ),
             
             
            SizedBox(height: 12),
            Text("Thông tin đặt phòng", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                "Phòng",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
               SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: selectedRoom,
                items: rooms
                    .map(
                      (gender) =>
                          DropdownMenuItem(value: gender, child: Text(gender)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRoom = value; // cập nhật giá trị
                  });
                },
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),

              SizedBox(height: 16),
              Text(
                "Ngày nhận phòng",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
               SizedBox(height: 6),
              TextFormField(
                controller: _checkInDateController,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập ngày nhận phòng",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập ngày nhận phòng";
                  }
                  return null;
                },
              ),
            
              SizedBox(height: 16),
              Text(
                "Số tiền đặt cọc",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
               SizedBox(height: 6),
              TextFormField(
                controller: _moneyNumberController,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập số số tiền",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập số tiền đặt cọc";
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),
              Text(
                "Ghi chú",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
               SizedBox(height: 6),
              TextFormField(
                controller: _noteController,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "ghi chú (nếu có)",
                ),
              ),


             SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child:  Text("Hủy"),
                  ),
                ),
                 SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child:  Text("Lưu thay đổi"),
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