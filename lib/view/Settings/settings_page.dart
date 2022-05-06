import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tawbah/constants/colors.dart';
import 'package:tawbah/constants/dimensions.dart';
import '../../constants/themes.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight:Dimensions.height10*7,
        centerTitle: true,
        backgroundColor: AppColors.isha2,
        title: const Text('Settings',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
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
      body: Column(
        children:  [
          ListTile(
            title: const Text('Change Mood',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            trailing: DayNightSwitcher(isDarkModeEnabled: themeProvider.isDarkMode , onStateChanged:(bool isDarkModeEnabled){
              setState(() {
                final provider = Provider.of<ThemeProvider>(context, listen: false);
                provider.toggleTheme(isDarkModeEnabled);
           });} ),
          ),
          ListTile(
            title: const Text('Main Colors',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            trailing: SizedBox(
              width: Dimensions.height30*3,
              child: Row(
                children: const[
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: AppColors.isha2,
                  ),
                  SizedBox(width: 10,),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: AppColors.maghrib1,
                  ),
                  SizedBox(width: 10,),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: AppColors.maghrib2,
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Push Notification',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            trailing: Switch(value: themeProvider.isDarkMode, onChanged: (value){
                final provider = Provider.of<ThemeProvider>(context, listen: false);
                provider.toggleTheme(value);
            },activeColor: AppColors.isha2,activeTrackColor: AppColors.isha2,),
          ),
        ],
      ),
    );
  }
}
