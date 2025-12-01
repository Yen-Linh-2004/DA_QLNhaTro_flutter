import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/UI/shared/input_field.dart';

class UpdateStatusPage extends StatefulWidget {
  const UpdateStatusPage({super.key});

  @override
  State<UpdateStatusPage> createState() => _UpdateStatusPageState();
}

class _UpdateStatusPageState extends State<UpdateStatusPage> {
  final _formKey = GlobalKey<FormState>();

  final _noteController = TextEditingController();
  String? selectedStatus = "Chọn trạng thái";

  List<String> listStatus = ["Chọn trạng thái", "Đang cập nhật", "Tạm dừng", "Hoàn thành", "Đã hủy"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cập nhật trạng thái", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
        padding: EdgeInsets.all(20),
        child: Center(
          child: Card(
            elevation: 5,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDropdown(
                      label: "Trạng thái mới",
                      value: selectedStatus,
                      items: listStatus,
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value;
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    buildContendField("Ghi chú cập nhật",  "Ghi chú về tiến độ, vấn đề gặp phải...", _noteController, context),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        buildActionBtn(Icons.close, "Hủy", Colors.red, () => Navigator.pop(context),),
                        SizedBox(width: 10),
                        buildActionBtn(Icons.update, "Cập nhật", Colors.green, (){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                            content: Text("Đã cập nhât thành công!"),
                            backgroundColor: Colors.green,
                          ));
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
