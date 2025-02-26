import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/screens/home_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
 
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), (){
       SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      Get.off(()=>HomeScreen());

      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: mq.width*0.27,
            top: mq.height*0.3,
            width: mq.width*0.5,
            child: Image.asset('assets/images/logo.png')),
            Positioned(
              left: mq.width*0.2,
              bottom: mq.height*0.1,
              child: Column(
             children: [
              
                Text('APNA VPN',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text('Developed by: Misbah Ur Rehman ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                             ],
              )

               )
        ],
      ),
    );
  }


 final mycolor= ui.Gradient.linear(
                Offset(0.0, 0.0),
                Offset(200.0, 0.0),
                [
                  Colors.orange,
                  Colors.pink,
                ],
              );


}






