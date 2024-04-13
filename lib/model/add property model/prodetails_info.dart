// To parse this JSON data, do
//
//     final proDetailsInfo = proDetailsInfoFromJson(jsonString);

import 'dart:convert';

ProDetailsInfo proDetailsInfoFromJson(String str) =>
    ProDetailsInfo.fromJson(json.decode(str));

String proDetailsInfoToJson(ProDetailsInfo data) => json.encode(data.toJson());

class ProDetailsInfo {
  ProDetailsInfo({
    required this.bookdetails,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  Bookdetails bookdetails;
  String responseCode;
  String result;
  String responseMsg;

  factory ProDetailsInfo.fromJson(Map<String, dynamic> json) => ProDetailsInfo(
        bookdetails: Bookdetails.fromJson(json["bookdetails"]),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "bookdetails": bookdetails.toJson(),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Bookdetails {
  Bookdetails({
    required this.bookId,
    required this.propId,
    required this.uid,
    required this.bookDate,
    required this.checkIn,
    required this.checkOut,
    required this.paymentTitle,
    required this.subtotal,
    required this.total,
    required this.tax,
    required this.couAmt,
    required this.noguest,
    required this.wallAmt,
    required this.transactionId,
    required this.pMethodId,
    required this.addNote,
    required this.bookStatus,
    required this.checkIntime,
    required this.checkOuttime,
    required this.bookFor,
    required this.isRate,
    required this.totalRate,
    required this.rateText,
    required this.propPrice,
    required this.totalDay,
    required this.cancleReason,
    required this.customerName,
    required this.customerMobile,
  });

  String bookId;
  String propId;
  String uid;
  DateTime bookDate;
  DateTime checkIn;
  DateTime checkOut;
  String paymentTitle;
  String subtotal;
  String total;
  String tax;
  String couAmt;
  String noguest;
  String wallAmt;
  String transactionId;
  String pMethodId;
  String addNote;
  String bookStatus;
  String checkIntime;
  String checkOuttime;
  String bookFor;
  String isRate;
  String totalRate;
  String rateText;
  String propPrice;
  String totalDay;
  String cancleReason;
  String customerName;
  String customerMobile;

  factory Bookdetails.fromJson(Map<String, dynamic> json) => Bookdetails(
        bookId: json["book_id"],
        propId: json["prop_id"],
        uid: json["uid"],
        bookDate: DateTime.parse(json["book_date"]),
        checkIn: DateTime.parse(json["check_in"]),
        checkOut: DateTime.parse(json["check_out"]),
        paymentTitle: json["payment_title"],
        subtotal: json["subtotal"],
        total: json["total"],
        tax: json["tax"],
        couAmt: json["cou_amt"],
        noguest: json["noguest"],
        wallAmt: json["wall_amt"],
        transactionId: json["transaction_id"],
        pMethodId: json["p_method_id"],
        addNote: json["add_note"],
        bookStatus: json["book_status"],
        checkIntime: json["check_intime"],
        checkOuttime: json["check_outtime"],
        bookFor: json["book_for"],
        isRate: json["is_rate"],
        totalRate: json["total_rate"],
        rateText: json["rate_text"],
        propPrice: json["prop_price"],
        totalDay: json["total_day"],
        cancleReason: json["cancle_reason"],
        customerName: json["customer_name"],
        customerMobile: json["customer_mobile"],
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "prop_id": propId,
        "uid": uid,
        "book_date":
            "${bookDate.year.toString().padLeft(4, '0')}-${bookDate.month.toString().padLeft(2, '0')}-${bookDate.day.toString().padLeft(2, '0')}",
        "check_in":
            "${checkIn.year.toString().padLeft(4, '0')}-${checkIn.month.toString().padLeft(2, '0')}-${checkIn.day.toString().padLeft(2, '0')}",
        "check_out":
            "${checkOut.year.toString().padLeft(4, '0')}-${checkOut.month.toString().padLeft(2, '0')}-${checkOut.day.toString().padLeft(2, '0')}",
        "payment_title": paymentTitle,
        "subtotal": subtotal,
        "total": total,
        "tax": tax,
        "cou_amt": couAmt,
        "noguest": noguest,
        "wall_amt": wallAmt,
        "transaction_id": transactionId,
        "p_method_id": pMethodId,
        "add_note": addNote,
        "book_status": bookStatus,
        "check_intime": checkIntime,
        "check_outtime": checkOuttime,
        "book_for": bookFor,
        "is_rate": isRate,
        "total_rate": totalRate,
        "rate_text": rateText,
        "prop_price": propPrice,
        "total_day": totalDay,
        "cancle_reason": cancleReason,
        "customer_name": customerName,
        "customer_mobile": customerMobile,
      };
}
