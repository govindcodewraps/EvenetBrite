// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, unused_local_variable, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, avoid_print, unnecessary_string_interpolations, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:goproperti/Api/config.dart';
import 'package:goproperti/Api/data_store.dart';
import 'package:goproperti/controller/bookrealestate_controller.dart';
import 'package:goproperti/controller/coupon_controller.dart';
import 'package:goproperti/controller/homepage_controller.dart';
import 'package:goproperti/controller/login_controller.dart';
import 'package:goproperti/controller/reviewsummary_controller.dart';
import 'package:goproperti/controller/wallet_controller.dart';
import 'package:goproperti/model/fontfamily_model.dart';
import 'package:goproperti/model/routes_helper.dart';
import 'package:goproperti/screen/home_screen.dart';
import 'package:goproperti/screen/payment/FlutterWave.dart';
import 'package:goproperti/screen/payment/InputFormater.dart';
import 'package:goproperti/screen/payment/PaymentCard.dart';
import 'package:goproperti/screen/payment/Paytm.dart';
import 'package:goproperti/screen/payment/StripeWeb.dart';
import 'package:goproperti/screen/paypal/flutter_paypal.dart';
import 'package:goproperti/utils/Colors.dart';
import 'package:goproperti/utils/Custom_widget.dart';
import 'package:goproperti/utils/Dark_lightmode.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewSummaryScreen extends StatefulWidget {
  ReviewSummaryScreen({super.key});

  @override
  State<ReviewSummaryScreen> createState() => _ReviewSummaryScreenState();
}

class _ReviewSummaryScreenState extends State<ReviewSummaryScreen> {
  BookrealEstateController bookrealEstateController = Get.find();

  ReviewSummaryController reviewSummaryController = Get.find();
  CouponController couponController = Get.find();
  WalletController walletController = Get.find();
  HomePageController homePageController = Get.find();
  LoginController loginController = Get.find();

  int copAmt = Get.arguments["copAmt"];
  String fname = Get.arguments["fname"];
  String lname = Get.arguments["lname"];
  String gender = Get.arguments["gender"];
  String email = Get.arguments["email"];
  String mobile = Get.arguments["mobile"];
  String ccode = Get.arguments["ccode"];

  // String country = Get.arguments["country"];
  String couponCode = Get.arguments["couponCode"];

  var tempWallet = 0.0;
  dynamic totalprice = 0.00;
  dynamic currentTotalprice = 0.00;
  bool? status;
  var useWallet = 0.0;
  String wallet = "";
  dynamic tex = 0.00;

  late Razorpay _razorpay;

  //final plugin = PaystackPlugin();

  int? _value = 0;
  int curretnIndex = 0;
  int? _groupValue;

  int price = 0;

  String? selectidPay = "0";
  String razorpaykey = "";
  String? paymenttital;
  String formattedDate = "";

  bool? checkLogin;

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
    print("-------------============${fname}");
    print("-------------============${mobile}");

    couponController.couponMsg = "";
    checkLoginOrContinue();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    price = int.parse(reviewSummaryController.pPrice);
    setState(() {
      totalprice = double.parse(
          (price * 2).toString());
      wallet = homePageController.homeDatatInfo?.homeData.wallet ?? "";
      tex = double.parse("${(totalprice * walletController.tex / 100)}");
      currentTotalprice = (totalprice);
      print("£££££££@@@@@@@" + tex.toString());

      tempWallet =
          double.parse(homePageController.homeDatatInfo?.homeData.wallet ?? "");
    });
    setState(() {
      var now = DateTime.now();
      var formatter = DateFormat('dd/MM/yyyy');
      formattedDate = formatter.format(now);
      print(formattedDate);
    });
  }

  checkLoginOrContinue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      print(homePageController.currentIndex);

      checkLogin = prefs.getBool('Firstuser') ?? false;
    });
  }

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
          "Review Summary".tr,
          style: TextStyle(
            fontSize: 17,
            fontFamily: FontFamily.gilroyBold,
            color: notifire.getwhiteblackcolor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: GetBuilder<WalletController>(builder: (context) {
          return GetBuilder<HomePageController>(builder: (context) {
            return GetBuilder<BookrealEstateController>(builder: (context) {
              // String tex = "${(totalprice * walletController.tex / 100)}";

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                                child: Image.network(
                                  "${Config.imageUrl}${reviewSummaryController.pImage}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            Positioned(
                              top: 15,
                              right: 20,
                              child: Container(
                                height: 20,
                                width: 45,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 12,
                                      color: yelloColor,
                                    ),
                                    Text(
                                      "${homePageController.rate.toString()}",
                                      style: TextStyle(
                                        fontFamily: FontFamily.gilroyMedium,
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
                                        reviewSummaryController.pTitle,
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
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      reviewSummaryController.pCity,
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
                                        "${currency}${price}",
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
                  Container(
                    // height: 140,
                    width: Get.size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Booking Date".tr,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyMedium,
                                fontSize: 15,
                                color: notifire.getwhiteblackcolor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 15,
                                color: notifire.getwhiteblackcolor,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Check in".tr,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyMedium,
                                fontSize: 15,
                                color: notifire.getwhiteblackcolor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              bookrealEstateController.checkIn,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 15,
                                color: notifire.getwhiteblackcolor,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Check out".tr,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyMedium,
                                fontSize: 15,
                                color: notifire.getwhiteblackcolor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              bookrealEstateController.checkOut,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 15,
                                color: notifire.getwhiteblackcolor,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Number of Guest".tr,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyMedium,
                                fontSize: 15,
                                color: notifire.getwhiteblackcolor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${bookrealEstateController.count}",
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 15,
                                color: notifire.getwhiteblackcolor,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: notifire.getblackwhitecolor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  //! --------Coupon-------//
                  Visibility(
                    visible: checkLogin ?? true,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 15),
                            child: Text(
                              "Coupon".tr,
                              style: TextStyle(
                                color: notifire.getwhiteblackcolor,
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 60,
                            width: Get.size.width,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Image.asset(
                                  'assets/images/coupon.png',
                                  height: 25,
                                  width: 25,
                                  color: notifire.getgreycolor,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  couponCode != ""
                                      ? couponCode
                                      : 'Coupon code'.tr,
                                  style: TextStyle(
                                    color: couponCode != ""
                                        ? notifire.getwhiteblackcolor
                                        : notifire.getgreycolor,
                                    fontFamily: FontFamily.gilroyMedium,
                                    fontSize: 15,
                                  ),
                                ),
                                Spacer(),
                                couponCode != ""
                                    ? InkWell(
                                        onTap: () {
                                          status = false;
                                          copAmt = 0;
                                          couponCode = "";
                                          couponController.couponMsg = "";
                                          tempWallet =
                                              double.parse(wallet.toString());
                                          currentTotalprice = valuePlus(
                                              currentTotalprice, useWallet);
                                          useWallet = 0;
                                          currentTotalprice = 0;
                                          currentTotalprice =
                                              double.parse((price).toString());
                                          setState(() {});
                                        },
                                        child: Text(
                                          "Remove".tr,
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 16,
                                            color: RedColor,
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          couponController.getCouponDataApi();
                                          Get.toNamed(Routes.couponsScreen,
                                              arguments: {
                                                "price":
                                                    "${price}",
                                              });
                                        },
                                        child: Text(
                                          "Add".tr,
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 16,
                                            color: blueColor,
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: notifire.getblackwhitecolor,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: notifire.getblackwhitecolor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GetBuilder<CouponController>(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: couponController.isLodding
                          ? Text(
                              couponController.couponMsg,
                              style: TextStyle(
                                color: blueColor,
                                fontFamily: FontFamily.gilroyMedium,
                                fontSize: 16,
                              ),
                            )
                          : Text(""),
                    );
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  //! -------Wallet-------//
                  checkLogin == true && wallet != "0"
                      ? walletDetail()
                      : SizedBox(),
                  Container(
                    // height: 185,
                    width: Get.size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "${"Amount".tr} (${"days".tr})",
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyMedium,
                                fontSize: 15,
                                color: notifire.getwhiteblackcolor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${currency}${(price )}",
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 15,
                                color: notifire.getwhiteblackcolor,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "${"Tax".tr}(${walletController.tex}%)",
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyMedium,
                                fontSize: 15,
                                color: notifire.getwhiteblackcolor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${currency}${tex}",
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 15,
                                color: notifire.getwhiteblackcolor,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        copAmt != 0
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Coupon".tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyMedium,
                                      fontSize: 15,
                                      color: notifire.getwhiteblackcolor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${currency}${copAmt}",
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      fontSize: 15,
                                      color: Color(0xFF08E761),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 15,
                        ),
                        Visibility(
                          visible: status ?? false,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Wallet".tr,
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyMedium,
                                  fontSize: 15,
                                  color: notifire.getwhiteblackcolor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${currency}${0}",
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyBold,
                                  fontSize: 15,
                                  color: Color(0xFF08E761),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Total".tr,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyMedium,
                                fontSize: 15,
                                color: notifire.getwhiteblackcolor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              // "${currency}${(price * bookrealEstateController.days.length + walletController.tex - copAmt)}.00",
                              "${currency}${currentTotalprice}",
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 15,
                                color: notifire.getwhiteblackcolor,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: notifire.getblackwhitecolor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestButton(
                    Width: Get.size.width,
                    height: 50,
                    buttoncolor: blueColor,
                    margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                    buttontext: checkLogin == true ? "Continue".tr : "Login".tr,
                    style: TextStyle(
                      fontFamily: FontFamily.gilroyBold,
                      color: WhiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    onclick: () {
                      if (checkLogin == true) {
                        if (status == true) {
                          if (double.parse(currentTotalprice.toString()) > 0) {
                            paymentSheett();
                          } else {
                            bookApiData("0");
                          }
                        } else {
                          paymentSheett();
                        }
                      } else {
                        Get.toNamed(Routes.login);
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            });
          });
        }),
      ),
    );
  }

  walletCalculation(value) {
    if (value == true) {
      if (double.parse(wallet.toString()) <
          double.parse(currentTotalprice.toString())) {
        tempWallet = double.parse(currentTotalprice.toString()) -
            double.parse(wallet.toString());

        useWallet = double.parse(wallet.toString());
        currentTotalprice = (double.parse(currentTotalprice.toString()) -
                double.parse(wallet.toString()))
            .toString();
        tempWallet = 0;
        setState(() {});
      } else {
        tempWallet = double.parse(wallet.toString()) -
            double.parse(currentTotalprice.toString());
        useWallet = double.parse(wallet.toString()) - tempWallet;
        currentTotalprice = 0;
      }
    } else {
      tempWallet = double.parse(wallet.toString());
      currentTotalprice = valuePlus(currentTotalprice, useWallet);
      useWallet = 0;
      setState(() {});
    }
  }

  valuePlus(first, second) {
    return (double.parse(first.toString()) + double.parse(second.toString()))
        .toStringAsFixed(2);
  }

  Widget walletDetail() {
    return wallet != "0"
        ? Container(
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200, width: 1)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pay from Wallet".tr,
                    style: TextStyle(
                        fontSize: 16,
                        color: notifire.getwhiteblackcolor,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Text("Wallet Balance".tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: notifire.getwhiteblackcolor,
                      )),
                  SizedBox(height: Get.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(height: Get.height * 0.01),
                          Text("Available for Payment ".tr,
                              style: TextStyle(color: greycolor)),
                          Text(
                            "$currency${tempWallet.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: notifire.getwhiteblackcolor,
                            ),
                          ),
                        ],
                      ),
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          activeColor: blueColor,
                          value: status ?? false,
                          onChanged: (value) {
                            setState(() {});
                            status = value;
                            walletCalculation(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : SizedBox();
  }

  Future congratiulationDialog() {
    return Get.defaultDialog(
      title: "",
      content: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          height: 460,
          width: Get.size.width,
          child: Column(
            children: [
              Image.asset(
                "assets/images/payment.png",
                height: 150,
                width: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Congratulations!".tr,
                  style: TextStyle(
                    color: blueColor,
                    fontFamily: FontFamily.gilroyBold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Successfully\n booked. You can chack your booking\n on the menu Profile"
                    .tr,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: FontFamily.gilroyMedium,
                  color: notifire.getwhiteblackcolor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  couponCode = "";
                  couponController.couponMsg = "";
                  homePageController.getHomeDataApi(
                    countryId: getData.read("countryId"),
                  );
                  homePageController.getCatWiseData(
                    cId: "0",
                    countryId: getData.read("countryId"),
                  );
                  reviewSummaryController.cleanOtherDetails();
                  Get.back();
                  Get.offAndToNamed(Routes.mybookingScreen);
                  save("backHome", true);
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: Text(
                    "View E-Receipt".tr,
                    style: TextStyle(
                      color: WhiteColor,
                      fontFamily: FontFamily.gilroyBold,
                      fontSize: 16,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: blueColor,
                    borderRadius: BorderRadius.circular(45),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  couponCode = "";
                  couponController.couponMsg = "";
                  homePageController.getHomeDataApi(
                    countryId: getData.read("countryId"),
                  );
                  homePageController.getCatWiseData(
                    cId: "0",
                    countryId: getData.read("countryId"),
                  );
                  reviewSummaryController.cleanOtherDetails();
                  Get.back();
                  Get.offAllNamed(Routes.bottoBarScreen);
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: Text(
                    "Cancle".tr,
                    style: TextStyle(
                      color: blueColor,
                      fontFamily: FontFamily.gilroyBold,
                      fontSize: 16,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFeef4ff),
                    borderRadius: BorderRadius.circular(45),
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: notifire.getblackwhitecolor,
          ),
        ),
      ),
    );
  }

  Widget sugestlocationtype(
      {Function()? ontap,
      title,
      val,
      image,
      adress,
      radio,
      Color? borderColor,
      Color? titleColor}) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return InkWell(
        splashColor: Colors.transparent,
        onTap: ontap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 18),
          child: Container(
            height: Get.height / 10,
            decoration: BoxDecoration(
                border: Border.all(color: borderColor!, width: 1),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(11)),
            child: Row(
              children: [
                SizedBox(width: Get.width / 55),
                Container(
                    height: Get.height / 12,
                    width: Get.width / 5.5,
                    decoration: BoxDecoration(
                        color: const Color(0xffF2F4F9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: FadeInImage(
                          placeholder:
                              const AssetImage("assets/images/loading2.gif"),
                          image: NetworkImage(image)),
                      // Image.network(image, height: Get.height / 08)
                    )),
                SizedBox(width: Get.width / 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.01),
                    Text(title,
                        style: TextStyle(
                          fontSize: Get.height / 55,
                          fontFamily: 'Gilroy_Bold',
                          color: titleColor,
                        )),
                    SizedBox(
                      width: Get.width * 0.50,
                      child: Text(adress,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: Get.height / 65,
                              fontFamily: 'Gilroy_Medium',
                              color: Colors.grey)),
                    ),
                  ],
                ),
                const Spacer(),
                radio
              ],
            ),
          ),
        ),
      );
    });
  }

  //!-------- PaymentSheet --------//
  Future paymentSheett() {
    return showModalBottomSheet(
      backgroundColor: notifire.getbgcolor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return Wrap(children: [
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Center(
                  child: Container(
                    height: Get.height / 80,
                    width: Get.width / 5,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
                SizedBox(height: Get.height / 50),
                Row(children: [
                  SizedBox(width: Get.width / 14),
                  Text("Select Payment Method".tr,
                      style: TextStyle(
                          color: notifire.getwhiteblackcolor,
                          fontSize: Get.height / 40,
                          fontFamily: 'Gilroy_Bold')),
                ]),
                SizedBox(height: Get.height / 50),
                //! --------- List view paymente ----------
                SizedBox(
                  height: Get.height * 0.50,
                  child:
                      GetBuilder<ReviewSummaryController>(builder: (context) {
                    return reviewSummaryController.isLodding
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: reviewSummaryController
                                .paymentInfo?.paymentdata.length,
                            itemBuilder: (ctx, i) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: sugestlocationtype(
                                  borderColor: selectidPay ==
                                          reviewSummaryController
                                              .paymentInfo?.paymentdata[i].id
                                      ? buttonColor
                                      : const Color(0xffD6D6D6),
                                  title: reviewSummaryController
                                          .paymentInfo?.paymentdata[i].title ??
                                      "",
                                  titleColor: notifire.getwhiteblackcolor,
                                  val: 0,
                                  image: Config.imageUrl +
                                      reviewSummaryController
                                          .paymentInfo!.paymentdata[i].img,
                                  adress: reviewSummaryController.paymentInfo
                                          ?.paymentdata[i].subtitle ??
                                      "",
                                  ontap: () async {
                                    setState(() {
                                      razorpaykey = reviewSummaryController
                                          .paymentInfo!
                                          .paymentdata[i]
                                          .attributes;
                                      paymenttital = reviewSummaryController
                                          .paymentInfo!.paymentdata[i].title;
                                      selectidPay = reviewSummaryController
                                              .paymentInfo?.paymentdata[i].id ??
                                          "";
                                      _groupValue = i;
                                    });
                                  },
                                  radio: Radio(
                                    activeColor: buttonColor,
                                    value: i,
                                    groupValue: _groupValue,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  }),
                ),
                Container(
                  height: 80,
                  width: Get.size.width,
                  alignment: Alignment.center,
                  child: GestButton(
                    Width: Get.size.width,
                    height: 50,
                    buttoncolor: blueColor,
                    margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                    buttontext: "Continue".tr,
                    style: TextStyle(
                      fontFamily: FontFamily.gilroyBold,
                      color: WhiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    onclick: () async {
                      //!---- Stripe Payment ------
                      if (paymenttital == "Razorpay") {
                        Get.back();
                        openCheckout();
                      } else if (paymenttital == "Pay TO Owner") {
                        bookApiData("0");
                      } else if (paymenttital == "Paypal") {
                        List<String> keyList = razorpaykey.split(",");
                        paypalPayment(
                          currentTotalprice.toString(),
                          keyList[0],
                          keyList[1],
                        );
                      } else if (paymenttital == "Stripe") {
                        Get.back();
                        stripePayment();
                      } else if (paymenttital == "PayStack") {
                        String key = razorpaykey.split(",").first;
                       // await plugin.initialize(publicKey: key);
                  /*      chargeCard(
                          currentTotalprice,
                          getData.read("UserLogin")["email"],
                        );*/
                      } else if (paymenttital == "FlutterWave") {
                        Get.to(() => Flutterwave(
                                  totalAmount: currentTotalprice.toString(),
                                  email: getData
                                      .read("UserLogin")["email"]
                                      .toString(),
                                ))!
                            .then((otid) {
                          if (otid != null) {
                            bookApiData(otid);
                          } else {
                            Get.back();
                          }
                        });
                      } else if (paymenttital == "Paytm") {
                        Get.to(() => PayTmPayment(
                                  totalAmount: currentTotalprice.toString(),
                                  uid: getData
                                      .read("UserLogin")["id"]
                                      .toString(),
                                ))!
                            .then((otid) {
                          if (otid != null) {
                            bookApiData(otid);
                          } else {
                            Get.back();
                          }
                        });
                      } else if (paymenttital == "SenangPay") {
                        print(paymenttital.toString());
                      }
                    },
                  ),
                  decoration: BoxDecoration(
                    color: notifire.getblackwhitecolor,
                  ),
                ),
              ],
            );
          }),
        ]);
      },
    );
  }

  @override
  void dispose() {
    numberController.removeListener(_getCardTypeFrmNumber);
    numberController.dispose();
    _razorpay.clear();
    super.dispose();
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardTypee cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      _paymentCard.type = cardType;
    });
  }

  //!-------- Razorpay ----------//
  void openCheckout() async {
    var username = getData.read("UserLogin")["name"] ?? "";
    var mobile = getData.read("UserLogin")["mobile"] ?? "";
    var email = getData.read("UserLogin")["email"] ?? "";
    var options = {
      'key': razorpaykey,
      'amount': (double.parse(currentTotalprice.toString()) * 100).toString(),
      'name': username,
      'description': "",
      'timeout': 300,
      'prefill': {'contact': mobile, 'email': email},
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // bookNowOrder(response.paymentId);
    bookApiData(response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(
        'Error Response: ${"ERROR: " + response.code.toString() + " - " + response.message!}');
    showToastMessage(response.message!);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showToastMessage(response.walletName!);
  }

  paypalPayment(
    String amt,
    String key,
    String secretKey,
  ) {
    print("----------->>" + key.toString());
    print("----------->>" + secretKey.toString());
    Get.back();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return UsePaypal(
            sandboxMode: true,
            clientId: key,
            secretKey: secretKey,
            returnURL:
                "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=EC-35S7886705514393E",
            cancelURL: Config.paymentBaseUrl + "restate/paypal/cancle.php",
            transactions: [
              {
                "amount": {
                  "total": amt,
                  "currency": "USD",
                  "details": {
                    "subtotal": amt,
                    "shipping": '0',
                    "shipping_discount": 0
                  }
                },
                "description": "The payment transaction description.",
                // "payment_options": {
                //   "allowed_payment_method":
                //       "INSTANT_FUNDING_SOURCE"
                // },
                "item_list": {
                  "items": [
                    {
                      "name": "A demo product",
                      "quantity": 1,
                      "price": amt,
                      "currency": "USD"
                    }
                  ],
                  // shipping address is not required though
                  // "shipping_address": {
                  //   "recipient_name": "Jane Foster",
                  //   "line1": "Travis County",
                  //   "line2": "",
                  //   "city": "Austin",
                  //   "country_code": "US",
                  //   "postal_code": "73301",
                  //   "phone": "+00000000",
                  //   "state": "Texas"
                  // },
                }
              }
            ],
            note: "Contact us for any questions on your order.",
            onSuccess: (Map params) {
              Get.back();
              bookApiData(params["paymentId"].toString());
              congratiulationDialog();
            },
            onError: (error) {
              showToastMessage(error.toString());
            },
            onCancel: (params) {
              showToastMessage(params.toString());
            },
          );
        },
      ),
    );
  }

  //!-------- bookOrderApi ----------//
  bookApiData(otid) {
    bookrealEstateController.bookApiData(
      pid: reviewSummaryController.id,
      subtotal:
          (price * bookrealEstateController.days.length - copAmt).toString(),
      total: currentTotalprice.toString(),
      totalDays: bookrealEstateController.days.length.toString(),
      couAmt: copAmt.toString(),
      wallAmt: useWallet.toString(),
      transactionId: otid,
      addNote: reviewSummaryController.note.text,
      propPrice: price.toString(),
      bookFor: bookrealEstateController.chack ? 'other' : 'self',
      pMethodId: double.parse(currentTotalprice.toString()) > 0
          ? selectidPay.toString()
          : "5",
      tex: tex.toString(),
      fname: fname,
      lname: lname,
      gender: gender,
      email: email,
      mobile: mobile,
      ccode: ccode,
      country: "",
      noGuest: bookrealEstateController.count.toString(),
    );
    congratiulationDialog();
    showToastMessage("Payment Successfully");
  }

  //!-------- PayStack ----------//

  String _getReference() {
    var platform = (Platform.isIOS) ? 'iOS' : 'Android';
    final thisDate = DateTime.now().millisecondsSinceEpoch;
    return 'ChargedFrom${platform}_$thisDate';
  }

  /*chargeCard(int amount, String email) async {
    Get.back();
    var charge = Charge()
      ..amount = amount * 100
      ..reference = _getReference()
      ..putCustomField(
        'custom_id',
        '846gey6w',
      ) //to pass extra parameters to be retrieved on the response from Paystack
      ..email = email;

    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );
    if (response.status == true) {
      bookApiData(response.reference);
    } else {
      showToastMessage('Payment Failed!!!'.tr);
    }
  }*/

  //!-------- Stripe Patment --------//

  final _formKey = GlobalKey<FormState>();
  var numberController = TextEditingController();
  final _paymentCard = PaymentCardCreated();
  var _autoValidateMode = AutovalidateMode.disabled;
  bool isloading = false;

  final _card = PaymentCardCreated();

  stripePayment() {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: notifire.getbgcolor,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Ink(
                child: Column(
                  children: [
                    SizedBox(height: Get.height / 45),
                    Center(
                      child: Container(
                        height: Get.height / 85,
                        width: Get.width / 5,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height * 0.03),
                          Text("Add Your payment information".tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 0.5)),
                          SizedBox(height: Get.height * 0.02),
                          Form(
                            key: _formKey,
                            autovalidateMode: _autoValidateMode,
                            child: Column(
                              children: [
                                const SizedBox(height: 16),
                                TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(19),
                                    CardNumberInputFormatter()
                                  ],
                                  controller: numberController,
                                  onSaved: (String? value) {
                                    _paymentCard.number =
                                        CardUtils.getCleanedNumber(value!);

                                    CardTypee cardType =
                                        CardUtils.getCardTypeFrmNumber(
                                            _paymentCard.number.toString());
                                    setState(() {
                                      _card.name = cardType.toString();
                                      _paymentCard.type = cardType;
                                    });
                                  },
                                  onChanged: (val) {
                                    CardTypee cardType =
                                        CardUtils.getCardTypeFrmNumber(val);
                                    setState(() {
                                      _card.name = cardType.toString();
                                      _paymentCard.type = cardType;
                                    });
                                  },
                                  validator: CardUtils.validateCardNum,
                                  decoration: InputDecoration(
                                    prefixIcon: SizedBox(
                                      height: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 14,
                                          horizontal: 6,
                                        ),
                                        child: CardUtils.getCardIcon(
                                          _paymentCard.type,
                                        ),
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: buttonColor,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: buttonColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: buttonColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: buttonColor,
                                      ),
                                    ),
                                    hintText:
                                        "What number is written on card?".tr,
                                    hintStyle: TextStyle(color: Colors.grey),
                                    labelStyle: TextStyle(color: Colors.grey),
                                    labelText: "Number".tr,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 4,
                                      child: TextFormField(
                                        style: TextStyle(color: Colors.grey),
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                        ],
                                        decoration: InputDecoration(
                                            prefixIcon: SizedBox(
                                              height: 10,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 14),
                                                child: Image.asset(
                                                  'assets/images/card_cvv.png',
                                                  width: 6,
                                                  color: buttonColor,
                                                ),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: buttonColor,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: buttonColor,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: buttonColor,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: buttonColor)),
                                            hintText:
                                                "Number behind the card".tr,
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            labelStyle:
                                                TextStyle(color: Colors.grey),
                                            labelText: 'CVV'),
                                        validator: CardUtils.validateCVV,
                                        keyboardType: TextInputType.number,
                                        onSaved: (value) {
                                          _paymentCard.cvv = int.parse(value!);
                                        },
                                      ),
                                    ),
                                    SizedBox(width: Get.width * 0.03),
                                    Flexible(
                                      flex: 4,
                                      child: TextFormField(
                                        style: TextStyle(color: Colors.black),
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                          CardMonthInputFormatter()
                                        ],
                                        decoration: InputDecoration(
                                          prefixIcon: SizedBox(
                                            height: 10,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14),
                                              child: Image.asset(
                                                'assets/images/calender.png',
                                                width: 10,
                                                color: buttonColor,
                                              ),
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: buttonColor,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: buttonColor,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: buttonColor,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: buttonColor,
                                            ),
                                          ),
                                          hintText: 'MM/YY',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          labelStyle:
                                              TextStyle(color: Colors.grey),
                                          labelText: "Expiry Date".tr,
                                        ),
                                        validator: CardUtils.validateDate,
                                        keyboardType: TextInputType.number,
                                        onSaved: (value) {
                                          List<int> expiryDate =
                                              CardUtils.getExpiryDate(value!);
                                          _paymentCard.month = expiryDate[0];
                                          _paymentCard.year = expiryDate[1];
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: Get.height * 0.055),
                                Container(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: Get.width,
                                    child: CupertinoButton(
                                      onPressed: () {
                                        _validateInputs();
                                      },
                                      color: buttonColor,
                                      child: Text(
                                        "Pay ${currency}${(price * bookrealEstateController.days.length + tex)}",
                                        style: TextStyle(fontSize: 17.0),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.065),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  void _validateInputs() {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      setState(() {
        _autoValidateMode =
            AutovalidateMode.always; // Start validating on every change.
      });
      showToastMessage("Please fix the errors in red before submitting.".tr);
    } else {
      var username = getData.read("UserLogin")["name"] ?? "";
      var email = getData.read("UserLogin")["email"] ?? "";
      _paymentCard.name = username;
      _paymentCard.email = email;
      _paymentCard.amount = currentTotalprice.toString();
      form.save();

      Get.to(() => StripePaymentWeb(paymentCard: _paymentCard))!.then((otid) {
        Get.back();
        //! order Api call
        if (otid != null) {
          //! Api Call Payment Success
          bookApiData(otid);
        }
      });

      showToastMessage("Payment card is valid".tr);
    }
  }
}
