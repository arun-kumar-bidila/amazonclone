import 'package:amazon_clone/constants/error_Handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/userModel.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetailsServices {
  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    print("rate product function is called");
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/rate-product"),
          headers: {
            "x-auth-token": userProvider.user.token,
            "Content-Type": "application/json",
          },
          body: jsonEncode({"id": product.id, "rating": rating}));
      print(res.body);
      print("rate product function ended");
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void addToCart(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/add-to-cart"),
          headers: {
            "Content-type": "application/json;charset=UTF-8",
            "x-auth-token": userProvider.user.token,
          },
          body: jsonEncode({"id": product.id}));
      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
