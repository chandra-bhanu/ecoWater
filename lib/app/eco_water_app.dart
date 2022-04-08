import 'dart:async';
import 'package:flutter/material.dart';
import 'package:eco_water_app/app/app_theme.dart';
import 'package:eco_water_app/app/app_icons.dart';


import '../ui/auth/login_page.dart';
import '../ui/customers/customers_details_page.dart';
import '../ui/customers/list_page.dart';
import '../ui/home/home_page.dart';
import '../ui/user/profile_page.dart';





class EcoWaterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      debugShowCheckedModeBanner: false,
      home: FlashPage(),
      theme: AppThemeDataFactory.prepareThemeData() ,
      routes: {
        'home': (context) => HomePage(),
        'profile': (context) => ProfilePage(),
        'customerList': (context) => CustomersList(),
      //  'customerDetails': (context) => CustomersDetails(),
      }
    );
  }
}




class FlashPage extends StatefulWidget {
  @override
  _FlashPageState createState() => _FlashPageState();
}
class _FlashPageState extends State<FlashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                   // HomePage(),
                LoginPage(),
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
      padding: const EdgeInsets.all(100.0),
        child:Image.asset(
            AppIcons.ecoLogo,
            scale: 0.8
        ),
    );
  }
  }
