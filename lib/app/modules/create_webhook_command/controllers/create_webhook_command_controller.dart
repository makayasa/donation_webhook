// import 'package:get_server/get_server.dart';
import 'package:get/get.dart';

class CreateWebhookCommandController extends GetxController {
  //TODO: Implement CreateWebhookCommandController

  final types = ['keyboard_input', 'obs_control'];

  // RxList<dynamic> test = RxList<dynamic>(['1', '2', '3', '4', 2]);
  var test = ['1', '2', '3', '4'].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
