import 'package:flutter/material.dart';
import 'package:flutter_application/generalPage/dashbroad.dart';
import 'package:flutter_application/users/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const TenantHomePage(),
      home: const HomeMobilePage(),
    );
  }
}
