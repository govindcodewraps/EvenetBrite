// ignore_for_file: unused_local_variable, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goproperti/Api/config.dart';
import 'package:goproperti/Api/data_store.dart';
import 'package:goproperti/firebase/auth_service.dart';
import 'package:goproperti/model/routes_helper.dart';
import 'package:goproperti/utils/Custom_widget.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController implements GetxService {
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController newPassword = TextEditingController();
  TextEditingController newConformPassword = TextEditingController();

  ImagePicker picker = ImagePicker();
  File? pickedImage;

  bool showPassword = true;
  bool newShowPassword = true;
  bool conformPassword = true;
  bool isChecked = false;

  String userMessage = "";
  String resultCheck = "";

  String forgetPasswprdResult = "";
  String forgetMsg = "";

  showOfPassword() {
    showPassword = !showPassword;
    update();
  }

  newShowOfPassword() {
    newShowPassword = !newShowPassword;
    update();
  }

  newConformShowOfPassword() {
    conformPassword = !conformPassword;
    update();
  }

  changeRememberMe(bool? value) {
    isChecked = value ?? false;
    update();
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      pickedImage = tempImage;
      update();
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  getLoginApiData(String cuntryCode, context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      Map map = {
        "mobile": number.text,
        "ccode": cuntryCode,
        "password": password.text,
      };
      Uri uri = Uri.parse(Config.path + Config.loginApi);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );

      if (response.statusCode == 200) {
        await prefs.setBool('Firstuser', true);
        var result = jsonDecode(response.body);
        print(result.toString());
        userMessage = result["ResponseMsg"];
        resultCheck = result["Result"];
        showToastMessage(userMessage);

        if (resultCheck == "true") {
          save("homeCall", true);
          save("UserLogin", result["UserLogin"]);

          OneSignal.shared.sendTag("user_id", getData.read("UserLogin")["id"]);
          setfirebaselogin(
              email: result["UserLogin"]["name"], context: context);

          // Get.toNamed(Routes.bottoBarScreen);
          Get.toNamed(Routes.selectCountryScreen);
          number.text = "";
          password.text = "";
          isChecked = false;
          update();
        }
        update();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void setfirebaselogin({context, required String email}) async {
    print("SingupWith email firbase");
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.singInAndStoreData(
          proPicPath: getData.read("UserLogin")["pro_pic"].toString(),
          email: email,
          uid: getData.read("UserLogin")["id"]);
    } catch (e) {
      print(e);
    }
  }

  setForgetPasswordApi({
    String? mobile,
    String? ccode,
  }) async {
    try {
      Map map = {
        "mobile": mobile,
        "ccode": ccode,
        "password": newPassword.text,
      };
      Uri uri = Uri.parse(Config.path + Config.forgetPassword);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        forgetPasswprdResult = result["Result"];
        forgetMsg = result["ResponseMsg"];
        if (forgetPasswprdResult == "true") {
          save('isLoginBack', false);
          Get.toNamed(Routes.login);
          showToastMessage(forgetMsg);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  updateProfileImage(String? base64image) async {
    try {
      Map map = {
        "uid": getData.read("UserLogin")["id"].toString(),
        "img": base64image,
      };
      Uri uri = Uri.parse(Config.path + Config.updateProfilePic);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        save("UserLogin", result["UserLogin"]);
        isUserOnlie(getData.read("UserLogin")["id"],
            getData.read("UserLogin")["pro_pic"]);
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> isUserOnlie(String uid, String proPic) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
    collectionReference.doc(uid).update({"pro_pic": proPic});
  }
}
