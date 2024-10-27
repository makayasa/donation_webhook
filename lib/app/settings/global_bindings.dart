import 'package:get/get.dart';
import 'package:get_server/get_server.dart' as gs;
import 'package:saweria_webhook/app/utils/network_controller.dart';

import '../../server/controllers/server_controller.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    // Get.put(HomeController());
    // Get.put(ServerController());
    // Get.put(ServerController());
    // gs.Get.put(TuyaController());
    // Get.put(SaweriaWebhookController());
    Get.put(NetworkController(), permanent: true);
    gs.Get.put(ServerController());
  }
}
