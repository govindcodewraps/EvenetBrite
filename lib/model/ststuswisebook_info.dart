// To parse this JSON data, do
//
//     final statusWiseBookInfo = statusWiseBookInfoFromJson(jsonString);

import 'dart:convert';

StatusWiseBookInfo statusWiseBookInfoFromJson(String str) =>
    StatusWiseBookInfo.fromJson(json.decode(str));

String statusWiseBookInfoToJson(StatusWiseBookInfo data) =>
    json.encode(data.toJson());

class StatusWiseBookInfo {
  StatusWiseBookInfo({
    required this.statuswise,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  List<Statuswise> statuswise;
  String responseCode;
  String result;
  String responseMsg;

  factory StatusWiseBookInfo.fromJson(Map<String, dynamic> json) =>
      StatusWiseBookInfo(
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
    required this.propPrice,
    required this.pMethodId,
    required this.totalDay,
    required this.totalRate,
    required this.bookStatus,
  });

  String bookId;
  String propId;
  String propImg;
  String propTitle;
  String propPrice;
  String pMethodId;
  String totalDay;
  String totalRate;
  String bookStatus;

  factory Statuswise.fromJson(Map<String, dynamic> json) => Statuswise(
        bookId: json["book_id"],
        propId: json["prop_id"],
        propImg: json["prop_img"],
        propTitle: json["prop_title"],
        propPrice: json["prop_price"],
        pMethodId: json["p_method_id"],
        totalDay: json["total_day"],
        totalRate: json["total_rate"],
        bookStatus: json["book_status"],
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "prop_id": propId,
        "prop_img": propImg,
        "prop_title": propTitle,
        "prop_price": propPrice,
        "p_method_id": pMethodId,
        "total_day": totalDay,
        "total_rate": totalRate,
        "book_status": bookStatus,
      };
}
