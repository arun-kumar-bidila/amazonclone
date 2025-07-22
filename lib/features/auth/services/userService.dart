import 'dart:convert';
import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/error_Handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';

import 'package:amazon_clone/models/userModel.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //signup
  void signupUser(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    try {
      User user = User(
          id: "",
          name: name,
          email: email,
          password: password,
          address: "",
          type: "",
          token: "",
          cart: []);
      print("function invoked ");
      http.Response res = await http.post(Uri.parse("$uri/api/signup"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-type": "application/json;charset=UTF-8",
          });
      print("function invoked -2");
      // print(res.body);
      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            showSnackbar(context, "Account created successfully");
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

//sign in user
  void signinUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/signin"),
          body: jsonEncode({"email": email, "password": password}),
          headers: <String, String>{
            "Content-type": "application/json;charset=UTF-8"
          });

      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                "x-auth-token", jsonDecode(res.body)["token"]);
          });
      Navigator.pushNamedAndRemoveUntil(
          context, BottomBar.routeName, (route) => false);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");
      if (token == null) {
        prefs.setString("x-auth-token", "");
      }
      http.Response tokenRes = await http.post(Uri.parse("$uri/tokenIsValid"),
          headers: <String, String>{
            "Content-type": "application/json;charset=UTF-8",
            "x-auth-token": token!
          });
      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(Uri.parse("$uri/"),
            headers: <String, String>{
              "Content-type": "application/json;charset=UTF-8",
              "x-auth-token": token
            });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {}
  }
}
