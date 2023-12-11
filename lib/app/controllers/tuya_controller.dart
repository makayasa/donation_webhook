import 'dart:convert';

// import 'package:get/get.dart' as g;
import 'package:get_server/get_server.dart';
import 'package:saweria_webhook/app/utils/function_utils.dart';

class TuyaController extends GetxController {
  RxInt brightness = RxInt(0);

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

  void turnOff() {
    var tuya = tuyaInit();
    tuya += 'lampu_kamar.turn_off()';
    runCommand(pyautoguiCommand: tuya);
  }

  void turnOn() {
    var tuya = tuyaInit();
    tuya += 'lampu_kamar.turn_on()';
    runCommand(pyautoguiCommand: tuya);
  }

  @override
  void onInit() {
    super.onInit();
    logKey('tuya init');
    getBrightness();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
