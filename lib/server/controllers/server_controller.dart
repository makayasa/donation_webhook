import 'package:get_server/get_server.dart' as gs;
import 'package:saweria_webhook/app/settings/server_bindings.dart';
import 'package:saweria_webhook/app/utils/constant.dart';
import 'package:saweria_webhook/app/utils/function_utils.dart';
import 'package:saweria_webhook/server/models/tuya_payload_models.dart';
import 'package:saweria_webhook/server/routes/api_routes.dart';

import '../routes/api_pages.dart';
import 'tuya_controller.dart';

// import 'package:get/get.dart' as g;

class ServerController extends gs.GetxController {
  final test = false.obs;
  final port = 7070;
  // var server = gs.GetServerApp(
  //   host: '192.168.0.2',
  //   port: 7070,
  //   getPages: ApiPages.routes,
  //   // certificateChain: 'ssl/mkys-webhook_my_id.crt',
  //   // privateKey: 'ssl/keymkys.key',
  // );

  // var server = gs.GetServer();
  late gs.GetServer server;

  void initServer() async {
    server = gs.GetServer(
      port: port,
      useLog: false,
      getPages: ApiPages.routes,
      initialBinding: ServerBindings(),
    );

    server.post(ApiRoutes.TUYA, (ctx) {
      return gs.PayloadWidget(
        builder: (context, payload) {
          var tuyaC = gs.Get.find<TuyaController>();
          try {
            final data = TuyaPayloadModels.fromJson(payload as Map<String, dynamic>);
            tuyaC.getDeviceDetails(data.deviceId).then(
                  (value) => context.sendJson(
                    {'result': value},
                  ),
                );
            logger.i(payload, error: context.request.path);
          } catch (e) {
            logger.e('Error ${context.request.path}', error: e);
          }

          return const gs.WidgetEmpty();
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
