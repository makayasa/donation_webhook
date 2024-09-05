// import 'package:flutter/material.dart';
import 'package:get_server/get_server.dart' as gs;
import 'package:saweria_webhook/app/utils/function_utils.dart';
import 'package:saweria_webhook/server/controllers/tuya_controller.dart';
// import 'get'

class TuyaTurnOff extends gs.GetView<TuyaController> {
  @override
  build(gs.BuildContext context) {
    var req = context.request.query;
    context.request.payload().then((value) {
      logKey('masuk off', value);
      //{"device_id":"3710228040f520e467e5"}
      controller.turnOff(value?['device_id']);
    });
    logKey('req saweria', req);
    return gs.Json(
      {'res': 'resss'},
    );
  }
}
