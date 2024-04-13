// To parse this JSON data, do
//
//     final subDetailsInfo = subDetailsInfoFromJson(jsonString);

import 'dart:convert';

SubDetailsInfo subDetailsInfoFromJson(String str) =>
    SubDetailsInfo.fromJson(json.decode(str));

String subDetailsInfoToJson(SubDetailsInfo data) => json.encode(data.toJson());

class SubDetailsInfo {
  SubDetailsInfo({
    required this.subscribedetails,
    required this.isSubscribe,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  List<Subscribedetail> subscribedetails;
  int isSubscribe;
  String responseCode;
  String result;
  String responseMsg;

  factory SubDetailsInfo.fromJson(Map<String, dynamic> json) => SubDetailsInfo(
        subscribedetails: List<Subscribedetail>.from(
            json["Subscribedetails"].map((x) => Subscribedetail.fromJson(x))),
        isSubscribe: json["is_subscribe"],
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "Subscribedetails":
            List<dynamic>.from(subscribedetails.map((x) => x.toJson())),
        "is_subscribe": isSubscribe,
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Subscribedetail {
  Subscribedetail({
    required this.id,
    required this.uid,
    required this.planId,
    required this.pName,
    required this.tDate,
    required this.amount,
    required this.day,
    required this.planTitle,
    required this.planDescription,
    required this.expireDate,
    required this.startDate,
    required this.transId,
    required this.planImage,
  });

  String id;
  String uid;
  String planId;
  String pName;
  DateTime tDate;
  String amount;
  String day;
  String planTitle;
  String planDescription;
  DateTime expireDate;
  DateTime startDate;
  String transId;
  String planImage;

  factory Subscribedetail.fromJson(Map<String, dynamic> json) =>
      Subscribedetail(
        id: json["id"],
        uid: json["uid"],
        planId: json["plan_id"],
        pName: json["p_name"],
        tDate: DateTime.parse(json["t_date"]),
        amount: json["amount"],
        day: json["day"],
        planTitle: json["plan_title"],
        planDescription: json["plan_description"],
        expireDate: DateTime.parse(json["expire_date"]),
        startDate: DateTime.parse(json["start_date"]),
        transId: json["trans_id"],
        planImage: json["plan_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "plan_id": planId,
        "p_name": pName,
        "t_date": tDate.toIso8601String(),
        "amount": amount,
        "day": day,
        "plan_title": planTitle,
        "plan_description": planDescription,
        "expire_date":
            "${expireDate.year.toString().padLeft(4, '0')}-${expireDate.month.toString().padLeft(2, '0')}-${expireDate.day.toString().padLeft(2, '0')}",
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "trans_id": transId,
        "plan_image": planImage,
      };
}
