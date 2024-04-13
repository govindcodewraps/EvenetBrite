// ignore_for_file: unnecessary_brace_in_string_interps, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goproperti/Api/config.dart';
import 'package:goproperti/controller/homepage_controller.dart';
import 'package:goproperti/model/fontfamily_model.dart';
import 'package:goproperti/model/routes_helper.dart';
import 'package:goproperti/screen/home_screen.dart';
import 'package:goproperti/utils/Colors.dart';
import 'package:goproperti/utils/Dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({super.key});

  @override
  State<FeaturedScreen> createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
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
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getfevAndSearch,
      appBar: AppBar(
        backgroundColor: notifire.getbgcolor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: notifire.getwhiteblackcolor,
          ),
        ),
        title: Text(
          "Featured".tr,
          style: TextStyle(
            fontSize: 17,
            fontFamily: FontFamily.gilroyBold,
            color: notifire.getwhiteblackcolor,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: homePageController
                    .homeDatatInfo!.homeData.featuredProperty.isNotEmpty
                ? ListView.builder(
                    itemCount: homePageController
                        .homeDatatInfo?.homeData.featuredProperty.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          setState(() {
                            homePageController.rate = homePageController
                                    .homeDatatInfo
                                    ?.homeData
                                    .featuredProperty[index]
                                    .rate ??
                                "";
                          });
                          homePageController.chnageObjectIndex(index);
                          await homePageController.getPropertyDetailsApi(
                              id: homePageController.homeDatatInfo?.homeData
                                  .featuredProperty[index].id);
                          Get.toNamed(
                            Routes.viewDataScreen,
                            // arguments: {
                            //   "price": homePageController.homeDatatInfo?.homeData
                            //       .featuredProperty[index].price,
                            // },
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
                                  homePageController
                                              .homeDatatInfo
                                              ?.homeData
                                              .featuredProperty[index]
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
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
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
                                                          .featuredProperty[
                                                              index]
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
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        )
                                      : Positioned(
                                          top: 15,
                                          right: 20,
                                          child: Container(
                                            height: 20,
                                            width: 45,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "BUY".tr,
                                              style: TextStyle(
                                                  color: blueColor,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFedeeef),
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                                            padding:
                                                const EdgeInsets.only(top: 30),
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
                                                fontFamily:
                                                    FontFamily.gilroyBold,
                                                color:
                                                    notifire.getwhiteblackcolor,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // InkWell(
                                        //   onTap: () {},
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
                                        // SizedBox(
                                        //   width: 20,
                                        // ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            homePageController
                                                    .homeDatatInfo
                                                    ?.homeData
                                                    .featuredProperty[index]
                                                    .city ??
                                                "",
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: notifire.getgreycolor,
                                              fontFamily:
                                                  FontFamily.gilroyMedium,
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
                                                fontFamily:
                                                    FontFamily.gilroyBold,
                                                color: blueColor,
                                              ),
                                            ),
                                            homePageController
                                                        .homeDatatInfo
                                                        ?.homeData
                                                        .featuredProperty[index]
                                                        .buyorrent ==
                                                    "1"
                                                ? Text(
                                                    "/night".tr,
                                                    style: TextStyle(
                                                      color:
                                                          notifire.getgreycolor,
                                                      fontFamily: FontFamily
                                                          .gilroyMedium,
                                                    ),
                                                  )
                                                : Text(""),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
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
          ),
        ],
      ),
    );
  }
}
