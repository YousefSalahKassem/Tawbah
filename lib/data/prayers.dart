import 'dart:ui';

import 'package:tawbah/constants/colors.dart';

class Prayers{
  String name,time,image;
  Color color1,color2;

  Prayers(this.name, this.time,this.image, this.color1, this.color2);
}

List<Prayers> prayer=[
  Prayers('Fajar', '04:39 AM', 'assets/images/moon.png',AppColors.fajar1, AppColors.fajar2),
  Prayers('DUHR', '12:38 PM', 'assets/images/sun.png',AppColors.duhr1, AppColors.duhr2),
  Prayers('ASAR', '05:16 PM', 'assets/images/sun.png',AppColors.asar1, AppColors.asar2),
  Prayers('MAGHRIB', '07:14 PM', 'assets/images/sunset.png',AppColors.maghrib1, AppColors.maghrib2),
  Prayers('ISHA', '08:36 PM', 'assets/images/moon.png',AppColors.isha1, AppColors.isha2),
];