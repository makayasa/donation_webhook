import 'package:get_server/get_server.dart' as gs;
import 'package:saweria_webhook/app/utils/function_utils.dart';
import 'package:saweria_webhook/server/routes/api_routes.dart';

import '../routes/api_pages.dart';
import 'tuya_controller.dart';

// import 'package:get/get.dart' as g;

class ServerController extends gs.GetxController {
  final test = false.obs;
  // var server = gs.GetServerApp(
  //   host: '192.168.0.2',
  //   port: 7070,
  //   getPages: ApiPages.routes,
  //   // certificateChain: 'ssl/mkys-webhook_my_id.crt',
  //   // privateKey: 'ssl/keymkys.key',
  // );

  var server = gs.GetServer(
    host: '192.168.0.2',
    port: 7070,
    getPages: ApiPages.routes,
  );

  void initServer() {
    logKey('masuk init server');
    server.post(ApiRoutes.TUYA, (ctx) {
      return gs.PayloadWidget(
        builder: (context, payload) {
          var tuyaC = gs.Get.find<TuyaController>();
          tuyaC.getDeviceDetails(payload?['device_id']).then(
                (value) => context.sendJson(
                  {'result': value},
                ),
              );
          return gs.WidgetEmpty();
        },
      );
    });

    server.post(
      ApiRoutes.TUYA_JEDAG_JEDUG,
      (ctx) {
        return gs.PayloadWidget(
          builder: (context, payload) {
            var tuyaC = gs.Get.find<TuyaController>();
            tuyaC.jedagJedug(payload?['device_id'], payload?['is_on']).then(
                  (value) => context.sendJson({'result': 'wow'}),
                );
            return const gs.WidgetEmpty();
          },
        );
      },
    );
  }

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
    initServer();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
