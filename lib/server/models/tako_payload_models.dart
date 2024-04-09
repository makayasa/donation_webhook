class TakoPayloadModel {
  TakoPayloadModel({
    required this.id,
    required this.type,
    required this.name,
    required this.email,
    required this.message,
    required this.amount,
    this.soundboardOptionId,
    required this.gifUrl,
    required this.creatorId,
  });
  String id;
  String type;
  String name;
  String email;
  String message;
  int amount;
  String? soundboardOptionId;
  String gifUrl;
  String creatorId;

  factory TakoPayloadModel.fromJson(Map<dynamic, dynamic> json) => TakoPayloadModel(
        id: json['id'],
        type: json['type'],
        name: json['name'],
        email: json['email'],
        message: json['message'] ?? '',
        amount: json['amount'],
        soundboardOptionId: json['soundboardOptionId'],
        gifUrl: json['gifUrl'] ?? '',
        creatorId: json['creatorId'] ?? '',
      );

  toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "email": email,
        "message": message,
        "amount": amount,
        "gifUrl": gifUrl,
        // "pollingOptionId": null,
        "soundboardOptionId": soundboardOptionId ?? '',
        // "ttvVoteOptionId": null,
        // "userId": null,
        "creatorId": creatorId,
        // "transactionId": null,
        // "youtubeVideoId": null,
        // "youtubeVideoStartAt": null,
        // "createdAt": "2023-12-15T11:40:13.380Z",
        // "updatedAt": "2023-12-15T11:40:13.380Z",
        // "expiredAt": "2023-12-15T11:40:13.380Z"
      };
}
