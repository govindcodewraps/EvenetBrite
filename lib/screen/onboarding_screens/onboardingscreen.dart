import 'package:flutter/material.dart';

import 'onboardingsecond.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return

      SafeArea(
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
                        Icon(Icons.circle,size: 15,color: Color(0xff48DBFB),),
                        Icon(Icons.circle,size: 13,color: Colors.grey,),
                        Icon(Icons.circle,size: 13,color: Colors.grey,),
                      ],),
                      InkWell(

                          onTap: (){
                            // OnboardingScreen2();
                            // print("asdfghjklkjhgfdsdfgh");

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>onboardingsecond()));
                          },
                          child: Icon(Icons.arrow_forward)),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 140,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  //color: Colors.white, // Set the background color for the bottom row
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      firstOnboard(),
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

  Widget firstOnboard() {
    return Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
        Text("Hockey Camps International", textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w600),),
        Text("You don't have to go far to find a good restaurant,we have provided all the restaurants that isnear you",  textAlign: TextAlign.center,style: TextStyle(color: Color(0xff4B5563),fontSize: 16,fontWeight: FontWeight.w400),),
      ],
    );
  }
}



