// To parse this JSON data, do
//
//     final galleryInfo = galleryInfoFromJson(jsonString);

import 'dart:convert';

GalleryInfo galleryInfoFromJson(String str) =>
    GalleryInfo.fromJson(json.decode(str));

String galleryInfoToJson(GalleryInfo data) => json.encode(data.toJson());

class GalleryInfo {
  GalleryInfo({
    required this.gallerydata,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  List<Gallerydatum> gallerydata;
  String responseCode;
  String result;
  String responseMsg;

  factory GalleryInfo.fromJson(Map<String, dynamic> json) => GalleryInfo(
        gallerydata: List<Gallerydatum>.from(
            json["gallerydata"].map((x) => Gallerydatum.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "gallerydata": List<dynamic>.from(gallerydata.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Gallerydatum {
  Gallerydatum({
    required this.title,
    required this.imglist,
  });

  String title;
  List<String> imglist;

  factory Gallerydatum.fromJson(Map<String, dynamic> json) => Gallerydatum(
        title: json["title"],
        imglist: List<String>.from(json["imglist"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "imglist": List<dynamic>.from(imglist.map((x) => x)),
      };
}
