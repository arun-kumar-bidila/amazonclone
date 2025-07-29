import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address-screen";
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressFormKey = GlobalKey<FormState>();
  final TextEditingController flatController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flatController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: Form(
        key: _addressFormKey,
        child: Container(
          padding: EdgeInsets.all(8),
          color: GlobalVariables.backgroundColor,
          child: Column(
            children: [
              CustomTextfield(
                controller: flatController,
                hintText: "Flat & House No :",
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextfield(
                controller: areaController,
                hintText: "Area & Street",
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextfield(
                controller: pincodeController,
                hintText: "Pincode",
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextfield(
                controller: cityController,
                hintText: "Town/City",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
