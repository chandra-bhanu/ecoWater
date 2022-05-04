import 'dart:convert';



class DataReturn
{
  int? userId;
  String? mobile;
  String? name;

  DataReturn({this.userId, this.mobile, this.name});

  DataReturn.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    mobile = json['mobile'];
    name = json['name'];
  }

}


class SignUpResponse{
  String? success;
  String? message;
  DataReturn dataReturn;

  SignUpResponse({required this.success, required this.message, required this.dataReturn});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
    success: json["success"],
    message: json["message"],
    dataReturn:DataReturn.fromJson(json['data']),
  );
}

