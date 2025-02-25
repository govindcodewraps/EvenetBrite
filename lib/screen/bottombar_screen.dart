// // ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, prefer_typing_uninitialized_variables, sort_child_properties_last
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:goproperti/Api/data_store.dart';
// import 'package:goproperti/controller/dashboard_controller.dart';
// import 'package:goproperti/controller/listofproperti_controller.dart';
// import 'package:goproperti/controller/selectcountry_controller.dart';
// import 'package:goproperti/controller/wallet_controller.dart';
// import 'package:goproperti/model/fontfamily_model.dart';
// import 'package:goproperti/screen/add%20proparty/addintro_screen.dart';
// import 'package:goproperti/screen/add%20proparty/membarship_screen.dart';
// // import 'package:goproperti/screen/bottomSearch.dart';
// import 'package:goproperti/screen/favorite_screen.dart';
// import 'package:goproperti/screen/home_screen.dart';
// import 'package:goproperti/screen/login_screen.dart';
// import 'package:goproperti/screen/near%20by%20map/map_screen.dart';
// import 'package:goproperti/screen/profile_screen.dart';
// import 'package:goproperti/utils/Dark_lightmode.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class BottoBarScreen extends StatefulWidget {
//   const BottoBarScreen({super.key});
//
//   @override
//   State<BottoBarScreen> createState() => _BottoBarScreenState();
// }
//
// late TabController tabController;
//
// class _BottoBarScreenState extends State<BottoBarScreen>
//     with TickerProviderStateMixin {
//   WalletController walletController = Get.find();
//   DashBoardController dashBoardController = Get.find();
//   ListOfPropertiController listOfPropertiController = Get.find();
//   SelectCountryController selectCountryController = Get.find();
//
//   int _currentIndex = 0;
//
//   var isLogin;
//
//   List<Widget> myChilders = [
//     HomeScreen(),
//     MapScreen(),
//     // BottomSearchScreen(),
//     FavoriteScreen(),
//     // MassageScreen(),
//     ProfileScreen(),
//   ];
//
//   late ColorNotifire notifire;
//
//   getdarkmodepreviousstate() async {
//     final prefs = await SharedPreferences.getInstance();
//     bool? previusstate = prefs.getBool("setIsDark");
//
//     if (previusstate == null) {
//       notifire.setIsDark = false;
//     } else {
//       notifire.setIsDark = previusstate;
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     dashBoardController.getDashBoardData();
//     isLogin = getData.read("UserLogin");
//     tabController = TabController(length: 4, vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     notifire = Provider.of<ColorNotifire>(context, listen: true);
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body:
//       TabBarView(
//         physics: const NeverScrollableScrollPhysics(),
//         controller: tabController,
//         children: myChilders,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//      floatingActionButton: Padding(
//        padding: const EdgeInsets.all(8.0),
//         child: FloatingActionButton(
//           backgroundColor: Color(0xff3D5BF6),
//           onPressed: () {
//             if (isLogin != null) {
//               if (dashBoardController.dashBoardInfo?.isSubscribe == 1) {
//                 dashBoardController.getDashBoardData();
//                 listOfPropertiController.getPropertiList();
//                 selectCountryController.getCountryApi();
//                 Get.to(MembershipScreen());
//               } else {
//                 selectCountryController.getCountryApi();
//                 Get.to(BoardingPage());
//               }
//             } else {
//               Get.to(() => LoginScreen());
//             }
//           },
//           child: Container(
//             margin: EdgeInsets.all(15.0),
//             child: Image.asset(
//               "assets/images/bolt.png",
//             ),
//           ),
//           elevation: 4.0,
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: notifire.getbgcolor,
//         child: TabBar(
//           onTap: (index) {
//             setState(() {});
//
//             if (isLogin != null) {
//               _currentIndex = index;
//             } else {
//               index != 0 ? Get.to(() => LoginScreen()) : const SizedBox();
//             }
//           },
//           indicator: UnderlineTabIndicator(
//             insets: EdgeInsets.only(bottom: 52),
//             borderSide: BorderSide(color: notifire.getbgcolor, width: 2),
//           ),
//           labelColor: Colors.blueAccent,
//           indicatorSize: TabBarIndicatorSize.label,
//           unselectedLabelColor: Colors.grey,
//           controller: tabController,
//           padding: const EdgeInsets.symmetric(vertical: 6),
//           tabs: [
//             Tab(
//               child: Column(
//                 children: [
//                   // _currentIndex == 0
//                   //     ?
//
//                   Image.asset(
//                     "assets/images/${_currentIndex == 0 ? "HomeBold.png" : "Home.png"}",
//                     scale: 21,
//                     color: _currentIndex == 0
//                         ? Color(0xff3D5BF6)
//                         : notifire.getwhiteblackcolor,
//                   ),
//
//                   // : Image.asset(
//                   //     "assets/images/Home.png",
//                   //     scale: 21,
//                   //     color: notifire.getwhiteblackcolor,
//                   //   ),
//
//                   SizedBox(height: 3),
//
//                   Text(
//                     "Camp".tr,
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontFamily: FontFamily.gilroyMedium,
//                       color:
//                           _currentIndex == 0 ? Color(0xff3D5BF6) : Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 50,
//               width: 80,
//               alignment: getData.read("lCode") == "ar_IN"
//                   ? Alignment.topRight
//                   : Alignment.topLeft,
//               child: Tab(
//                 child: Column(
//                   children: [
//                     Image.asset(
//                       "assets/images/${_currentIndex == 1 ? "mapbold.png" : "map.png"}",
//                       scale: 3.7,
//                       color: _currentIndex == 1
//                           ? Color(0xff3D5BF6)
//                           : notifire.getwhiteblackcolor,
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       "My Trips".tr,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontFamily: FontFamily.gilroyMedium,
//                         color: _currentIndex == 1
//                             ? Color(0xff3D5BF6)
//                             : Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // Container(
//             //   height: 50,
//             //   width: 80,
//             //   alignment: Alignment.topLeft,
//             //   child: Tab(
//             //     child: Column(
//             //       children: [
//             //         Image.asset(
//             //           "assets/images/Search.png",
//             //           scale: 21,
//             //           color: notifire.getwhiteblackcolor,
//             //         ),
//             //         Text(
//             //           "Search".tr,
//             //           style: TextStyle(
//             //             fontSize: 10,
//             //             fontFamily: FontFamily.gilroyMedium,
//             //             color: _currentIndex == 1
//             //                 ? Color(0xff3D5BF6)
//             //                 : Colors.grey,
//             //           ),
//             //         ),
//             //       ],
//             //     ),
//             //   ),
//             // ),
//
//             Container(
//               height: 50,
//               width: 80,
//               alignment: getData.read("lCode") == "ar_IN"
//                   ? Alignment.topLeft
//                   : Alignment.topRight,
//               child: Tab(
//                 child: Column(
//                   children: [
//                     // _currentIndex == 2
//                     //     ?
//
//                     Image.asset(
//                       "assets/images/${_currentIndex == 2 ? "heartBold.png" : "heartline.png"}",
//                       scale: 21,
//                       color: _currentIndex == 2
//                           ? Color(0xff3D5BF6)
//                           : notifire.getwhiteblackcolor,
//                     ),
//
//                     // : Image.asset(
//                     //     "assets/images/heartline.png",
//                     //     scale: 21,
//                     //     color: notifire.getwhiteblackcolor,
//                     //   ),
//
//                     SizedBox(height: 3),
//
//                     Text(
//                       "Wallet".tr,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontFamily: FontFamily.gilroyMedium,
//                         color: _currentIndex == 2
//                             ? Color(0xff3D5BF6)
//                             : Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             Tab(
//               child: Column(
//                 children: [
//                   // _currentIndex == 3
//                   //     ?
//                   Image.asset(
//                     "assets/images/${_currentIndex == 3 ? "userBold.png" : "userline.png"}",
//                     scale: 21,
//                     color: _currentIndex == 3
//                         ? Color(0xff3D5BF6)
//                         : notifire.getwhiteblackcolor,
//                   ),
//                   // : Image.asset(
//                   //     "assets/images/userline.png",
//                   //     scale: 21,
//                   //     color: notifire.getwhiteblackcolor,
//                   //   ),
//                   SizedBox(height: 3),
//                   Text(
//                     "Saved".tr,
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontFamily: FontFamily.gilroyMedium,
//                       color:
//                           _currentIndex == 3 ? Color(0xff3D5BF6) : Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, prefer_typing_uninitialized_variables, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goproperti/Api/data_store.dart';
import 'package:goproperti/controller/dashboard_controller.dart';
import 'package:goproperti/controller/listofproperti_controller.dart';
import 'package:goproperti/controller/selectcountry_controller.dart';
import 'package:goproperti/controller/wallet_controller.dart';
import 'package:goproperti/model/fontfamily_model.dart';
import 'package:goproperti/screen/add%20proparty/addintro_screen.dart';
import 'package:goproperti/screen/add%20proparty/membarship_screen.dart';
// import 'package:goproperti/screen/bottomSearch.dart';
import 'package:goproperti/screen/favorite_screen.dart';
import 'package:goproperti/screen/home_screen.dart';
import 'package:goproperti/screen/login_screen.dart';
import 'package:goproperti/screen/near%20by%20map/map_screen.dart';
import 'package:goproperti/screen/profile_screen.dart';
import 'package:goproperti/utils/Dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottoBarScreen extends StatefulWidget {
  const BottoBarScreen({super.key});

  @override
  State<BottoBarScreen> createState() => _BottoBarScreenState();
}

late TabController tabController;

class _BottoBarScreenState extends State<BottoBarScreen>
    with TickerProviderStateMixin {
  WalletController walletController = Get.find();
  DashBoardController dashBoardController = Get.find();
  ListOfPropertiController listOfPropertiController = Get.find();
  SelectCountryController selectCountryController = Get.find();

  int _currentIndex = 0;

  var isLogin;

  List<Widget> myChilders = [
    HomeScreen(),
    MapScreen(),
    // BottomSearchScreen(),
    FavoriteScreen(),
    // MassageScreen(),
    ProfileScreen(),
  ];

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
    dashBoardController.getDashBoardData();
    isLogin = getData.read("UserLogin");
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: myChilders,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Color(0xff3D5BF6),
          onPressed: () {
            if (isLogin != null) {
              if (dashBoardController.dashBoardInfo?.isSubscribe == 1) {
                dashBoardController.getDashBoardData();
                listOfPropertiController.getPropertiList();
                selectCountryController.getCountryApi();
                Get.to(MembershipScreen());
              } else {
                selectCountryController.getCountryApi();
                Get.to(BoardingPage());
              }
            } else {
              Get.to(() => LoginScreen());
            }
          },
          child: Container(
            margin: EdgeInsets.all(15.0),
            child: Image.asset(
              "assets/images/bolt.png",
            ),
          ),
          elevation: 4.0,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: notifire.getbgcolor,
        child: TabBar(
          onTap: (index) {
            setState(() {});

            if (isLogin != null) {
              _currentIndex = index;
            } else {
              index != 0 ? Get.to(() => LoginScreen()) : const SizedBox();
            }
          },
          indicator: UnderlineTabIndicator(
            insets: EdgeInsets.only(bottom: 52),
            borderSide: BorderSide(color: notifire.getbgcolor, width: 2),
          ),
          labelColor: Colors.blueAccent,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Colors.grey,
          controller: tabController,
          padding: const EdgeInsets.symmetric(vertical: 6),
          tabs: [
            Tab(
              child: Column(
                children: [
                  // _currentIndex == 0
                  //     ?

                  Image.asset(
                    "assets/images/${_currentIndex == 0 ? "HomeBold.png" : "Home.png"}",
                    scale: 21,
                    color: _currentIndex == 0
                        ? Color(0xff3D5BF6)
                        : notifire.getwhiteblackcolor,
                  ),

                  // : Image.asset(
                  //     "assets/images/Home.png",
                  //     scale: 21,
                  //     color: notifire.getwhiteblackcolor,
                  //   ),

                  SizedBox(height: 3),

                  Text(
                    "Home".tr,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: FontFamily.gilroyMedium,
                      color:
                      _currentIndex == 0 ? Color(0xff3D5BF6) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: 80,
              alignment: getData.read("lCode") == "ar_IN"
                  ? Alignment.topRight
                  : Alignment.topLeft,
              child: Tab(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/${_currentIndex == 1 ? "mapbold.png" : "map.png"}",
                      scale: 3.7,
                      color: _currentIndex == 1
                          ? Color(0xff3D5BF6)
                          : notifire.getwhiteblackcolor,
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Nearby".tr,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.gilroyMedium,
                        color: _currentIndex == 1
                            ? Color(0xff3D5BF6)
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Container(
            //   height: 50,
            //   width: 80,
            //   alignment: Alignment.topLeft,
            //   child: Tab(
            //     child: Column(
            //       children: [
            //         Image.asset(
            //           "assets/images/Search.png",
            //           scale: 21,
            //           color: notifire.getwhiteblackcolor,
            //         ),
            //         Text(
            //           "Search".tr,
            //           style: TextStyle(
            //             fontSize: 10,
            //             fontFamily: FontFamily.gilroyMedium,
            //             color: _currentIndex == 1
            //                 ? Color(0xff3D5BF6)
            //                 : Colors.grey,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            Container(
              height: 50,
              width: 80,
              alignment: getData.read("lCode") == "ar_IN"
                  ? Alignment.topLeft
                  : Alignment.topRight,
              child: Tab(
                child: Column(
                  children: [
                    // _currentIndex == 2
                    //     ?

                    Image.asset(
                      "assets/images/${_currentIndex == 2 ? "heartBold.png" : "heartline.png"}",
                      scale: 21,
                      color: _currentIndex == 2
                          ? Color(0xff3D5BF6)
                          : notifire.getwhiteblackcolor,
                    ),

                    // : Image.asset(
                    //     "assets/images/heartline.png",
                    //     scale: 21,
                    //     color: notifire.getwhiteblackcolor,
                    //   ),

                    SizedBox(height: 3),

                    Text(
                      "Favorite".tr,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.gilroyMedium,
                        color: _currentIndex == 2
                            ? Color(0xff3D5BF6)
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Tab(
              child: Column(
                children: [
                  // _currentIndex == 3
                  //     ?
                  Image.asset(
                    "assets/images/${_currentIndex == 3 ? "userBold.png" : "userline.png"}",
                    scale: 21,
                    color: _currentIndex == 3
                        ? Color(0xff3D5BF6)
                        : notifire.getwhiteblackcolor,
                  ),
                  // : Image.asset(
                  //     "assets/images/userline.png",
                  //     scale: 21,
                  //     color: notifire.getwhiteblackcolor,
                  //   ),
                  SizedBox(height: 3),
                  Text(
                    "Account".tr,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: FontFamily.gilroyMedium,
                      color:
                      _currentIndex == 3 ? Color(0xff3D5BF6) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
