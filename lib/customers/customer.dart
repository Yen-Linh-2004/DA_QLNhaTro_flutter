import 'package:flutter/material.dart';
import 'package:flutter_application/customers/add_customers.dart';
import 'package:flutter_application/customers/detail_customers.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});
  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<Map<String, dynamic>> tenants = [
    {
      "name": "Nguyễn Văn A",
      "id": "123456789",
      "phone": "0901234567",
      "room": "A101",
      "contract": "15/1/2024 - 15/12/2024",
      "rent": "3.500.000đ",
      "deposit": "7.000.000đ", 
      "status": "Đang thuê",
    },
    {
      "name": "Trần Thị B",
      "id": "987654321",
      "phone": "0976543210",
      "room": "B202",
      "contract": "1/2/2024 - 30/11/2024",
      "rent": "3.800.000đ",
      "deposit": "7.600.000đ",
      "status": "Đang thuê",
    },
    {
      "name": "Lê Văn C",
      "id": "456789123",
      "phone": "0912345678",
      "room": "A105",
      "contract": "1/12/2023 - 31/1/2024",
      "rent": "3.000.000đ",
      "deposit": "6.000.000đ",
      "status": "Hết hạn",
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case "Đang thuê":
        return Colors.green.shade100;
      case "Hết hạn":
        return Colors.red.shade100;
      case "Chờ duyệt":
        return Colors.orange.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  Color getStatusTextColor(String status) {
    switch (status) {
      case "Đang thuê":
        return Colors.green.shade700;
      case "Hết hạn":
        return Colors.red.shade700;
      case "Chờ duyệt":
        return Colors.orange.shade700;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Quản lý khách thuê"),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.add),
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => const AddCustomerPage(),
      //           ),
      //         );
      //       },
      //       tooltip: "Thêm khách thuê",
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Scrollbar(
          thumbVisibility: true, // hiện thanh kéo luôn, dễ dùng
          thickness: 6, // độ dày thanh kéo
          radius: Radius.circular(10),
          child: ListView.builder(
            itemCount: tenants.length,
            itemBuilder: (context, i) {
              var t = tenants[i];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CustomerDetailPage(
                        // tenantData: t, // truyền dữ liệu nếu cần
                      ),
                    ),
                  );
                },
                child: Card(
                  margin: EdgeInsets.only(bottom: 12),
                  elevation: 1.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(14),
                    child: Row(
                      children: [
                        CircleAvatar(radius: 22, child: Text(t['name'][0])),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                t['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "CCCD: ${t['id']}",
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(
                            color: getStatusColor(t['status']),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            t['status'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: getStatusTextColor(t['status']),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCustomerPage(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        label:  Text("Thêm khách thuê", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        icon:  Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
