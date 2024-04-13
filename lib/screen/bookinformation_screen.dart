// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, prefer_interpolation_to_compose_strings, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:goproperti/controller/bookrealestate_controller.dart';
import 'package:goproperti/controller/reviewsummary_controller.dart';
import 'package:goproperti/model/fontfamily_model.dart';
import 'package:goproperti/model/routes_helper.dart';
import 'package:goproperti/utils/Colors.dart';
import 'package:goproperti/utils/Custom_widget.dart';
import 'package:goproperti/utils/Dark_lightmode.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> list = ["Male", "Female"];
List<String> countryList = ["United State", "India", "New York", "Japan"];

class BookInformetionScreen extends StatefulWidget {
  const BookInformetionScreen({super.key});

  @override
  State<BookInformetionScreen> createState() => _BookInformetionScreenState();
}

class _BookInformetionScreenState extends State<BookInformetionScreen> {
  BookrealEstateController bookrealEstateController = Get.find();
  ReviewSummaryController reviewSummaryController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // TextEditingController fname = TextEditingController();
  // TextEditingController lname = TextEditingController();
  // TextEditingController email = TextEditingController();
  // TextEditingController number = TextEditingController();

  List listOfUser = [];

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

  String selectValue = list.first;
  String selectCountry = countryList.first;
  String cuntryCode = "";

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
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
          "Book For Someone".tr,
          style: TextStyle(
            fontSize: 17,
            fontFamily: FontFamily.gilroyBold,
            color: notifire.getwhiteblackcolor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Your Information Details".tr,
                  style: TextStyle(
                    color: notifire.getwhiteblackcolor,
                    fontFamily: FontFamily.gilroyBold,
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: reviewSummaryController.firstName,
                  cursorColor: notifire.getwhiteblackcolor,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14,
                    color: notifire.getwhiteblackcolor,
                  ),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: blueColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: notifire.getborderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: notifire.getborderColor),
                      ),
                      hintText: "First Name".tr,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name'.tr;
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
                  controller: reviewSummaryController.lastName,
                  cursorColor: notifire.getwhiteblackcolor,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14,
                    color: notifire.getwhiteblackcolor,
                  ),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: blueColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: notifire.getborderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: notifire.getborderColor),
                      ),
                      hintText: "Last Name".tr,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name'.tr;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: Get.size.width,
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.only(left: 15, right: 15),
                child: DropdownButton(
                  value: selectValue,
                  dropdownColor: notifire.getbgcolor,
                  icon: Image.asset(
                    'assets/images/Arrow - Down.png',
                    height: 20,
                    width: 20,
                    color: notifire.getwhiteblackcolor,
                  ),
                  isExpanded: true,
                  underline: SizedBox.shrink(),
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontFamily: FontFamily.gilroyMedium,
                          color: notifire.getwhiteblackcolor,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectValue = value ?? "";
                      listOfUser.add(selectValue);
                    });
                  },
                ),
                decoration: BoxDecoration(
                  // color: notifire.getblackwhitecolor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: notifire.getborderColor),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Container(
              //   height: 50,
              //   width: Get.size.width,
              //   margin: EdgeInsets.symmetric(horizontal: 15),
              //   child: Row(
              //     children: [
              //       SizedBox(
              //         width: 15,
              //       ),
              //       Text(
              //         bookrealEstateController.checkOut,
              //         style: TextStyle(
              //           color: notifire.getwhiteblackcolor,
              //           fontFamily: FontFamily.gilroyMedium,
              //         ),
              //       ),
              //       Spacer(),
              //       Image.asset(
              //         "assets/images/Calendar.png",
              //         height: 25,
              //         width: 25,
              //         color: notifire.getwhiteblackcolor,
              //       ),
              //       SizedBox(
              //         width: 10,
              //       ),
              //     ],
              //   ),
              //   decoration: BoxDecoration(
              //     color: notifire.getblackwhitecolor,
              //     borderRadius: BorderRadius.circular(15),
              //     border: Border.all(color: Colors.grey.shade100),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: reviewSummaryController.gmail,
                  cursorColor: notifire.getwhiteblackcolor,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14,
                    color: notifire.getwhiteblackcolor,
                  ),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: blueColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: notifire.getborderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: notifire.getborderColor),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          "assets/images/email.png",
                          height: 10,
                          width: 10,
                          color: notifire.getwhiteblackcolor,
                        ),
                      ),
                      hintText: "Email".tr,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      )),
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
                  controller: reviewSummaryController.mobile,
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
                    color: notifire.getwhiteblackcolor,
                  ),
                  onChanged: (value) {
                    cuntryCode = value.countryCode;
                  },
                  onCountryChanged: (value) {
                    reviewSummaryController.mobile.text = '';
                  },
                  decoration: InputDecoration(
                    helperText: null,
                    hintText: "Mobile Number".tr,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: blueColor,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: notifire.getborderColor,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: notifire.getborderColor,
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
                height: 10,
              ),
              // Container(
              //   height: 50,
              //   width: Get.size.width,
              //   margin: EdgeInsets.symmetric(horizontal: 15),
              //   padding: EdgeInsets.only(left: 15, right: 15),
              //   child: DropdownButton(
              //     value: selectCountry,
              //     icon: Image.asset(
              //       'assets/images/Arrow - Down.png',
              //       height: 20,
              //       width: 20,
              //     ),
              //     isExpanded: true,
              //     underline: SizedBox.shrink(),
              //     items:
              //         countryList.map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(
              //           value,
              //           style: TextStyle(
              //             fontFamily: FontFamily.gilroyMedium,
              //             color: notifire.getwhiteblackcolor,
              //             fontSize: 16,
              //           ),
              //         ),
              //       );
              //     }).toList(),
              //     onChanged: (value) {
              //       setState(() {
              //         selectCountry = value ?? "";
              //         listOfUser.add(selectCountry);
              //       });
              //     },
              //   ),
              //   decoration: BoxDecoration(
              //     color: notifire.getblackwhitecolor,
              //     borderRadius: BorderRadius.circular(15),
              //     border: Border.all(color: Colors.grey.shade100),
              //   ),
              // ),
              SizedBox(
                height: 50,
              ),
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
                  if (_formKey.currentState?.validate() ?? false) {
                    Get.toNamed(Routes.reviewSummaryScreen, arguments: {
                      "copAmt": 0,
                      "fname": reviewSummaryController.firstName.text,
                      "lname": reviewSummaryController.lastName.text,
                      "gender": selectValue,
                      "email": reviewSummaryController.gmail.text,
                      "mobile": reviewSummaryController.mobile.text,
                      "ccode": cuntryCode,
                      // "country": selectCountry,
                      "couponCode": "",
                    });
                  } else {
                    showToastMessage("Please fill all required fields".tr);
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
