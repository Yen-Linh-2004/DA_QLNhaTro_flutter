import 'package:flutter/material.dart';
import 'package:flutter_application/UI/generalPage/dashbroad.dart';
import 'package:flutter_application/UI/generalPage/login.dart';
import 'package:flutter_application/core/config/app_config.dart';
import 'package:flutter_application/core/network/dio_client.dart';
import 'package:flutter_application/data/service/NoiQuyService.dart';
import 'package:flutter_application/provider/AuthProvider.dart';
import 'package:flutter_application/provider/BaoTriProvider.dart';
import 'package:flutter_application/provider/DichVuProvider.dart';
import 'package:flutter_application/provider/LoaiPhongProvider.dart';
import 'package:flutter_application/provider/NoiQuyProvider.dart';
import 'package:flutter_application/provider/PhongTroProvider.dart';
import 'package:flutter_application/provider/ThietBiProvider.dart';
import 'package:flutter_application/provider/ViPhamProvider.dart';
import 'package:flutter_application/provider/khachthueProvider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/assets/.env");
  await AppConfig.loadToken();
  DioClient.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LoaiPhongProvider()),
        ChangeNotifierProvider(create: (_) => KhachThueProvider()),
        ChangeNotifierProvider(create: (_) => PhongTroProvider()),
        ChangeNotifierProvider(create: (_) => DichVuProvider()),
        ChangeNotifierProvider(create: (_) => ThietBiProvider()),
        ChangeNotifierProvider(create: (_) => NoiQuyProvider()),
        ChangeNotifierProvider(create: (_) => ViPhamProvider()),
        ChangeNotifierProvider(create: (_) => BaoTriProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const LoginPage(),
    );
  }
}

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const HomeMobilePage(),
//     );
//   }
// }
