// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_is_empty, unnecessary_brace_in_string_interps, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goproperti/Api/config.dart';
import 'package:goproperti/controller/homepage_controller.dart';
import 'package:goproperti/controller/search_controller.dart';
import 'package:goproperti/model/fontfamily_model.dart';
import 'package:goproperti/model/routes_helper.dart';
import 'package:goproperti/screen/home_screen.dart';
import 'package:goproperti/utils/Colors.dart';
import 'package:goproperti/utils/Dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/data_store.dart';

class HomeSearchScreen extends StatefulWidget {
  const HomeSearchScreen({super.key});

  @override
  State<HomeSearchScreen> createState() => _HomeSearchScreenState();
}

class _HomeSearchScreenState extends State<HomeSearchScreen> {
  SearchPropertyController searchController = Get.find();
  HomePageController homePageController = Get.find();
  late ColorNotifire notifire;
  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }

  @override
  void initState() {
    super.initState();
    searchController.searchText = "";
    searchController.search.text = "";
    searchController.searchData = [];
    searchController.getSearchData(countryId: getData.read("countryId"));
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getfevAndSearch,
      body: GetBuilder<SearchPropertyController>(builder: (context) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      searchController.search.text = "";
                      searchController.searchData = [];
                      Get.back();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_back,
                        color: notifire.getwhiteblackcolor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: Get.size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7, right: 8),
                        child: TextField(
                          controller: searchController.search,
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            searchController.getSearchData(
                                countryId: getData.read("countryId"));
                          },
                          onChanged: (value) {
                            searchController.changeValueUpdate(value);
                            if (value == "") {
                              setState(() {
                                searchController.searchData = [];
                              });
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search...".tr,
                            hintStyle: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              color: notifire.getlightblack,
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Image.asset(
                                "assets/images/SearchHomescreen.png",
                                height: 10,
                                width: 10,
                                fit: BoxFit.cover,
                                color: notifire.getlightblack,
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/Filter.png",
                                height: 10,
                                width: 10,
                                fit: BoxFit.cover,
                                color: notifire.getlightblack,
                              ),
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: notifire.getblackwhitecolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: searchController.searchText != ""
                    ? Text(
                        "${searchController.searchData.length} founds",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: FontFamily.gilroyBold,
                          color: notifire.getwhiteblackcolor,
                        ),
                      )
                    : SizedBox(),
              ),
              searchController.searchText != ""
                  ? searchController.isLoading
                      ? searchController.searchData.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: searchController.searchData.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      setState(() {
                                        homePageController.rate =
                                            searchController
                                                .searchData[index].rate;
                                      });
                                      homePageController
                                          .chnageObjectIndex(index);
                                      await homePageController
                                          .getPropertyDetailsApi(
                                              id: searchController
                                                  .searchData[index].id);
                                      Get.toNamed(
                                        Routes.viewDataScreen,
                                      );
                                    },
                                    child: Container(
                                      height: 140,
                                      margin: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height: 140,
                                                width: 130,
                                                margin: EdgeInsets.all(10),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child:
                                                      FadeInImage.assetNetwork(
                                                    fadeInCurve:
                                                        Curves.easeInCirc,
                                                    placeholder:
                                                        "assets/images/ezgif.com-crop.gif",
                                                    height: 140,
                                                    image:
                                                        "${Config.imageUrl}${searchController.searchData[index].image}",
                                                    fit: BoxFit.cover,
                                                  ),
                                                  // child: Image.network(
                                                  //   "${Config.imageUrl}${searchController.searchData[index].image}",
                                                  //   fit: BoxFit.cover,
                                                  // ),
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                              searchController.searchData[index]
                                                          .buyorrent ==
                                                      "1"
                                                  ? Positioned(
                                                      top: 15,
                                                      right: 20,
                                                      child: Container(
                                                        height: 30,
                                                        width: 45,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              margin: const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 3, 0),
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/Rating.png",
                                                                height: 12,
                                                                width: 12,
                                                              ),
                                                            ),
                                                            Text(
                                                              searchController
                                                                  .searchData[
                                                                      index]
                                                                  .rate,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .gilroyMedium,
                                                                color:
                                                                    blueColor,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFedeeef),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                      ),
                                                    )
                                                  : Positioned(
                                                      top: 15,
                                                      right: 20,
                                                      child: Container(
                                                        height: 30,
                                                        width: 60,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "BUY".tr,
                                                          style: TextStyle(
                                                              color: blueColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFedeeef),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 30),
                                                        child: Text(
                                                          searchController
                                                              .searchData[index]
                                                              .title,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontFamily:
                                                                FontFamily
                                                                    .gilroyBold,
                                                            color: notifire
                                                                .getwhiteblackcolor,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        searchController
                                                            .searchData[index]
                                                            .city,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: notifire
                                                              .getgreycolor,
                                                          fontFamily: FontFamily
                                                              .gilroyMedium,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "${currency}${searchController.searchData[index].price}",
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .gilroyBold,
                                                              color: blueColor,
                                                            ),
                                                          ),
                                                          searchController
                                                                      .searchData[
                                                                          index]
                                                                      .buyorrent ==
                                                                  "1"
                                                              ? Text(
                                                                  "/night".tr,
                                                                  style:
                                                                      TextStyle(
                                                                    color: notifire
                                                                        .getgreycolor,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .gilroyMedium,
                                                                  ),
                                                                )
                                                              : SizedBox(),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        color: notifire.getblackwhitecolor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 5),
                              child: Column(
                                children: [
                                  SizedBox(height: Get.height * 0.10),
                                  Image(
                                    image: AssetImage(
                                        "assets/images/searchDataEmpty.png"),
                                    height: 110,
                                    width: 110,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: Get.width * 0.80,
                                      child: Text(
                                        "Sorry, Search Data Not Found".tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: notifire.getgreycolor,
                                          fontFamily: FontFamily.gilroyBold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                      : SizedBox()
                  : showFeaturedList(),
            ],
          ),
        );
      }),
    );
  }

  Widget showFeaturedList() {
    return Expanded(
      child: homePageController
              .homeDatatInfo!.homeData.featuredProperty.isNotEmpty
          ? ListView.builder(
              itemCount: homePageController
                  .homeDatatInfo?.homeData.featuredProperty.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    setState(() {
                      homePageController.rate = homePageController.homeDatatInfo
                              ?.homeData.featuredProperty[index].rate ??
                          "";
                    });
                    homePageController.chnageObjectIndex(index);
                    await homePageController.getPropertyDetailsApi(
                        id: homePageController.homeDatatInfo?.homeData
                            .featuredProperty[index].id);
                    Get.toNamed(Routes.viewDataScreen);
                  },
                  child: Container(
                    height: 140,
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 140,
                              width: 130,
                              margin: EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: FadeInImage.assetNetwork(
                                  fadeInCurve: Curves.easeInCirc,
                                  placeholder:
                                      "assets/images/ezgif.com-crop.gif",
                                  height: 140,
                                  image:
                                      "${Config.imageUrl}${homePageController.homeDatatInfo?.homeData.featuredProperty[index].image ?? ""}",
                                  fit: BoxFit.cover,
                                ),
                                // child: Image.network(
                                //   "${Config.imageUrl}${homePageController.homeDatatInfo?.homeData.featuredProperty[index].image ?? ""}",
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            homePageController.homeDatatInfo?.homeData
                                        .featuredProperty[index].buyorrent ==
                                    "1"
                                ? Positioned(
                                    top: 15,
                                    right: 20,
                                    child: Container(
                                      height: 30,
                                      width: 45,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 3, 0),
                                            child: Image.asset(
                                              "assets/images/Rating.png",
                                              height: 12,
                                              width: 12,
                                            ),
                                          ),
                                          Text(
                                            homePageController
                                                    .homeDatatInfo
                                                    ?.homeData
                                                    .featuredProperty[index]
                                                    .rate ??
                                                "",
                                            style: TextStyle(
                                              fontFamily:
                                                  FontFamily.gilroyMedium,
                                              color: blueColor,
                                            ),
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFedeeef),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    top: 15,
                                    right: 20,
                                    child: Container(
                                      height: 30,
                                      width: 60,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "BUY".tr,
                                        style: TextStyle(
                                            color: blueColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFedeeef),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Text(
                                        homePageController
                                                .homeDatatInfo
                                                ?.homeData
                                                .featuredProperty[index]
                                                .title ??
                                            "",
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: FontFamily.gilroyBold,
                                          color: notifire.getwhiteblackcolor,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     if (getData.read("UserLogin") != null) {
                                  //       homePageController.addFavouriteList(
                                  //         pid: homePageController.homeDatatInfo
                                  //             ?.homeData.featuredProperty[index].id,
                                  //         propertyType: homePageController
                                  //             .homeDatatInfo
                                  //             ?.homeData
                                  //             .featuredProperty[index]
                                  //             .propertyType,
                                  //       );
                                  //     }
                                  //   },
                                  //   child: homePageController
                                  //               .homeDatatInfo
                                  //               ?.homeData
                                  //               .featuredProperty[index]
                                  //               .isFavourite ==
                                  //           1
                                  //       ? Padding(
                                  //           padding: const EdgeInsets.only(
                                  //               top: 10, right: 15),
                                  //           child: Image.asset(
                                  //             "assets/images/Fev-Bold.png",
                                  //             color: blueColor,
                                  //             height: 20,
                                  //             width: 20,
                                  //           ),
                                  //         )
                                  //       : Padding(
                                  //           padding: const EdgeInsets.only(
                                  //               top: 10, right: 15),
                                  //           child: Image.asset(
                                  //             "assets/images/favorite.png",
                                  //             color: blueColor,
                                  //             height: 20,
                                  //             width: 20,
                                  //           ),
                                  //         ),
                                  // ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      homePageController.homeDatatInfo?.homeData
                                              .featuredProperty[index].city ??
                                          "",
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: notifire.getgreycolor,
                                        fontFamily: FontFamily.gilroyMedium,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "${currency}${homePageController.homeDatatInfo?.homeData.featuredProperty[index].price ?? ""}",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: FontFamily.gilroyBold,
                                          color: blueColor,
                                        ),
                                      ),
                                      Text(
                                        "/night".tr,
                                        style: TextStyle(
                                          color: notifire.getgreycolor,
                                          fontFamily: FontFamily.gilroyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: notifire.getblackwhitecolor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                );
              },
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              child: Column(
                children: [
                  SizedBox(height: Get.height * 0.10),
                  Image(
                    image: AssetImage(
                      "assets/images/searchDataEmpty.png",
                    ),
                    height: 110,
                    width: 110,
                  ),
                  Center(
                    child: SizedBox(
                      width: Get.width * 0.80,
                      child: Text(
                        "Sorry, there is no any nearby \n category or data not found"
                            .tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: notifire.getgreycolor,
                          fontFamily: FontFamily.gilroyBold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
