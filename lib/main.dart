import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/Rooms/type_room/LoaiPhong.dart';
import 'package:flutter_application/UI/admin/generalPage/dashbroad.dart';
import 'package:flutter_application/provider/LoaiPhongProvider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/assets/.env");
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LoaiPhongProvider())],
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
      home: const TypeRoomPage(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'ui/pages/khach_thue_page.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(fileName: ".env");

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Flutter Call API Laravel",
//       debugShowCheckedModeBanner: false,
//       home: const KhachThuePage(),
//     );
//   }
// }
