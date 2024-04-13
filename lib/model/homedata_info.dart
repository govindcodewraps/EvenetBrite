// To parse this JSON data, do
//
//     final homeDatatInfo = homeDatatInfoFromJson(jsonString);

import 'dart:convert';

HomeDatatInfo homeDatatInfoFromJson(String str) =>
    HomeDatatInfo.fromJson(json.decode(str));

String homeDatatInfoToJson(HomeDatatInfo data) => json.encode(data.toJson());

class HomeDatatInfo {
  HomeDatatInfo({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
    required this.homeData,
  });

  String responseCode;
  String result;
  String responseMsg;
  HomeData homeData;

  factory HomeDatatInfo.fromJson(Map<String, dynamic> json) => HomeDatatInfo(
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
        homeData: HomeData.fromJson(json["HomeData"]),
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
        "HomeData": homeData.toJson(),
      };
}

class HomeData {
  HomeData({
    required this.catlist,
    required this.currency,
    required this.wallet,
    required this.featuredProperty,
    required this.cateWiseProperty,
  });

  List<Catlist> catlist;
  String currency;
  String wallet;
  List<Property> featuredProperty;
  List<Property> cateWiseProperty;

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        catlist:
            List<Catlist>.from(json["Catlist"].map((x) => Catlist.fromJson(x))),
        currency: json["currency"],
        wallet: json["wallet"],
        featuredProperty: List<Property>.from(
            json["Featured_Property"].map((x) => Property.fromJson(x))),
        cateWiseProperty: List<Property>.from(
            json["cate_wise_property"].map((x) => Property.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Catlist": List<dynamic>.from(catlist.map((x) => x.toJson())),
        "currency": currency,
        "wallet": wallet,
        "Featured_Property":
            List<dynamic>.from(featuredProperty.map((x) => x.toJson())),
        "cate_wise_property":
            List<dynamic>.from(cateWiseProperty.map((x) => x.toJson())),
      };
}

class Property {
  String id;
  String title;
  String buyorrent;
  String? latitude;
  String? longtitude;
  String plimit;
  String rate;
  String city;
  String propertyType;
  String image;
  String price;
  int isFavourite;

  Property({
    required this.id,
    required this.title,
    required this.buyorrent,
    this.latitude,
    this.longtitude,
    required this.plimit,
    required this.rate,
    required this.city,
    required this.propertyType,
    required this.image,
    required this.price,
    required this.isFavourite,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["id"],
        title: json["title"],
        buyorrent: json["buyorrent"],
        latitude: json["latitude"],
        longtitude: json["longtitude"],
        plimit: json["plimit"],
        rate: json["rate"],
        city: json["city"],
        propertyType: json["property_type"],
        image: json["image"],
        price: json["price"],
        isFavourite: json["IS_FAVOURITE"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "buyorrent": buyorrent,
        "latitude": latitude,
        "longtitude": longtitude,
        "plimit": plimit,
        "rate": rate,
        "city": city,
        "property_type": propertyType,
        "image": image,
        "price": price,
        "IS_FAVOURITE": isFavourite,
      };
}

class Catlist {
  Catlist({
    required this.id,
    required this.title,
    required this.img,
    required this.status,
  });

  String id;
  String title;
  String img;
  String status;

  factory Catlist.fromJson(Map<String, dynamic> json) => Catlist(
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
