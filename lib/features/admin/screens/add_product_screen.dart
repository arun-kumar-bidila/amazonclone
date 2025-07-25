import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';

import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/add-product";
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  List<File> images = [];

  final _addProductFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    priceController.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion"
  ];

  void sellProduct() {
    print("\nsell product function invoked\n");
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      print("\nif condition product function invoked\n");
      adminServices.sellProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          category: category,
          images: images);
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  String category = "Mobiles";

  @override
  Widget build(BuildContext context) {
    double textScale = MediaQuery.of(context).textScaleFactor;
    print(textScale);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            "Add Product",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _addProductFormKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  images.isNotEmpty
                      ? CarouselSlider(
                          items: images.map((i) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            );
                          }).toList(),
                          options:
                              CarouselOptions(viewportFraction: 1, height: 200),
                        )
                      : GestureDetector(
                          onTap: selectImages,
                          child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              dashPattern: [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open,
                                      size: 40,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Select Product Images",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade500),
                                    )
                                  ],
                                ),
                              )),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    controller: productNameController,
                    hintText: "Product Name",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    controller: descriptionController,
                    hintText: "Description",
                    maxLines: 7,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    controller: priceController,
                    hintText: "Price",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    controller: quantityController,
                    hintText: "Quantity",
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      value: category,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: productCategories.map((String item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          category = newVal!;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(text: "Sell", onTap: sellProduct)
                ],
              ),
            )),
      ),
    );
  }
}
