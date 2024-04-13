// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goproperti/Api/config.dart';
import 'package:goproperti/Api/data_store.dart';
import 'package:goproperti/controller/dashboard_controller.dart';
import 'package:goproperti/firebase/chats_list.dart';
import 'package:goproperti/model/fontfamily_model.dart';
import 'package:goproperti/model/routes_helper.dart';
import 'package:goproperti/screen/home_screen.dart';
import 'package:goproperti/utils/Colors.dart';
import 'package:goproperti/utils/Dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  DashBoardController dashBoardController = Get.find();

  List<String> routesList = [
    Routes.listOfPropertyScreen,
    Routes.extraImageScreen,
    Routes.galleryCategoryScreen,
    Routes.galleryImageScreen,
    Routes.bookingScreen,
    Routes.myEarningsScreen,
    Routes.myPayoutScreen,
    Routes.enquiryScreen,
  ];

  @override
  void initState() {
    super.initState();
    dashBoardController.getDashBoardData();
    getdarkmodepreviousstate();
  }

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
      backgroundColor: notifire.getbgcolor,
      appBar: AppBar(
        backgroundColor: notifire.getbgcolor,
        elevation: 0,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Get.to(ChatList());
            },
            child: Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Center(
                child: Image.asset(
                  "assets/images/Chat.png",
                  // height: 2,
                  width: 28,
                  fit: BoxFit.cover,
                  color: blueColor,
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: notifire.getborderColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
        leading: BackButton(
          color: notifire.getwhiteblackcolor,
          onPressed: () {
            Get.back();
          },
        ),
        title: Image.asset(
          "assets/images/applogo.png",
          height: 30,
          width: 30,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            Duration(seconds: 2),
            () {
              dashBoardController.getDashBoardData();
            },
          );
        },
        child: GetBuilder<DashBoardController>(builder: (context) {
          return dashBoardController.isLoading
              ? SizedBox(
                  height: Get.size.height,
                  width: Get.size.width,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Center(
                          child: InkWell(
                            onTap: () {
                              dashBoardController.getSubScribeDetails();
                              Get.toNamed(Routes.memberShipDetails);
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              // width: 295,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/verified_user.png",
                                    height: 25,
                                    width: 25,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        dashBoardController.membershipData[0],
                                        style: TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          fontSize: 16,
                                          color: Color(0xff3D5BF6),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        "Membership".tr,
                                        style: TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          fontSize: 16,
                                          color: notifire.getwhiteblackcolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    height: 25,
                                    width: 70,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "ACTIVE".tr,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: WhiteColor,
                                        fontFamily: FontFamily.gilroyMedium,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xff3D5BF6),
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: notifire.getborderColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Valid Till: ".tr,
                                style: TextStyle(
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: FontFamily.gilroyMedium,
                                ),
                              ),
                              Text(
                                dashBoardController.membershipData[1],
                                style: TextStyle(
                                  color: Color(0xff3D5BF6),
                                  fontFamily: FontFamily.gilroyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: GridView.builder(
                              itemCount: dashBoardController
                                  .dashBoardInfo?.reportData.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                mainAxisExtent: 115,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.toNamed(routesList[index]);
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 115,
                                        width: 170,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: getData.read("lCode") ==
                                                      "ar_IN"
                                                  ? EdgeInsets.only(right: 15)
                                                  : EdgeInsets.only(left: 15),
                                              child: index / 5 == 1
                                                  ? Text(
                                                      "${currency}${dashBoardController.dashBoardInfo?.reportData[index].reportData ?? ""}",
                                                      style: TextStyle(
                                                        fontSize: 25,
                                                        color:
                                                            Color(0xff3D5BF6),
                                                        fontFamily: FontFamily
                                                            .gilroyExtraBold,
                                                      ),
                                                    )
                                                  : index / 6 == 1
                                                      ? Text(
                                                          "${currency}${dashBoardController.dashBoardInfo?.reportData[index].reportData ?? ""}",
                                                          style: TextStyle(
                                                            fontSize: 25,
                                                            color: Color(
                                                                0xff3D5BF6),
                                                            fontFamily: FontFamily
                                                                .gilroyExtraBold,
                                                          ),
                                                        )
                                                      : Text(
                                                          "${dashBoardController.dashBoardInfo?.reportData[index].reportData ?? ""}",
                                                          style: TextStyle(
                                                            fontSize: 25,
                                                            color: Color(
                                                                0xff3D5BF6),
                                                            fontFamily: FontFamily
                                                                .gilroyExtraBold,
                                                          ),
                                                        ),
                                            ),
                                            Padding(
                                              padding: getData.read("lCode") ==
                                                      "ar_IN"
                                                  ? EdgeInsets.only(right: 15)
                                                  : EdgeInsets.only(left: 15),
                                              child: Text(
                                                dashBoardController
                                                        .dashBoardInfo
                                                        ?.reportData[index]
                                                        .title ??
                                                    "",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Color(0xff3D5BF6),
                                                  fontFamily:
                                                      FontFamily.gilroyBold,
                                                  fontSize: 15,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade200),
                                          image: DecorationImage(
                                            image: getData.read("lCode") ==
                                                    "ar_IN"
                                                ? AssetImage(
                                                    "assets/images/Frame2.png")
                                                : AssetImage(
                                                    "assets/images/Frame.png"),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0.5,
                                        right: 16.5,
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(15),
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                "${Config.imageUrl}${dashBoardController.dashBoardInfo?.reportData[index].url ?? ""}",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //   top: 0,
                                      //   right: 13,
                                      //   child: Container(
                                      //     height: 35,
                                      //     width: 35,
                                      //     decoration: BoxDecoration(
                                      //       borderRadius: BorderRadius.only(
                                      //         topRight: Radius.circular(15),
                                      //       ),
                                      //       image: DecorationImage(
                                      //         image: AssetImage(
                                      //             "assets/images/Vector (1).png"),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      // Positioned(
                                      //   bottom: 0,
                                      //   left: 0,
                                      //   child: Container(
                                      //     height: 35,
                                      //     width: 35,
                                      //     decoration: BoxDecoration(
                                      //       borderRadius: BorderRadius.only(
                                      //         bottomLeft: Radius.circular(15),
                                      //       ),
                                      //       image: DecorationImage(
                                      //         image: AssetImage(
                                      //             "assets/images/Vector (2).png"),
                                      //         fit: BoxFit.cover,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(
                              top: 20, left: 10, right: 10, bottom: 10),
                          child: Image.asset(
                            height: 270,
                            "assets/images/addpropartyimg.png",
                            fit: BoxFit.fill,
                          ),
                        )
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 15),
                        //   child: TextFormField(
                        //     // controller: signUpController.name,
                        //     controller: addPropertiesController.pTitle,
                        //     cursorColor: notifire.getwhiteblackcolor,
                        //     style: TextStyle(
                        //       fontFamily: 'Gilroy',
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.w600,
                        //       color: notifire.getwhiteblackcolor,
                        //     ),
                        //     decoration: InputDecoration(
                        //       focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(15),
                        //         borderSide: BorderSide(color: notifire.getgreycolor),
                        //       ),
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(15),
                        //       ),
                        //       prefixIcon: Padding(
                        //         padding: const EdgeInsets.all(10),
                        //         child: Image.asset(
                        //           "assets/images/user.png",
                        //           height: 10,
                        //           width: 10,
                        //           color: notifire.getgreycolor,
                        //         ),
                        //       ),
                        //       labelText: "Full Name",
                        //       labelStyle: TextStyle(
                        //         color: notifire.getgreycolor,
                        //       ),
                        //     ),
                        //     validator: (value) {
                        //       if (value == null || value.isEmpty) {
                        //         return 'Please enter your name';
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        }),
      ),
    );
  }
}
