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

  final _noteController = TextEditingController();

  String? selectedRoom;     // MaPhong
  String? selectedTenant;   // MaKhachThue
  String? selectedReport;
  String? selectedLevel;
  DateTime selectDate = DateTime.now();

  final List<String> Report = [
    "Chọn nội quy",
    "Giờ giấc sinh hoạt",
    "Vệ sinh chung",
    "Khách thăm",
    "An toàn cháy nổ",
    "Khác"
  ];

  final List<String> listLevel = [
    "nhe",
    "vua",
    "nghiem_trong",
    "rat_nghiem_trong"
  ];

  String convertSeverityToVietnamese(String key) {
    switch (key) {
      case 'nhe':
        return 'Nhẹ';
      case 'vua':
        return 'Vừa';
      case 'nghiem_trong':
        return 'Nghiêm trọng';
      case 'rat_nghiem_trong':
        return 'Rất nghiêm trọng';
      default:
        return key;
    }
  }

  @override
  void initState() async {
    super.initState();
    selectedReport = Report.first;
    final provider = Provider.of<CustomerProvider>(context, listen: false);
    await provider.fetchRoomBuilding();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  // ---------------- GỬI DỮ LIỆU LÊN PROVIDER ----------------
  Future<void> _submitToAPI() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedRoom == null || selectedTenant == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng chọn phòng và khách thuê!")),
      );
      return;
    }

    final payload = {
      "MaKhachThue": int.tryParse(selectedTenant!) ?? 0,
      "MaNoiQuy": Report.indexOf(selectedReport!),
      "MoTa": _noteController.text.trim(),
      "MucDo": selectedLevel ?? "",
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
                    // ================== DROPDOWN PHÒNG ==================
                    Dropdown(
                      label: "Chọn phòng vi phạm",
                      value: selectedRoom,
                      items: provider.roombuilding
                          .map((room) => room.maPhong.toString())
                          .toList(),
                      displayTextMapper: (value) {
                        final room = provider.roombuilding.firstWhere(
                          (e) => e.maPhong.toString() == value,
                        );
                        return room.tenPhong;
                      },
                      onChanged: (value) async {
                        setState(() {
                          selectedRoom = value;
                          selectedTenant = null; // reset tenant khi đổi phòng
                        });

                        ///  Gọi API lấy khách theo phòng
                        await provider.fetchTenantByRoom(int.parse(value!));
                      },
                    ),

                    SizedBox(height: 12),

                    // ================== DROPDOWN KHÁCH THUÊ ==================
                    Dropdown(
                      label: "Khách thuê vi phạm",
                      value: selectedTenant,
                      items: provider.tenantbyroom
                          .map((t) => t.maKhachThue.toString())
                          .toList(),
                      displayTextMapper: (value) {
                        final tenant = provider.tenantbyroom.firstWhere(
                            (e) => e.maKhachThue.toString() == value);
                        return tenant.hoTen;
                      },
                      onChanged: (value) {
                        setState(() {
                          selectedTenant = value;
                        });
                      },
                    ),

                    SizedBox(height: 16),

                    // ================== DROPDOWN NỘI QUY ==================
                    CustomDropdown(
                      label: "Nội quy bị vi phạm",
                      value: selectedReport,
                      items: Report,
                      onChanged: (value) {
                        setState(() {
                          selectedReport = value;
                        });
                      },
                    ),

                    SizedBox(height: 12),

                    // ================== DROPDOWN MỨC ĐỘ ==================
                    Dropdown(
                      label: "Mức độ",
                      value: selectedLevel,
                      items: listLevel,
                      displayTextMapper: convertSeverityToVietnamese,
                      onChanged: (value) {
                        setState(() {
                          selectedLevel = value;
                        });
                      },
                    ),
                    SizedBox(height: 12),
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

