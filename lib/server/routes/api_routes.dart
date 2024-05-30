abstract class ApiRoutes {
  ApiRoutes._();

  static const ROOT = '/';
  static const SAWERIA = '/saweria/webhook';

  static const TUYA = '/tuya';
  static const TURN_OFF = '$TUYA/turn_off';
  static const TURN_ON = '$TUYA/turn_on';
  static const SET_DIM = '/tuya/set_dim';
  static const IR_AC = '/tuya/ir_ac';
}
