import 'package:get_server/get_server.dart';

import '../../controllers/tuya_controller.dart';

class TuyaIrAcTurnOff extends GetView<TuyaController> {
  @override
  build(BuildContext context) {
    // var req = context.request.query;
    context.request.payload().then((value) {
      controller.turnOffAc(value?['device_id']);
    });
    return Json(
      {'res': 'resss'},
    );
  }
}
