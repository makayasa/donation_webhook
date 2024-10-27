class TuyaPayloadModels {
  TuyaPayloadModels({
    required this.deviceId,
  });

  String deviceId;

  factory TuyaPayloadModels.fromJson(Map<String, dynamic> json) => TuyaPayloadModels(
        deviceId: json['device_id'],
      );

  Map<String, dynamic> toJson() => {
        'device_id': deviceId,
      };
}
