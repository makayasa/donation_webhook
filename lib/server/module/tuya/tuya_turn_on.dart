// import 'package:flutter/material.dart';
import 'package:get_server/get_server.dart' as gs;
import 'package:saweria_webhook/server/controllers/tuya_controller.dart';

import '../../../app/utils/constant.dart';
import '../../models/tuya_payload_models.dart';
// import 'get'

class TuyaTurnOn extends gs.GetView<TuyaController> {
  @override
  build(gs.BuildContext context) {
    var req = context.request.query;
    context.request.payload().then((value) {
      try {
        logger.i(value, error: context.request.path);
        final data = TuyaPayloadModels.fromJson(value as Map<String, dynamic>);
        controller.turnOn(data.deviceId);
      } catch (e) {
        logger.e('Error ${context.request.path}', error: e);
      }
    });
    // logKey('req saweria', req);
    return gs.Json(
      {'res': 'resss'},
    );
  }
}
