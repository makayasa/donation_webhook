// import 'package:flutter/material.dart';
import 'package:get_server/get_server.dart' as gs;
import 'package:saweria_webhook/app/controllers/tuya_controller.dart';
import 'package:saweria_webhook/app/utils/function_utils.dart';
// import 'get'

class TuyaTurnOn extends gs.GetView<TuyaController> {
  @override
  build(gs.BuildContext context) {
    var req = context.request.query;
    context.request.payload().then((value) {
      controller.turnOn(value?['device_id']);
    });
    logKey('req saweria', req);
    return gs.Json(
      {'res': 'resss'},
    );
  }
}
