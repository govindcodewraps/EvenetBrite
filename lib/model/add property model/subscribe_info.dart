// To parse this JSON data, do
//
//     final subscribeInfo = subscribeInfoFromJson(jsonString);

import 'dart:convert';

SubscribeInfo subscribeInfoFromJson(String str) =>
    SubscribeInfo.fromJson(json.decode(str));

String subscribeInfoToJson(SubscribeInfo data) => json.encode(data.toJson());

class SubscribeInfo {
  SubscribeInfo({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
    required this.packageData,
    required this.isSubscribe,
  });

  String responseCode;
  String result;
  String responseMsg;
  List<PackageDatum> packageData;
  int isSubscribe;

  factory SubscribeInfo.fromJson(Map<String, dynamic> json) => SubscribeInfo(
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
        packageData: List<PackageDatum>.from(
            json["PackageData"].map((x) => PackageDatum.fromJson(x))),
        isSubscribe: json["is_subscribe"],
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
        "PackageData": List<dynamic>.from(packageData.map((x) => x.toJson())),
        "is_subscribe": isSubscribe,
      };
}

class PackageDatum {
  PackageDatum({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.status,
    required this.day,
    required this.price,
  });

  String id;
  String title;
  String image;
  String description;
  String status;
  String day;
  String price;

  factory PackageDatum.fromJson(Map<String, dynamic> json) => PackageDatum(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        description: json["description"],
        status: json["status"],
        day: json["day"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "description": description,
        "status": status,
        "day": day,
        "price": price,
      };
}
