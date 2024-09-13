import 'dart:async';
import 'dart:convert';

// import 'package:get/get.dart' as g;
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as g hide Response;
import 'package:get_server/get_server.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:saweria_webhook/app/utils/constant.dart';
import 'package:saweria_webhook/app/utils/function_utils.dart';
import 'package:saweria_webhook/app/utils/network_controller.dart';
import 'package:uuid/uuid.dart';

class TuyaController extends GetxController {
  final _expiredTime = RxInt(0);

  Timer? timer;

  RxInt brightness = RxInt(0);
  final boxTuya = GetStorage('tuya');
  final networkC = g.Get.find<NetworkController>();

  final clientId = 'kac5gdupecy9unxea4hx';
  final accessSecret = 'e0d4770addb64034b44fc5bbf9dfda75';
  final tuyaBaseUrl = 'https://openapi.tuyaus.com';
  final ver = 'v1.0';

  String _generateSignature(
      {required String clientId, required String secret, String? accessToken, required String t, String? nonce, required String stringToSign}) {
    var signStr = clientId + (accessToken ?? '') + t + (nonce ?? '') + stringToSign;
    var key = utf8.encode(secret);
    var bytes = utf8.encode(signStr);
    var hmacSha256 = Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);
    return digest.toString().toUpperCase();
  }

  Future<void> checkTokenValidation() async {
    if (_expiredTime.value <= 0) {
      try {
        await tuyaRefreshToken(refreshToken: boxTuya.read(kTuyaRefreshToken));
      } catch (e) {
        rethrow;
      }
    }
    // try {
    //   await tuyaGetToken();
    // } catch (e) {
    //   rethrow;
    // }
    // await tuyaGetToken(isRefresh: true);
    // await tuyaRefreshToken();
    // return;
    // if (!await isTokenValid()) {
    //   logKey('TOKEN INVALID!!!', boxTuya.read(kTuyaAccessToken));
    //   boxTuya.erase();
    //   await tuyaGetToken(isRefresh: true);
    //   logKey('GET NEW TOKEN', boxTuya.read(kTuyaAccessToken));
    // }
  }

  Future<void> tuyaGetToken() async {
    final url = '$tuyaBaseUrl/$ver/token?grant_type=1';
    await boxTuya.erase();
    var headers = _generateHeaderSignature(url: url).headers;
    try {
      final Response res = await networkC.get(
        url,
        headers: headers,
      );
      final isSuccess = res.data['success'];
      if (!isSuccess) {
        throw DioException.badResponse(
          statusCode: 404,
          requestOptions: RequestOptions(),
          response: Response(
            requestOptions: RequestOptions(),
          ),
        );
      }
      final data = res.data['result'] as Map<String, dynamic>;
      _expiredTime.value = data['expire_time'];
      // if (_expiredTime.value <= 0) {
      //   await tuyaRefreshToken(refreshToken: data['refresh_token']);
      //   return;
      // }
      boxTuya.write(kTuyaRefreshToken, data['refresh_token']);
      boxTuya.write(kTuyaTokenMap, data);
      boxTuya.write(kTuyaAccessToken, data['access_token']);
      // boxTuya.write(kTuyaExpireTime, data['expire_time']);
      // boxTuya.write(kTuyaCreatedTime, data['created_time']);

      // logKey('success write token', boxTuya.read(kTuyaAccessToken));
      // logKey('success write refresh token', boxTuya.read(kTuyaRefreshToken));
    } on DioException catch (e) {
      logKey('error auth', e.message);
      rethrow;
    }
  }

  //* not working
  Future<void> tuyaRefreshToken({required String refreshToken}) async {
    // final refreshToken = boxTuya.read(kTuyaRefreshToken);
    final url = '$tuyaBaseUrl/$ver/token/$refreshToken?grant_type=1';
    final headers = _generateHeaderSignature(url: url).headers;
    try {
      final Response res = await networkC.get(
        url,
        headers: headers,
      );
      logKey('res tuyaRefreshToken', res.data);
      if (res.data['code'] == 1004) {
        return;
      }
      final data = res.data['result'] as Map<String, dynamic>;
      _expiredTime.value = data['expire_time'];

      boxTuya.erase();
      boxTuya.write(kTuyaTokenMap, data);
      boxTuya.write(kTuyaAccessToken, data['access_token']);
      boxTuya.write(kTuyaRefreshToken, data['refresh_token']);
      logKey('token refreshed. New Token', data['access_token']);
    } on DioException catch (e) {
      logKey('error tuyaRefreshToken', e.message);
      rethrow;
    }
  }

  ({String signature, String timeStamp, String nonce, Map<String, dynamic> headers}) _generateHeaderSignature({
    required String url,
    List<Map<String, dynamic>>? commands,
    String httpMethod = 'GET',
    bool isRefreshToken = false,
  }) {
    final accessToken = isRefreshToken ? boxTuya.read(kTuyaRefreshToken) ?? '' : boxTuya.read(kTuyaAccessToken) ?? '';
    String timestamp = (DateTime.now().millisecondsSinceEpoch).toString();
    String nonce = const Uuid().v4();
    String contentSha256;
    if (commands != null) {
      final data = {
        'commands': jsonEncode(commands),
      };
      contentSha256 = sha256.convert(utf8.encode(jsonEncode(data))).toString();
    } else {
      contentSha256 = sha256.convert(utf8.encode('')).toString();
    }
    String optionalSignatureKey = '';
    String stringToSign = [
      httpMethod,
      contentSha256,
      optionalSignatureKey,
      // '/v1.0/devices/$deviceId/commands',
      url.split(tuyaBaseUrl).last,
    ].join('\n');
    String sign = _generateSignature(
      clientId: clientId,
      secret: accessSecret,
      accessToken: accessToken,
      t: timestamp,
      nonce: nonce,
      stringToSign: stringToSign,
    );
    var headers = {
      'sign_method': 'HMAC-SHA256',
      'client_id': clientId,
      't': timestamp,
      'sign': sign,
      // 'access_token': accessToken,
      'nonce': nonce,
    };
    if (isRefreshToken) {
      headers['refresh_token'] = accessToken;
    } else {
      headers['access_token'] = accessToken;
    }
    // logKey('headers', headers);
    return (signature: sign, timeStamp: timestamp, nonce: nonce, headers: headers);
  }

  Future<void> testControl(String deviceId) async {
    final url = '$tuyaBaseUrl/$ver/devices/$deviceId/commands';
    String timestamp = (DateTime.now().millisecondsSinceEpoch).toString();
    String nonce = const Uuid().v4();
    final accessToken = boxTuya.read('tuya_token')?['access_token'];
    final commands = [
      {'code': 'switch_led', 'value': true}
    ];
    final data = {
      'commands': jsonEncode(commands),
    };
    String httpMethod = 'POST';
    String contentSha256 = sha256.convert(utf8.encode(jsonEncode(data))).toString();
    String optionalSignatureKey = '';
    String stringToSign = [
      httpMethod,
      contentSha256,
      optionalSignatureKey,
      // '/v1.0/devices/$deviceId/commands',
      url.split(tuyaBaseUrl).last,
    ].join('\n');

    String sign = _generateSignature(
      clientId: clientId,
      secret: accessSecret,
      accessToken: accessToken,
      t: timestamp,
      nonce: nonce,
      stringToSign: stringToSign,
    );

    var headers = {
      'sign_method': 'HMAC-SHA256',
      'client_id': clientId,
      't': timestamp,
      'sign': sign,
      'access_token': accessToken,
      'nonce': nonce,
    };

    try {
      final Response res = await networkC.post(
        url,
        body: data,
        headers: headers,
      );
      logKey('res testControl', res.data);
    } on DioException catch (e) {
      logKey('error testControl', e.message);
    }
  }

  Future<void> getBrightness() async {
    logKey('msk get brightness');
    var tuya = tuyaInit();
    tuya += 'print(lampu_kamar.status())';
    var res = await runCommand(pyautoguiCommand: tuya);
    String str = res[0].stdout;
    str = str.replaceAll("'", '"');
    str = str.replaceAll('True', 'true');
    str = str.replaceAll('False', 'false');
    logKey('res', str);
    var jeson = json.decode(str);
    brightness.value = jeson['dps']['22'];
    // var json = jsonDecode(str);
  }

  void setBrightnessUp() async {
    var tuya = tuyaInit();
    if (brightness.value <= 900) {
      brightness.value += 100;
    }
    tuya += 'lampu_kamar.set_brightness(${brightness.value})';
    runCommand(pyautoguiCommand: tuya);
  }

  // void setBrightnessUp(String deviceid) {
  //   final url = '$tuyaBaseUrl/$ver/devices/$deviceid/commands';
  //   var header = _generateHeaderSignature(url: url).headers;

  // }

  void setBrightnessDown() async {
    if (brightness >= 100) {
      brightness.value -= 100;
    }
    var tuya = tuyaInit();
    tuya += 'lampu_kamar.set_brightness(${brightness.value})';
    runCommand(pyautoguiCommand: tuya);
  }

  void setBrightnessMinimum() async {
    var tuya = tuyaInit();
    tuya += 'lampu_kamar.set_brightness(${10})';
    await runCommand(pyautoguiCommand: tuya);
    brightness.value = 10;
  }

  void setBrightnessMaximum() async {
    var tuya = tuyaInit();
    tuya += 'lampu_kamar.set_brightness(${1000})';
    await runCommand(pyautoguiCommand: tuya);
    brightness.value = 1000;
  }

  // void turnOff() {
  //   var tuya = tuyaInit();
  //   tuya += 'lampu_kamar.turn_off()';
  //   runCommand(pyautoguiCommand: tuya);
  // }

  // void turnOn() {
  //   var tuya = tuyaInit();
  //   tuya += 'lampu_kamar.turn_on()';
  //   runCommand(pyautoguiCommand: tuya);
  // }

  void turnOff(String deviceId) async {
    final url = '$tuyaBaseUrl/$ver/devices/$deviceId/commands';
    final commands = [
      {
        'code': 'switch_led',
        'value': false,
      }
    ];
    final data = {'commands': jsonEncode(commands)};
    final headers = _generateHeaderSignature(url: url, commands: commands, httpMethod: 'POST').headers;
    try {
      await checkTokenValidation();
      final Response res = await networkC.post(url, body: data, headers: headers);
      logKey('res turnOff', res.data);
      if (res.data?['code'] == 1010 && res.data?['msg'] == 'token invalid') {
        await tuyaGetToken();
        turnOnAc(deviceId);
      }
    } on DioException catch (e) {
      logKey('error turnOff', e.message);
    }
  }

  Future<void> turnOn(String deviceId) async {
    final url = '$tuyaBaseUrl/$ver/devices/$deviceId/commands';
    final commands = [
      {
        'code': 'switch_led',
        'value': true,
      }
    ];
    final data = {'commands': jsonEncode(commands)};
    final headers = _generateHeaderSignature(httpMethod: 'POST', url: url, commands: commands).headers;
    try {
      await checkTokenValidation();
      final Response res = await networkC.post(url, body: data, headers: headers);
      logKey('res turnOn', res.data);
    } on DioException catch (e) {
      logKey('error turnOff', e.message);
      rethrow;
    }
  }

  Future<void> jedagJedug(String deviceId, bool isOn) async {
    final url = '$tuyaBaseUrl/$ver/devices/$deviceId/commands';
    final commands = [
      !isOn
          ? {
              'code': 'work_mode',
              'value': 'white',
            }
          : {
              "code": "scene_data_v2",
              "value": {
                "scene_num": 7,
                "scene_units": [
                  {
                    "bright": 0,
                    "h": 0,
                    "s": 1000,
                    "temperature": 0,
                    "unit_change_mode": "gradient",
                    "unit_gradient_duration": 100,
                    "unit_switch_duration": 100,
                    "v": 1000
                  },
                  {
                    "bright": 0,
                    "h": 120,
                    "s": 1000,
                    "temperature": 0,
                    "unit_change_mode": "gradient",
                    "unit_gradient_duration": 100,
                    "unit_switch_duration": 100,
                    "v": 1000
                  },
                  {
                    "bright": 0,
                    "h": 240,
                    "s": 1000,
                    "temperature": 0,
                    "unit_change_mode": "gradient",
                    "unit_gradient_duration": 100,
                    "unit_switch_duration": 100,
                    "v": 1000
                  }
                ]
              }
            }
    ];
    final data = {'commands': jsonEncode(commands)};
    final headers = _generateHeaderSignature(url: url, httpMethod: 'POST', commands: commands).headers;
    try {
      // await checkTokenValidation();
      await turnOn(deviceId);
      final Response res = await networkC.post(url, body: data, headers: headers);
      logKey('res jedagJedug', res.data);
    } on DioException catch (e) {
      logKey('error jedagJedug', e.message);
    }
  }

  void turnOffAc(String deviceId) async {
    final url = '$tuyaBaseUrl/$ver/devices/$deviceId/commands';
    logKey('masuk turnOffAc');
    final commands = [
      {
        "code": "PowerOff",
        // "type": "STRING",
        "values": "PowerOff",
      },
      // {
      //   "code": "switch",
      //   "values": false,
      // },
    ];
    final data = {'commands': jsonEncode(commands)};
    final headers = _generateHeaderSignature(url: url, commands: commands, httpMethod: 'POST').headers;
    try {
      await checkTokenValidation();
      final Response res = await networkC.post(url, body: data, headers: headers);
      logKey('res turnOffAc', res.data);
    } on DioException catch (e) {
      logKey('error turnOffAc', e.message);
    }
  }

  void turnOnAc(String deviceId) async {
    final url = '$tuyaBaseUrl/$ver/devices/$deviceId/commands';
    final commands = [
      {
        "code": "PowerOn",
        "values": "PowerOn",
      },
      // {
      //   "code": "mode",
      //   "desc": "mode",
      //   "name": "mode",
      //   "type": "ENUM",
      //   "values": "cold",
      // },
      {
        "code": "M",
        "value": 0,
      },
      {
        "code": "T",
        "value": 26,
      },
      {
        "code": "F",
        "value": 0,
      },
    ];
    for (var i = 0; i < commands.length; i++) {
      final _commands = [
        commands[i],
      ];
      logKey('_commands', _commands);
      final data = {'commands': jsonEncode(_commands)};
      final headers = _generateHeaderSignature(url: url, commands: _commands, httpMethod: 'POST').headers;
      try {
        await checkTokenValidation();
        final Response res = await networkC.post(url, body: data, headers: headers);
        logKey('res turnOffAc', res.data);
      } on DioException catch (e) {
        logKey('error turnOffAc', e.message);
      }
      // await Future.delayed(const Duration(seconds: 10));
    }
  }

  Future<List<dynamic>> getDeviceDetails(String deviceId) async {
    final url = '$tuyaBaseUrl/$ver/devices/$deviceId/status';
    final headers = _generateHeaderSignature(url: url, httpMethod: 'GET').headers;
    try {
      await checkTokenValidation();
      final Response res = await networkC.get(url, headers: headers);
      logKey('res getDeviceDetails', res.data);
      return res.data['result'];
    } on DioException catch (e) {
      logKey('error getDeviceDetails', e.message);
      return [];
    }
  }

  void setupTimer() {
    timer = Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      (_timer) async {
        if (_expiredTime.value == 0) {
          try {
            await tuyaGetToken();
            timer?.cancel();
            setupTimer();
          } catch (e) {
            return;
          }
          return;
        }
        _expiredTime.value--;
        // logKey('sisa waktu', _expiredTime.value);
      },
    );
  }

  void initialFunction() async {
    await tuyaGetToken();
    setupTimer();
    // timer = Timer.periodic(
    //   const Duration(
    //     seconds: 2,
    //   ),
    //   (timer) {
    //     logKey('sisa waktu');
    //   },
    // );
    // await tuyaGetToken(isRefresh: true);
    // final a = boxTuya.read(kTuyaAccessToken);
    // if (isEmpty(a)) {
    //   await tuyaGetToken();
    // }

    // await getDevicesList();
    // await testControl('3710228040f520e467e5');
    // getBrightness();
  }

  @override
  void onInit() {
    super.onInit();
    logKey('tuya init');
    // testTuya();
    initialFunction();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
