// ignore_for_file: constant_identifier_names
import 'package:get_server/get_server.dart' as gs;
import 'package:saweria_webhook/server/controllers/tuya_controller.dart';

enum FunctionName {
  MatiLampu,
  NyalaLampu,
  DropWeapon,
  Awoo,
}

abstract class TuyaUseCase {
  // Future<dynamic> testFuction();
  Future<void> turnOn(String deviceId, {int count = 0});
}

class TuyaUseCaseImpl implements TuyaUseCase {
  final tuyaC = gs.Get.find<TuyaController>();
  @override
  Future<void> turnOn(String deviceId, {int count = 0}) async => await tuyaC.turnOn(deviceId, count: count);
  // @override
  // Future testFuction() {
  //   tuyaC.turnOff(deviceId);
  // }
}
