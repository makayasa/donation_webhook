import 'package:get/get.dart';
import 'package:get_server/get_server.dart' as gs;
import 'package:get_storage/get_storage.dart';
import 'package:saweria_webhook/app/controllers/saweria_webhook_controller.dart';
import 'package:saweria_webhook/app/controllers/server_controller.dart';
import 'package:saweria_webhook/app/controllers/tuya_controller.dart';

class HomeController extends GetxController {
  var box = GetStorage();

  RxInt count = RxInt(0);
  RxBool valorantMode = RxBool(false);

  // var tuyaC = Get.find<TuyaController>();
  late TuyaController tuyaC;
  late ServerController serverC;
  late SaweriaWebhookController saweriaC;

  @override
  void onInit() {
    super.onInit();
    valorantMode.value = box.read('valo');
    if (gs.Get.isRegistered<TuyaController>()) {
      tuyaC = gs.Get.find<TuyaController>();
    } else {
      tuyaC = gs.Get.put(TuyaController());
    }
    if (Get.isRegistered<ServerController>()) {
      serverC = gs.Get.find<ServerController>();
    } else {
      serverC = gs.Get.put(ServerController());
    }
    if (gs.Get.isRegistered<SaweriaWebhookController>()) {
      saweriaC = gs.Get.find<SaweriaWebhookController>();
    } else {
      saweriaC = gs.Get.put(SaweriaWebhookController());
    }
  }

  @override
  void onReady() async {
    super.onReady();
    // tuyaC.getBrightness();
    // typeWord();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  // void testCmd() async {
  //   await Future.delayed(Duration(seconds: 2));
  //   await run('''python -c "import pyautogui; pyautogui.press(['g','g','g','g','g',]); pyautogui.hotkey('alt','f4')" ''');
  //   logKey('done');
  // }

  // Future<void> typeWord() async {
  //   await Keyboard.typeWord('Adib Mohsin', interval: 0);
  // }
}
