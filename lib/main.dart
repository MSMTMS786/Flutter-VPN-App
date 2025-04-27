import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/screens/splash_screen.dart';

//Global object to access media query
late Size mq;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  await Pref.initializehive();
  SystemChrome.setPreferredOrientations(
[DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]).then((value) =>runApp(const MyApp())); 
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APNA VPN',
      home: SplashScreen(),
      themeMode: Pref.isDarkMode?ThemeMode.dark:ThemeMode.light,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0Xff005a7d),
          centerTitle: true,
          elevation: 3,
        ),
      ),
      
      // Dark Theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0Xff005a7d),
          centerTitle: true,
          elevation: 3,
        ),
      ),
    );
  }
}

extension AppTheme on ThemeData{
Color get lightText=>Pref.isDarkMode?Colors.white38:Colors.black54;
Color get bottomNav=>Pref.isDarkMode?Colors.white10: Color.fromARGB(255, 100, 146, 148);
}