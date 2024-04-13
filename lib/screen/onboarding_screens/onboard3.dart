import 'package:flutter/material.dart';

import '../onbording_screen.dart';


class onboardingthird extends StatefulWidget {
  const onboardingthird({super.key});

  @override
  State<onboardingthird> createState() => _onboardingthirdState();
}

class _onboardingthirdState extends State<onboardingthird> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/onboard3.png'),
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
                        Icon(Icons.circle,size: 13,color: Colors.grey,),
                        Icon(Icons.circle,size: 15,color: Color(0xff48DBFB),),
                      ],),
                      InkWell(

                          onTap: (){
                            // OnboardingScreen2();
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>OnBordingScreen()));
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        children: [
          Text("Hockey Camps International", textAlign: TextAlign.center, style: TextStyle(color: Color(0xff48DBFB),fontSize: 24,fontWeight: FontWeight.w600),),
          Text("You don't have to go far to find a good restaurant,we have provided all the restaurants that isnear you", style: TextStyle(color: Color(0xffffffff),fontSize: 16,fontWeight: FontWeight.w400), textAlign: TextAlign.center,),


        ],
      ),
    );
  }
}
