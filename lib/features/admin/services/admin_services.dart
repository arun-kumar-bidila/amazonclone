import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_Handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
      final cloudinary = CloudinaryPublic("duoenlwuj", "amazonclone");
        List<String> imageUrls = [];

    try {
      try {
      
        // Uploading all images
        for (int i = 0; i < images.length; i++) {
          CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(images[i].path, folder: name),
          );
          imageUrls.add(res.secureUrl);
        }

        print("\nAll images uploaded to Cloudinary\n");
      } catch (e) {
        print("error in cludinary");
      }

      // Creating product object AFTER all images are uploaded
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );

      http.Response resp = await http.post(
        Uri.parse("$uri/admin/add-product"),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );
      print(userProvider.user.token);
      print(resp.statusCode);
      print("\n response is created\n");

      httpErrorHandler(
        context: context,
        response: resp,
        onSuccess: () {
          showSnackbar(context, "Product added successfully");
          Navigator.pop(context);
        },
      );
      print("\n error handler is created \n");
    } catch (e) {
      print("\n diverted to catch\n");
      showSnackbar(context, "Error: ${e.toString()}");
    }
  }

  //get all products

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response getres =
          await http.get(Uri.parse("$uri/admin/get-products"), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandler(
          context: context,
          response: getres,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(getres.body).length; i++) {
              productList.add(Product.fromJson(
                jsonEncode(
                  jsonDecode(getres.body)[i],
                ),
              ));
            }
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return productList;
  }

  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response deleteres = await http.post(
        Uri.parse("$uri/admin/delete-product"),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': product.id}),
      );

      httpErrorHandler(
          context: context, response: deleteres, onSuccess: onSuccess);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
