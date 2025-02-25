// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, unnecessary_brace_in_string_interps, prefer_adjacent_string_concatenation, unused_field, prefer_interpolation_to_compose_strings, avoid_print, unrelated_type_equality_checks

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:goproperti/Api/config.dart';
import 'package:goproperti/Api/data_store.dart';
import 'package:goproperti/controller/reviewsummary_controller.dart';
import 'package:goproperti/controller/subscribe_controller.dart';
import 'package:goproperti/model/fontfamily_model.dart';
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
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({super.key});

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  SubscribeController subscribeController = Get.find();
  ReviewSummaryController reviewSummaryController = Get.find();

  late Razorpay _razorpay;

  // final plugin = PaystackPlugin();

  int? _groupValue;
  String? selectidPay = "0";
  String razorpaykey = "";
  String? paymenttital;

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

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: Get.size.height,
              width: Get.size.width,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Subscribe Plan".tr,
                        style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16,
                            color: notifire.getblackwhitecolor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GetBuilder<SubscribeController>(builder: (context) {
                    return Expanded(
                      child: subscribeController.isLoading
                          ? ListView.builder(
                              itemCount: subscribeController
                                  .subscribeInfo?.packageData.length,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    subscribeController.changeSubscribe(index);
                                    subscribeController.price =
                                        subscribeController.subscribeInfo
                                                ?.packageData[index].price ??
                                            "";
                                    subscribeController.planId =
                                        subscribeController.subscribeInfo
                                                ?.packageData[index].id ??
                                            "";
                                  },
                                  child: Container(
                                    height: 90,
                                    width: Get.size.width,
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        subscribeController.currentIndex ==
                                                index
                                            ? Image.asset(
                                                "assets/images/Shape (1).png",
                                                height: 17,
                                                width: 17,
                                              )
                                            : Image.asset(
                                                "assets/images/Shape.png",
                                                height: 17,
                                                width: 17,
                                              ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${subscribeController.subscribeInfo?.packageData[index].title ?? ""} ${"Plan".tr}",
                                              style: TextStyle(
                                                color: Color(0xff3D5BF6),
                                                fontFamily:
                                                    FontFamily.gilroyBold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "${subscribeController.subscribeInfo?.packageData[index].day ?? ""} ${"days".tr}",
                                              style: TextStyle(
                                                color: Colors.grey.shade400,
                                                fontFamily:
                                                    FontFamily.gilroyBold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                knowMoreSheet(
                                                  discription:
                                                      subscribeController
                                                              .subscribeInfo
                                                              ?.packageData[
                                                                  index]
                                                              .description ??
                                                          "",
                                                  day: subscribeController
                                                          .subscribeInfo
                                                          ?.packageData[index]
                                                          .day ??
                                                      "",
                                                  image: subscribeController
                                                          .subscribeInfo
                                                          ?.packageData[index]
                                                          .image ??
                                                      "",
                                                );
                                              },
                                              child: Text(
                                                "Know More".tr,
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontFamily:
                                                      FontFamily.gilroyMedium,
                                                  fontSize: 13,
                                                  color: Color(0xFFFACC15),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            Text(
                                              "${subscribeController.subscribeInfo?.packageData[index].price}",
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontFamily:
                                                    FontFamily.gilroyBold,
                                                color: Color(0xff3D5BF6),
                                              ),
                                            ),
                                            Container(
                                              height: 35,
                                              width: 20,
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                "${currency}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily:
                                                      FontFamily.gilroyBold,
                                                  color: Color(0xff3D5BF6),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      border: subscribeController
                                                  .currentIndex ==
                                              index
                                          ? Border.all(color: Color(0xff3D5BF6))
                                          : Border.all(
                                              color: notifire.getborderColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    );
                  }),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 70,
                width: Get.size.width,
                child: Row(
                  children: [
                    GetBuilder<SubscribeController>(builder: (context) {
                      return Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Selected Plan".tr,
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyBold,
                                  fontSize: 12,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "${currency}${subscribeController.price}",
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyBold,
                                  fontSize: 20,
                                  color: Color(0xff3D5BF6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          if (subscribeController.price != "") {
                            if (subscribeController.price != "0") {
                              paymentSheett();
                            } else {
                              getpackagePurchase("0");
                              subscribeController.price = "";
                            }
                          } else {
                            showToastMessage("Please Select Subscribe Plan".tr);
                          }
                        },
                        child: Container(
                          height: 70,
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text(
                            "Subscribe Now".tr,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyBold,
                              color: WhiteColor,
                              fontSize: 16,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff3D5BF6),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: notifire.getblackwhitecolor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> knowMoreSheet({String? discription, day, image}) {
    return Get.bottomSheet(
      Container(
        width: Get.size.width,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                "${Config.imageUrl}${image}",
                height: 100,
                width: Get.size.width,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Package Description:".tr,
                style: TextStyle(
                  fontFamily: FontFamily.gilroyBold,
                  fontSize: 16,
                  color: notifire.getwhiteblackcolor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 10,
              ),
              child: HtmlWidget(
                discription ?? "",
                textStyle: TextStyle(
                  fontFamily: FontFamily.gilroyBold,
                  fontSize: 16,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Text(
                    "Validty: ".tr,
                    style: TextStyle(
                      fontFamily: FontFamily.gilroyBold,
                      fontSize: 16,
                      color: notifire.getwhiteblackcolor,
                    ),
                  ),
                  Text(
                    "${day} ${"Days".tr}",
                    style: TextStyle(
                      fontFamily: FontFamily.gilroyMedium,
                      fontSize: 14,
                      color: Colors.grey.shade400,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: notifire.getblackwhitecolor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
      ),
    );
  }

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
                              return reviewSummaryController
                                          .paymentInfo?.paymentdata[i].sShow !=
                                      "0"
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: sugestlocationtype(
                                        borderColor: selectidPay ==
                                                reviewSummaryController
                                                    .paymentInfo
                                                    ?.paymentdata[i]
                                                    .id
                                            ? buttonColor
                                            : notifire.getborderColor,
                                        title: reviewSummaryController
                                                .paymentInfo
                                                ?.paymentdata[i]
                                                .title ??
                                            "",
                                        titleColor: notifire.getwhiteblackcolor,
                                        val: 0,
                                        image: Config.imageUrl +
                                            reviewSummaryController.paymentInfo!
                                                .paymentdata[i].img,
                                        adress: reviewSummaryController
                                                .paymentInfo
                                                ?.paymentdata[i]
                                                .subtitle ??
                                            "",
                                        ontap: () async {
                                          setState(() {
                                            razorpaykey =
                                                reviewSummaryController
                                                    .paymentInfo!
                                                    .paymentdata[i]
                                                    .attributes;
                                            paymenttital =
                                                reviewSummaryController
                                                    .paymentInfo!
                                                    .paymentdata[i]
                                                    .title;
                                            selectidPay =
                                                reviewSummaryController
                                                        .paymentInfo
                                                        ?.paymentdata[i]
                                                        .id ??
                                                    "";
                                            _groupValue = i;
                                          });
                                        },
                                        radio: Radio(
                                          fillColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => i == _groupValue
                                                      ? blueColor
                                                      : notifire
                                                          .getborderColor),
                                          activeColor: buttonColor,
                                          value: i,
                                          groupValue: _groupValue,
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    )
                                  : SizedBox();
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
                      } else if (paymenttital == "Paypal") {
                        List<String> keyList = razorpaykey.split(",");
                        print(keyList.toString());
                        paypalPayment(
                          subscribeController.price,
                          keyList[0],
                          keyList[1],
                        );
                      } else if (paymenttital == "Stripe") {
                        Get.back();
                        stripePayment();
                      } else if (paymenttital == "PayStack") {
                        // String key = razorpaykey.split(",").first;
                        // await plugin.initialize(publicKey: key);
                        chargeCard(
                          int.parse(subscribeController.price),
                          getData.read("UserLogin")["email"],
                        );
                      } else if (paymenttital == "FlutterWave") {
                        Get.to(() => Flutterwave(
                                  totalAmount: subscribeController.price,
                                  email: getData
                                      .read("UserLogin")["email"]
                                      .toString(),
                                ))!
                            .then((otid) {
                          if (otid != null) {
                            getpackagePurchase(otid);
                            // homePageController.getHomeDataApi();
                            subscribeController.price = "";
                            showToastMessage("Payment Successfully");
                          } else {
                            Get.back();
                          }
                        });
                      } else if (paymenttital == "Paytm") {
                        Get.to(() => PayTmPayment(
                                  totalAmount: subscribeController.price,
                                  uid: getData
                                      .read("UserLogin")["id"]
                                      .toString(),
                                ))!
                            .then((otid) {
                          if (otid != null) {
                            getpackagePurchase(otid);
                            subscribeController.price = "";
                            showToastMessage("Payment Successfully");
                          } else {
                            Get.back();
                          }
                        });
                      } else if (paymenttital == "SenangPay") {}
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
              getpackagePurchase(params["paymentId"].toString());
              subscribeController.price = "";
              showToastMessage("Payment Successfully".tr);
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

  //!-------- Razorpay ----------//

  void openCheckout() async {
    var username = getData.read("UserLogin")["name"] ?? "";
    var mobile = getData.read("UserLogin")["mobile"] ?? "";
    var email = getData.read("UserLogin")["email"] ?? "";
    var options = {
      'key': razorpaykey,
      'amount': int.parse(subscribeController.price) * 100,
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
    getpackagePurchase(response.paymentId);
    subscribeController.price = "";
    showToastMessage("Payment Successfully");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(
        'Error Response: ${"ERROR: " + response.code.toString() + " - " + response.message!}');
    showToastMessage(response.message!);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showToastMessage(response.walletName!);
  }

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
                                        "Pay ${currency}${subscribeController.price}",
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
        _autoValidateMode = AutovalidateMode.always;
        // Start validating on every change.
      });
      showToastMessage("Please fix the errors in red before submitting.".tr);
    } else {
      var username = getData.read("UserLogin")["name"] ?? "";
      var email = getData.read("UserLogin")["email"] ?? "";
      _paymentCard.name = username;
      _paymentCard.email = email;
      _paymentCard.amount = subscribeController.price;
      form.save();

      Get.to(() => StripePaymentWeb(paymentCard: _paymentCard))!.then((otid) {
        Get.back();
        //! order Api call
        if (otid != null) {
          //! Api Call Payment Success
          getpackagePurchase(otid);
          // homePageController.getHomeDataApi();
          subscribeController.price = "";
          showToastMessage("Payment Successfully");
        }
      });

      showToastMessage("Payment card is valid".tr);
    }
  }

  //!-------- PayStack ----------//

  String _getReference() {
    var platform = (Platform.isIOS) ? 'iOS' : 'Android';
    final thisDate = DateTime.now().millisecondsSinceEpoch;
    return 'ChargedFrom${platform}_$thisDate';
  }

  chargeCard(int amount, String email) async {
    // Get.back();
    // var charge = Charge()
    //   ..amount = amount * 100
    //   ..reference = _getReference()
    //   ..putCustomField(
    //     'custom_id',
    //     '846gey6w',
    //   ) //to pass extra parameters to be retrieved on the response from Paystack
    //   ..email = email;

    // CheckoutResponse response = await plugin.checkout(
    //   context,
    //   method: CheckoutMethod.card,
    //   charge: charge,
    // );
    // if (response.status == true) {
    //   getpackagePurchase(response.reference);

    //   subscribeController.price = "";
    //   showToastMessage("Payment Successfully");
    // } else {
    //   showToastMessage('Payment Failed!!!');
    // }
  }

  getpackagePurchase(String? otid) {
    subscribeController.packagePurchaseApi(otid: otid, pName: paymenttital);
  }
}
