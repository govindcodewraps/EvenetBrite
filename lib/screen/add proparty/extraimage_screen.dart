// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goproperti/Api/config.dart';
import 'package:goproperti/controller/extraimage_controller.dart';
import 'package:goproperti/model/fontfamily_model.dart';
import 'package:goproperti/model/routes_helper.dart';
import 'package:goproperti/utils/Colors.dart';
import 'package:goproperti/utils/Dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExtraImageScreen extends StatefulWidget {
  const ExtraImageScreen({super.key});

  @override
  State<ExtraImageScreen> createState() => _ExtraImageScreenState();
}

class _ExtraImageScreenState extends State<ExtraImageScreen> {
  ExtraImageController extraImageController = Get.find();
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
    getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getfevAndSearch,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 80,
              width: Get.size.width,
              color: notifire.getblackwhitecolor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: notifire.getwhiteblackcolor,
                      ),
                    ),
                    Text(
                      "Extra Images".tr,
                      style: TextStyle(
                        color: notifire.getwhiteblackcolor,
                        fontFamily: FontFamily.gilroyBold,
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                          Routes.addExtraImageScreen,
                          arguments: {
                            "add": "Add",
                          },
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.add,
                          color: WhiteColor,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff3D5BF6),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GetBuilder<ExtraImageController>(builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: extraImageController.isLoading
                      ? extraImageController.extraListInfo!.extralist.isNotEmpty
                          ? ListView.builder(
                              itemCount: extraImageController
                                  .extraListInfo?.extralist.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Container(
                                      height: 90,
                                      width: Get.size.width,
                                      margin: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 90,
                                            width: 80,
                                            margin: EdgeInsets.all(10),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                "${Config.imageUrl}${extraImageController.extraListInfo?.extralist[index].image ?? ""}",
                                                height: 90,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
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
                                                            EdgeInsets.only(
                                                                top: 30),
                                                        child: Text(
                                                          extraImageController
                                                                  .extraListInfo
                                                                  ?.extralist[
                                                                      index]
                                                                  .propertyTitle ??
                                                              "",
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
                                                // Row(
                                                //   children: [
                                                //     Expanded(
                                                //       child: Text(
                                                //         "Bejing, China",
                                                //         maxLines: 1,
                                                //         style: TextStyle(
                                                //           color: notifire
                                                //               .getgreycolor,
                                                //           fontFamily: FontFamily
                                                //               .gilroyMedium,
                                                //           overflow: TextOverflow
                                                //               .ellipsis,
                                                //         ),
                                                //       ),
                                                //     ),
                                                //   ],
                                                // )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: notifire.getborderColor),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () {
                                          extraImageController
                                              .getEditExtraImage(
                                                  img: extraImageController
                                                          .extraListInfo
                                                          ?.extralist[index]
                                                          .image ??
                                                      "",
                                                  recordId: extraImageController
                                                          .extraListInfo
                                                          ?.extralist[index]
                                                          .id ??
                                                      "",
                                                  selectPro:
                                                      extraImageController
                                                              .extraListInfo
                                                              ?.extralist[index]
                                                              .propertyTitle ??
                                                          "",
                                                  pId: extraImageController
                                                          .extraListInfo
                                                          ?.extralist[index]
                                                          .propertyId ??
                                                      "");
                                          Get.toNamed(
                                              Routes.addExtraImageScreen,
                                              arguments: {
                                                "add": "edit",
                                              });
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          padding: EdgeInsets.all(9),
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                              "assets/images/Pen (1).png"),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xff3D5BF6),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            )
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 5),
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
                            )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                  decoration: BoxDecoration(
                    color: notifire.getblackwhitecolor,
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
