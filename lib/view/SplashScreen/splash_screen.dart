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

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), ()=>Navigator.pushReplacement(context, PageTransition(child: const HomePage(), type: PageTransitionType.rightToLeft)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.fajar1,
              AppColors.fajar2,
            ],
          ),
        ),
        child: Stack(
          children: [
            Center(child: Image.asset('assets/images/logos.png',fit: BoxFit.cover,width:Dimensions.splashImage*10 ,)),
            Positioned(right:0,left:0,bottom: -Dimensions.height30*5,child: Image.asset('assets/images/mosque.png',fit: BoxFit.cover,)),
        ],),
      ),
    );
  }
}
