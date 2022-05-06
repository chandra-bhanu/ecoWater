import 'dart:convert';


import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';


import 'package:eco_water_app/app/app_constants.dart';

//import the data model
import 'package:eco_water_app/models/employee_model.dart';



Future<Employee> fetchAdmin(adminId) async {
  final response = await http.get(Uri.parse(adminProfile+'/$adminId'));

  //print(response.body.toString());

  if (response.statusCode == 200) {
    return Employee.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

//UPDATE Employee
Future<Employee?> updateAdminService(employeeId,String name,String number,String password,bool status) async {
  final response = await http.post(Uri.parse(adminUpdate),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: ''
    },
    body: jsonEncode({
      'name': name,
      'number': number,
      'password': password,
      'status': (status==false)?"0":"1",
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

