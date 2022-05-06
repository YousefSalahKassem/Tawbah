import 'package:flutter/material.dart';
import 'package:flutter_grid_delegate_ext/rendering/grid_delegate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tawbah/constants/colors.dart';
import 'package:tawbah/view/QuranPage/quran_screen.dart';

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
          Container(
          margin: const EdgeInsets.all(15),
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppColors.guide2,
                AppColors.guide1,
              ],
            ),
          ),
          child: InkWell(
            onTap: (){
              Get.to(const QuranScreen());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const Text('Al Quran',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),
                      const SizedBox(height: 10,),
                      Row(
                        children: const [
                          Text('Go To',style: TextStyle(color: Colors.white70,fontSize: 16),),
                          Icon(Icons.arrow_forward_ios,color: Colors.white70,size: 20,),
                        ],
                      ),
                    ],
                  ),
                ),
                Image.asset('assets/images/quran4.png',fit: BoxFit.cover,width: Dimensions.height30*7,height: Dimensions.height30*4,)
              ],
            ),
          ),
          ),
          SizedBox(
            height: Dimensions.pageViewContainer*2.5,
            width: double.maxFinite,
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(15),
                itemCount: list.length,
                gridDelegate: XSliverGridDelegate(
                    crossAxisCount: 2,
                    smallCellExtent: Dimensions.height30*7,
                    bigCellExtent: Dimensions.height30*9,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    isFirstCellBig: false
                ),
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: list[index].onTap,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 15,),
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            list[index].color1,
                            list[index].color2,
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0,left: 8.0),
                            child: Image.asset(list[index].image,fit: BoxFit.cover,width: Dimensions.height30*3,height: Dimensions.height30*3,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                Text(list[index].name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),
                                SizedBox(height: 10,),
                                Row(
                                  children: const [
                                    Text('Go To',style: TextStyle(color: Colors.white70,fontSize: 16),),
                                    Icon(Icons.arrow_forward_ios,color: Colors.white70,size: 20,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),

        ],
      ),
    );

  }
}
