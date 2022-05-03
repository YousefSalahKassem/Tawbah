import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:tawbah/constants/dimensions.dart';
import 'package:tawbah/models/ayah_of_the_day.dart';
import 'package:tawbah/service/api_service.dart';
import 'package:tawbah/view/Settings/settings_page.dart';
import 'package:tawbah/widgets/menu.dart';
import '../../data/prayers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Location location=Location();
  Location location2=Location();
  LocationData? _currentPosition;
  double? latitude,longitude;
  final _today = HijriCalendar.now();
  ApiServices apiServices=ApiServices();

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
                  FutureBuilder(
                    future: getLoc(),
                    builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Shimmer(
                          duration: const Duration(seconds: 3), //Default value
                          interval: const Duration(seconds: 5), //Default value: Duration(seconds: 0)
                          color: Colors.white,
                          colorOpacity: 0, //Default value
                          enabled: true, //Default value
                          direction: const ShimmerDirection.fromLTRB(),  //Default Value
                          child: Container(
                            color: Colors.grey.shade100,
                          ),
                        );
                      }

                      final coordinates=Coordinates(latitude, longitude);
                      final params=CalculationMethod.muslim_world_league.getParameters();
                      params.madhab=Madhab.hanafi;
                      final prayerTimes=PrayerTimes.today(coordinates, params);
                      getLeftTime(prayerTimes);

                      String date=getLeftTime(prayerTimes).toString().substring(0,getLeftTime(prayerTimes).toString().indexOf('/'));
                      String type=getLeftTime(prayerTimes).toString().substring(getLeftTime(prayerTimes).toString().indexOf('/')+1,getLeftTime(prayerTimes).toString().indexOf('&'));
                      String i=getLeftTime(prayerTimes).toString().substring(getLeftTime(prayerTimes).toString().indexOf('&')+1);
                      return Container(
                        height: Dimensions.height20*15,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            image: const DecorationImage(image: AssetImage('assets/images/mosque.png'),fit: BoxFit.cover,alignment: Alignment.topRight),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                prayer[int.parse(i)].color1,
                                prayer[int.parse(i)].color2,
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
                              SizedBox(height: Dimensions.height10,),
                              Text(type,style: GoogleFonts.workSans(textStyle:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),),
                              SizedBox(height: Dimensions.height10/2,),
                              Row(
                                children:  [
                                  Text(DateFormat.jm().format(DateTime.parse(date)).substring(0,DateFormat.jm().format(DateTime.parse(date)).indexOf(' ')),style: const TextStyle(color: Colors.white,fontSize: 35)),
                                  Text(DateFormat.jm().format(DateTime.parse(date)).substring(DateFormat.jm().format(DateTime.parse(date)).indexOf(' ',2)),style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,height: 2.5)),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10/2,),
                              Text(_today.toFormat("MMMM dd yyyy"),style: GoogleFonts.workSans(textStyle: TextStyle(color: Colors.white.withOpacity(.85),fontWeight: FontWeight.bold,fontSize: 16)),),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  FutureBuilder<AyaOfTheDay>(
                    future: apiServices.getAyaOfTheDay(),
                    builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Shimmer(
                          duration: const Duration(seconds: 3), //Default value
                          interval: const Duration(seconds: 5), //Default value: Duration(seconds: 0)
                          color: Colors.white,
                          colorOpacity: 0, //Default value
                          enabled: true, //Default value
                          direction: const ShimmerDirection.fromLTRB(),  //Default Value
                          child: Container(
                            color: Colors.grey.shade100,
                          ),
                        );
                      }
                      else{
                        return Positioned(
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
                                        SizedBox(width: Dimensions.height30*5,child: Text(snapshot.data!.surEnName!,style: GoogleFonts.workSans(textStyle: TextStyle(color: Colors.grey.withOpacity(.85),fontWeight: FontWeight.w500,fontSize: 14)),textAlign: TextAlign.end,)),
                                      ],
                                    ),
                                    Divider(color: Colors.grey.shade300,thickness: 1.75,),
                                    SizedBox(height: Dimensions.height30*2,width: double.maxFinite,child: Text(snapshot.data!.arText!,style: TextStyle(color: Colors.black.withOpacity(.85),fontWeight: FontWeight.bold,fontSize: 16,wordSpacing: 5),textAlign: TextAlign.end,)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
           const Menu(),
          ],
        ),
      ),
    );
  }

    Future<void> getLoc()async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled=await location.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled=await location.requestService();
      if(!_serviceEnabled){return;}
    }
    _permissionGranted= await location.hasPermission();
    if(_permissionGranted== PermissionStatus.denied){
      _permissionGranted=await location.requestPermission();
      if(_permissionGranted!=PermissionStatus.granted){
        return;
      }
    }

    _currentPosition=await location.getLocation();
    latitude=_currentPosition!.latitude;
    longitude=_currentPosition!.longitude;
  }

    getLeftTime(PrayerTimes prayerTimes){

      int fajr = (prayerTimes.fajr.hour * 3600) +
          (prayerTimes.fajr.minute * 60) +
          prayerTimes.fajr.second;

      int dhuhr = (prayerTimes.dhuhr.hour * 3600) +
          (prayerTimes.dhuhr.minute * 60) +
          prayerTimes.dhuhr.second;

      int asr = (prayerTimes.asr.hour * 3600) +
          (prayerTimes.asr.minute * 60) +
          prayerTimes.asr.second;

      int maghrib = (prayerTimes.maghrib.hour * 3600) +
          (prayerTimes.maghrib.minute * 60) +
          prayerTimes.maghrib.second;

      int isha = (prayerTimes.isha.hour * 3600) +
          (prayerTimes.isha.minute * 60) +
          prayerTimes.isha.second;

      int now = (DateTime.now().hour * 3600) +
          (DateTime.now().minute * 60) +
          DateTime.now().second;

      if(now>=fajr && now< dhuhr){
        return prayerTimes.dhuhr.toString()+"/DUHR&1";
      }else if(now>=dhuhr && now< asr){
        return prayerTimes.asr.toString()+"/ASAR&2";
      }
      else if(now>=asr && now< maghrib){
        return prayerTimes.maghrib.toString()+"/MAGHRIB&3";
      }
      else if(now>=maghrib && now< isha){
        return prayerTimes.isha.toString()+"/ISHA&4";
      }
      else {
        return prayerTimes.fajr.toString()+"/FAJAR&0";
      }
  }
}
