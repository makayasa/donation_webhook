import 'package:get/get.dart';
import 'package:get_server/get_server.dart' as gs;
import 'package:get_storage/get_storage.dart';
import 'package:saweria_webhook/app/utils/constant.dart';
import 'package:saweria_webhook/server/controllers/server_controller.dart';

class SettingController extends GetxController {
  final serverC = gs.Get.find<ServerController>();
  final box = GetStorage();

  final port = RxInt(0);

  final valorantMode = RxBool(false);
  final eldenringMode = RxBool(false);

  void initialFunction() async {
    valorantMode.value = box.read(kValorantMode) ?? false;
    eldenringMode.value = box.read(kEldenRingMode) ?? false;
    port.value = serverC.port;
  }

  void changedGameMode(String game, bool state) {
    if (game == 'valorant') {
      valorantMode.value = state;
      box.write(kValorantMode, state);
      return;
    }
    if (game == 'elden_ring') {
      eldenringMode.value = state;
      box.write(kEldenRingMode, state);
    }
    return;
  }

  @override
  void onInit() {
    super.onInit();
    initialFunction();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
