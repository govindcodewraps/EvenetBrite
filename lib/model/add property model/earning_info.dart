// To parse this JSON data, do
//
//     final earningInfo = earningInfoFromJson(jsonString);

import 'dart:convert';

EarningInfo earningInfoFromJson(String str) =>
    EarningInfo.fromJson(json.decode(str));

String earningInfoToJson(EarningInfo data) => json.encode(data.toJson());

class EarningInfo {
  EarningInfo({
    required this.statuswise,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  List<Statuswise> statuswise;
  String responseCode;
  String result;
  String responseMsg;

  factory EarningInfo.fromJson(Map<String, dynamic> json) => EarningInfo(
        statuswise: List<Statuswise>.from(
            json["statuswise"].map((x) => Statuswise.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "statuswise": List<dynamic>.from(statuswise.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Statuswise {
  Statuswise({
    required this.bookId,
    required this.propId,
    required this.propImg,
    required this.propTitle,
    required this.pMethodId,
    required this.propPrice,
    required this.totalDay,
    this.rate,
    required this.bookStatus,
  });

  String bookId;
  String propId;
  String propImg;
  String propTitle;
  String pMethodId;
  String propPrice;
  String totalDay;
  dynamic rate;
  String bookStatus;

  factory Statuswise.fromJson(Map<String, dynamic> json) => Statuswise(
        bookId: json["book_id"],
        propId: json["prop_id"],
        propImg: json["prop_img"],
        propTitle: json["prop_title"],
        pMethodId: json["p_method_id"],
        propPrice: json["prop_price"],
        totalDay: json["total_day"],
        rate: json["rate"],
        bookStatus: json["book_status"],
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "prop_id": propId,
        "prop_img": propImg,
        "prop_title": propTitle,
        "p_method_id": pMethodId,
        "prop_price": propPrice,
        "total_day": totalDay,
        "rate": rate,
        "book_status": bookStatus,
      };
}
