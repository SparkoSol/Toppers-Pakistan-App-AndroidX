import 'package:flutter/material.dart';

class AboutUS extends StatefulWidget {
  @override
  _AboutUSState createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ABOUT US"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(13),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.black45,
                        size: 20,
                      ),
                      Text(
                        " About Toppers Pakistan",
                        style: TextStyle(color: Colors.black45),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Here at Toppers Pakistan we use fresh , locally sourced produce to create healthy, convenient meals dlivered direct to you",
                    style: TextStyle(color: Colors.black45),
                  )
                ],
              ),
            ),
          ),Card(elevation: 10,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), child: Padding(padding: EdgeInsets.all(13),child: Row(
            children: <Widget>[

              Icon(Icons.train,color: Colors.black45,size:20, ),
              Text("Delivery Charges",style: TextStyle(color: Colors.black45),),
                            Text("(PKR 50.00)",style: TextStyle(color: Colors.black45),)
            ],
          ),),),


          Card(elevation: 10,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), child: Padding(padding: EdgeInsets.all(13),child: Column(


            children: <Widget>[
             Row(children: <Widget>[  Icon(Icons.timer,color: Colors.black45,size:20, ),
              Text("Delivery Times",style: TextStyle(color: Colors.black45),),
             ],),SizedBox(height: 10,),
              Text("Order palce before 11 am, customer can choose can choose 11 am to 4 pm same day delivery time.",style: TextStyle(color: Colors.black45),),
              SizedBox(height: 10,),
              Text("Order palce between 11 am to 4 pm order can deliver  same day after 4 pm.",style: TextStyle(color: Colors.black45),),
              
           
            ],
          ),
          ),)
        ],
      ),
    );
  }
}
