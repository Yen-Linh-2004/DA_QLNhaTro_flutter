import 'package:dio/dio.dart';
import '../config/app_config.dart';
class DioClient {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: AppConfig.apiUrl,
    connectTimeout: Duration(seconds: 20),
    receiveTimeout: Duration(seconds: 20),
    contentType: "application/json",
  ));

  // static void init() {
  //   dio.interceptors.clear();

  //   dio.interceptors.add(
  //     InterceptorsWrapper(
  //       onRequest: (options, handler) {
  //         if (AppConfig.token != null) {
  //           options.headers["Authorization"] = "Bearer ${AppConfig.token}";
  //           print("Gửi token lên server: ${AppConfig.token}");
  //         }
  //         return handler.next(options);
  //       },
  //     ),
  //   );
  // }

  static void init() {
    dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (options.extra["noAuth"] == true) {
            return handler.next(options);
          }
          final token = await AppConfig.loadToken();
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
      ),
    );
  }

}
