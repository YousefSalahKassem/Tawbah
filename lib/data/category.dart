import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tawbah/view/DuasPage/duas_page.dart';
import 'package:tawbah/view/Guide/guide_page.dart';
import 'package:tawbah/view/QiblaPage/qibla_screen.dart';
import 'package:tawbah/view/QuranPage/quran_screen.dart';
import 'package:tawbah/view/Tasbeh/tasbeh_screen.dart';
import 'package:tawbah/view/prayerTimer/prayer_timer.dart';

class Categories{
  String name,image;
  VoidCallback onTap;

  Categories(this.name, this.image,this.onTap);

}
List<Categories> list=[
  Categories('AL QURAN', 'assets/images/quranround.png',()=>Get.to(const QuranScreen())),
  Categories('QIBLA', 'assets/images/compass.png',()=>Get.to(const QiblaScreen())),
  Categories('TASBEEH', 'assets/images/timer.png',()=>Get.to(const TasbehScreen())),
  Categories('Muslim Guide', 'assets/images/prayer.png',()=>Get.to(const GuidePage())),
  Categories('Duas', 'assets/images/pray.png',()=>Get.to(const DuasScreen())),
  Categories('Prayer Times', 'assets/images/pray.png',()=>Get.to(const PrayerTimer())),
];