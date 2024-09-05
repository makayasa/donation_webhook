// import 'package:flutter/material.dart';
import 'package:get_server/get_server.dart' as gs;
import 'package:saweria_webhook/app/utils/function_utils.dart';
import 'package:saweria_webhook/server/controllers/server_controller.dart';
// import 'get'

class HomeServer extends gs.GetView<ServerController> {
  // const HomeServer({gs.Key? key}) : super(key: key);

  @override
  build(gs.BuildContext context) {
    gs.Get.find<ServerController>;
    var req = context.request.query;
    context.request.payload().then((value) {
      logKey('payload', value);
      if (value != null) {
        // SaweriaPayloadModels data = SaweriaPayloadModels.fromJson(value);
        // controller.homeC.allChat(data.message);
      }
    });
    logKey('req', req);
    return gs.Json(
      {'res': 'resss'},
    );
  }
}
