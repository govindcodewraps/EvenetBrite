// To parse this JSON data, do
//
//     final proTypeInfo = proTypeInfoFromJson(jsonString);

import 'dart:convert';

ProTypeInfo proTypeInfoFromJson(String str) =>
    ProTypeInfo.fromJson(json.decode(str));

String proTypeInfoToJson(ProTypeInfo data) => json.encode(data.toJson());

class ProTypeInfo {
  ProTypeInfo({
    required this.typelist,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  List<Typelist> typelist;
  String responseCode;
  String result;
  String responseMsg;

  factory ProTypeInfo.fromJson(Map<String, dynamic> json) => ProTypeInfo(
        typelist: List<Typelist>.from(
            json["typelist"].map((x) => Typelist.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "typelist": List<dynamic>.from(typelist.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Typelist {
  Typelist({
    required this.id,
    required this.title,
  });

  String id;
  String title;

  factory Typelist.fromJson(Map<String, dynamic> json) => Typelist(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
