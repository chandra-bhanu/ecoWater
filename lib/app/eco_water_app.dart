import 'dart:async';
import 'package:flutter/material.dart';
import 'package:eco_water_app/app/app_theme.dart';
import 'package:eco_water_app/app/app_icons.dart';

import 'package:eco_water_app/ui/auth/login_page.dart';
import 'package:eco_water_app/ui/customers/customers_details_page.dart';
import 'package:eco_water_app/ui/customers/list_page.dart';

import 'package:eco_water_app/ui/home/home_page.dart';
import 'package:eco_water_app/ui/user/profile_page.dart';

//Inventory Pages
import 'package:eco_water_app/ui/inventory/inventory_entry_page.dart';
import 'package:eco_water_app/ui/inventory/inventory_overall.dart';
import 'package:eco_water_app/ui/inventory/inventory_update.dart';
import 'package:eco_water_app/ui/inventory/inventory_load_jars.dart';
import 'package:eco_water_app/ui/inventory/inventory_un_load_jars.dart';
import 'package:eco_water_app/ui/inventory/inventory_report_page.dart';

//Employee Pages
import 'package:eco_water_app/ui/employee/employee_list_page.dart';



class EcoWaterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      debugShowCheckedModeBanner: false,
      home: FlashPage(),
     theme: AppThemeDataFactory.prepareThemeData(),
      routes: {
        'home': (context) => HomePage(),
        'profile': (context) => ProfilePage(),
        'customerList': (context) => CustomersList(),
        'inventoryEntry': (context) => const InventoryList(),
        'inventoryOverall': (context) => const InventoryOverall(),
        'inventoryUpdate': (context) => const InventoryUpdate(),
        'loadJars': (context) => const InventoryLoadJars(),
        'unloadJars': (context) => const InventoryUnLoadJars(),
        'inventoryReport': (context) => const InventoryReports(),
        'employeeList': (context) => EmployeeList(),
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
