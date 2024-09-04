class CommandModels {
  CommandModels({
    required this.uuid,
    required this.name,
    required this.minimumAmount,
    required this.functionId,
  });
  String uuid;
  String name;
  int minimumAmount;
  int functionId;

  factory CommandModels.fromJson(Map<String, dynamic> json) => CommandModels(
        name: json['name'],
        uuid: json['uuid'],
        minimumAmount: json['minimum_ammount'],
        functionId: json['function_id'],
      );

  toJson() => {
        'name': name,
        'uuid': uuid,
        'minimum_ammount': minimumAmount,
        'function_id': functionId,
      };
}
