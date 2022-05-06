import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tawbah/constants/colors.dart';
import 'package:tawbah/constants/dimensions.dart';
import 'package:tawbah/constants/strings.dart';
import 'package:tawbah/models/qari.dart';
import 'package:tawbah/models/surah.dart';
import 'package:tawbah/view/QuranPage/qari_screen.dart';
import '../../models/translation.dart';
import '../../service/api_service.dart';


class DetailsScreen extends StatelessWidget {
  String name,translate,type;
  int verse,i;
  List<Surah> list;
  DetailsScreen(this.name, this.translate, this.type, this.verse,this.i,this.list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiServices _apiServices = ApiServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: AppColors.fajar2),),
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios,color: AppColors.fajar2,)),
        actions: [
          IconButton(onPressed: (){Get.to(QariScreen(index: i,list: list,));}, icon: const Icon(Icons.play_circle_fill_rounded,color: AppColors.fajar2,)),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
          width: double.maxFinite,
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.only(left: 15,right: 15,top: 25,bottom: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppColors.fajar1,
                AppColors.fajar2,
              ],
            ),
            image: const DecorationImage(image: AssetImage('assets/images/mosque.png'),fit: BoxFit.cover,opacity: .3)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(name,style: const TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w500),),
              SizedBox(height: Dimensions.height10,),
              Text(translate,style: const TextStyle(color: Colors.white,fontSize: 16),),
              SizedBox(height: Dimensions.height10,),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.height30*1.5,right: Dimensions.height30*1.5),
                child: const Divider(color: Colors.white,thickness: 1,),
              ),
              SizedBox(height: Dimensions.height10,),
              Text(type+' - '+verse.toString()+' Verses',style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),),
            ],
          ),
        ),
          SizedBox(height: Dimensions.height10,),
          Align(alignment: Alignment.center,child: Image.asset('assets/images/besmallah.png',fit: BoxFit.cover,color: AppColors.fajar2,height: Dimensions.height30*2,width: Dimensions.height30*10,)),
          SizedBox(height: Dimensions.height20,),
          Expanded(
          child: FutureBuilder(
              future: _apiServices.getTranslation(AppStrings.surahIndex!),
              builder: (BuildContext context, AsyncSnapshot<SurahTranslationList> snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(),);
                }
                else if(snapshot.hasData){
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.translationList.length,
                    itemBuilder: (context,index){
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: const EdgeInsets.only(left: 15,right: 15,bottom: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Image.asset('assets/images/star.png',fit: BoxFit.cover,width: Dimensions.height30*1.3,color: AppColors.fajar2,),
                                  Positioned(
                                    bottom: 0,
                                    top: 0,
                                    right: 0,
                                    left: 0,
                                    child: Center(
                                      child: Text(snapshot.data!.translationList[index].aya!,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: Dimensions.height20,),
                              SizedBox(width: double.maxFinite,child: Text(snapshot.data!.translationList[index].arabic_text!,style: const TextStyle(color: AppColors.fajar2,fontWeight: FontWeight.bold),textAlign: TextAlign.end,)),
                              SizedBox(height: Dimensions.height10,),
                              SizedBox(width: double.maxFinite,child: Text(snapshot.data!.translationList[index].translation!,style: const TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,)),

                            ],
                          ),
                        ),
                      );
                    }
                  );
                }
                else {
                  return Center(child: Text('Translation Not found'),);
                }

              }),
        )
      ],),
    );
  }
}
