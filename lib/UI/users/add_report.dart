import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/UI/shared/input_field.dart';
import 'package:flutter_application/provider/CustomerProvider.dart';
import 'package:provider/provider.dart';

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

  // ---------------- GỬI DỮ LIỆU LÊN PROVIDER ----------------
  Future<void> _submitToAPI() async {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      "MaKhachThue": int.tryParse(_customerController.text.trim()) ?? 0,
      "MaNoiQuy": Report.indexOf(selectedReport!), // bạn đổi lại nếu backend khác
      "MoTa": _noteController.text.trim(),
      "MucDo": "vua", // default hoặc bạn thêm dropdown
      "NgayBaoCao": selectDate.toIso8601String(),
    };

    print("📤 Gửi dữ liệu tạo violation: $payload");

    final provider = Provider.of<CustomerProvider>(context, listen: false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Đang gửi báo cáo...")),
    );

    await provider.createViolations(payload);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gửi báo cáo thành công!")),
      );
    }

    Navigator.pop(context);
  }

  // ------------------------------------------------------------

  String _formatDate(DateTime dt) {
    return "${dt.day}/${dt.month}/${dt.year}  ${dt.hour}:${dt.minute}";
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Báo cáo vi phạm",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildTextField(
                      "Mã khách thuê",
                      "Nhập ID khách thuê",
                      _customerController,
                      (v) {
                        if (v == null || v.isEmpty) return "Không được để trống";
                        if (!RegExp(r'^\d+$').hasMatch(v)) {
                          return "Phải là số ID";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 16),

                    // Dropdown Nội quy
                    Text("Nội quy vi phạm:", style: TextStyle(fontWeight: FontWeight.bold)),
                    DropdownButtonFormField<String>(
                      value: selectedReport,
                      items: Report
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) => setState(() => selectedReport = v),
                      validator: (v) {
                        if (v == null || v == Report.first)
                          return "Vui lòng chọn nội quy";
                        return null;
                      },
                    ),

                    SizedBox(height: 16),

                    buildDatePickerField(
                      context,
                      "Ngày báo cáo",
                      selectDate,
                      (d) => setState(() => selectDate = d),
                    ),

                    SizedBox(height: 16),

                    buildContendField(
                      "Mô tả báo cáo",
                      "Nhập mô tả chi tiết...",
                      _noteController,
                      context,
                    ),

                    SizedBox(height: 24),

                    Row(
                      children: [
                        buildActionBtn(Icons.close, "Hủy", Colors.red, () {
                          Navigator.pop(context);
                        }),
                        SizedBox(width: 12),
                        buildActionBtn(Icons.send, "Gửi", Colors.blue, _submitToAPI),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
