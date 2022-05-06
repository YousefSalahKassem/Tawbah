import 'package:flutter/material.dart';
import 'package:tawbah/data/wduh.dart';

import '../../constants/colors.dart';
import '../../constants/dimensions.dart';

class GuideDetailsPage extends StatelessWidget {
  Guide guide;
  GuideDetailsPage({Key? key,required this.guide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight:Dimensions.height10*7,
        centerTitle: true,
        backgroundColor: AppColors.isha2,
        title: Text(guide.title,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: Dimensions.screenHeight,
          width: Dimensions.screenWidth,
          child: ListView.builder(
              itemCount: guide.details.length,
              itemBuilder: (context,index){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Text('Step ${(index+1).toString()}:\n\n'+guide.details[index].description,style:const TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                    const SizedBox(height: 20,),
                    guide.details[index].image.isEmpty?Container():Image.asset(guide.details[index].image,fit: BoxFit.cover,),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
