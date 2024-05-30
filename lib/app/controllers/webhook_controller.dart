import 'package:get_server/get_server.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saweria_webhook/app/controllers/tuya_controller.dart';
import 'package:saweria_webhook/app/utils/environment.dart';
import 'package:saweria_webhook/server/models/tako_payload_models.dart';

import '../../helpers/saweria_message_helper.dart';
import '../../server/models/saweria_payload_models.dart';
import '../utils/function_utils.dart';

class WebhookController extends GetxController {
  var box = GetStorage();
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
      tuyaC.turnOn(lampu_kamar_device_id);
      return;
    } else if (msg.contains(SaweriaMessageHelper.OFF)) {
      tuyaC.turnOff(lampu_kamar_device_id);
      return;
    } else if (msg.contains(SaweriaMessageHelper.DROP)) {
      dropWeapon(_isValo);
      return;
    } else if (msg.contains(SaweriaMessageHelper.TXT)) {
      allChat(msg, _isValo);
      return;
    }
  }

  // final takoSoundboard = {};

  void donationTako(TakoPayloadModel data) async {
    var _isValo = box.read('valo');
    String msg = data.message;
    if (data.amount < 5000 && data.type != 'SOUNDBOARD') {
      return;
    }

    logKey('masuk ke tako', data.soundboardOptionId);

    if (data.soundboardOptionId == '6f8f7bcc-35f1-4ee4-8e16-4624e609686d') {
      tuyaC.turnOff(lampu_kamar_device_id);
    } else if (data.soundboardOptionId == 'e614f419-971f-43f6-a0e1-22a9f5b111a5') {
      tuyaC.turnOn(lampu_kamar_device_id);
    } else if (data.soundboardOptionId == 'dfe8802b-1ca0-4a6a-a2e1-e1c0b3b2e321' && box.read('valo')) {
      dropWeapon(true);
    }
    // if (msg.contains(SaweriaMessageHelper.ON)) {
    //   logKey('msg', msg);
    //   tuyaC.turnOn();
    //   return;
    // } else if (msg.contains(SaweriaMessageHelper.OFF)) {
    //   tuyaC.turnOff();
    //   return;
    // } else if (msg.contains(SaweriaMessageHelper.DROP)) {
    //   dropWeapon(_isValo);
    //   return;
    // } else if (msg.contains(SaweriaMessageHelper.TXT)) {
    //   allChat(msg, _isValo);
    //   return;
    // }
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
