class CommandModels {
  CommandModels({required this.uuid, required this.name});
  String uuid;
  String name;

  factory CommandModels.fromJson(Map<String, dynamic> json) => CommandModels(
        name: json['name'],
        uuid: json['uuid'],
      );

  toJson() => {
        'name': name,
        'uuid': uuid,
      };
}
