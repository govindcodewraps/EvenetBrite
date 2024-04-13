// To parse this JSON data, do
//
//     final favouriteInfo = favouriteInfoFromJson(jsonString);

import 'dart:convert';

FavouriteInfo favouriteInfoFromJson(String str) =>
    FavouriteInfo.fromJson(json.decode(str));

String favouriteInfoToJson(FavouriteInfo data) => json.encode(data.toJson());

class FavouriteInfo {
  FavouriteInfo({
    required this.propetylist,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  List<Propetylist> propetylist;
  String responseCode;
  String result;
  String responseMsg;

  factory FavouriteInfo.fromJson(Map<String, dynamic> json) => FavouriteInfo(
        propetylist: List<Propetylist>.from(
            json["propetylist"].map((x) => Propetylist.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "propetylist": List<dynamic>.from(propetylist.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Propetylist {
  Propetylist({
    required this.id,
    required this.title,
    required this.rate,
    required this.city,
    required this.propertyType,
    required this.image,
    required this.price,
    required this.buyorrent,
    required this.isFavourite,
  });

  String id;
  String title;
  String rate;
  String city;
  String propertyType;
  String image;
  String price;
  String buyorrent;
  int isFavourite;

  factory Propetylist.fromJson(Map<String, dynamic> json) => Propetylist(
        id: json["id"],
        title: json["title"],
        rate: json["rate"],
        city: json["city"],
        propertyType: json["property_type"],
        image: json["image"],
        price: json["price"],
        buyorrent: json["buyorrent"],
        isFavourite: json["IS_FAVOURITE"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "rate": rate,
        "city": city,
        "property_type": propertyType,
        "image": image,
        "price": price,
        "buyorrent": buyorrent,
        "IS_FAVOURITE": isFavourite,
      };
}
