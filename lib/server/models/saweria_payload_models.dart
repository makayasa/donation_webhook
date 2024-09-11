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

//? contoh webhook dummy dari saweria
// {
//     "version": "2022.01",
//     "created_at": "2021-01-01T12:00:00+00:00",
//     "id": "00000000-0000-0000-0000-000000000000",
//     "type": "donation",
//     "amount_raw": 69420,
//     "cut": 3471,
//     "donator_name": "Someguy",
//     "donator_email": "someguy@example.com",
//     "donator_is_user": false,
//     "message": "THIS IS A FAKE MESSAGE! HAVE A GOOD ONE",
//     "etc": {
//         "amount_to_display": 69420
//     }
// }

//? contoh payload soundboard. Kemungkinan ID nya 1
// {
//     "version": "2022.01",
//     "created_at": "2024-09-08T13:12:02.568043+07:00",
//     "id": "5435cf5c-94a1-4c7d-b2e5-5aed7412bc6e",
//     "type": "donation",
//     "amount_raw": 1000,
//     "cut": -58,
//     "donator_name": "Budi",
//     "donator_email": "budi@gmail.com",
//     "donator_is_user": false,
//     "message": "",
//     "etc": {
//         "id": 1,
//         "name": "Huh",
//         "type": "sb",
//         "fileUrl": "https://saweria-space.sgp1.cdn.digitaloceanspaces.com/prd/sound/80e1e291-17db-43fd-a767-f771ee51ada6-4f3ad6f20dc11f155eae6719e36ed32c.mp3",
//         "amount_to_display": 1000
//     }
// }

//? contoh payload mediashare
// {
//     "version": "2022.01",
//     "created_at": "2024-09-08T15:28:08.961137+07:00",
//     "id": "e05cdcfe-04db-4b23-ba25-a4797c767f35",
//     "type": "donation",
//     "amount_raw": 1000,
//     "cut": -58,
//     "donator_name": "budi",
//     "donator_email": "budi@gmail.com",
//     "donator_is_user": false,
//     "message": "gomen amanai",
//     "etc": {
//         "id": "Z6XcqcFc9cU",
//         "end": 10,
//         "type": "yt",
//         "start": 0,
//         "amount_to_display": 1000
//     }
// }