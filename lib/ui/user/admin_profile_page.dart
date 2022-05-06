import 'dart:convert';
import 'package:eco_water_app/ui/auth/login_page.dart';
import 'package:eco_water_app/ui/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:eco_water_app/services/admin_services.dart';
import 'package:eco_water_app/models/employee_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminProfilePage extends StatefulWidget {
  //final int customerId;
  const AdminProfilePage({Key? key}) : super(key: key);
  //const CustomersDetails({Key? key, required this.customerId}) : super(key: key);
  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();

}
class _AdminProfilePageState extends State<AdminProfilePage> {

  late Future<Employee> futureEmployee;

  final _formKey = GlobalKey<FormState>();
  late String name,mobile,accountstatus, password;

  String? _accountstatus;

  bool? _isActive;
  String? textValue;


  bool isLoading=false;
  final GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger ;
  var reg=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _mobileController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();

  String? adminId;

  @override
  void initState() {
    super.initState();
    getPref();
  }


  @override
  Widget build(BuildContext context) {

    futureEmployee = fetchAdmin(int.parse(adminId!));
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildDetailPage(context,int.parse(adminId!)),
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


          if( _isActive == null)
          {
            textValue=(snapshot.data!.employeeData?.status=="0")?"Inactive":"Active";
            _isActive = (snapshot.data!.employeeData?.status=="0")?false:true;
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [

              const SizedBox(height: 15,),
              const Text('Manage Profile',
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
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
                          updateAdmin(int.parse(adminId!),_nameController.text,_mobileController.text,_passwordController.text,_isActive);


                      },
                      child: const Text(
                        'Update Profile',
                        style:  TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    decoration: const BoxDecoration(
                      color: Colors.red,), //borderRadius: BorderRadius.circular(20)
                    child: TextButton(
                      onPressed: () async {
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        preferences.clear();
                        Navigator.pop(context);
                        Navigator.pushReplacement(context,
                          MaterialPageRoute(builder:
                              (context) =>
                          const LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Log Out',
                        style:  TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
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
  updateAdmin(employeeId,name,number,password,status)
  async {

    // LoadingScreen().show(
    //   context: context,
    //   text: 'Please wait a moment',
    // );



    final dataResponse= await updateAdminService(employeeId,name,number,password,status);

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

    // LoadingScreen().hide();
  }

  getPref() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      adminId=preferences.getString("logged_id");
    });
  }

}
