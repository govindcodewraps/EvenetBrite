// To parse this JSON data, do
//
//     final enquiryInfo = enquiryInfoFromJson(jsonString);

import 'dart:convert';

EnquiryInfo enquiryInfoFromJson(String str) =>
    EnquiryInfo.fromJson(json.decode(str));

String enquiryInfoToJson(EnquiryInfo data) => json.encode(data.toJson());

class EnquiryInfo {
  EnquiryInfo({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
    required this.enquiryData,
  });

  String responseCode;
  String result;
  String responseMsg;
  List<EnquiryDatum> enquiryData;

  factory EnquiryInfo.fromJson(Map<String, dynamic> json) => EnquiryInfo(
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
        enquiryData: List<EnquiryDatum>.from(
            json["EnquiryData"].map((x) => EnquiryDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
        "EnquiryData": List<dynamic>.from(enquiryData.map((x) => x.toJson())),
      };
}

class EnquiryDatum {
  EnquiryDatum({
    required this.title,
    required this.image,
    required this.name,
    required this.mobile,
    required this.isSell,
  });

  String title;
  String image;
  String name;
  String mobile;
  String isSell;

  factory EnquiryDatum.fromJson(Map<String, dynamic> json) => EnquiryDatum(
        title: json["title"],
        image: json["image"],
        name: json["name"],
        mobile: json["mobile"],
        isSell: json["is_sell"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "name": name,
        "mobile": mobile,
        "is_sell": isSell,
      };
}
