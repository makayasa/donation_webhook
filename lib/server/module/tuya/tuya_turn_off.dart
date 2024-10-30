// import 'package:flutter/material.dart';
import 'package:get_server/get_server.dart' as gs;
import 'package:saweria_webhook/app/utils/constant.dart';
import 'package:saweria_webhook/server/controllers/tuya_controller.dart';
import 'package:saweria_webhook/server/models/tuya_payload_models.dart';
// import 'get'

class TuyaTurnOff extends gs.GetView<TuyaController> {
  @override
  build(gs.BuildContext context) {
    var req = context.request.query;
    // logger.i(context.request.path);
    context.request.payload().then((value) async {
      try {
        logger.i(value, error: context.request.path);
        final data = TuyaPayloadModels.fromJson(value as Map<String, dynamic>);
        await controller.turnOff(data.deviceId);
      } catch (e) {
        logger.e('Error ${context.request.path}', error: e);
      }
    });
    return gs.Json(
      const {'res': 'resss'},
    );
  }
}
