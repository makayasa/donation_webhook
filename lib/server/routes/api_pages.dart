import 'package:get_server/get_server.dart' as gs;
import 'package:saweria_webhook/server/module/tuya/tur_ir_ac_turn_on.dart';
import 'package:saweria_webhook/server/module/tuya/tuya_change_color.dart';
import 'package:saweria_webhook/server/module/tuya/tuya_ir_ac_turn_off.dart';
import 'package:saweria_webhook/server/module/tuya/tuya_turn_off.dart';
import 'package:saweria_webhook/server/module/tuya/tuya_turn_on.dart';
import 'package:saweria_webhook/server/module/webhook/webhook.dart';
import 'package:saweria_webhook/server/routes/api_routes.dart';

import '../home_server.dart';
import '../module/tuya/set_dim.dart';

class ApiPages {
  ApiPages._();

  static final routes = [
    gs.GetPage(
      name: ApiRoutes.ROOT,
      page: () => HomeServer(),
      method: gs.Method.post,
    ),
    gs.GetPage(
      name: ApiRoutes.SAWERIA,
      page: () => Webhook(),
      method: gs.Method.post,
      // keys: [],
      // needAuth: true,
    ),
    // gs.GetPage(
    //   name: ApiRoutes.TUYA,
    //   page: () => Tuya(),
    //   method: gs.Method.post,
    // ),
    gs.GetPage(
      name: ApiRoutes.TURN_ON,
      page: () => TuyaTurnOn(),
      method: gs.Method.post,
    ),
    gs.GetPage(
      name: ApiRoutes.TURN_ON,
      page: () => TuyaTurnOn(),
      method: gs.Method.get,
    ),
    gs.GetPage(
      name: ApiRoutes.TURN_OFF,
      page: () => TuyaTurnOff(),
      method: gs.Method.post,
    ),
    gs.GetPage(
      name: ApiRoutes.TURN_OFF,
      page: () => TuyaTurnOff(),
      method: gs.Method.get,
    ),
    gs.GetPage(
      name: ApiRoutes.CHANGE_COLOR,
      page: () => TuyaChangeColor(),
      method: gs.Method.post,
    ),
    gs.GetPage(
      name: ApiRoutes.SET_DIM,
      page: () => SetDim(),
      method: gs.Method.post,
    ),
    gs.GetPage(
      name: ApiRoutes.IR_AC_TURN_OFF,
      page: () => TuyaIrAcTurnOff(),
      method: gs.Method.post,
    ),
    gs.GetPage(
      name: ApiRoutes.IR_AC_TURN_ON,
      page: () => TuyaIrAcTurnOn(),
      method: gs.Method.post,
    ),
  ];
}
