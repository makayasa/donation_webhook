// import 'package:flutter/material.dart';
import 'package:get_server/get_server.dart' as gs;
import 'package:saweria_webhook/app/controllers/server_controller.dart';
import 'package:saweria_webhook/app/utils/function_utils.dart';
// import 'get'

class Tuya extends gs.GetView<ServerController> {
  @override
  build(gs.BuildContext context) {
    var req = context.request.query;
    context.request.payload().then((value) {
      // final tuyaC = gs.Get.find<TuyaController>();
      // tuyaC.jedagJedug(value?['device_id'], value?['is_on']);
    });
    logKey('req saweria', req);

    return gs.Json(
      {'res': 'resss'},
    );
  }
}
