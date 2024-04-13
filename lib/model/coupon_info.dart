// To parse this JSON data, do
//
//     final couponListInfo = couponListInfoFromJson(jsonString);

import 'dart:convert';

CouponListInfo couponListInfoFromJson(String str) =>
    CouponListInfo.fromJson(json.decode(str));

String couponListInfoToJson(CouponListInfo data) => json.encode(data.toJson());

class CouponListInfo {
  CouponListInfo({
    required this.couponlist,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  List<Couponlist> couponlist;
  String responseCode;
  String result;
  String responseMsg;

  factory CouponListInfo.fromJson(Map<String, dynamic> json) => CouponListInfo(
        couponlist: List<Couponlist>.from(
            json["couponlist"].map((x) => Couponlist.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "couponlist": List<dynamic>.from(couponlist.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Couponlist {
  Couponlist({
    required this.id,
    required this.cImg,
    required this.cdate,
    required this.cDesc,
    required this.cValue,
    required this.couponCode,
    required this.couponTitle,
    required this.minAmt,
  });

  String id;
  String cImg;
  DateTime cdate;
  String cDesc;
  String cValue;
  String couponCode;
  String couponTitle;
  String minAmt;

  factory Couponlist.fromJson(Map<String, dynamic> json) => Couponlist(
        id: json["id"],
        cImg: json["c_img"],
        cdate: DateTime.parse(json["cdate"]),
        cDesc: json["c_desc"],
        cValue: json["c_value"],
        couponCode: json["coupon_code"],
        couponTitle: json["coupon_title"],
        minAmt: json["min_amt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "c_img": cImg,
        "cdate":
            "${cdate.year.toString().padLeft(4, '0')}-${cdate.month.toString().padLeft(2, '0')}-${cdate.day.toString().padLeft(2, '0')}",
        "c_desc": cDesc,
        "c_value": cValue,
        "coupon_code": couponCode,
        "coupon_title": couponTitle,
        "min_amt": minAmt,
      };
}
