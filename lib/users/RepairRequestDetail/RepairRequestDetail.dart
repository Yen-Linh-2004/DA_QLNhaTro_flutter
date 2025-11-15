import 'package:flutter/material.dart';

class RepairRequestDetailPage extends StatelessWidget {
  const RepairRequestDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text("Chi tiết yêu cầu bảo trì")),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Thông tin cơ bản ---
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:  EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      "Thông tin cơ bản",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     SizedBox(height: 10),
                    _infoRow("Tiêu đề", "Điều hòa không hoạt động"),
                    _infoRow("Danh mục", "Điện lạnh"),
                    _infoRow("Ưu tiên", "Cao", valueColor: Colors.red),
                    _infoRow(
                      "Trạng thái",
                      "Chờ xử lý",
                      valueColor: Colors.orange[700],
                    ),
                  ],
                ),
              ),
            ),

             SizedBox(height: 12),

            // --- Thông tin xử lý ---
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:  EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      "Thông tin xử lý",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     SizedBox(height: 10),
                    _infoRow("Ngày tạo", "2024-12-10"),
                    _infoRow(
                      "Chi phí ước tính",
                      "500,000 VNĐ",
                      valueColor: Colors.teal[700],
                    ),
                  ],
                ),
              ),
            ),

             SizedBox(height: 12),

            // --- Mô tả vấn đề ---
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:  EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      "Mô tả vấn đề",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Điều hòa phòng 101A không thể bật, có thể do hỏng remote hoặc máy.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

             SizedBox(height: 12),

            // --- Ghi chú ---
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:  EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      "Ghi chú",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Cần xử lý gấp vì trời nóng.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

             SizedBox(height: 20),

            // --- Hình ảnh minh họa ---
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:  EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      "Hình ảnh minh họa",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     SizedBox(height: 10),
                    Row(
                      children: [
                        _imagePlaceholder(),
                         SizedBox(width: 10),
                        _imagePlaceholder(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:  EdgeInsets.all(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.close, color: Colors.white),
                  SizedBox(width: 4),
                  Text(
                    "Hủy yêu cầu",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding:  EdgeInsets.all(12),
                  ),
                  child: Container(width: 140, alignment: Alignment.center, child: Text("Đóng", style: TextStyle(fontSize: 16),))
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding:  EdgeInsets.all(12),
                  ),
                  child: Container(width: 140, alignment: Alignment.center, child: Text("Chỉnh sửa", style: TextStyle(color: Colors.white, fontSize: 16)))
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style:  TextStyle(fontWeight: FontWeight.w500)),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child:  Icon(Icons.image, color: Colors.grey),
    );
  }
}
