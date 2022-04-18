import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tawbah/constants/colors.dart';
import 'package:tawbah/constants/dimensions.dart';
import 'package:tawbah/view/HomePage/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();


}



class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;


  @override
  void initState() {
    super.initState();
    controller=AnimationController(vsync: this,duration: const Duration(seconds: 2))..forward();
    animation=CurvedAnimation(parent: controller, curve: Curves.ease);
    Timer(const Duration(seconds: 3), ()=>Navigator.pushReplacement(context, PageTransition(child: const HomePage(), type: PageTransitionType.rightToLeft)));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ScaleTransition(scale: animation,child: Center(child: Image.asset('assets/images/logo.png',fit: BoxFit.cover,width:Dimensions.splashImage/1.25 ,))),
          Center(child: Image.asset('assets/images/islamic.png',fit: BoxFit.cover)),
      ],),
    );
  }
}
