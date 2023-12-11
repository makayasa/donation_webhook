class SaweriaPayloadModels {
  SaweriaPayloadModels({
    this.version = '',
    this.createdAt = '',
    this.id = '',
    this.type = '',
    this.amountRaw = 0,
    this.cut = 0,
    this.donatorName = '',
    this.donatorEmail = '',
    this.donatorIsUser = false,
    this.message = '',
  });

  String version;
  String createdAt;
  String id;
  String type;
  int amountRaw;
  int cut;
  String donatorName;
  String donatorEmail;
  bool donatorIsUser;
  String message;

  factory SaweriaPayloadModels.fromJson(Map<dynamic, dynamic> json) => SaweriaPayloadModels(
        version: json['version'],
        createdAt: json['created_at'],
        id: json['id'],
        type: json['type'],
        amountRaw: json['amount_raw'],
        cut: json['cut'],
        donatorName: json['donator_name'],
        donatorEmail: json['donator_email'],
        donatorIsUser: json['donator_is_user'],
        message: json['message'],
      );

  toJson() => {
        "version": version,
        "created_at": createdAt,
        "id": id,
        "type": type,
        "amount_raw": amountRaw,
        "cut": cut,
        "donator_name": donatorName,
        "donator_email": donatorEmail,
        "donator_is_user": donatorIsUser,
        "message": message,
      };
}
