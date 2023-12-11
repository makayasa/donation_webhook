// import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import 'package:get_server/get_server.dart' as gs;
import 'package:saweria_webhook/app/controllers/tuya_controller.dart';
import 'package:saweria_webhook/app/utils/function_utils.dart';
// import 'get'

class SetDim extends gs.GetView<TuyaController> {
  @override
  build(gs.BuildContext context) {
    var req = context.request.query;
    context.request.payload().then((value) {
      if (value == null) {
        return;
      }
      g.Get.snackbar('title', 'message');
      // Fluttertoast.showToast(msg: 'msg');

      try {
        if (value.containsKey('max')) {
          if (value['max']) {
            controller.setBrightnessMaximum();
            return;
          }
          controller.setBrightnessMinimum();
          return;
        }
        if (value['dim_up']) {
          controller.setBrightnessUp();
          return;
        }
        {
          controller.setBrightnessDown();
          return;
        }
      } catch (e) {
        logKey('error SetDim', e.toString());
      }
    });
    // logKey('req saweria', req);
    return gs.Json(
      {'res': 'resss'},
    );
  }
}
