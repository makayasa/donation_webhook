import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
// import 'package:http/http.dart' hide Response;
// import 'package:get/get_connect.dart' hide Re;

class NetworkController extends GetxController {
  final Dio _dio = Dio();

  Future<({bool isConnected, ConnectivityResult connectedVia})> checkConnection() async {
    _dio.options.connectTimeout = const Duration(milliseconds: 5000);
    final res = await Connectivity().checkConnectivity();
    if (res.contains(ConnectivityResult.none)) {
      return (isConnected: true, connectedVia: ConnectivityResult.none);
    }
    return (isConnected: true, connectedVia: res.first);
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    final isConnected = await checkConnection();
    if (!isConnected.isConnected) {
      return;
    }
    try {
      Response res = await _dio.get(
        path,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      return res;
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    final isConnected = await checkConnection();
    if (!isConnected.isConnected) {
      return;
    }
    try {
      Response res = await _dio.post(
        path,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      return res;
    } on DioException catch (e) {
      rethrow;
    }
  }
}
