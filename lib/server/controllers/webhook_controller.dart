import 'package:get/get.dart' as g;
import 'package:get_server/get_server.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saweria_webhook/app/controllers/obs_controller.dart';
import 'package:saweria_webhook/app/utils/constant.dart';
import 'package:saweria_webhook/app/utils/environment.dart';
import 'package:saweria_webhook/server/controllers/tuya_controller.dart';
import 'package:saweria_webhook/server/models/tako_payload_models.dart';

import '../../app/modules/home/controllers/home_controller.dart';
import '../../app/utils/function_utils.dart';
import '../../helpers/saweria_message_helper.dart';
import '../models/saweria_payload_models.dart';

class WebhookController extends GetxController {
  var box = GetStorage();
  // var tuyaC = Get.put(TuyaController());

  // var homeC = Get.find<HomeController>();
  var tuyaC = Get.find<TuyaController>();

  // HomeController homeC = g.Get.put(HomeController());
  // HomeController homeC = g.Get.find<HomeController>();
  // late TuyaController tuyaC;a

  void donationSaweria(SaweriaPayloadModels data) async {
    var _isValo = box.read('valo');
    String msg = data.message;
    if (data.amountRaw < 5000) {
      return;
    }
    if (msg.contains(SaweriaMessageHelper.ON)) {
      logKey('msg', msg);
      tuyaC.turnOn(lampuKamarDeviceId);
      return;
    } else if (msg.contains(SaweriaMessageHelper.OFF)) {
      tuyaC.turnOff(lampuKamarDeviceId);
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
    HomeController homeC = g.Get.find<HomeController>();
    // HomeController homeC = g.Get.put(HomeController());
    var isValo = box.read(kValorantMode);
    String msg = data.message;
    if (data.amount < 0 && data.type != 'SOUNDBOARD') {
      return;
    }
    if (isValo) {
      dropWeapon(isValo);
    }

    // logKey('masuk ke tako', data.soundboardSoundId);

    // if (data.soundboardOptionId == '362dd29d-34eb-4492-a95b-45608a9edb5f') {
    // await homeC.toggleSourceOnActiveScene('Awoo');

    if (data.soundboardSoundId != null && data.soundboardName != null) {
      _soundboard(data.soundboardName!);
    } else {
      /// on progres
    }

    // if (data.soundboardSoundId == '362dd29d-34eb-4492-a95b-45608a9edb5f') {
    //   tuyaC.turnOff(lampuKamarDeviceId);
    // } else if (data.soundboardSoundId == 'f7afed74-4a3e-468f-9779-cead122e7781') {
    //   tuyaC.turnOn(lampuKamarDeviceId);
    // } else if (data.soundboardSoundId == 'dfe8802b-1ca0-4a6a-a2e1-e1c0b3b2e321' && box.read('valo')) {
    //   dropWeapon(true);
    // } else if (data.soundboardSoundId == 'cb570f65-753b-41d0-8a4e-e41564cc88dc') {
    //   await homeC.playMediaSource('Awoo');
    // }
    // await homeC.toggleSourceOnActiveScene('Mixer AG06', sceneName: 'Audio');
    // await homeC.toggleSourceOnActiveScene('Logitech Webcam');
    // await Future.delayed(const Duration(seconds: 5));
    // await homeC.toggleSourceOnActiveScene('Logitech Webcam');
    // await homeC.toggleSourceOnActiveScene('Mixer AG06', sceneName: 'Audio');
  }

  void _soundboard(String soundboardName, {String? deviceId}) async {
    ObsController obsC = g.Get.find<ObsController>();
    switch (soundboardName) {
      case 'Awoo':
        await obsC.playMediaSource('Awoo');
        break;

      case 'Matikan Lampu':
        await tuyaC.turnOff(deviceId!);
        break;

      case 'Nyalakan Lampu':
        await tuyaC.turnOn(deviceId!);
        break;

      case 'Drop Weapon':
        // await
        break;

      default:
    }
    if (soundboardName == 'Awoo') {}
    //  if (data.soundboardSoundId == '362dd29d-34eb-4492-a95b-45608a9edb5f') {
    //   tuyaC.turnOff(lampuKamarDeviceId);
    // } else if (data.soundboardSoundId == 'f7afed74-4a3e-468f-9779-cead122e7781') {
    //   tuyaC.turnOn(lampuKamarDeviceId);
    // } else if (data.soundboardSoundId == 'dfe8802b-1ca0-4a6a-a2e1-e1c0b3b2e321' && box.read('valo')) {
    //   dropWeapon(true);
    // } else if (data.soundboardSoundId == 'cb570f65-753b-41d0-8a4e-e41564cc88dc') {
    //   await homeC.playMediaSource('Awoo');
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
