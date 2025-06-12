import 'dart:convert';

import 'package:amazon_clone/constants/error_Handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<List<Product>> fetchSearchedProduct(
      {required BuildContext context, required String searchQuery}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    List<Product> productsList = [];
    print("searched product");

    try {
      http.Response res = await http
          .get(Uri.parse("$uri/api/products/search/$searchQuery"), headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": userProvider.user.token
      });
      print(res.body);
      print("api ");
      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              print(jsonDecode(res.body)[i]);
              productsList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
            print(productsList);
          });
      print("error handler ");
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return productsList;
  }
}
