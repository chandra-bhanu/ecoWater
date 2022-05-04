import 'dart:convert';
import 'package:eco_water_app/ui/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:eco_water_app/services/employee_services.dart';
import 'package:eco_water_app/models/employee_model.dart';

class EmployeeDetails extends StatefulWidget {
  //final int customerId;
  const EmployeeDetails({Key? key}) : super(key: key);
  //const CustomersDetails({Key? key, required this.customerId}) : super(key: key);
  @override
  _EmployeeDetailsState createState() => _EmployeeDetailsState();

}
class _EmployeeDetailsState extends State<EmployeeDetails> {

  late Future<Employee> futureEmployee;

  final _formKey = GlobalKey<FormState>();
  late String name,mobile,employeestatus, password,employmentType;

  String? _employeestatus;

  bool? _isActive;
  String? textValue;

  bool? _isTemp;
  String? empTypeValue;

  bool isLoading=false;
  GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger ;
  var reg=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  TextEditingController _nameController=new TextEditingController();
  TextEditingController _mobileController=new TextEditingController();
  TextEditingController _passwordController=new TextEditingController();
  TextEditingController _statusController=new TextEditingController();
  TextEditingController _employmentTypeController=new TextEditingController();


  @override
  Widget build(BuildContext context) {
    int employeeId = ModalRoute.of(context)!.settings.arguments as int;
    futureEmployee = fetchEmployee(employeeId);
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Employee Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildDetailPage(context,employeeId),
          ],
        ),
      ),

    );
  }

  FutureBuilder<Employee> _buildDetailPage(BuildContext context,employeeId) {


      return FutureBuilder<Employee>(
        future: futureEmployee,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            _nameController.text= "${snapshot.data!.employeeData?.name}";
            _mobileController.text= "${snapshot.data!.employeeData?.mobile}";
            // bool isSwitched=(snapshot.data!.employeeData?.status=="0")?false:true;
            // String


            if( _isActive == null)
              {
                textValue=(snapshot.data!.employeeData?.status=="0")?"Inactive":"Active";
                _isActive = (snapshot.data!.employeeData?.status=="0")?false:true;
              }

            if( _isTemp == null)
            {

              empTypeValue=(snapshot.data!.employeeData?.type=="temporary")?"Temporary":"Permanent";
              _isTemp = (snapshot.data!.employeeData?.type=="temporary")?false:true;
            }





           //   return Text('${snapshot.data!.employeeData.name.substring(0, 1)}');
            //toggleSwitch((snapshot.data!.employeeData?.status=="0")?false:true);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [

                    const SizedBox(height: 15,),
                    const Text('Manage Employee',
                      style: TextStyle(fontSize: 18.0,
                      //fontWeight: FontWeight.bold,
                      color: Color(0xFF303030)
                    ),
                    ),
                const SizedBox(height: 20,),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter your name',
                    ),
                    style: const TextStyle(fontSize: 18),
                    onSaved: (val) {
                      name = val!;
                    },
                  ),

                ),

                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30.0, top: 15, bottom: 15.0),
                  child: TextFormField(
                    controller: _mobileController,
                    decoration:  const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile',
                      hintText: 'Enter valid mobile number',
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 18),
                    onSaved: (val) {
                      mobile = val!;
                    },

                  ),

                ),

               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text('Account Status - $textValue', style: const TextStyle(fontSize: 20),) ,
                   Switch(
                     onChanged:(bool value) {
                       if(value == false)
                       {
                       setState(() {
                         _isActive = false;
                         textValue = 'Inactive';
                       });
                         //  print('Switch Button is ON');
                       }
                       else
                       {
                       setState(() {
                         _isActive = true;
                         textValue = 'Active';


                       });
                         //  print('Switch Button is OFF');
                       }
                     },
                     value: _isActive?? false,
                     activeColor: Colors.green,
                     activeTrackColor: Colors.lightGreenAccent,
                     inactiveThumbColor: Colors.redAccent,
                     inactiveTrackColor: Colors.grey,
                   ),
                 ],
               ),

                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Employee Type - $empTypeValue', style: const TextStyle(fontSize: 20),) ,
                    Switch(
                      onChanged:(bool value) {

                        if(value == false)
                        {
                          setState(() {
                            _isTemp = false;
                            empTypeValue = 'Temporary';
                          });
                          //  print('Switch Button is ON');
                        }
                        else
                        {
                          setState(() {
                            _isTemp = true;
                            empTypeValue = 'Permanent';
                          });
                          //  print('Switch Button is OFF');
                        }
                      },
                      value: _isTemp?? false,
                      activeColor: Colors.green,
                      activeTrackColor: Colors.lightGreenAccent,
                      inactiveThumbColor: Colors.redAccent,
                      inactiveTrackColor: Colors.grey,
                    ),
                  ],
                ),


                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30.0, top: 25, bottom: 35),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration:  const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Change Password',
                      hintText: 'Change Password',
                    ),
                    style: const TextStyle(fontSize: 18),
                    obscureText: true,
                    onSaved: (val) {
                      password = val!;
                    },
                  ),
                ),

                Container(

                  decoration: const BoxDecoration(
                      color: Colors.blue,), //borderRadius: BorderRadius.circular(20)
                  child: TextButton(
                    onPressed: () {
                      //DO the Save Form


                      //Validate The data

                      if(_nameController.text.isEmpty)
                      {
                        scaffoldMessenger.showSnackBar(const SnackBar(content:Text("Please Enter Name")));
                        return;
                      }
                      if(_mobileController.text.isEmpty)
                      {
                        scaffoldMessenger.showSnackBar(const SnackBar(content:Text("Please Enter Mobile Number")));
                        return;
                      }
                      if(_mobileController.text.length !=10)
                      {
                        scaffoldMessenger.showSnackBar(const SnackBar(content:Text("Please Enter Valid Mobile Number")));
                        return;
                      }



                      if(_passwordController.text.isNotEmpty && _passwordController.text.length <5)
                      {
                        scaffoldMessenger.showSnackBar(const SnackBar(content:Text("Please use a strong password!")));
                        return;
                      }

                      //SignUp call
                      updateEmployee(employeeId,_nameController.text,_mobileController.text,_passwordController.text,_isActive,_isTemp);


                    },
                    child: const Text(
                      'Update Employee',
                      style:  TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),

              ],
            );
          }

          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
  }


  //API CALL TO UPDATE
  updateEmployee(employeeId,name,number,password,status,empType)
  async {

    LoadingScreen().show(
      context: context,
      text: 'Please wait a moment',
    );

    String empTypeText= (empType==false)?'temporary':'permanent';

    final dataResponse= await updateEmployeeService(employeeId,name,number,password,status,empTypeText);

    if (dataResponse != null && dataResponse.success == 'true') {
      scaffoldMessenger.showSnackBar(
          SnackBar(
            content:Text("${dataResponse.message}",textAlign: TextAlign.center,),
            backgroundColor: Colors.green,

          )
      );
     Navigator.pop(context);
    }
    else if (dataResponse != null && dataResponse.success == 'false') {
      scaffoldMessenger.showSnackBar(
          SnackBar(
            content:Text("${dataResponse.message}",textAlign: TextAlign.center,),
            backgroundColor: Colors.red,

          )
      );
      // Navigator.pop(context);
    }
    else{
      scaffoldMessenger.showSnackBar(const SnackBar(
        content:Text("Unable to process! Please try after sometime",textAlign: TextAlign.center,),
        backgroundColor: Colors.red,
      ));
      // Navigator.pop(context);
    }

    LoadingScreen().hide();
  }



}
