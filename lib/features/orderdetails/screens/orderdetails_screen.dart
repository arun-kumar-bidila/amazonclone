import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/search/screens/searchscreen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderdetailsScreen extends StatefulWidget {
  static const String routeName = "/orderdetails-screen";
  final Order order;
  const OrderdetailsScreen({super.key, required this.order});

  @override
  State<OrderdetailsScreen> createState() => _OrderdetailsScreenState();
}

class _OrderdetailsScreenState extends State<OrderdetailsScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, Searchscreen.routeName, arguments: query);
  }

  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
        context: context,
        status: status+1,
        order: widget.order,
        onSuccess: () {
          setState(() {
            currentStep += 1;
          });
        });
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.only(top: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 1)),
                        hintText: "Search Amazon.in",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "View Orders",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Order Date:${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}"),
                    Text("Order Id:${widget.order.id}"),
                    Text("Order Total:${widget.order.totalPrice}"),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Purchase Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.order.products[i].name,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text("Quantiy:${widget.order.quantity[i]}"),
                            ],
                          ))
                        ],
                      )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Tracking",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Stepper(
                    controlsBuilder: (context, details) {
                      if (user.type == "admin") {
                        return CustomButton(
                            text: "Done",
                            onTap: () {
                              changeOrderStatus(details.currentStep);
                            });
                      }
                      return SizedBox();
                    },
                    currentStep: currentStep,
                    steps: [
                      Step(
                          title: Text("Pending"),
                          content: Text("yet to deliver"),
                          isActive: currentStep >= 0,
                          state: currentStep > 0
                              ? StepState.complete
                              : StepState.indexed),
                      Step(
                          title: Text("Completed"),
                          content: Text("yet to deliver"),
                          isActive: currentStep > 1,
                          state: currentStep > 0
                              ? StepState.complete
                              : StepState.indexed),
                      Step(
                          title: Text("Delivered"),
                          content: Text("yet to deliver"),
                          isActive: currentStep > 2,
                          state: currentStep > 0
                              ? StepState.complete
                              : StepState.indexed),
                      Step(
                          title: Text("Received"),
                          content: Text("yet to deliver"),
                          isActive: currentStep >= 3,
                          state: currentStep > 0
                              ? StepState.complete
                              : StepState.indexed),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
