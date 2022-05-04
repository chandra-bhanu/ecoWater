import 'package:flutter/material.dart';
import 'package:eco_water_app/ui/home/home_page.dart';
import 'package:eco_water_app/app/app_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

//API Service page

import 'package:eco_water_app/services/auth_services.dart';

import 'package:eco_water_app/ui/loading/loading_screen.dart';




class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _formKey = GlobalKey<FormState>();
  late String name,mobile, password, rePassword;
  bool isLoading=false;
  GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger ;
  var reg=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  TextEditingController _nameController=new TextEditingController();
  TextEditingController _mobileController=new TextEditingController();
  TextEditingController _passwordController=new TextEditingController();
  TextEditingController _rePasswordController=new TextEditingController();


  @override
  Widget build(BuildContext context) {

    scaffoldMessenger = ScaffoldMessenger.of(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Signup Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: SizedBox(
                    width: 100,
                    height: 80,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset(AppIcons.ecoLogo)),
              ),
            ),
             Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
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

            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextFormField(
                controller: _passwordController,
                decoration:  const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Password',
                ),
                style: const TextStyle(fontSize: 18),
                obscureText: true,
                onSaved: (val) {
                  password = val!;
                },
              ),
            ),

            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextFormField(
                controller: _rePasswordController,
                decoration:  const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Retype Password',
                  hintText: 'Retype Password',
                ),
                style: const TextStyle(fontSize: 18),
                obscureText: true,
                onSaved: (val) {
                  rePassword = val!;
                },
              ),
            ),

            const SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
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

                  if(_passwordController.text.isEmpty)
                  {
                    scaffoldMessenger.showSnackBar(const SnackBar(content:Text("Please Enter Password")));
                    return;
                  }

                  if(_passwordController.text.length <5)
                  {
                    scaffoldMessenger.showSnackBar(const SnackBar(content:Text("Please use a strong password!")));
                    return;
                  }

                  if(_rePasswordController.text.isEmpty)
                  {
                    scaffoldMessenger.showSnackBar(const SnackBar(content:Text("Please Retype Password")));
                    return;
                  }

                  if(_rePasswordController.text != _passwordController.text)
                  {
                    scaffoldMessenger.showSnackBar(const SnackBar(content:Text("Password Mismatch!")));
                    return;
                  }




                  //SignUp call
                  signUp(_nameController.text,_mobileController.text,_passwordController.text);


                },
                child: const Text(
                  'Signup',
                  style:  TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            TextButton(
              onPressed: (){
                //SignUP Screen
                Navigator.pop(context);
              },
              child: const Text(
                'Have a account? Login Here',
                style:  TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),

          ],
        ),
      ),
    );
  }


  signUp(name,number,password)
  async {

    LoadingScreen().show(
      context: context,
      text: 'Please wait a moment',
    );

    final dataResponse= await signUpService(name,number,password);

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