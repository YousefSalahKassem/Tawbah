import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tawbah/constants/colors.dart';
import 'package:tawbah/view/DuasPage/duas_page.dart';
import 'package:tawbah/view/Guide/guide_page.dart';
import 'package:tawbah/view/QiblaPage/qibla_screen.dart';
import 'package:tawbah/view/QuranPage/quran_screen.dart';
import 'package:tawbah/view/Tasbeh/tasbeh_screen.dart';

class Categories{
  String name,image;
  Color color1,color2;
  VoidCallback onTap;

  Categories(this.name, this.image,this.color1,this.color2,this.onTap);

}
List<Categories> list=[
  Categories('QIBLA', 'assets/images/qibla3.png',AppColors.dua1,AppColors.dua2,()=>Get.to(const QiblaScreen())),
  Categories('TASBEEH', 'assets/images/sebha3.png',AppColors.sebha1,AppColors.sebha2,()=>Get.to(const TasbehScreen())),
  Categories('Muslim Guide', 'assets/images/guide3.png',AppColors.quran1,AppColors.quran2,()=>Get.to(const GuidePage())),
  Categories('Duas', 'assets/images/dua3.png',AppColors.dua2,AppColors.dua1,()=>Get.to(const DuasScreen())),
];