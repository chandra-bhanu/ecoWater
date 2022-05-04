import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:eco_water_app/app/app_constants.dart';

//import the data model
import 'package:eco_water_app/models/employee_model.dart';

Future<List <DataReturn>> getEmployeeList() async{
  final response = await http.get(Uri.parse(userList),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : ''
    }
  );

  //print(response.body.toString());

  if(response.statusCode==200)
  {
    List jsonResponse = json.decode(response.body)['data'];
    return jsonResponse.map((job) => DataReturn.fromJson(job)).toList();

   // return DataReturn.fromJson(jsonDecode(response.body)['data']);
  }
  else
  {
  // return null;
    throw Exception('Opps! Something went wrong.');
  }
}

Future<Employee> fetchEmployee(employeeId) async {
  final response = await http.get(Uri.parse(userList+'/$employeeId'));

  //print(response.body.toString());

  if (response.statusCode == 200) {
    return Employee.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

//UPDATE Employee
Future<Employee?> updateEmployeeService(employeeId,String name,String number,String password,bool status,String empTypeText) async {
  final response = await http.post(Uri.parse(userUpdate),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: ''
    },
    body: jsonEncode({
      'name': name,
      'number': number,
      'password': password,
      'status': (status==false)?"0":"1",
      'type': empTypeText,
      'id': employeeId
    }),
  );
//print(response.body.toString());
  if (response.statusCode == 200) {
    return Employee.fromJson(jsonDecode(response.body));
  }
  else {
    return null;
    //throw Exception('Opps! Something went wrong.');
  }
}

