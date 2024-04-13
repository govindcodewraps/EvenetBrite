// To parse this JSON data, do
//
//     final countryInfo = countryInfoFromJson(jsonString);

import 'dart:convert';

CountryInfo countryInfoFromJson(String str) =>
    CountryInfo.fromJson(json.decode(str));

String countryInfoToJson(CountryInfo data) => json.encode(data.toJson());

class CountryInfo {
  CountryInfo({
    required this.countryData,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  List<CountryDatum> countryData;
  String responseCode;
  String result;
  String responseMsg;

  factory CountryInfo.fromJson(Map<String, dynamic> json) => CountryInfo(
        countryData: List<CountryDatum>.from(
            json["CountryData"].map((x) => CountryDatum.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "CountryData": List<dynamic>.from(countryData.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class CountryDatum {
  CountryDatum({
    required this.id,
    required this.title,
    required this.img,
    required this.status,
  });

  String id;
  String title;
  String img;
  String status;

  factory CountryDatum.fromJson(Map<String, dynamic> json) => CountryDatum(
        id: json["id"],
        title: json["title"],
        img: json["img"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "img": img,
        "status": status,
      };
}
