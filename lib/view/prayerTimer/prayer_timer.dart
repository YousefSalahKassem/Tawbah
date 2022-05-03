import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:adhan/adhan.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:tawbah/constants/dimensions.dart';
import '../../data/prayers.dart';
import '../../constants/dimensions.dart';

class PrayerTimer extends StatefulWidget {
  const PrayerTimer({Key? key}) : super(key: key);

  @override
  State<PrayerTimer> createState() => _PrayerTimerState();
}

class _PrayerTimerState extends State<PrayerTimer> {
  Location location2=Location();
  LocationData? _currentPosition2;
  double? latitude2,longitude2;
  var address;
  final _today = HijriCalendar.now();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: Dimensions.height30*15,
              width: double.maxFinite,
              decoration: BoxDecoration(
                gradient:  LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    prayer[0].color1,
                    prayer[0].color2
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.height30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                          const Text('Prayer Time',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                          Container(width: Dimensions.height30*2,),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0,left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text('FAJAR',style: GoogleFonts.workSans(textStyle:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),),
                            SizedBox(height: Dimensions.height10/2,),
                            Row(
                              children: const [
                                Text('6:23',style:  TextStyle(color: Colors.white,fontSize: 50)),
                                Text(' AM',style:  TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold,height: 2.5)),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    bottom: -Dimensions.height30*4,
                    right: 0,
                    left: 0,
                    child: Image.asset('assets/images/mosque.png',fit: BoxFit.cover,),)
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.height30*2,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0,right: 30.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Day',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                        Text(DateTime.now().toString().substring(0,DateTime.now().toString().indexOf(' ')),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const VerticalDivider(color: Colors.black,thickness: 2,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Time',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                        Text(DateFormat.jm().format(DateTime.parse(DateTime.now().toString())),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height30*3,),
              Padding(
                padding: const EdgeInsets.only(left: 30.0,right: 30.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Hijri',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                        Text(_today.toFormat("MMMM dd yyyy"),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const VerticalDivider(color: Colors.black,thickness: 2,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Your location',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                        Text(DateFormat.jm().format(DateTime.parse(DateTime.now().toString())),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // Positioned(
  // bottom: -100,
  // child: Container(
  // height: Dimensions.pageViewContainer/1.05,
  // margin: const EdgeInsets.only(left: 10,right: 10),
  // child: SizedBox(
  // width: double.maxFinite,
  // height: Dimensions.pageViewContainer/1.3,
  // child: FutureBuilder(
  // future: getLocation(),
  // builder: (context,snapshot){
  // if(snapshot.connectionState==ConnectionState.waiting){
  // return Shimmer(
  // duration: const Duration(seconds: 3), //Default value
  // interval: const Duration(seconds: 5), //Default value: Duration(seconds: 0)
  // color: Colors.white,
  // colorOpacity: 0, //Default value
  // enabled: true, //Default value
  // direction: const ShimmerDirection.fromLTRB(),  //Default Value
  // child: Container(
  // color: Colors.grey.shade100,
  // ),
  // );
  // }
  // final coordinates=Coordinates(latitude2, longitude2);
  // final params=CalculationMethod.muslim_world_league.getParameters();
  // params.madhab=Madhab.hanafi;
  // final prayerTimes=PrayerTimes.today(coordinates, params);
  // List<DateTime> prayertimes=[
  // prayerTimes.fajr,
  // prayerTimes.dhuhr,
  // prayerTimes.asr,
  // prayerTimes.maghrib,
  // prayerTimes.isha,
  // ];
  // return ListView.builder(
  // scrollDirection: Axis.horizontal,
  // itemCount: prayer.length,
  // itemBuilder: (context,index){
  // return Padding(
  // padding: const EdgeInsets.all(8.0),
  // child: Column(
  // children: [
  // Container(
  // height: Dimensions.height30*3.5,
  // width: Dimensions.height20*4,
  // decoration: BoxDecoration(
  // borderRadius: BorderRadius.circular(10),
  // gradient:  LinearGradient(
  // begin: Alignment.topRight,
  // end: Alignment.bottomLeft,
  // colors: [
  // prayer[index].color1,
  // prayer[index].color2
  // ],
  // ),
  // ),
  // child: Padding(
  // padding: EdgeInsets.only(bottom: Dimensions.height10),
  // child: Column(
  // mainAxisAlignment: MainAxisAlignment.end,
  // children: [
  // Image.asset(prayer[index].image,width: Dimensions.height30*2,),
  // SizedBox(height: Dimensions.height15,),
  // Align(
  // alignment: Alignment.bottomCenter,
  // child: Text(DateFormat.jm().format(prayertimes[index]),style:const  TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
  // ),
  // ],
  // ),
  // ),
  // ),
  // SizedBox(height: Dimensions.height10/2,),
  // Text(prayer[index].name,style: GoogleFonts.workSans(textStyle:const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14)),),
  // ],
  // ),
  // );
  // });
  // },
  // )
  // ),
  // ),)

  // SizedBox(
  //   height: Dimensions.height30*10,
  //   width: double.maxFinite,
  //   child: GridView.builder(
  //       itemCount: 4,
  //       padding: const EdgeInsets.all(8),
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //           mainAxisSpacing: 10,
  //           crossAxisSpacing: 10,
  //           crossAxisCount: 2,
  //       ),
  //       itemBuilder: (context,index){
  //         return Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(categories[index].title),
  //             Text(categories[index].subTitle)
  //           ],
  //         );
  //       },
  //
  //   ),
  // )


  Future<void> getLocation()async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled=await location2.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled=await location2.requestService();
      if(!_serviceEnabled){return;}
    }
    _permissionGranted= await location2.hasPermission();
    if(_permissionGranted== PermissionStatus.denied){
      _permissionGranted=await location2.requestPermission();
      if(_permissionGranted!=PermissionStatus.granted){
        return;
      }
    }

    _currentPosition2=await location2.getLocation();
    latitude2=_currentPosition2!.latitude;
    longitude2=_currentPosition2!.longitude;
  }

}