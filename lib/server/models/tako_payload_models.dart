class TakoPayloadModel {
  TakoPayloadModel({
    required this.id,
    required this.type,
    required this.creatorName,
    required this.gifterEmail,
    required this.gifterName,
    required this.message,
    required this.amount,
    this.soundboardSoundId,
    required this.gifUrl,
    required this.creatorId,
  });
  String id;
  String type;
  String creatorName;
  String gifterName;
  String gifterEmail;
  String message;
  int amount;
  String? soundboardSoundId;
  String gifUrl;
  String creatorId;

  factory TakoPayloadModel.fromJson(Map<dynamic, dynamic> json) => TakoPayloadModel(
        id: json['id'],
        type: json['type'],
        creatorName: json['creatorName'],
        gifterName: json['gifterName'],
        gifterEmail: json['gifterEmail'],
        message: json['message'] ?? '',
        amount: json['amount'],
        soundboardSoundId: json['soundboardSoundId'],
        gifUrl: json['gifUrl'] ?? '',
        creatorId: json['creatorId'] ?? '',
      );

  toJson() => {
        "id": id,
        "type": type,
        "creatorName": creatorName,
        'gifterName': gifterName,
        "gifterEmail": gifterEmail,
        "message": message,
        "amount": amount,
        "gifUrl": gifUrl,
        // "pollingOptionId": null,
        "soundboardSoundId": soundboardSoundId ?? '',
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
