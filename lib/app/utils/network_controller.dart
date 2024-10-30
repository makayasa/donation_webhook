import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saweria_webhook/app/utils/function_utils.dart';
// import 'package:http/http.dart' hide Response;
// import 'package:get/get_connect.dart' hide Re;

class NetworkController extends GetxController {
  final Dio _dio = Dio();
  String filepath = '';
// _dio;
  late File logFile;

  @override
  onInit() async {
    super.onInit();
    // _dio.interceptors.add(TestInterceptor());
    // Directory a = await getTemporaryDirectory();
    final res = await Permission.storage.request();
    logKey('res permission', res.isGranted);
    Directory a = await getApplicationDocumentsDirectory();

    filepath = a.path;
    logFile = File('${filepath + r'\'}ini_log_file.txt');
    _dio.interceptors.add(
      LoggyDioInterceptor(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        // requestLevel: LogLevel.warning,
      ),
    );
    // _dio.interceptors.add(PrettyDioLogger(
    //   requestHeader: true,
    //   requestBody: true,
    //   responseBody: true,
    //   responseHeader: false,
    //   compact: true,
    //   enabled: kDebugMode,
    // ));
  }

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
