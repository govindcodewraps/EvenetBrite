import 'package:flutter/material.dart';

import 'onboard3.dart';

class onboardingsecond extends StatefulWidget {
  const onboardingsecond({super.key});

  @override
  State<onboardingsecond> createState() => _onboardingsecondState();
}

class _onboardingsecondState extends State<onboardingsecond> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/onboard2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 140,

                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  //color: Colors.white, // Set the background color for the bottom row
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      secondOnboard(),
                    ],
                  ),
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  //color: Colors.white, // Set the background color for the bottom row
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Skip", style: TextStyle(color: Colors.black)),

                      Row(children: [
                        Icon(Icons.circle,size: 13,color: Colors.grey,),
                        Icon(Icons.circle,size: 15,color: Color(0xff48DBFB),),
                        Icon(Icons.circle,size: 13,color: Colors.grey,),
                      ],),
                      InkWell(

                          onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>onboardingthird()));
                          },
                          child: Icon(Icons.arrow_forward)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget secondOnboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Hockey Camps International", textAlign: TextAlign.center, style: TextStyle(color: Color(0xff48DBFB),fontSize: 24,fontWeight: FontWeight.w600),),
        Text("You don't have to go far to find a good restaurant,we have provided all the restaurants that isnear you", style: TextStyle(color: Color(0xffffffff),fontSize: 16,fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
      ],
    );
  }
}
