import 'dart:convert';

import 'package:amazon_clone/constants/error_Handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Homeservices {
  Future<List<Product>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    print("fetchCategoryProducts");
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse("$uri/api/products?category=$category"), headers: {
        "Content-Type": "application/json;charset=UTF-8",
        "x-auth-token": userProvider.user.token,
      });
      print("API URL: $uri/api/products?category=$category");


      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
          print("fetchCategoryProducts3");
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return productList;
  }
}
