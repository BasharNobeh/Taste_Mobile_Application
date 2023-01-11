import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:taste_application/Primary_Screens/Home_Screen.dart';
import 'package:taste_application/SecondaryScreens/login_screen.dart';

class TasteSplashScreen extends StatefulWidget {
  @override
  State<TasteSplashScreen> createState() => _TasteSplashScreenState();
}

class _TasteSplashScreenState extends State<TasteSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      backgroundColor: const Color.fromARGB(255, 218, 64, 74),
      logoWidth: 150,
      loaderColor: Colors.white.withOpacity(0.7),
      logo: Image.asset(
        "Images/WLogoWithTitleNbg.png",
      ),
      showLoader: true,
      navigator: const TasteHomeScreen(),
      durationInSeconds: 3,
    );
  }
}
