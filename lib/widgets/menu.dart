import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/dimensions.dart';
import '../data/category.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Align(alignment: Alignment.center,child: Text('Categories',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 16),)),
          SizedBox(height: Dimensions.height10,),
          Divider(color: Colors.grey.withOpacity(.3),thickness: .5,),
          SizedBox(
            height: Dimensions.pageViewContainer*1.1,
            width: double.maxFinite,
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(15),
                itemCount: list.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,),
                itemBuilder: (context,index){
                  return Column(
                    children: [
                      Image.asset(list[index].image,fit: BoxFit.cover,width: Dimensions.height30*2.5,),
                      SizedBox(height:Dimensions.height10,),
                      Text(list[index].name,style: GoogleFonts.workSans(textStyle:const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14)),),
                    ],
                  );
                }),
          )
        ],
      ),
    );

  }
}
