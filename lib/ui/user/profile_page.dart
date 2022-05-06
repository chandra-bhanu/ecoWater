import 'dart:convert';
import 'package:eco_water_app/ui/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 10),
          _ProfileWidget(),
         // const SizedBox(height: 5),
          _buildName(),
          const SizedBox(height: 10),
          _buildDetails(),
          _buildEmptyDetails(),
          const SizedBox(height: 30),
          _buildUnloadDetails(),
          _buildUnloadEmptyDetails(),
          const SizedBox(height: 20),
          _buildButton(),
          const SizedBox(height: 15),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _ProfileWidget()=>Container(
   // margin: EdgeInsets.all(10),
    padding: const EdgeInsets.all(20),
    width: 90,
    height: 90,
    child: const Center(
              child: Text("J",
                          style: TextStyle(fontSize: 35.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                          textAlign: TextAlign.center,
                          ),
                  ),

    decoration: BoxDecoration(
                  border:Border.all(width:5,color:Colors.green),
                  shape: BoxShape.circle,
                  color: Colors.lightGreen,

    ),
  );
  //
  //
  Widget _buildName() => Column(
    children: const [
      Text(
        'John Doe',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      SizedBox(height: 4),
      Text(
        '+91- 900000001',
        style: TextStyle(color: Colors.grey),
      )
    ],
  );
  //
  Widget _buildDetails() => Column(
      children:<Widget>[
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Today Summary",textScaleFactor: 1.5,style: TextStyle(fontWeight:FontWeight.bold,color:Colors.blue),),
        ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Table(
                      border: TableBorder.all(width: 1.0, color: Colors.black),
                      children: [
                        TableRow(
                          decoration: const BoxDecoration(
                            color: Colors.green,
                          ),
                          children: [
                            TableCell(
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,

                                children: const <Widget>[
                                  Text('Loaded- Filled Jars',style: TextStyle(fontSize: 20.0,
                                    fontWeight: FontWeight.bold,

                                  ),),

                                ],
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: const <Widget>[
                                  Text('Chilled Jar'),
                                  Text('(C) Jar'),
                                  Text('Normal Jar'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: const <Widget>[
                                  Text('50pc (10pc)'),
                                  Text('30pc (4pc)'),
                                  Text('80pc (5pc)'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ),
      ],
  );

  Widget _buildEmptyDetails() => Column(
    children:<Widget>[
      const Padding(
        padding: EdgeInsets.all(0),
       // child: Text("Today Summary",textScaleFactor: 1.5,style: TextStyle(fontWeight:FontWeight.bold,color:Colors.blue),),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Table(
          border: TableBorder.all(width: 1.0, color: Colors.black),
          children: [
            TableRow(
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              children: [
                TableCell(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: const <Widget>[
                      Text('Loaded- Empty Jars',style: TextStyle(fontSize: 20.0,
                        fontWeight: FontWeight.bold,

                      ),),

                    ],
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const <Widget>[
                      Text('Chilled Jar'),
                      Text('Normal Jar'),
                    ],
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const <Widget>[
                      Text('5pc ( 20pc )'),
                      Text('10pc ( 30pc )'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );




  Widget _buildUnloadDetails() => Column(
    children:<Widget>[
      const Padding(
        padding: EdgeInsets.all(0),
        //child: Text("Today Summary",textScaleFactor: 1.5,style: TextStyle(fontWeight:FontWeight.bold,color:Colors.blue),),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Table(
          border: TableBorder.all(width: 1.0, color: Colors.black),
          children: [
            TableRow(
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              children: [
                TableCell(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: const <Widget>[
                      Text('Unloaded- Filled Jars',style: TextStyle(fontSize: 20.0,
                        fontWeight: FontWeight.bold,

                      ),),

                    ],
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const <Widget>[
                      Text('Chilled Jar'),
                      Text('(C) Jar'),
                      Text('Normal Jar'),
                    ],
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const <Widget>[
                      Text('10pc'),
                      Text('20pc'),
                      Text('10pc'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  Widget _buildUnloadEmptyDetails() => Column(
    children:<Widget>[
      const Padding(
        padding: EdgeInsets.all(0),
        //child: Text("Today Summary",textScaleFactor: 1.5,style: TextStyle(fontWeight:FontWeight.bold,color:Colors.blue),),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Table(
          border: TableBorder.all(width: 1.0, color: Colors.black),
          children: [
            TableRow(
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              children: [
                TableCell(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: const <Widget>[
                      Text('Unloaded- Empty Jars',style: TextStyle(fontSize: 20.0,
                        fontWeight: FontWeight.bold,

                      ),),

                    ],
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const <Widget>[
                      Text('Chilled Jar'),
                      Text('Normal Jar'),
                    ],
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const <Widget>[
                      Text('30pc'),
                      Text('20pc'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );


  Widget _buildCashForm()=>Column(
          children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(left:0.0,right: 0.0,top:10,bottom: 10),
                      //  padding: EdgeInsets.symmetric(horizontal: 0),
                        child: TextField(
                        decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Today Collected Cash',
                        hintText: 'Please enter collected cash',
                        ),
                        style: TextStyle(fontSize: 18),

                        ),

                      ),
            const Padding(
              padding: EdgeInsets.only(left:0.0,right: 0.0,top:10,bottom: 20),
              //  padding: EdgeInsets.symmetric(horizontal: 0),
              child: TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Comment',
                  hintText: 'Please enter Comment',
                ),
                style: TextStyle(fontSize: 18),

              ),

            ),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),


           ],
  );





  Widget _buildButton()=>Container(
    height: 50,
    width: 100,
    margin: const EdgeInsetsDirectional.fromSTEB(50, 0, 50, 10),//: const EdgeInsets.all(200),
    decoration: BoxDecoration(
        color: Colors.red, borderRadius: BorderRadius.circular(10)),
    child: TextButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Positioned(
                      right: -40.0,
                      top: -40.0,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const CircleAvatar(
                          child: Icon(Icons.close),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                     //   SizedBox(height: 50),
                       const Text('Please enter to end day!', style: TextStyle(color: Colors.black, fontSize: 18),),
                        const SizedBox(height: 10),
                        _buildCashForm(),
                      ],
                    )
                  ],
                ),
              );
            });
      },
      child: const Text(
        'Day End',
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    ),
  );

  Widget _buildLogoutButton()=>Container(
    height: 50,
    width: 100,
    margin: const EdgeInsetsDirectional.fromSTEB(50, 0, 50, 10),//: const EdgeInsets.all(200),
    decoration: BoxDecoration(
        color: Colors.red, borderRadius: BorderRadius.circular(10)),
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
        'Logout',
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    ),
  );
}
