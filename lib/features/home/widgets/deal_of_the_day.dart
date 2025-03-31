import 'package:flutter/material.dart';

class DealOfTheDay extends StatelessWidget {
  const DealOfTheDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          "https://images.unsplash.com/photo-1741851373559-6879db14fd8a?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          height: 235,
          fit: BoxFit.fitHeight,
        ),
        Container(
          padding: EdgeInsets.only(left: 15),
          alignment: Alignment.topLeft,
          child: Text(
            "\$100",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 15, right: 40, top: 5),
          child: Text(
            "Rivaan",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                  "https://images.unsplash.com/photo-1741851373559-6879db14fd8a?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",fit:BoxFit.fitWidth,width: 100,height: 100,),
              Image.network(
                  "https://images.unsplash.com/photo-1741851373559-6879db14fd8a?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",fit:BoxFit.fitWidth,width: 100,height: 100,),
              Image.network(
                  "https://images.unsplash.com/photo-1741851373559-6879db14fd8a?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",fit:BoxFit.fitWidth,width: 100,height: 100,),
              Image.network(
                  "https://images.unsplash.com/photo-1741851373559-6879db14fd8a?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",fit:BoxFit.fitWidth,width: 100,height: 100,),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
          alignment: Alignment.topLeft,
          child: Text("See all deals",style: TextStyle(color: Colors.cyan.shade800,),)
        )
      ],
    );
  }
}
