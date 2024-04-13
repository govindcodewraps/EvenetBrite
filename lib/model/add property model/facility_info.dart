// To parse this JSON data, do
//
//     final facilityInfo = facilityInfoFromJson(jsonString);

import 'dart:convert';

FacilityInfo facilityInfoFromJson(String str) =>
    FacilityInfo.fromJson(json.decode(str));

String facilityInfoToJson(FacilityInfo data) => json.encode(data.toJson());

class FacilityInfo {
  FacilityInfo({
    required this.facilitylist,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  List<Facilitylist> facilitylist;
  String responseCode;
  String result;
  String responseMsg;

  factory FacilityInfo.fromJson(Map<String, dynamic> json) => FacilityInfo(
        facilitylist: List<Facilitylist>.from(
            json["facilitylist"].map((x) => Facilitylist.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "facilitylist": List<dynamic>.from(facilitylist.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Facilitylist {
  Facilitylist({
    required this.id,
    required this.title,
    required this.img,
  });

  String id;
  String title;
  String img;

  factory Facilitylist.fromJson(Map<String, dynamic> json) => Facilitylist(
        id: json["id"],
        title: json["title"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "img": img,
      };
}
