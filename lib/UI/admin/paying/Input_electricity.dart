import 'package:flutter/material.dart';

class InputElectricityPage extends StatelessWidget {
  const InputElectricityPage({super.key});

  final List<Map<String, dynamic>> data = const [
    {
      "day": "Dãy A",
      "phong": "A101",
      "khach": "Nguyễn Văn A",
      "chiSoCu": 150,
      "chiSoMoi": 250,
      "tieuThu": 100
    },
    {
      "day": "Dãy A",
      "phong": "A102",
      "khach": "Trần Thị B",
      "chiSoCu": 200,
      "chiSoMoi": 280,
      "tieuThu": 80
    },
    {
      "day": "Dãy B",
      "phong": "B201",
      "khach": "Lê Văn C",
      "chiSoCu": 180,
      "chiSoMoi": 330,
      "tieuThu": 150
    },
    {
      "day": "Dãy B",
      "phong": "B202",
      "khach": "Phạm Hoàng D",
      "chiSoCu": 120,
      "chiSoMoi": 230,
      "tieuThu": 110
    },
    {
      "day": "Dãy C",
      "phong": "C301",
      "khach": "Vũ Đình E",
      "chiSoCu": 160,
      "chiSoMoi": 290,
      "tieuThu": 130
    },
    {
      "day": "Dãy C",
      "phong": "C302",
      "khach": "Trần Văn F",
      "chiSoCu": 190,
      "chiSoMoi": 285,
      "tieuThu": 95
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Nhập chỉ số điện", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding:  EdgeInsets.all(12),
            color: Colors.blue.shade50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Icon(Icons.info_outline, color: Colors.blue),
                 SizedBox(width: 8),
                Expanded(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hướng dẫn nhập chỉ số điện',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Click "Sửa" để nhập chỉ số mới cho từng phòng. '
                        'Hệ thống sẽ tự động tính toán mức tiêu thụ.',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 13),
                      )
                    ],
                  )
                )
              ],
            ),
          ),
           SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              itemBuilder: (context, index) {
                final item = data[index];
                return Container(
                  margin:  EdgeInsets.symmetric(vertical: 6),
                  padding:  EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 6,
                        offset:  Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${item['day']} - Phòng ${item['phong']}',
                          style:  TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                       SizedBox(height: 4),
                      Text('Khách thuê: ${item['khach']}',
                          style:  TextStyle(fontSize: 14)),
                       Divider(height: 16, thickness: 1.2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Chỉ số cũ: ${item['chiSoCu']}'),
                              Text('Chỉ số mới: ${item['chiSoMoi']}'),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Tiêu thụ: ${item['tieuThu']} kWh',
                                style: TextStyle(
                                    color: Colors.green.shade700,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                onPressed: () {},
                                child:  Text('Sửa',
                                    style: TextStyle(color: Colors.blue)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () { },
                    label:  Text("Đóng"),
                    style: ElevatedButton.styleFrom(
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () { },
                    icon:  Icon(Icons.save),
                    label:  Text("Lưu tất cả"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey.shade100,
    );
  }
}
