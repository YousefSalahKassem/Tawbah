import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:tawbah/constants/colors.dart';

class Prayers{
  String name,time,image;
  Color color1,color2;

  Prayers(this.name, this.time,this.image, this.color1, this.color2);
}

List<Prayers> prayer=[
  Prayers('Fajar','', 'assets/images/moon.png',AppColors.fajar1, AppColors.fajar2),
  Prayers('DUHR', '', 'assets/images/sun.png',AppColors.duhr1, AppColors.duhr2),
  Prayers('ASAR', '', 'assets/images/sun.png',AppColors.asar1, AppColors.asar2),
  Prayers('MAGHRIB', '', 'assets/images/sunset.png',AppColors.maghrib1, AppColors.maghrib2),
  Prayers('ISHA', '', 'assets/images/moon.png',AppColors.isha1, AppColors.isha2),
];

class Categories{
  String title,subTitle;

  Categories(this.title, this.subTitle);
}

List<Categories> categories=[
  Categories('Day', DateFormat('yyyy-MM-dd').format(DateTime.now())),
  Categories('Time', 'subTitle'),
  Categories('Hijri', ''),
  Categories('Location', 'subTitle'),
];