import 'package:eco_water_app/ui/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:eco_water_app/ui/home/home_page.dart';
import 'package:eco_water_app/app/app_icons.dart';
import 'package:eco_water_app/ui/auth/signup_page.dart';

import 'package:eco_water_app/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  late String name,mobile, password, rePassword;
  bool isLoading=false;
  GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger ;

  TextEditingController _mobileController=new TextEditingController();
  TextEditingController _passwordController=new TextEditingController();



  @override
  Widget build(BuildContext context) {

    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text("Login Page"),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 80,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset(AppIcons.ecoLogo)),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Welcome to EcoFresh',
              style: TextStyle(color: Color(0xFF303030), fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              'Serving Pure, Safe & Healthy Drinking Water',
              style: TextStyle(color: Color(0xFF303030), fontSize: 12),
            ),
            Padding(

              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: SizedBox(
                    width: 250,
                    height: 120,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset(AppIcons.jarDisplay)),
              ),
            ),


            const SizedBox(
              height: 30,
            ),
             Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
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
                        //Login call
                        logIn(_mobileController.text,_passwordController.text);
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: (){
                //SignUP Screen
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const SignupPage())
                );
              },
              child: const Text(
                'New User? Create Account',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'EcoFresh Delivery App V-1.0.1(Beta)',
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ],
        ),

      ),
    );
  }


  logIn(number,password)
  async {

    LoadingScreen().show(
      context: context,
      text: 'Please wait a moment',
    );

    final dataResponse= await logInService(number,password);

    if (dataResponse != null && dataResponse.success == 'true') {

        //Save login
      await savePref(1, dataResponse.dataReturn.name!, dataResponse.dataReturn.mobile!, dataResponse.dataReturn.userId,  dataResponse.dataReturn.isAdmin);
      scaffoldMessenger.showSnackBar(
          SnackBar(
            content:Text("${dataResponse.message}",textAlign: TextAlign.center,),
            backgroundColor: Colors.green,

          )
      );
      Navigator.pushReplacement (
          context, MaterialPageRoute(builder: (_) => HomePage())
      );
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


  savePref(int value, String name, String number, int? id, int? isAdmin) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("logged_value", value);
    preferences.setString("logged_name", name);
    preferences.setString("logged_email", number);
    preferences.setString("logged_id", id.toString());
    preferences.setString("logged_isAdmin", isAdmin.toString());
    //preferences.commit();




  }






}