import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tawbah/constants/dimensions.dart';
import 'package:tawbah/data/category.dart';
import 'package:tawbah/view/Settings/settings_page.dart';
import 'package:tawbah/widgets/menu.dart';
import '../../data/prayers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex=0;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           SizedBox(
              height: Dimensions.pageViewContainer*2,
              child: Stack(
                children: [
                  Container(
                    height: Dimensions.height20*15,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        image: const DecorationImage(image: AssetImage('assets/images/mosque.png'),fit: BoxFit.cover,alignment: Alignment.topRight),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            prayer[selectedIndex].color1,
                            prayer[selectedIndex].color2,
                          ],
                        ),
                        borderRadius:const BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0,right: 15,top: Dimensions.height30*2.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                              Text('Welcome Back!',style:GoogleFonts.workSans(textStyle: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),),
                              IconButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage()));
                              },icon: const Icon(Icons.settings,color: Colors.white,size: 20,))
                            ],
                          ),
                          SizedBox(height: Dimensions.height20*1.5,),
                          Text(prayer[selectedIndex].name,style: GoogleFonts.workSans(textStyle:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),),
                          SizedBox(height: Dimensions.height10/2,),
                          Row(
                            children:  [
                              Text(prayer[selectedIndex].time.substring(0,prayer[selectedIndex].time.indexOf(' ')),style: TextStyle(color: Colors.white,fontSize: 35)),
                              Text(prayer[selectedIndex].time.substring(prayer[selectedIndex].time.indexOf(' ',2)),style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,height: 2.5)),
                            ],
                          ),
                          SizedBox(height: Dimensions.height10/2,),
                          Text('Ramadan 17, 1443 AH',style: GoogleFonts.workSans(textStyle: TextStyle(color: Colors.white.withOpacity(.85),fontWeight: FontWeight.bold,fontSize: 16)),),
                        ],
                      ),
                    ),

                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: Dimensions.height15,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.maxFinite,
                        margin: const EdgeInsets.only(left: 30,right: 30,bottom: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0xFFe8e8e8),
                                  blurRadius: 10,
                                  offset: Offset(0, 10)
                              ),
                              BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-2,0)
                              ),
                              BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(2,0)
                              ),
                            ]
                        ),
                        child: Container(
                          padding: EdgeInsets.only(top: Dimensions.height15,left: 15,right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:  [
                                      Image.asset('assets/images/quran.png',width: Dimensions.height30*1.5),
                                      SizedBox(width: Dimensions.width10/2,),
                                      const Text('Ayah Of Day',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Text('Al-Fatiah - Ayah 07',style: GoogleFonts.workSans(textStyle: TextStyle(color: Colors.grey.withOpacity(.85),fontWeight: FontWeight.w500,fontSize: 14)),),
                                ],
                              ),
                              Divider(color: Colors.grey.shade300,thickness: 1.75,),
                              Text('صِرَاطَ  الَّذِينَ  أَنْعَمْتَ  عَلَيْهِمْ  غَيْرِ الْمَغْضُوبِ  عَلَيْهِمْ  وَلاَ  الضَّالِّين ',style: TextStyle(color: Colors.black.withOpacity(.85),fontWeight: FontWeight.bold,fontSize: 16,wordSpacing: 5),textAlign: TextAlign.end,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
           Container(
              height: Dimensions.pageViewContainer/1.05,
              margin: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  const Text('Prayer Timing',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 16),),
                  SizedBox(
                    width: double.maxFinite,
                    height: Dimensions.pageViewContainer/1.3,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: prayer.length,
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              setState(() {
                                selectedIndex=index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: Dimensions.height30*3.5,
                                    width: Dimensions.height20*4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient:  LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          prayer[index].color1,
                                          prayer[index].color2
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: Dimensions.height10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Image.asset(prayer[index].image,width: Dimensions.height30*2,),
                                          SizedBox(height: Dimensions.height15,),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(prayer[index].time,style:const  TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.height10/2,),
                                  Text(prayer[index].name,style: GoogleFonts.workSans(textStyle:const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14)),),

                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
           const Menu(),
          ],
        ),
      ),
    );
  }
}
