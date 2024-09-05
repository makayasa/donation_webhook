class Tuya {
  static Tuya? _instance;
  Tuya._();
  factory Tuya() => _instance ??= Tuya._();
}
