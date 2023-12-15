import 'package:get_server/get_server.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saweria_webhook/app/controllers/tuya_controller.dart';
import 'package:saweria_webhook/server/models/tako_payload_models.dart';

import '../../helpers/saweria_message_helper.dart';
import '../../server/models/saweria_payload_models.dart';
import '../utils/function_utils.dart';

class SaweriaWebhookController extends GetxController {
  var box = GetStorage();
  // var homeC = Get.put(HomeController());
  // var tuyaC = Get.put(TuyaController());

  // var homeC = Get.find<HomeController>();
  var tuyaC = Get.find<TuyaController>();

  // HomeController homeC = g.Get.put(HomeController());
  // late TuyaController tuyaC;a

  void donationSaweria(SaweriaPayloadModels data) async {
    var _isValo = box.read('valo');
    String msg = data.message;
    if (data.amountRaw < 5000) {
      return;
    }
    if (msg.contains(SaweriaMessageHelper.ON)) {
      logKey('msg', msg);
      tuyaC.turnOn();
      return;
    } else if (msg.contains(SaweriaMessageHelper.OFF)) {
      tuyaC.turnOff();
      return;
    } else if (msg.contains(SaweriaMessageHelper.DROP)) {
      dropWeapon(_isValo);
      return;
    } else if (msg.contains(SaweriaMessageHelper.TXT)) {
      allChat(msg, _isValo);
      return;
    }
  }

  void donationTako(TakoPayloadModel data) async {
    var _isValo = box.read('valo');
    String msg = data.message;
    if (data.amount < 5000) {
      return;
    }
    if (msg.contains(SaweriaMessageHelper.ON)) {
      logKey('msg', msg);
      tuyaC.turnOn();
      return;
    } else if (msg.contains(SaweriaMessageHelper.OFF)) {
      tuyaC.turnOff();
      return;
    } else if (msg.contains(SaweriaMessageHelper.DROP)) {
      dropWeapon(_isValo);
      return;
    } else if (msg.contains(SaweriaMessageHelper.TXT)) {
      allChat(msg, _isValo);
      return;
    }
  }

  @override
  void onInit() {
    super.onInit();
    // if (g.Get.isRegistered<HomeController>()) {
    //   homeC = g.Get.find<HomeController>();
    // } else {
    //   homeC = g.Get.put(HomeController());
    // }

    // if (Get.isRegistered<TuyaController>()) {
    //   tuyaC = Get.find<TuyaController>();
    // } else {
    //   tuyaC = Get.put(TuyaController());
    // }
    //
  }

  @override
  void onReady() {
    super.onReady();
    logKey('saweria on ready');
  }

  @override
  void onClose() {}
}
