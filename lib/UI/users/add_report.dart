import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/UI/shared/input_field.dart';

class AddReportPage extends StatefulWidget {
 const AddReportPage({super.key});

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  final _formKey = GlobalKey<FormState>();

  final _customerController = TextEditingController();
  final _roomController = TextEditingController();
  final _floorController = TextEditingController();
  final _roomReportController = TextEditingController();
  final _noteController = TextEditingController();

  // default -> đặt bằng mục đầu tiên trong list (Chọn nội quy)
  String? selectedReport;
  DateTime selectDate = DateTime.now();

  final List<String> Report = [
    "Chọn nội quy",
    "Giờ giấc sinh hoạt",
    "Vệ sinh chung",
    "Khách thăm",
    "An toàn cháy nổ",
    "Khác"
  ];

  @override
  void initState() {
    super.initState();
    selectedReport = Report.first;
  }

  @override
  void dispose() {
    _customerController.dispose();
    _roomController.dispose();
    _floorController.dispose();
    _roomReportController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _onAddReport() {
    if (!_formKey.currentState!.validate()) return;

    final customer = _customerController.text.trim();
    final room = _roomController.text.trim();
    final floor = _floorController.text.trim();
    final roomReport = _roomReportController.text.trim();
    final note = _noteController.text.trim();
    final violation = selectedReport ?? "";
    final timeOccur = selectDate;

    // Bạn có thể gửi dữ liệu này lên API ở đây.
    // Hiện tại chỉ show dialog xác nhận
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Xác nhận gửi báo cáo"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Khách thuê: $customer"),
            Text("Phòng: $room"),
            if (floor.isNotEmpty) Text("Dãy: $floor"),
            if (roomReport.isNotEmpty) Text("Phòng bị báo cáo: $roomReport"),
            Text("Nội quy: $violation"),
            Text("Thời gian: ${_formatDate(timeOccur)}"),
            if (note.isNotEmpty) ...[
              SizedBox(height: 8),
              Text("Ghi chú:"),
              Text(note)
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Hủy"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _submitReport({
                "khachThue": customer,
                "phong": room,
                "day": floor,
                "phongBiBaoCao": roomReport,
                "noiQuy": violation,
                "thoiGian": timeOccur.toIso8601String(),
                "ghiChu": note,
              });
            },
            child: Text("Gửi"),
          ),
        ],
      ),
    );
  }

  // Hàm thực hiện gửi report (hiện giả lập)
  Future<void> _submitReport(Map<String, dynamic> payload) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Đang gửi báo cáo...")),
    );

    await Future.delayed(Duration(milliseconds: 800));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Gửi báo cáo thành công")),
    );

    // Xóa form (tuỳ ý)
    _formKey.currentState!.reset();
    setState(() {
      selectedReport = Report.first;
      selectDate = DateTime.now();
    });
    _customerController.clear();
    _roomController.clear();
    _floorController.clear();
    _roomReportController.clear();
    _noteController.clear();
  }

  String _formatDate(DateTime dt) {
    return "${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2,'0')}:${dt.minute.toString().padLeft(2,'0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Báo cáo vi phạm",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField(
                "Khách thuê",
                "Nhập khách thuê",
                _customerController,
                (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập tên khách thuê";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Số phòng
              buildTextField(
                "Phòng",
                "Nhập số phòng",
                _roomController,
                (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập số phòng";
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
                    return "Số phòng phải là số nguyên";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Dãy trọ
              buildTextField(
                "Dãy trọ",
                "VD: Dãy E",
                _floorController,
                (value) {
                  // optional
                  return null;
                },
              ),

              SizedBox(height: 16),

              // Phòng bị báo cáo
              buildTextField(
                "Phòng bị báo cáo",
                "Nhập số phòng bị báo cáo (nếu có)",
                _roomReportController,
                (value) {
                  // optional
                  return null;
                },
              ),

              SizedBox(height: 16),

              // Dropdown Nội quy
              Text("Nội quy bị vi phạm:", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: selectedReport,
                items: Report
                    .map((report) => DropdownMenuItem(
                          value: report,
                          child: Text(report),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedReport = value;
                  });
                },
                validator: (value) {
                  if (value == null || value == Report.first) {
                    return "Vui lòng chọn loại vi phạm";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
              ),

              SizedBox(height: 16),

              // Date picker
              buildDatePickerField(context, "Thời gian xảy ra (nếu có)", selectDate,
                  (date) {
                setState(() {
                  selectDate = date;
                });
              }),

              SizedBox(height: 16),

              // Mô tả nội dung
              buildContendField("Nội dung chi tiết", "Mô tả...", _noteController, context),

              SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: buildActionBtn(Icons.close, "Hủy", Colors.red, () {
                      Navigator.pop(context);
                    }),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: buildActionBtn(Icons.add, "Gửi báo cáo", Colors.blue, _onAddReport),
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
