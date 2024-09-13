abstract class ApiRoutes {
  ApiRoutes._();

  static const ROOT = '/';
  static const SAWERIA = '/saweria/webhook';

  static const TUYA = '/tuya';
  static const TURN_OFF = '$TUYA/turn_off';
  static const TURN_ON = '$TUYA/turn_on';
  static const TUYA_JEDAG_JEDUG = '/tuya/jedagjedug';
  static const SET_DIM = '/tuya/set_dim';
  static const IR_AC_TURN_OFF = '/tuya/ir_ac/turn_off';
  static const IR_AC_TURN_ON = '/tuya/ir_ac/turn_on';
}
