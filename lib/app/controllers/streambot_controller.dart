import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class StreambotController extends GetxController {
  //TODO: Implement StreambotController

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

  var channel = WebSocketChannel.connect(
    Uri.parse(''),
  );
}
