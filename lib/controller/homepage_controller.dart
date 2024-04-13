// ignore_for_file: avoid_print, unused_local_variable, prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables, prefer_if_null_operators, prefer_const_constructors

import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goproperti/Api/config.dart';
import 'package:goproperti/Api/data_store.dart';
import 'package:goproperti/model/catwise_info.dart';
import 'package:goproperti/model/favourite_info.dart';
import 'package:goproperti/model/homedata_info.dart';
import 'package:goproperti/model/map_info.dart';
import 'package:goproperti/model/propetydetails_Info.dart';
// import 'package:goproperti/model/routes_helper.dart';
import 'package:goproperti/utils/Custom_widget.dart';
import 'package:http/http.dart' as http;

import '../screen/home_screen.dart';

class HomePageController extends GetxController implements GetxService {
  HomeDatatInfo? homeDatatInfo;
  PropetydetailsInfo? propetydetailsInfo;
  FavouriteInfo? favouriteInfo;

  List<MapInfo> mapInfo = [];

  String searchLocation = "";

  String rate = "";

  CatWiseInfo? catWiseInfo;

  List<int> selectedIndex = [];

  int currentIndex = 0;
  int catCurrentIndex = 0;
  int ourCurrentIndex = 0;

  bool isLoading = false;
  bool isProperty = false;
  bool isfevorite = false;
  bool isCatWise = false;

  String fevResult = "";
  String fevMsg = "";
  String enquiry = "";

  PageController pageController = PageController();

  CameraPosition kGoogle = CameraPosition(
    target: LatLng(21.2381962, 72.8879607),
    zoom: 5,
  );

  List<Marker> markers = <Marker>[];

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  HomePageController() {
    getHomeDataApi();
    getCatWiseData();
  }

  chnageObjectIndex(int index) {
    currentIndex = 0;
    currentIndex = index;
    update();
  }

  changeCategoryIndex(int index) {
    catCurrentIndex = 0;
    catCurrentIndex = index;
    update();
  }

  changeOurCurrentIndex(int index) {
    ourCurrentIndex = index;
    update();
  }

  getChangeLocation(String location) {
    searchLocation = location;
    Get.back();
    // getHomeDataApi();
    update();
  }

  updateMapPosition({int? index}) {
    pageController.animateToPage(index ?? 0,
        duration: Duration(seconds: 1), curve: Curves.decelerate);
    update();
  }

  getHomeDataApi({String? countryId}) async {
    try {
      isLoading = false;
      Map map = {
        "uid": getData.read("UserLogin") == null
            ? "0"
            : "${getData.read("UserLogin")["id"]}",
        "country_id": countryId,
      };
      print("--------(Map)-------->>" + map.toString());
      Uri uri = Uri.parse(Config.path + Config.homeDataApi);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print(response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        print(response.body);
        print(">>>>>>>>>>>>>>>>>>>>");
        // mapInfo = [];
        // for (var element in result["HomeData"]["Featured_Property"]) {
        //   mapInfo.add(MapInfo.fromJson(element));
        // }

        homeDatatInfo = HomeDatatInfo.fromJson(result);
        var maplist = mapInfo.reversed.toList();
        currency = homeDatatInfo?.homeData.currency ?? "";
        update();

        // for (var element in result["HomeData"]["Featured_Property"]) {
        //   print(element["latitude"]);
        //   print(element["longtitude"]);
        //   final Uint8List markIcon =
        //       await getImages("assets/images/MapPin.png", 100);
        //   markers.add(
        //     Marker(
        //       markerId: MarkerId(element["id"].toString()),
        //       position: LatLng(
        //         double.parse(element["latitude"].toString()),
        //         double.parse(element["longtitude"].toString()),
        //       ),
        //       icon: BitmapDescriptor.fromBytes(markIcon),
        //       onTap: () {
        //         for (var i = 0;
        //             i < homeDatatInfo!.homeData.featuredProperty.length;
        //             i++) {
        //           pageController.animateToPage(i,
        //               duration: Duration(seconds: 1), curve: Curves.decelerate);
        //           update();
        //         }
        //       },
        //       infoWindow: InfoWindow(
        //         title: element["title"],
        //         snippet: element["city"],
        //         onTap: () async {
        //           await getPropertyDetailsApi(id: element["id"]);
        //           Get.toNamed(
        //             Routes.viewDataScreen,
        //           );
        //         },
        //       ),
        //     ),
        //   );
        //   kGoogle = CameraPosition(
        //     target: LatLng(
        //       double.parse(element["latitude"].toString()),
        //       double.parse(element["longtitude"].toString()),
        //     ),
        //     zoom: 8,
        //   );
        // }

        // for (var i = 0; i < mapInfo.length; i++) {
        //   final Uint8List markIcon =
        //       await getImages("assets/images/MapPin.png", 100);
        //   markers.add(
        //     Marker(
        //       markerId: MarkerId(i.toString()),
        //       position: LatLng(
        //         double.parse(mapInfo[i].latitude.toString()),
        //         double.parse(mapInfo[i].longtitude.toString()),
        //       ),
        //       icon: BitmapDescriptor.fromBytes(markIcon),
        //       onTap: () {
        //         pageController.animateToPage(i,
        //             duration: Duration(seconds: 1), curve: Curves.decelerate);
        //         update();
        //       },
        //       infoWindow: InfoWindow(
        //         title: mapInfo[i].title,
        //         snippet: mapInfo[i].city,
        //         onTap: () async {
        //           print("!!!!!!!!!!!!!!" + i.toString());
        //           print("!!!!!!!!!!!!!!" + mapInfo.length.toString());
        //           print("!!!!!!!!!!!!!!" + mapInfo[i].id.toString());
        //           print("---------(Title)-------->>" +
        //               mapInfo[i].title.toString());
        //           chnageObjectIndex(i);
        //           await getPropertyDetailsApi(id: mapInfo[i].id);
        //           Get.toNamed(
        //             Routes.viewDataScreen,
        //           );
        //         },
        //       ),
        //     ),
        //   );

        //   kGoogle = CameraPosition(
        //     target: LatLng(
        //       double.parse(mapInfo[i].latitude.toString()),
        //       double.parse(mapInfo[i].longtitude.toString()),
        //     ),
        //     zoom: 8,
        //   );
        // }
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }




  getPropertyDetailsApi({String? id}) async {
    try {
      isProperty = false;
      update();

      Map map = {
        "pro_id": id,
        "uid": getData.read("UserLogin") == null
            ? "0"
            : "${getData.read("UserLogin")["id"]}",
      };

      print("(Map)------------->>" + map.toString());

      //Uri uri = Uri.parse(Config.path + Config.propertyDetails);
      Uri uri = Uri.parse(Config.path + Config.propertyDetails);

      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print(".............................");
      print("DDDDDDDDDDDDDDDD" + response.body);
      print(".............................");

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        propetydetailsInfo = PropetydetailsInfo.fromJson(result);
      }

      isProperty = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  addFavouriteList({String? pid, String? propertyType}) async {
    try {
      Map map = {
        "uid": getData.read("UserLogin")["id"].toString(),
        "pid": pid,
        "property_type": propertyType,
      };

      Uri uri = Uri.parse(Config.path + Config.addAndRemoveFavourite);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        fevResult = result["Result"];
        fevMsg = result["ResponseMsg"];
        getPropertyDetailsApi(id: pid);
        getFavouriteList(countryId: getData.read("countryId"));
        showToastMessage(fevMsg);
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getFavouriteList({String? countryId}) async {
    try {
      Map map = {
        "uid": getData.read("UserLogin")["id"].toString(),
        "property_type": "0",
        "country_id": countryId,
      };
      print("AAAAAAAAAAAAAAA" + map.toString());
      Uri uri = Uri.parse(Config.path + Config.favouriteList);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print("-------==========" + response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        favouriteInfo = FavouriteInfo.fromJson(result);
      }
      isfevorite = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getCatWiseData({String? cId, String? countryId}) async {
    try {
      Map map = {
        "cid": cId ?? "0",
        "uid": getData.read("UserLogin") == null
            ? "0"
            : getData.read("UserLogin")["id"].toString(),
        "country_id": countryId,
      };

      Uri uri = Uri.parse(Config.path + Config.catWiseData);

      print("++++++ -------- +++++++ ------- ++++++${map}");
      print("++++++ -------- +++++++ ------- ++++++${uri}");

      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        catWiseInfo = CatWiseInfo.fromJson(result);
      }
      isCatWise = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  enquirySetApi({String? pId}) async {
    try {
      Map map = {
        "uid": getData.read("UserLogin")["id"].toString(),
        "prop_id": pId,
      };
      print(map.toString());
      Uri uri = Uri.parse(Config.path + Config.enquiry);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print("---------------" + response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print("+++++++++++++++" + result.toString());
        enquiry = result["Result"];
        // getPropertyDetailsApi(pId);
        showToastMessage(result["ResponseMsg"].toString());
        update();
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
