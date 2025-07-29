import 'dart:convert';

import 'package:amazon_clone/constants/error_Handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/userModel.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CartServices {
  void removeFromCart(
      {required BuildContext context, required Product product}) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
          Uri.parse("$uri/api/remove-from-cart/${product.id}"),
          headers: {
            "Content-type": "application/json;charset=UTF-8",
            "x-auth-token": userProvider.user.token
          });

      httpErrorHandler(context: context, response: res, onSuccess: () {
         User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUserFromModel(user);
      });
      
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
