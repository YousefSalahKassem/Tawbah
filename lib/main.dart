import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tawbah/models/surah.dart';
import 'package:tawbah/view/SplashScreen/splash_screen.dart';
import 'constants/themes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir=await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter<Surah>(SurahAdapter());
  await Hive.openBox<Surah>('surah');
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
  create: (context) => ThemeProvider(),
  builder: (context, _) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: const SplashScreen(),
    );
  });
}

