import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/shared/buildCard.dart';
import 'package:flutter_application/UI/admin/shared/input_field.dart';
class AddFloorPage extends StatefulWidget {
  const AddFloorPage({super.key});

  @override
  State<AddFloorPage> createState() => _AddFloorPageState();
}

class _AddFloorPageState extends State<AddFloorPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameFloorController = TextEditingController();
  final _areaController = TextEditingController();


  @override
  void dispose() {
    _nameFloorController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  void _onAddFloor() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:  Text("Thêm dãy phòng thành công"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop();
                Navigator.of(context)
                    .pop();
              },
              child:  Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm dãy phòng mới", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField("Thêm dãy phòng",  "Dãy E", _nameFloorController),
              SizedBox(height: 12),
              buildContendField("Địa chỉ", "Nhập đĩa chỉ của dãy", _areaController, context),
              SizedBox(height: 24),
              // Nút hành động
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildActionBtn(Icons.close, "Hủy", Colors.red, (){}),
                  SizedBox(width: 20),
                  buildActionBtn(Icons.add, "Thêm dãy phòng", Colors.blue, (){}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
