import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/models/sales.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int? totalSales;
  List<Sales>? earnings;
  final AdminServices adminServices = AdminServices();

  void getEarnings() async {
    var earningData = await adminServices.getEarnings(context: context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return earnings==null || totalSales ==null ?Loader():
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text("Total Earnings:\$ ${totalSales}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
           Text("Mobile Earnings:\$ ${earnings![0].earnings}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text("Essentials Earnings:\$ ${earnings![1].earnings}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
             Text("Appliances Earnings:\$ ${earnings![2].earnings}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text("Books Earnings:\$ ${earnings![3].earnings}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
               Text("Fashion Earnings:\$ ${earnings![4].earnings}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      
      
        ],
      ),
    );
  }
}
