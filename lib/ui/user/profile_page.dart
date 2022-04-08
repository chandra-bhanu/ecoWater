import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:eco_water_app/ui/home/home_page.dart';
import 'package:eco_water_app/app/app_icons.dart';
import 'package:eco_water_app/app/ui/auth/login_page.dart';

import 'dayend_page.dart';

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
        title: Text("Profile Page"),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
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
        ],
      ),
    );
  }

  Widget _ProfileWidget()=>Container(
   // margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(20),
    width: 90,
    height: 90,
    child: Center(
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
    children: [
      Text(
        'John Doe',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        '+91- 900000001',
        style: TextStyle(color: Colors.grey),
      )
    ],
  );
  //
  Widget _buildDetails() => Column(
      children:<Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Today Summary",textScaleFactor: 1.5,style: TextStyle(fontWeight:FontWeight.bold,color:Colors.blue),),
        ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Table(
                      border: TableBorder.all(width: 1.0, color: Colors.black),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            color: Colors.green,
                          ),
                          children: [
                            TableCell(
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,

                                children: <Widget>[
                                  new Text('Loaded- Filled Jars',style: TextStyle(fontSize: 20.0,
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
                                children: <Widget>[
                                  new Text('Chilled Jar'),
                                  new Text('(C) Jar'),
                                  new Text('Normal Jar'),
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
                                children: <Widget>[
                                  new Text('50pc (10pc)'),
                                  new Text('30pc (4pc)'),
                                  new Text('80pc (5pc)'),
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
      Padding(
        padding: const EdgeInsets.all(0),
       // child: Text("Today Summary",textScaleFactor: 1.5,style: TextStyle(fontWeight:FontWeight.bold,color:Colors.blue),),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Table(
          border: TableBorder.all(width: 1.0, color: Colors.black),
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              children: [
                TableCell(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: <Widget>[
                      new Text('Loaded- Empty Jars',style: TextStyle(fontSize: 20.0,
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
                    children: <Widget>[
                      new Text('Chilled Jar'),
                      new Text('Normal Jar'),
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
                    children: <Widget>[
                      new Text('5pc ( 20pc )'),
                      new Text('10pc ( 30pc )'),
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
      Padding(
        padding: const EdgeInsets.all(0),
        //child: Text("Today Summary",textScaleFactor: 1.5,style: TextStyle(fontWeight:FontWeight.bold,color:Colors.blue),),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Table(
          border: TableBorder.all(width: 1.0, color: Colors.black),
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              children: [
                TableCell(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: <Widget>[
                      new Text('Unloaded- Filled Jars',style: TextStyle(fontSize: 20.0,
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
                    children: <Widget>[
                      new Text('Chilled Jar'),
                      new Text('(C) Jar'),
                      new Text('Normal Jar'),
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
                    children: <Widget>[
                      new Text('10pc'),
                      new Text('20pc'),
                      new Text('10pc'),
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
      Padding(
        padding: const EdgeInsets.all(0),
        //child: Text("Today Summary",textScaleFactor: 1.5,style: TextStyle(fontWeight:FontWeight.bold,color:Colors.blue),),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Table(
          border: TableBorder.all(width: 1.0, color: Colors.black),
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              children: [
                TableCell(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: <Widget>[
                      new Text('Unloaded- Empty Jars',style: TextStyle(fontSize: 20.0,
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
                    children: <Widget>[
                      new Text('Chilled Jar'),
                      new Text('Normal Jar'),
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
                    children: <Widget>[
                      new Text('30pc'),
                      new Text('20pc'),
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
                      Padding(
                        padding: const EdgeInsets.only(left:0.0,right: 0.0,top:10,bottom: 10),
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
            Padding(
              padding: const EdgeInsets.only(left:0.0,right: 0.0,top:10,bottom: 20),
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
                child: Text(
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
                        child: CircleAvatar(
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
                        SizedBox(height: 10),
                        _buildCashForm(),
                      ],
                    )
                  ],
                ),
              );
            });
      },
      child: Text(
        'Day End',
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    ),
  );


}
