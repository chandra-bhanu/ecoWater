import 'dart:convert';



class DataReturn
{
  int? userId;
  String? mobile;
  String? name;
  String? status;
  String? statusLabel;
  String? registeredOn;
  String? type;
  DataReturn({this.userId, this.mobile, this.name, this.status, this.statusLabel, this.registeredOn, this.type});

  factory DataReturn.fromJson(Map<String, dynamic> json)
  {
    return DataReturn(
        userId : json['id'],
        mobile : json['mobile'],
        name : json['name'],
        status :json['status'],
        statusLabel : (json['status']=="1")?'Active':'Inactive',
        registeredOn: json['created_on'],
       type: json['type'],
    );
  }



}


class EmployeeListResponse{
  String? success;
  String? message;

  List<DataReturn> dataReturn;
  EmployeeListResponse({required this.success, required this.message, required this.dataReturn});

  factory EmployeeListResponse.fromJson(Map<String, dynamic> json)
  {

      var list= json['data'] as List;
      List<DataReturn> dataReturnList= list.map((dataReturn) => DataReturn.fromJson(dataReturn)).toList();

      return EmployeeListResponse(
          success: json["success"],
          message: json["message"],
          dataReturn:dataReturnList,
      );

  }
}



//SINGLE EMPLOYEE
class Employee
{
  String? success;
  DataReturn? employeeData;
  String? message;

  Employee({this.success,this.message,required this.employeeData});

  factory Employee.fromJson(Map<String, dynamic> json)
  {
    return Employee(
      success: json["success"],
      message: json["message"],
      employeeData:DataReturn.fromJson(json["data"]),
    );
  }


}


