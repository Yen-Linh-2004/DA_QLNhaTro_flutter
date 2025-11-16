import 'package:flutter/material.dart';
import 'package:flutter_application/shared/buildCard.dart';
import 'package:flutter_application/shared/input_field.dart';

class StaffAssignmentPage extends StatefulWidget {
  const StaffAssignmentPage({super.key});

  @override
  State<StaffAssignmentPage> createState() => _StaffAssignmentPageState();
}

class _StaffAssignmentPageState extends State<StaffAssignmentPage> {
  final _formKey = GlobalKey<FormState>();

  final _noteController = TextEditingController();
  String? selectedStaff = "Chọn nhân viên";

  List<String> listStaff = ["Chọn nhân viên", "Tuấn", "My"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phân công nhân viên", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                      label: "Chọn nhân viên",
                      value: selectedStaff,
                      items: listStaff,
                      onChanged: (value) {
                        setState(() {
                          selectedStaff = value;
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    buildContendField("Ghi chú",  "Ghi chú thêm về công việc...", _noteController, context),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        buildActionBtn(Icons.close, "Hủy", Colors.red, (){}),
                        SizedBox(width: 10),
                        buildActionBtn(Icons.person_add, "Phân công", Colors.blue, (){}),
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
