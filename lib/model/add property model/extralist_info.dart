// To parse this JSON data, do
//
//     final extraListInfo = extraListInfoFromJson(jsonString);

import 'dart:convert';

ExtraListInfo extraListInfoFromJson(String str) =>
    ExtraListInfo.fromJson(json.decode(str));

String extraListInfoToJson(ExtraListInfo data) => json.encode(data.toJson());

class ExtraListInfo {
  ExtraListInfo({
    required this.extralist,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  List<Extralist> extralist;
  String responseCode;
  String result;
  String responseMsg;

  factory ExtraListInfo.fromJson(Map<String, dynamic> json) => ExtraListInfo(
        extralist: List<Extralist>.from(
            json["extralist"].map((x) => Extralist.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "extralist": List<dynamic>.from(extralist.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Extralist {
  Extralist({
    required this.id,
    required this.propertyTitle,
    required this.propertyId,
    required this.image,
    required this.status,
  });

  String id;
  String propertyTitle;
  String propertyId;
  String image;
  String status;

  factory Extralist.fromJson(Map<String, dynamic> json) => Extralist(
        id: json["id"],
        propertyTitle: json["property_title"],
        propertyId: json["property_id"],
        image: json["image"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "property_title": propertyTitle,
        "property_id": propertyId,
        "image": image,
        "status": status,
      };
}
