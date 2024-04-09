import 'package:saweria_webhook/app/data/models/command_models.dart';

class GroupCommandModels {
  GroupCommandModels({
    required this.uuid,
    required this.name,
    required this.commands,
  });

  String uuid;
  String name;
  List<CommandModels> commands;

  factory GroupCommandModels.fromJson(Map<String, dynamic> json) => GroupCommandModels(
        uuid: json['uuid'],
        name: json['name'],
        commands: json.isNotEmpty ? List<CommandModels>.from(json['commands'].map((x) => x)) : [],
      );

  toJson() => {
        'uuid': uuid,
        'name': name,
        'commands': commands,
      };
}
