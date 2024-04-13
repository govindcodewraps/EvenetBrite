// To parse this JSON data, do
//
//     final faqListInfo = faqListInfoFromJson(jsonString);

import 'dart:convert';

FaqListInfo faqListInfoFromJson(String str) =>
    FaqListInfo.fromJson(json.decode(str));

String faqListInfoToJson(FaqListInfo data) => json.encode(data.toJson());

class FaqListInfo {
  FaqListInfo({
    required this.faqData,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  List<FaqDatum> faqData;
  String responseCode;
  String result;
  String responseMsg;

  factory FaqListInfo.fromJson(Map<String, dynamic> json) => FaqListInfo(
        faqData: List<FaqDatum>.from(
            json["FaqData"].map((x) => FaqDatum.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "FaqData": List<dynamic>.from(faqData.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class FaqDatum {
  FaqDatum({
    required this.id,
    required this.question,
    required this.answer,
    required this.status,
  });

  String id;
  String question;
  String answer;
  String status;

  factory FaqDatum.fromJson(Map<String, dynamic> json) => FaqDatum(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
        "status": status,
      };
}
