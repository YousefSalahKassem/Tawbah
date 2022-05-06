import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tawbah/models/surah.dart';
import 'package:tawbah/service/api_service.dart';
import 'package:tawbah/view/QuranPage/audio_screen.dart';

import '../../constants/colors.dart';
import '../../constants/dimensions.dart';
import '../../models/qari.dart';

class QariScreen extends StatefulWidget {
  List<Surah> list;
  int index;
  QariScreen({Key? key,required this.list,required this.index}) : super(key: key);

  @override
  State<QariScreen> createState() => _QariScreenState();
}

class _QariScreenState extends State<QariScreen> {
  ApiServices apiServices=ApiServices();
  List<Qari> qari = [];
  List<Qari> qariList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiServices.getQariList().then((value) {
      setState(() {
        qari=value;
        qariList=qari;
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
          title: const Text('Qari\'s',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
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
                      qariList=qari.where((element) => element.name!.replaceAll('-', ' ').toLowerCase().contains(string.toLowerCase())).toList();
                    });
                  },
                ),
              ),
              SizedBox(height: Dimensions.height10*2,),
            ],
          ), preferredSize: Size.fromHeight(Dimensions.height20))
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const SizedBox(height: 20,),
        Expanded(
        child: FutureBuilder(
          future: apiServices.getQariList(),
          builder: (BuildContext context , AsyncSnapshot<List<Qari>> snapshot){
            if(snapshot.hasError){
              return const Center(child: Text('Qari\'s data not found '),);
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            return ListView.builder(
              itemCount: qariList.length,
              itemBuilder: (context , index){
                return ListTile(
                  title: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin : const EdgeInsets.only(left: 5,right: 5,bottom: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: Dimensions.height30*9,
                              child: Text(qariList[index].name!,style: const TextStyle(color: AppColors.fajar2),maxLines:2,)),
                          const Icon(Icons.play_circle_fill_rounded,color: AppColors.fajar2,),
                        ],
                      ),
                    ),
                  ),
                  onTap: (){
                    Get.to(AudioScreen(qari: qariList[index], index: widget.index+1, list:widget.list ));
                  },
                );
              },
            );

          },
        )),
        const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
