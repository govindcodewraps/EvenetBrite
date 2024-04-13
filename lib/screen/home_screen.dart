// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, sort_child_properties_last, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, unused_local_variable, no_leading_underscores_for_local_identifiers, avoid_print, prefer_interpolation_to_compose_strings, unrelated_type_equality_checks, use_build_context_synchronously
import 'dart:convert';
import 'dart:io';

import 'package:badges/badges.dart' as bg;
import 'package:chewie/chewie.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:goproperti/Api/config.dart';
import 'package:goproperti/Api/data_store.dart';
import 'package:goproperti/controller/homepage_controller.dart';
import 'package:goproperti/controller/search_controller.dart';
import 'package:goproperti/controller/signup_controller.dart';
import 'package:goproperti/firebase/chat_screen.dart';
import 'package:goproperti/model/fontfamily_model.dart';
import 'package:goproperti/model/routes_helper.dart';
import 'package:goproperti/utils/Colors.dart';
import 'package:goproperti/utils/Dark_lightmode.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

var lat;
var long;
var first;
var currency;
// var tWallet;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController dateInputController = TextEditingController();
  TextEditingController dateInputController2 = TextEditingController();

  HomePageController homePageController = Get.find();
  SignUpController signUpController = Get.find();
  bool isLoding = false;
  Position? currentLocation;
  String fevId = "";

  String userName = "";
  String? base64Image;

  String? networkimage;


   final videoURL ="https://www.youtube.com/watch?v=367-O2G5U10";
    late YoutubePlayerController _youtubecontroller;




  @override
  void initState() {


    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    _youtubecontroller=YoutubePlayerController(initialVideoId: videoID!,
      flags:const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );





    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      Get.to(ChatPage(
        proPic: remoteMessage.data["propic"],
        resiverUserId: remoteMessage.data["id"],
        resiverUseremail: remoteMessage.data["name"],
      ));
    });
    getdarkmodepreviousstate();
    if (getData.read("UserLogin") != null) {
      isUserOnlie(getData.read("UserLogin")["id"], false);
    }

    lat == null ? getUserLocation() : getUserLocation1();
    super.initState();
    getData.read("UserLogin") != null
        ? setState(() {
      userName = getData.read("UserLogin")["name"] ?? "";
      networkimage = getData.read("UserLogin")["pro_pic"] ?? "";
      getData.read("UserLogin")["pro_pic"] != "null"
          ? setState(() {
        networkimageconvert();
      })
          : const SizedBox();
    })
        : null;
  }

  networkimageconvert() {
    (() async {
      http.Response response =
      await http.get(Uri.parse(Config.imageUrl + networkimage.toString()));

      if (mounted) {
        print(response.bodyBytes);
        setState(() {
          base64Image = const Base64Encoder().convert(response.bodyBytes);
        });
      }
    })();
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future getUserLocation() async {
    isLoding = true;
    setState(() {});
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {}
    var currentLocation = await locateUser();
    debugPrint('location: ${currentLocation.latitude}');
    lat = currentLocation.latitude;
    long = currentLocation.longitude;

    List<Placemark> addresses = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);
    setState(() {
      if (getData.read("homeCall") == true) {
        setState(() {
          homePageController.getHomeDataApi(
            countryId: getData.read("countryId"),
          );
        });
        save("homeCall", false);
      }
      first = addresses.first.name;
    });
  }

  Future getUserLocation1() async {
    isLoding = true;
    setState(() {});
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {}
    var currentLocation = await locateUser();
    debugPrint('location: ${currentLocation.latitude}');

    // setState(() {
    // if (getData.read("homeCall") == true) {
    //   setState(() {
    // homePageController.getHomeDataApi(
    //   countryId: getData.read("countryId"),
    // );
    // });
    // save("homeCall", false);
    // }
    // uid = getData.read("UserLogin") != null
    //     ? getData.read("UserLogin")["id"] ?? "0"
    //     : "0";
    // // homeController.getHomePageData();
    // homePageApi();
    // });
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
  DateTime? currentBackPressTime;



  final List<String> videoUrls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',

  ];

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return WillPopScope(
      //onWillPop: () => exit(0),

      onWillPop: () async {
        if (currentBackPressTime == null ||
            DateTime.now().difference(currentBackPressTime!) >
                Duration(seconds: 2)) {
          currentBackPressTime = DateTime.now();
          // Show a snackbar or a dialog to inform the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press back again to exit'),
            ),
          );
          return false;
        }
        return true;
      },

      child: Scaffold(
        backgroundColor: notifire.getbgcolor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
            backgroundColor: notifire.getblackwhitecolor,
            elevation: 0,
            title: Row(
              children: [
                getData.read("UserLogin") != null && networkimage != ""
                    ? InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            "${Config.imageUrl}${networkimage ?? ""}"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                )
                    : InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/profile-default.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello Welcome 👋".tr,
                      style: TextStyle(
                        color: Color(0xFF757575),
                        fontFamily: FontFamily.gilroyMedium,
                        fontSize: 14,
                      ),
                    ),
                    userName != ""
                        ? Text(
                      userName,
                      style: TextStyle(
                        color: notifire.getwhiteblackcolor,
                        fontFamily: FontFamily.gilroyBold,
                        fontSize: 18,
                      ),
                    )
                        : Text(
                      "User".tr,
                      style: TextStyle(
                        color: notifire.getwhiteblackcolor,
                        fontFamily: FontFamily.gilroyBold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                )
              ],
            ),

            actions: [
              InkWell(
                onTap: () {
                  if (getData.read("UserLogin") != null) {
                   // Get.toNamed(Routes.notificationScreen);
                  } else {
                    Get.toNamed(Routes.login);
                  }
                },
                child: bg.Badge(
                  badgeStyle: bg.BadgeStyle(
                    badgeColor: Colors.red,
                    shape: bg.BadgeShape.circle,
                  ),
                  badgeContent: Text(''),
                  badgeAnimation: bg.BadgeAnimation.slide(),
                  position: bg.BadgePosition.topEnd(end: 10, top: 14),
                  child: CircleAvatar(
                    radius: 24,
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/Notification.png",
                        height: 25,
                        width: 25,
                        color: notifire.getwhiteblackcolor,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    ),
                    backgroundColor: notifire.getboxcolor,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 2),
                  () {
                homePageController.getHomeDataApi(
                  countryId: getData.read("countryId"),
                );
                homePageController.getCatWiseData(
                  cId: "0",
                  countryId: getData.read("countryId"),
                );
              },
            );
          },
          child: GetBuilder<HomePageController>(builder: (context) {
            // tWallet = homePageController.homeDatatInfo?.homeData.wallet ?? "";
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: homePageController.isLoading
                  ? Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  // searchBar(),
                  searchWidget(),
                  SizedBox(
                    height: 20,
                  ),



                  // calendar(),
                  // SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //       flex: 1,
                  //       child: Container(
                  //         height: 45,
                  //         decoration: BoxDecoration(
                  //           color: Color(0xffF4F4F4),
                  //           borderRadius: BorderRadius.circular(12),
                  //           border: Border.all(
                  //             color: Colors.white10,
                  //           ),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.black12.withOpacity(0.5),
                  //               spreadRadius: 1,
                  //               blurRadius: 1,
                  //               offset: const Offset(0, 1),
                  //             ),
                  //           ],
                  //         ),
                  //         child: TextButton(
                  //           onPressed: () {
                  //             // Add your signup with Google functionality here
                  //           },
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               const Text(
                  //                 "Name Or Location",
                  //                 style: TextStyle(
                  //                   fontSize: 14,
                  //                   fontWeight: FontWeight.w600,
                  //                   color: Color(0xff222222),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: 10,),
                  //     Expanded(
                  //       flex: 1,
                  //       child: Container(
                  //         height: 45,
                  //         decoration: BoxDecoration(
                  //           color: Color(0xffF4F4F4),
                  //           borderRadius: BorderRadius.circular(12),
                  //           border: Border.all(
                  //             color: Colors.white10,
                  //           ),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.black38.withOpacity(0.5),
                  //               spreadRadius: 1,
                  //               blurRadius: 1,
                  //               offset: const Offset(0, 1),
                  //             ),
                  //           ],
                  //         ),
                  //         child: TextButton(
                  //           onPressed: () {
                  //             // Add your signup with Google functionality here
                  //           },
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               const Text(
                  //                 "Rooms & Guests ",
                  //                 style: TextStyle(
                  //                   fontSize: 14,
                  //                   fontWeight: FontWeight.w600,
                  //                   color: Color(0xff222222),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],),
                  // SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //       flex: 1,
                  //
                  //       child: Container(
                  //         height: 45,
                  //         decoration: BoxDecoration(
                  //           color: Color(0xffF4F4F4),
                  //           borderRadius: BorderRadius.circular(12),
                  //           border: Border.all(
                  //             color: Colors.white10,
                  //           ),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.black12.withOpacity(0.5),
                  //               spreadRadius: 1,
                  //               blurRadius: 1,
                  //               offset: const Offset(0, 1),
                  //             ),
                  //           ],
                  //         ),
                  //         child: TextButton(
                  //           onPressed: () {
                  //             // Add your signup with Google functionality here
                  //           },
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               const Text(
                  //                 "Check-In",
                  //                 style: TextStyle(
                  //                   fontSize: 14,
                  //                   fontWeight: FontWeight.w600,
                  //                   color: Color(0xff222222),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: 10,),
                  //     Expanded(
                  //       flex: 1,
                  //
                  //       child: Container(
                  //         height: 45,
                  //         decoration: BoxDecoration(
                  //           color: Color(0xffF4F4F4),
                  //           borderRadius: BorderRadius.circular(12),
                  //           border: Border.all(
                  //             color: Colors.white10,
                  //           ),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.black12.withOpacity(0.5),
                  //               spreadRadius: 1,
                  //               blurRadius: 1,
                  //               offset: const Offset(0, 1),
                  //             ),
                  //           ],
                  //         ),
                  //         child: TextButton(
                  //           onPressed: () {
                  //             // Add your signup with Google functionality here
                  //           },
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               const Text(
                  //                 "Check-Out",
                  //                 style: TextStyle(
                  //                   fontSize: 14,
                  //                   fontWeight: FontWeight.w600,
                  //                   color: Color(0xff222222),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],),
                  // SizedBox(height: 10,),
                  // Container(
                  //   height: 36,
                  //   width: 133,
                  //   decoration: BoxDecoration(
                  //     color: Color(0xff0DC4EC),
                  //     borderRadius: BorderRadius.circular(12),
                  //     border: Border.all(
                  //       color: Colors.white10,
                  //     ),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.black12.withOpacity(0.5),
                  //         spreadRadius: 1,
                  //         blurRadius: 1,
                  //         offset: const Offset(0, 1),
                  //       ),
                  //     ],
                  //   ),
                  //   child: TextButton(
                  //     onPressed: () {
                  //       // Add your signup with Google functionality here
                  //     },
                  //     child: const Text(
                  //       "Submit",
                  //       style: TextStyle(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w700,
                  //         color: Color(0xff000000),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  categoryAndSeeAllWidget("Featured".tr, "See All".tr),
                  listFeatured(),

                 //     child: Text("For Your stay1 in Dubai",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),)),

                  /* Container(

                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: videoUrls.length,
                            itemBuilder: (context, index) {
                              final videoPlayerController = VideoPlayerController.network(videoUrls[index]);
                              final chewieController = ChewieController(
                                videoPlayerController: videoPlayerController,
                                autoPlay: false,
                                looping: true,
                                aspectRatio: 16 / 9,
                                allowMuting: true,
                                allowPlaybackSpeedChanging: false,
                                showControlsOnInitialize: false,
                                showOptions: false,
                                showControls: false,
                              );
                              videoPlayerController.initialize().then((_) {
                                chewieController.pause();
                              });

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VideoPlayerScreen(videoPlayerController: videoPlayerController),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 200, // Adjust the width as needed
                                  margin: EdgeInsets.all( 9.0),
                                 // margin: EdgeInsets.symmetric(horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5.0,
                                        spreadRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12.0),
                                        child: AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: Chewie(
                                            controller: chewieController,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("VIDEO",
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),*/



                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Popluar Training Videos",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),)),

                  //Text("VIDEOS LIST"),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: YoutubePlayer(controller: _youtubecontroller,
                      showVideoProgressIndicator: true,
                      onReady: ()=>debugPrint('Ready'),
                      bottomActions: [
                        CurrentPosition(),
                        ProgressBar(
                          isExpanded:true,
                          colors: const ProgressBarColors(
                            playedColor: Colors.amber,
                            handleColor: Colors.amberAccent,
                          ),
                        ),
                        const PlaybackSpeedButton(),
                      ],
                    ),
                  ),




                  // Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Text("Popluar Training Videos",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),)),

                  /*Container(
                          padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
                          decoration: BoxDecoration(
                           // border:Border.all(),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: 400,
                          child:
                          GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 6.0,
                              mainAxisSpacing: 6.0,
                            ),
                            itemCount: videoUrls.length,
                            itemBuilder: (context, index) {
                              final videoPlayerController = VideoPlayerController.network(videoUrls[index]);
                              final chewieController = ChewieController(
                                videoPlayerController: videoPlayerController,
                                autoPlay: false,
                                looping: true,
                                aspectRatio: 16 / 9,
                                allowMuting: true,
                                allowPlaybackSpeedChanging: false,
                                showControlsOnInitialize: false,
                                showOptions: false,
                                showControls: false,
                              );
                              videoPlayerController.initialize().then((_) {
                                chewieController.pause();
                              });

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VideoPlayerScreen(videoPlayerController: videoPlayerController),
                                    ),
                                  );
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(12.0),
                                  elevation: 5.0,
                                  shadowColor: Colors.grey,
                                  child:
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white38,
                                          blurRadius: 5.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(12.0),
                                          child: AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: Chewie(
                                              controller: chewieController,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Text("The Aston Vill Hotel",style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),),
                                              Text("Alice Springs NT 0870, Australia",style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),),
                                              Text("\$500",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),*/


                  //Text("AAAAAdata"),


                  categoryAndSeeAllWidget(
                      "Our Recommendation".tr, "See All".tr),

                  SizedBox(
                    height: 55,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ListView.builder(
                        itemCount:
                        homePageController.homeDatatInfo?.homeData.catlist.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              homePageController
                                  .changeCategoryIndex(index);

                              homePageController.getCatWiseData(
                                cId: homePageController.homeDatatInfo
                                    ?.homeData.catlist[index].id,
                                countryId: getData.read("countryId"),
                              );

                              // homePageController.getHomeDataApi(
                              //   catId: homePageController.homeDatatInfo
                              //       ?.homeData.catlist[index].id,
                              // );
                            },
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.only(
                                  left: 5, right: 5, top: 7, bottom: 7),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  // Image.network(
                                  //   "${Config.imageUrl}${homePageController.homeDatatInfo?.homeData.catlist[index].img ?? ""}",
                                  //   color: homePageController
                                  //       .catCurrentIndex ==
                                  //       index
                                  //       ? WhiteColor
                                  //       : blueColor,
                                  //   height: 25,
                                  //   width: 25,
                                  //   fit: BoxFit.cover,
                                  // ),
                                  SizedBox(
                                    width: 5,
                                  ),

                                  Text(
                                    homePageController
                                        .homeDatatInfo
                                        ?.homeData
                                        .catlist[index]
                                        .title ??
                                        "",
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      color: homePageController
                                          .catCurrentIndex ==
                                          index
                                          ? WhiteColor
                                          : blueColor,
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: blueColor, width: 2),
                                borderRadius: BorderRadius.circular(25),
                                color:
                                homePageController.catCurrentIndex ==
                                    index
                                    ? blueColor
                                    : notifire.getblackwhitecolor,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  homePageController.isCatWise
                      ? homePageController
                      .catWiseInfo!.propertyCat.isNotEmpty
                      ? GridView.builder(
                    itemCount: homePageController
                        .catWiseInfo?.propertyCat.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 270,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          setState(() {
                            homePageController.rate =
                                homePageController
                                    .catWiseInfo
                                    ?.propertyCat[index]
                                    .rate ??
                                    "";
                          });
                          homePageController
                              .chnageObjectIndex(index);
                          await homePageController
                              .getPropertyDetailsApi(
                            id: homePageController.catWiseInfo
                                ?.propertyCat[index].id,
                          );
                          Get.toNamed(Routes.viewDataScreen
                            // arguments: {
                            //   "price": homePageController
                            //       .homeDatatInfo
                            //       ?.homeData
                            //       .cateWiseProperty[index]
                            //       .price,
                            // },
                          );
                        },
                        child: Container(
                          height: 270,
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 140,
                                    width: Get.size.width,
                                    margin: EdgeInsets.all(8),
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(
                                          15),
                                      child: FadeInImage
                                          .assetNetwork(
                                        fadeInCurve:
                                        Curves.easeInCirc,
                                        placeholder:
                                        "assets/images/ezgif.com-crop.gif",
                                        height: 130,
                                        width: Get.size.width,
                                        image:
                                        "${Config.imageUrl}${homePageController.catWiseInfo?.propertyCat[index].image ?? ""}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  homePageController
                                      .catWiseInfo
                                      ?.propertyCat[
                                  index]
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
                                                0,
                                                0,
                                                3,
                                                0),
                                            child: Image
                                                .asset(
                                              "assets/images/Rating.png",
                                              height: 15,
                                              width: 15,
                                            ),
                                          ),
                                          Text(
                                            "${homePageController.catWiseInfo?.propertyCat[index].rate ?? ""}",
                                            style:
                                            TextStyle(
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
                                        color: Color(
                                            0xFFedeeef),
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            15),
                                      ),
                                    ),
                                  )
                                      : Positioned(
                                    top: 15,
                                    right: 20,
                                    child: Container(
                                      height: 30,
                                      width: 60,
                                      alignment: Alignment
                                          .center,
                                      child: Text(
                                        "BUY".tr,
                                        style: TextStyle(
                                            color:
                                            blueColor,
                                            fontWeight:
                                            FontWeight
                                                .w600),
                                      ),
                                      decoration:
                                      BoxDecoration(
                                        color: Color(
                                            0xFFedeeef),
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  height: 128,
                                  width: Get.size.width,
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets
                                            .only(left: 10),
                                        child: Text(
                                          homePageController
                                              .catWiseInfo
                                              ?.propertyCat[
                                          index]
                                              .title ??
                                              "",
                                          maxLines: 1,
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
                                      Padding(
                                        padding:
                                        const EdgeInsets
                                            .only(
                                            left: 10,
                                            top: 6),
                                        child: Text(
                                          homePageController
                                              .catWiseInfo
                                              ?.propertyCat[
                                          index]
                                              .city ??
                                              "",
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: notifire
                                                .getgreycolor,
                                            fontFamily: FontFamily
                                                .gilroyMedium,
                                            overflow:
                                            TextOverflow
                                                .ellipsis,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets
                                            .only(left: 10),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  top: 7),
                                              child: Text(
                                                "${currency}${homePageController.catWiseInfo?.propertyCat[index].price ?? ""}",
                                                style:
                                                TextStyle(
                                                  color:
                                                  blueColor,
                                                  fontFamily:
                                                  FontFamily
                                                      .gilroyBold,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ),
                                            homePageController
                                                .catWiseInfo
                                                ?.propertyCat[
                                            index]
                                                .buyorrent ==
                                                "1"
                                                ? Padding(
                                              padding: const EdgeInsets
                                                  .only(
                                                  left: 3,
                                                  top: 7),
                                              child: Text(
                                                "/night"
                                                    .tr,
                                                style:
                                                TextStyle(
                                                  color: notifire
                                                      .getgreycolor,
                                                  fontFamily:
                                                  FontFamily.gilroyMedium,
                                                ),
                                              ),
                                            )
                                                : Text(""),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: notifire.getborderColor),
                            borderRadius:
                            BorderRadius.circular(10),
                            color: notifire.getblackwhitecolor,
                          ),
                        ),
                      );
                    },
                  )
                      : Padding(
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
                                fontFamily:
                                FontFamily.gilroyBold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                      : Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              )
                  : SizedBox(
                height: Get.height,
                width: Get.width,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }


  Widget calendar(){
    return  Container(
      padding: EdgeInsets.only(left: 0,right: 0),
      child:  Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text("From Date"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.greenAccent,
                          ),
                        ),
                        labelText: "Date",
                        hintText: 'Date',
                        suffixIcon:
                        Icon(Icons.calendar_month, color: Colors.black),
                      ),
                      controller: dateInputController,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2050),
                        );

                        if (pickedDate != null) {
                          setState(() {
                            dateInputController.text =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                          });

                          // if (dateInputController2.text.isNotEmpty) {
                          //   // Call the future method when both dates are selected
                          //   getAppointments(
                          //     dateInputController.text,
                          //     dateInputController2.text,
                          //   ).then((appointments) {
                          //     if (appointments != null) {
                          //       // Do something with the fetched data
                          //       print(appointments);
                          //     }
                          //   });
                          // }

                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text("To Date"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.greenAccent,
                          ),
                        ),
                        labelText: "Date",
                        hintText: 'Date',
                        suffixIcon:
                        Icon(Icons.calendar_month, color: Colors.black),
                      ),
                      controller: dateInputController2,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2050),
                        );

                        if (pickedDate != null) {
                          setState(() {
                            dateInputController2.text =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                          });

                          // if (dateInputController.text.isNotEmpty) {
                          //   // Call the future method when both dates are selected
                          //   getAppointments(
                          //     dateInputController.text,
                          //     dateInputController2.text,
                          //   ).then((appointments) {
                          //     if (appointments != null) {
                          //       // Do something with the fetched data
                          //       print(appointments);
                          //     }
                          //   });
                          // }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),


          // ElevatedButton(onPressed: (){
          //   pastappointmentapi();
          //   todayappointmentlist();
          //   upcoming_appointment();
          //   // appointmentslistwidget();
          //   time_slot();
          //
          //   print("Govindddddddd ");
          //
          // }, child: Text("Buttton")
          //
          // ),

          // Use FutureBuilder to handle the async operation

          SizedBox(height: 20,),



          SizedBox(height: 20,),


        ],
      ),
    );
  }

  Widget searchWidget() {
    SearchPropertyController searchController =
    Get.put(SearchPropertyController());
    return InkWell(
      onTap: () {
        searchController.search.text = "";
        Get.toNamed(Routes.homeSearchScreen);
      },
      child: Container(
        height: 50,
        width: Get.size.width,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                "assets/images/SearchHomescreen.png",
                height: 22,
                width: 22,
                fit: BoxFit.cover,
                color: notifire.getlightblack,
              ),
            ),
            Text(
              "Search".tr,
              style: TextStyle(
                fontFamily: FontFamily.gilroyMedium,
                color: notifire.getlightblack,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          // color: Color(0xFFf5f5f5),
          color: notifire.getlightblackwhite,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget categoryAndSeeAllWidget(String name, String buttonName) {
    return Row(
      children: [
        SizedBox(
          width: 15,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 17,
            fontFamily: FontFamily.gilroyBold,
            color: notifire.getwhiteblackcolor,
          ),
        ),

        Spacer(),
        TextButton(
          onPressed: () {
            if (name == "Featured".tr) {
              Get.toNamed(Routes.featuredScreen);
            }
            if (name == "Our Recommendation".tr) {
              homePageController.getCatWiseData();
              Get.toNamed(Routes.ourRecommendationScreen);
            }
          },
          child: Text(
            buttonName,
            style: TextStyle(
              color: Color(0xff48DBFB),
              fontFamily: FontFamily.gilroyBold,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget listFeatured() {
    return GetBuilder<HomePageController>(builder: (context) {
      return SizedBox(
        height: 320,
        width: Get.size.width,
        child: homePageController
            .homeDatatInfo!.homeData.featuredProperty.isNotEmpty
            ? ListView.builder(
          itemCount: homePageController
              .homeDatatInfo?.homeData.featuredProperty.length,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            currency =
                homePageController.homeDatatInfo?.homeData.currency ?? "";
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
                  //   "price": homePageController
                  //       .homeDatatInfo?.homeData.featuredProperty[index].price,
                  // },
                );
              },
              child: Container(
                height: 320,
                width: 240,
                margin: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Stack(
                    // alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        height: 320,
                        width: 240,
                        child: FadeInImage.assetNetwork(
                          fadeInCurve: Curves.easeInCirc,
                          placeholder: "assets/images/ezgif.com-crop.gif",
                          height: 320,
                          width: 240,
                          placeholderCacheHeight: 320,
                          placeholderCacheWidth: 240,
                          placeholderFit: BoxFit.fill,
                          // placeholderScale: 1.0,
                          image:
                          "${Config.imageUrl}${homePageController.homeDatatInfo?.homeData.featuredProperty[index].image ?? ""}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.6, 0.8, 1.5],
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.5),
                              Colors.black.withOpacity(0.5),
                            ],
                          ),
                          //border: Border.all(color: lightgrey),
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
                                  height: 15,
                                  width: 15,
                                ),
                              ),
                              Text(
                                "${homePageController.homeDatatInfo?.homeData.featuredProperty[index].rate ?? ""}",
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
                      Positioned(
                        bottom: 0,
                        child: SizedBox(
                          height: 120,
                          width: 240,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, top: 10),
                                child: Text(
                                  homePageController
                                      .homeDatatInfo
                                      ?.homeData
                                      .featuredProperty[index]
                                      .title ??
                                      "",
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: FontFamily.gilroyBold,
                                    color: WhiteColor,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, top: 10),
                                child: Text(
                                  homePageController
                                      .homeDatatInfo
                                      ?.homeData
                                      .featuredProperty[index]
                                      .city ??
                                      "",
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontFamily: FontFamily.gilroyMedium,
                                    color: WhiteColor,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, top: 10),
                                    child: Text(
                                      "${currency}${homePageController.homeDatatInfo?.homeData.featuredProperty[index].price}",
                                      style: TextStyle(
                                        color: WhiteColor,
                                        fontFamily: FontFamily.gilroyBold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  homePageController
                                      .homeDatatInfo
                                      ?.homeData
                                      .featuredProperty[index]
                                      .buyorrent ==
                                      "1"
                                      ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, top: 10),
                                    child: Text(
                                      "/night".tr,
                                      style: TextStyle(
                                        color: WhiteColor,
                                        fontFamily:
                                        FontFamily.gilroyMedium,
                                      ),
                                    ),
                                  )
                                      : Text(""),
                                  // Spacer(),
                                  // InkWell(
                                  //   onTap: () {
                                  //     if (getData.read("UserLogin") != null) {
                                  //       homePageController.addFavouriteList(
                                  //         pid: homePageController
                                  //             .homeDatatInfo
                                  //             ?.homeData
                                  //             .featuredProperty[index]
                                  //             .id,
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
                                  //             color: WhiteColor,
                                  //             height: 20,
                                  //             width: 20,
                                  //           ),
                                  //         )
                                  //       : Padding(
                                  //           padding: const EdgeInsets.only(
                                  //               top: 10, right: 15),
                                  //           child: Image.asset(
                                  //             "assets/images/favorite.png",
                                  //             color: WhiteColor,
                                  //             height: 20,
                                  //             width: 20,
                                  //           ),
                                  //         ),
                                  // )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
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
      );
    });
  }
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void listenFCM() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              //      one that already exists in example app.
              icon: '@mipmap/ic_launcher',
            ),
            iOS: const IOSNotificationDetails(
              presentAlert: true,
              presentSound: true,
              presentBadge: true,
            ),
          ),
          payload: jsonEncode({
            "name": message.data["name"],
            "id": message.data["id"],
            "propic": message.data["propic"]
          }));
    }
  });
}

Future<void> initializeNotifications() async {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (String? payload) async {
      if (payload != null) {
        Map data = jsonDecode(payload);
        // Navigate to the DetailPage when notification is clicked

        Get.to(ChatPage(
          proPic: data["propic"],
          resiverUserId: data["id"],
          resiverUseremail: data["name"],
        ));
      }
    },
  );
}

void loadFCM() async {
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
      enableVibration: true,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}


//
// class VideoPlayerScreen extends StatefulWidget {
//   final VideoPlayerController videoPlayerController;
//
//   VideoPlayerScreen({required this.videoPlayerController});
//
//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }
//
// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late ChewieController _chewieController;
//
//   @override
//   void initState() {
//     super.initState();
//     _chewieController = ChewieController(
//       videoPlayerController: widget.videoPlayerController,
//       autoPlay: true,
//       looping: false,
//       aspectRatio: 9 / 5,
//       allowMuting: true,
//       allowPlaybackSpeedChanging: true,
//       showControlsOnInitialize: true,
//       showOptions: true,
//       showControls: true,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Player'),
//       ),
//       body: Center(
//         child: Chewie(
//           controller: _chewieController,
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _chewieController.dispose();
//   }
// }