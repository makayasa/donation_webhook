import '../controllers/create_webhook_command_controller.dart';
import 'package:get/get.dart';

class CreateWebhookCommandBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateWebhookCommandController>(
      () => CreateWebhookCommandController(),
    );
  }
}
