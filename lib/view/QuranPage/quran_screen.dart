import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tawbah/constants/strings.dart';
import 'package:tawbah/models/surah.dart';
import 'package:tawbah/service/api_service.dart';
import 'package:tawbah/view/QuranPage/details_screen.dart';
import '../../constants/colors.dart';
import '../../constants/dimensions.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  ApiServices apiServices=ApiServices();
  List<Surah> surah = [];
  List<Surah> surahList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiServices.getSurah().then((value) {
      setState(() {
        surah=value;
        surahList=surah;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight:Dimensions.height10*11,
        centerTitle: true,
        backgroundColor: AppColors.isha2,
        title: const Text('Al Quran',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
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
        bottom:  PreferredSize(child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: Dimensions.height30*1.5,
              margin: const EdgeInsets.only(left: 50,right: 50),
              padding: const EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Search',
                  labelStyle:TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 18,height: 1.15),
                  hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,height: 1.45),
                  prefixIcon: Icon(Icons.search,color: AppColors.fajar2,),
                  border: InputBorder.none,
                ),
                onChanged: (string){
                  setState(() {
                    surahList=surah.where((element) => element.englishName!.replaceAll('-', ' ').toLowerCase().contains(string.toLowerCase())).toList();
                  });
                },
              ),
            ),
            SizedBox(height: Dimensions.height10*2,),
          ],
        ), preferredSize: Size.fromHeight(Dimensions.height20))
      ),
      body: Container(
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
          future: apiServices.getSurah(),
          builder: (BuildContext context,AsyncSnapshot<List<Surah>> snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return const CircularProgressIndicator();
            }
            List<Surah>? surah= snapshot.data;
            return ListView.builder(
                itemCount: surahList!.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      setState(() {
                        AppStrings.surahIndex=index+1;
                      });
                      Get.to(DetailsScreen(surahList[index].englishName!, surahList[index].englishNameTranslation!, surahList[index].revelationType!, surahList[index].numberOfAyahs!,index,surahList));
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                            child: ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(

                                  image: DecorationImage(image: AssetImage('assets/images/star.png',),)
                                ),
                                child: Center(child: Text((surahList[index].number).toString()),),
                              ),
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(surahList[index].englishName!,style: const TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(height: Dimensions.height10,),
                                  Text(surahList[index].numberOfAyahs!.toString()+' Verses',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 14),),
                                ],
                              ),
                              trailing: SizedBox(width: Dimensions.height30*6,child: Text(surahList[index].name!.substring(surahList[index].name!.indexOf(' ')).toString()!,style: const TextStyle(color: AppColors.fajar2,fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.end,maxLines: 1,)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                          child: index==surahList.length-1?Container():const Divider(thickness: .5),
                        )
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
