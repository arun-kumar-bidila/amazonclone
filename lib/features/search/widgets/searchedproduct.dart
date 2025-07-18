import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Searchedproduct extends StatelessWidget {
  final Product product;
  const Searchedproduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
 double avgRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
     
      if (totalRating != 0) {
        avgRating = totalRating / product.rating!.length;
      }
    }
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 135,
                width: 135,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 235,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        product.name,
                        style: TextStyle(fontSize: 16),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Stars(
                        rating: avgRating,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        "\$${product.price}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: EdgeInsets.only(left: 10),
                      child: Text("Eligible for free shipping"),
                    ),
                    Container(
                      width: 235,
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "In stock",
                        style: TextStyle(color: Colors.teal),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
