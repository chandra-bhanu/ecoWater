import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:eco_water_app/app/app_constants.dart';

//import the data model
import 'package:eco_water_app/models/auth_model.dart';


// signUp(name,number,password) async
// {
//   scaffoldMessenger.showSnackBar(const SnackBar(content:Text("Signing you up! Please wait!")));
// }

Future<String?> _getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) { // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if(Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }
}

  Future<SignUpResponse?> signUpService(String name,String number,String password) async{
    String? deviceId = await _getId();

    final response = await http.post(Uri.parse(userSignupApi),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader : ''
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'number': number,
          'password': password,
          'deviceid': deviceId!,
        }),
    );
//print(response.body.toString());
    if(response.statusCode==200)
    {
      return SignUpResponse.fromJson(jsonDecode(response.body));
    }
    else
    {
     return null;
      //throw Exception('Opps! Something went wrong.');
    }

  }


Future<SignUpResponse?> logInService(String number,String password) async{

  final response = await http.post(Uri.parse(userLoginApi),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : ''
    },
    body: jsonEncode(<String, String>{
      'number': number,
      'password': password,
    }),
  );
//print(response.body.toString());
  if(response.statusCode==200)
  {
    return SignUpResponse.fromJson(jsonDecode(response.body));
  }
  else
  {
    return null;
    //throw Exception('Opps! Something went wrong.');
  }

}


