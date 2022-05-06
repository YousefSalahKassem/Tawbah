import 'package:flutter/material.dart';
import 'package:tawbah/data/wduh.dart';
import 'package:tawbah/view/Guide/guide_details_page.dart';

import '../../constants/colors.dart';
import '../../constants/dimensions.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight:Dimensions.height10*7,
        centerTitle: true,
        backgroundColor: AppColors.isha2,
        title: const Text('Muslim Guide',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
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
      body: SizedBox(
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        child: ListView.builder(
            itemCount: guide.length,
            itemBuilder: (context,index){
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.fajar2,
                      child: Center(
                        child: Text((index+1).toString(),style: const TextStyle(color: Colors.white,fontSize: 12),),
                      ),
                    ),
                    title: Text(guide[index].title,style:const TextStyle(fontWeight: FontWeight.bold),),
                    trailing: const CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.fajar2,
                      child: Center(
                        child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 12,),
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GuideDetailsPage(guide: guide[index])));
                    },
                  ),
                  const Divider(thickness: .5),
                ],
              );
            }),
      ),
    );
  }
}
