// ignore_for_file: unused_element, prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, file_names, sort_child_properties_last

import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:goproperti/utils/Colors.dart';

class PayStack extends StatefulWidget {
  final String? email;
  final String? totalAmount;
  final String? paystackId;

  const PayStack({this.email, this.totalAmount, this.paystackId});

  @override
  State<PayStack> createState() => _PayStackState();
}

class _PayStackState extends State<PayStack> {
  String publicKeyTest = 'pk_test_71d15313379591407f0bf9786e695c2616eece54';
  // final plugin = PaystackPlugin();

  @override
  void initState() {
    // plugin.initialize(publicKey: publicKeyTest);
    super.initState();
  }

  String _getReference() {
    var platform = (Platform.isIOS) ? 'iOS' : 'Android';
    final thisDate = DateTime.now().millisecondsSinceEpoch;
    return 'ChargedFrom${platform}_$thisDate';
  }

  chargeCard() async {
    // var charge = Charge()
    //   ..amount = int.parse(widget.totalAmount ?? "1000") * 100
    //   ..reference = _getReference()
    //   ..putCustomField(
    //     'custom_id',
    //     '846gey6w',
    //   ) //to pass extra parameters to be retrieved on the response from Paystack
    //   ..email = widget.email;
    // CheckoutResponse response = await plugin.checkout(
    //   context,
    //   method: CheckoutMethod.card,
    //   charge: charge,
    // );
    // if (response.status == true) {
    //   showToastMessage('Payment was successful!!!');
    // } else {
    //   showToastMessage('Payment Failed!!!');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
            height: 50,
            width: Get.size.width,
            child: GestureDetector(
              onTap: () {
                chargeCard();
              },
              child: Container(
                height: 50,
                width: Get.size.width,
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text("Pay Now !!"),
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            )),
      ),
    );
  }
}
