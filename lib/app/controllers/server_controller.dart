import 'package:get_server/get_server.dart' as gs;
import 'package:saweria_webhook/app/utils/function_utils.dart';

import '../../server/routes/api_pages.dart';

// import 'package:get/get.dart' as g;

class ServerController extends gs.GetxController {
  // HomeController homeC = g.Get.find<HomeController>();
  // TuyaController tuyaC = Get.find<TuyaController>();
  // late SaweriaWebhookController saweriaC;
  var server = gs.GetServerApp(
    host: '192.168.0.2',
    port: 7070,
    getPages: ApiPages.routes,
    // certificateChain: 'ssl/mkys-webhook_my_id.crt',
    // privateKey: 'ssl/keymkys.key',
  );

  String getForwardedUrl(String output) {
    // Parsing output ngrok untuk mendapatkan URL forwarding
    final regex = RegExp(r'https?://[^\s]+');
    final match = regex.firstMatch(output);
    return match?.group(0) ?? '';
  }

  void ngrok({required String url, required String ip, required String port}) async {
    var res = await startNgrok(url: url, ip: ip, port: port);
    // var stdout = await res[0].stdout;
    // logKey('res kontol', stdout);
    // var ngrok = await Process.start('ngrok', ['http 7070']);
    // var stdout = await ngrok.stdout;
  }

  @override
  void onInit() {
    super.onInit();
    // ngrok();
    logKey('server started');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
