import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tawbah/data/duas.dart';

import '../../constants/colors.dart';
import '../../constants/dimensions.dart';

class DetailsPage extends StatelessWidget {
  Duas duas;
  DetailsPage({Key? key,required this.duas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight:Dimensions.height10*7,
        centerTitle: true,
        backgroundColor: AppColors.isha2,
        title: Text(duas.title,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius:BorderRadius.vertical(
              bottom: Radius.circular(15),) ,
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage('assets/images/mosque.png'),
              opacity: .5,
              fit: BoxFit.cover,
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(alignment: Alignment.center,child: Text(duas.details,style: GoogleFonts.workSans(textStyle:const TextStyle(color: AppColors.fajar2,fontWeight: FontWeight.bold,fontSize: 22)),)),
          const SizedBox(height: 20,),
          Align(alignment: Alignment.center,child: Text(duas.translate,textAlign: TextAlign.center,style: GoogleFonts.workSans(textStyle:const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 18)),)),
        ],
      ),
    );
  }
}
