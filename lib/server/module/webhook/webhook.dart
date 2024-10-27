// import 'package:flutter/material.dart';
import 'package:get/get.dart' as gett;
import 'package:get_server/get_server.dart' as gs;
import 'package:saweria_webhook/app/utils/constant.dart';
import 'package:saweria_webhook/server/controllers/webhook_controller.dart';
import 'package:saweria_webhook/server/models/saweria_payload_models.dart';
import 'package:saweria_webhook/server/models/tako_payload_models.dart';

import '../../../app/modules/home/controllers/home_controller.dart';
// import 'get'

class Webhook extends gs.GetView<WebhookController> {
  @override
  build(gs.BuildContext context) {
    // if (!gs.Get.isRegistered<ServerController>()) {
    //   gs.Get.put(ServerController());
    // }
    var req = context.request.query;
    context.request.payload().then((value) {
      // logKey('payload', value);
      var homeC = gett.Get.find<HomeController>();
      if (value == null) {
        return;
      }
      try {
        if (value.containsKey('amount_raw')) {
          homeC.hideSourceOnAllScene('Webcam');
          final a = {
            'asd': homeC.hideSourceOnAllScene('Webcam'),
          };
          a['asd'];
          logger.t('Donasi Saweria');
          // logKey('donasi saweria');
          SaweriaPayloadModels data = SaweriaPayloadModels.fromJson(value);
          controller.donationSaweria(data);
        } else {
          // homeC.showSourceOnAllScene('Webcam');
          final data = TakoPayloadModel.fromJson(value);
          logger.t('Donasi Tako\n${data.toJson()}');
          // logKey('donasi tako', data.toJson());
          controller.donationTako(data);
        }
      } catch (e) {
        // logKey('error Saweria', e.toString());
        logger.e('error webhook', error: e);
      }
    });
    // logKey('req saweria', req);
    return gs.Json(
      {'res': 'resss'},
    );
  }
}
