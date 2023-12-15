// import 'package:flutter/material.dart';
import 'package:get_server/get_server.dart' as gs;
import 'package:saweria_webhook/app/controllers/saweria_webhook_controller.dart';
import 'package:saweria_webhook/app/utils/function_utils.dart';
import 'package:saweria_webhook/server/models/saweria_payload_models.dart';
import 'package:saweria_webhook/server/models/tako_payload_models.dart';
// import 'get'

class Saweria extends gs.GetView<SaweriaWebhookController> {
  @override
  build(gs.BuildContext context) {
    // if (!gs.Get.isRegistered<ServerController>()) {
    //   gs.Get.put(ServerController());
    // }
    var req = context.request.query;
    context.request.payload().then((value) {
      logKey('payload', value);
      if (value == null) {
        return;
      }
      try {
        if (value.containsKey('amount_raw')) {
          logKey('donasi saweria');
          SaweriaPayloadModels data = SaweriaPayloadModels.fromJson(value);
          controller.donationSaweria(data);
        } else {
          logKey('donasi tako');
          final data = TakoPayloadModel.fromJson(value);
          controller.donationTako(data);
        }
      } catch (e) {
        logKey('error Saweria', e.toString());
      }
    });
    logKey('req saweria', req);
    return gs.Json(
      {'res': 'resss'},
    );
  }
}
