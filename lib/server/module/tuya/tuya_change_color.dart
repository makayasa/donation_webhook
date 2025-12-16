import 'package:get_server/get_server.dart' as gs;
import 'package:saweria_webhook/server/controllers/tuya_controller.dart';

import '../../../app/utils/constant.dart';

class TuyaChangeColor extends gs.GetView<TuyaController> {
  @override
  build(gs.BuildContext context) {
    var req = context.request.query;
    var method = context.request.method;
    context.request.payload().then((value) async {
      try {
        logger.i(value, error: context.request.path);
        // final data = TuyaPayloadModels.fromJson(value as Map<String, dynamic>);
        await controller.changeColor(deviceId: value!['device_id'], hexColor: value['hex_color']);
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
