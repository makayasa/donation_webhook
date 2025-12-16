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
    var method = context.request.method;
    if (method == 'GET') {
      context.request.payload().then((value) async {
        try {
          logger.i(value, error: context.request.uri.queryParameters['device_id']);
          logger.i(value, error: context.request.uri.queryParameters['device_id']);
          var deviceId = context.request.uri.queryParameters['device_id'];
          // var header = context.request.header(name)
          // final data = TuyaPayloadModels.fromJson(value as Map<String, dynamic>);
          if (deviceId != null) {
            await controller.turnOff(deviceId);
          }
        } catch (e) {
          logger.e('Error ${context.request.path}', error: e);
        }
      });
      return gs.Json(
        {'res': 'resss'},
      );
    }
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
