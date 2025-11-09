import 'package:flutter/material.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  // Controllers
  final TextEditingController _contactNumberControl = TextEditingController(
    text: "HD005",
  );
  final TextEditingController _dateStartControl = TextEditingController(
    text: "01/01/2025",
  );
  final TextEditingController _dateRegistrationControl = TextEditingController(
    text: "01/11/2025",
  );
  final TextEditingController _dateEndController = TextEditingController(
    text: "01/11/2025",
  );
  final TextEditingController _moneyControl = TextEditingController(
    text: "01/11/2025",
  );
  final TextEditingController _depositControl = TextEditingController(
    text: "01/11/2025",
  );
  final TextEditingController _electricityBillControl = TextEditingController(
    text: "01/11/2025",
  );
  final TextEditingController _waterBillControl = TextEditingController(
    text: "01/11/2025",
  );

  // Dropdown values
  String? selectedRoom = "A101";
  String? selectedCustomers = "Nguyễn Văn A";

  List<String> rooms = ["A101", "A102", "B201", "B202"];
  List<String> customers = ["Nguyễn Văn A", "Trần Thị B"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tạo hợp đồng"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text("Số hợp đồng", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: _contactNumberControl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập số hợp đồng",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập số hợp đồng";
                }
                return null;
              },
            ),

            SizedBox(height: 16),
            Text("Khách thuê", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: selectedCustomers,
              items: customers
                  .map(
                    (customer) => DropdownMenuItem(
                      value: customer,
                      child: Text(customer),
                    ),
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
            Text("Ngày bắt đầu", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: _dateStartControl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập ngày bắt đầu",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập ngày bắt đầu";
                }
                return null;
              },
            ),

            SizedBox(height: 16),
            Text("Ngày đăng ký", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: _dateRegistrationControl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập ngày đăng ký",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập ngày đăng ký";
                }
                return null;
              },
            ),

            SizedBox(height: 16),
            Text(
              "Ngày kết thúc",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            TextFormField(
              controller: _dateEndController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập ngày kết thúc",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập ngày kết thúc";
                }
                return null;
              },
            ),

            SizedBox(height: 16),
            Text("Phòng", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: selectedRoom,
              items: rooms
                  .map(
                    (rooms) => DropdownMenuItem(
                      value: rooms,
                      child: Text(rooms),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedRoom = value;
                });
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),

            SizedBox(height: 16),
            Text("Tiền thuê", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: _moneyControl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập số tiền thuê phòng",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập số tiền thuê phòng";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Text("Tiền cọc", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: _depositControl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập số tiền cọc",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập số tiền cọc";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Text("Giá điện", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: _electricityBillControl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập giá điện",
              ),
            ),

            SizedBox(height: 16),
            Text("Giá nước", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextFormField(
              controller: _waterBillControl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập giá nước",
              ),
            ),
              SizedBox(height: 16),
             // Nút hành động
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Hủy"),
                  ),
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text("Thêm phòng", style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
