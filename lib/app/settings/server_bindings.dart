import 'package:get_server/get_server.dart';
import 'package:saweria_webhook/server/controllers/tuya_controller.dart';
import 'package:saweria_webhook/server/controllers/webhook_controller.dart';

class ServerBindings  extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    // Get.put(ServerController());
    Get.put(TuyaController());
    Get.put(WebhookController());
  }
  
}