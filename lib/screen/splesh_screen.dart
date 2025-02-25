// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goproperti/Api/data_store.dart';
import 'package:goproperti/controller/homepage_controller.dart';
import 'package:goproperti/model/fontfamily_model.dart';
import 'package:goproperti/screen/bottombar_screen.dart';
import 'package:goproperti/screen/login_screen.dart';
import 'package:goproperti/screen/onbording_screen.dart';
import 'package:goproperti/utils/Dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_screens/onboardingscreen.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({super.key});

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
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
    setScreen();
    getData.remove("lCode");
    save("lanValue", 0);
    homePageController.getHomeDataApi(
      countryId: getData.read("countryId"),
    );
    homePageController.getCatWiseData(
      cId: "0",
      countryId: getData.read("countryId"),
    );
  }

  setScreen() async {
    final prefs = await SharedPreferences.getInstance();
    Timer(
        const Duration(seconds: 2),
        () => prefs.getBool('Firstuser') != true
            ? Navigator.pushReplacement(context,
                 MaterialPageRoute(builder: (context) => OnBordingScreen()))
                //MaterialPageRoute(builder: (context) => OnboardingScreen()))
            : prefs.getBool('Remember') != true
                ? Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()))
                : Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BottoBarScreen())));
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      //backgroundColor: notifire.getbgcolor,
     backgroundColor: Color(0xff48DBFB),
     // backgroundColor: Colors.orange,
      body:
      Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Get.height * 0.4),


              Center(
                  child:  Text("EVENT BRITE",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 35),),
                  //child: Image.asset("assets/images/applogo.png", height: 50)
              ),

             // SizedBox(height: Get.height * 0.03),

              // Text(
              //   "GoProperty".tr,
              //   style: TextStyle(
              //       fontSize: 24,
              //       color: Colors.blue,
              //       fontFamily: FontFamily.gilroyBold),
              // ),

             // SizedBox(height: Get.height * 0.03),

              // Text(
              //   "Manage your properties with ease and \nget instant alert about responses"
              //       .tr,
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //       fontSize: 16,
              //       color: Colors.blue,
              //       fontFamily: FontFamily.gilroyMedium),
              // ),
              // SizedBox(height: Get.height * 0.11),
            ],
          ),


          // Positioned(
          //     bottom: 0,
          //     child: Image.asset(
          //       "assets/images/spleshimage.png",
          //       height: Get.height * 0.5,
          //     )),
        ],
      ),
    );
  }
}
