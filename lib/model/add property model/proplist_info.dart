// To parse this JSON data, do
//
//     final propListInfo = propListInfoFromJson(jsonString);

import 'dart:convert';

PropListInfo propListInfoFromJson(String str) =>
    PropListInfo.fromJson(json.decode(str));

String propListInfoToJson(PropListInfo data) => json.encode(data.toJson());

class PropListInfo {
  PropListInfo({
    required this.proplist,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  List<Proplist> proplist;
  String responseCode;
  String result;
  String responseMsg;

  factory PropListInfo.fromJson(Map<String, dynamic> json) => PropListInfo(
        proplist: List<Proplist>.from(
            json["proplist"].map((x) => Proplist.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "proplist": List<dynamic>.from(proplist.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Proplist {
  Proplist({
    required this.id,
    required this.title,
    required this.propertyType,
    required this.propertyTypeId,
    required this.image,
    required this.countryId,
    required this.countryTitle,
    required this.price,
    required this.beds,
    required this.plimit,
    required this.bathroom,
    required this.sqrft,
    required this.isSell,
    required this.facilitySelect,
    required this.status,
    required this.latitude,
    required this.longtitude,
    required this.mobile,
    required this.buyorrent,
    required this.city,
    required this.rate,
    required this.description,
    required this.address,
  });

  String id;
  String title;
  String propertyType;
  String propertyTypeId;
  String image;
  String countryId;
  String countryTitle;
  String price;
  String beds;
  String plimit;
  String bathroom;
  String sqrft;
  String isSell;
  String facilitySelect;
  String status;
  String latitude;
  String longtitude;
  String mobile;
  String buyorrent;
  String city;
  String rate;
  String description;
  String address;

  factory Proplist.fromJson(Map<String, dynamic> json) => Proplist(
        id: json["id"],
        title: json["title"],
        propertyType: json["property_type"],
        propertyTypeId: json["property_type_id"],
        image: json["image"],
        countryId: json["country_id"],
        countryTitle: json["country_title"],
        price: json["price"],
        beds: json["beds"],
        plimit: json["plimit"],
        bathroom: json["bathroom"],
        sqrft: json["sqrft"],
        isSell: json["is_sell"],
        facilitySelect: json["facility_select"],
        status: json["status"],
        latitude: json["latitude"],
        longtitude: json["longtitude"],
        mobile: json["mobile"],
        buyorrent: json["buyorrent"],
        city: json["city"],
        rate: json["rate"],
        description: json["description"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "property_type": propertyType,
        "property_type_id": propertyTypeId,
        "image": image,
        "country_id": countryId,
        "country_title": countryTitle,
        "price": price,
        "beds": beds,
        "plimit": plimit,
        "bathroom": bathroom,
        "sqrft": sqrft,
        "is_sell": isSell,
        "facility_select": facilitySelect,
        "status": status,
        "latitude": latitude,
        "longtitude": longtitude,
        "mobile": mobile,
        "buyorrent": buyorrent,
        "city": city,
        "rate": rate,
        "description": description,
        "address": address,
      };
}
