import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/home/services/homeservices.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  Homeservices homeservices = Homeservices();
  Product? product;

  void fetchDealOfTheDay() async {
    product = await homeservices.fetchDealOfTheDay(context: context);
    setState(() {});
  }

  void navigateToDetailsScreen() async {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDealOfTheDay();
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? Loader()
        : product!.name.isEmpty
            ? SizedBox()
            : GestureDetector(
                onTap: () {
                  navigateToDetailsScreen();
                },
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 10, top: 15),
                      child: Text(
                        "Deal of the Day",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "\$ ${product!.price.toString()}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 15, right: 40, top: 5),
                      child: Text(
                        product!.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map((e) => Image.network(
                                  e,
                                  fit: BoxFit.fitWidth,
                                  width: 100,
                                  height: 100,
                                ))
                            .toList(),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "See all deals",
                          style: TextStyle(
                            color: Colors.cyan.shade800,
                          ),
                        ))
                  ],
                ),
              );
  }
}
