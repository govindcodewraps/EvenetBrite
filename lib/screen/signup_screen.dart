// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:goproperti/controller/login_controller.dart';
import 'package:goproperti/controller/signup_controller.dart';
import 'package:goproperti/model/fontfamily_model.dart';
import 'package:goproperti/utils/Colors.dart';
import 'package:goproperti/utils/Custom_widget.dart';
import 'package:goproperti/utils/Dark_lightmode.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpController signUpController = Get.find();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String cuntryCode = "";

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

  bool isvalidate = false;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(18.0),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              'assets/images/back.png',
              color: notifire.getwhiteblackcolor,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.size.height,
            width: Get.size.width,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     Get.back();
                  //   },
                  //   child: Container(
                  //     height: 50,
                  //     width: 50,
                  //     alignment: Alignment.center,
                  //     padding: EdgeInsets.all(15),
                  //     margin: EdgeInsets.only(left: 10),
                  //     child: Image.asset(
                  //       'assets/images/back.png',
                  //       color: notifire.getwhiteblackcolor,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: notifire.getboxcolor,
                  //       shape: BoxShape.circle,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Get Started!".tr,
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: FontFamily.gilroyBold,
                        color: notifire.getwhiteblackcolor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Create an account to continue.".tr,
                      style: TextStyle(
                        fontFamily: FontFamily.gilroyMedium,
                        color: notifire.getwhiteblackcolor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: signUpController.name,
                      cursorColor: notifire.getwhiteblackcolor,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: notifire.getwhiteblackcolor,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: blueColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: notifire.getborderColor,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: notifire.getborderColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            "assets/images/user.png",
                            height: 10,
                            width: 10,
                            color: notifire.getgreycolor,
                          ),
                        ),
                        labelText: "Full Name".tr,
                        labelStyle: TextStyle(
                          color: notifire.getgreycolor,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: signUpController.email,
                      cursorColor: notifire.getwhiteblackcolor,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: notifire.getwhiteblackcolor,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: blueColor),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: notifire.getborderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: notifire.getborderColor,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            "assets/images/email.png",
                            height: 10,
                            width: 10,
                            color: notifire.getgreycolor,
                          ),
                        ),
                        labelText: "Email Address".tr,
                        labelStyle: TextStyle(
                          color: notifire.getgreycolor,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: IntlPhoneField(
                      disableLengthCheck: true,
                      keyboardType: TextInputType.number,
                      cursorColor: notifire.getwhiteblackcolor,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: signUpController.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      dropdownIcon: Icon(
                        Icons.arrow_drop_down,
                        color: notifire.getgreycolor,
                      ),
                      dropdownTextStyle: TextStyle(
                        color: notifire.getgreycolor,
                      ),
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: notifire.getwhiteblackcolor,
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (signUpController.number.text.isNotEmpty) {
                            isvalidate = false;
                          } else {
                            isvalidate = true;
                          }
                        });
                        cuntryCode = value.countryCode;
                      },
                      onCountryChanged: (value) {
                        signUpController.number.text = '';
                      },
                      decoration: InputDecoration(
                        helperText: null,
                        labelText: "Mobile Number".tr,
                        labelStyle: TextStyle(
                          color: notifire.getgreycolor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: isvalidate ? Colors.red.shade700 : blueColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isvalidate
                                ? Colors.red.shade700
                                : notifire.getborderColor,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isvalidate
                                ? Colors.red.shade700
                                : notifire.getborderColor,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (p0) {
                        if (p0!.completeNumber.isEmpty) {
                          return 'Please enter your number'.tr;
                        } else {}
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GetBuilder<SignUpController>(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: signUpController.password,
                        obscureText: signUpController.showPassword,
                        cursorColor: notifire.getwhiteblackcolor,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: notifire.getwhiteblackcolor,
                        ),
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: blueColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: notifire.getborderColor,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: notifire.getborderColor,
                            ),
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              signUpController.showOfPassword();
                            },
                            child: !signUpController.showPassword
                                ? Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset(
                                      "assets/images/showpassowrd.png",
                                      height: 10,
                                      width: 10,
                                      color: notifire.getgreycolor,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset(
                                      "assets/images/HidePassword.png",
                                      height: 10,
                                      width: 10,
                                      color: notifire.getgreycolor,
                                    ),
                                  ),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              "assets/images/Unlock.png",
                              height: 10,
                              width: 10,
                              color: notifire.getgreycolor,
                            ),
                          ),
                          labelText: "Password".tr,
                          labelStyle: TextStyle(
                            color: notifire.getgreycolor,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password'.tr;
                          }
                          return null;
                        },
                      ),
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: signUpController.referralCode,
                      cursorColor: notifire.getwhiteblackcolor,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: notifire.getwhiteblackcolor,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: blueColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: notifire.getborderColor,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: notifire.getborderColor,
                          ),
                        ),
                        labelText: "Referral code (optional)".tr,
                        labelStyle: TextStyle(
                          color: notifire.getgreycolor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GetBuilder<SignUpController>(builder: (context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Transform.scale(
                          scale: 1,
                          child: Checkbox(
                            value: signUpController.chack,
                            side: const BorderSide(color: Color(0xffC5CAD4)),
                            activeColor: blueColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onChanged: (newbool) async {
                              signUpController.checkTermsAndCondition(newbool);
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool('Remember', true);
                            },
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "By creating an account,you agree to our".tr,
                              style: TextStyle(
                                fontSize: 12,
                                color: notifire.getgreycolor,
                                fontFamily: FontFamily.gilroyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              "Terms and Condition".tr,
                              style: TextStyle(
                                fontSize: 12,
                                color: blueColor,
                                fontFamily: FontFamily.gilroyBold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  }),
                  GestButton(
                    Width: Get.size.width,
                    height: 50,
                    buttoncolor: blueColor,
                    margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                    buttontext: "Continue".tr,
                    style: TextStyle(
                      fontFamily: FontFamily.gilroyBold,
                      color: WhiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    onclick: () {
                      setState(() {
                        if (signUpController.number.text.isNotEmpty) {
                          isvalidate = false;
                        } else {
                          isvalidate = true;
                        }
                      });
                      if ((_formKey.currentState?.validate() ?? false) &&
                          (signUpController.chack == true)) {
                        signUpController.checkMobileNumber(cuntryCode);

                        // signUpController.setUserApiData(cuntryCode);
                        // sendOTP(signUpController.number.text, cuntryCode);
                        // Get.toNamed(Routes.otpScreen, arguments: {
                        //   "number": signUpController.number.text,
                        //   "cuntryCode": cuntryCode,
                        //   "route": "signUpScreen",
                        // });
                      } else {
                        if (signUpController.chack == false) {
                          showToastMessage(
                              "Please select Terms and Condition".tr);
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyMedium,
                            color: notifire.getgreycolor,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(LoginController());
                          },
                          child: Text(
                            "Login".tr,
                            style: TextStyle(
                              color: blueColor,
                              fontFamily: FontFamily.gilroyBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
