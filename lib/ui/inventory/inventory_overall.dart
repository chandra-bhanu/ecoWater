import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:eco_water_app/ui/widgets/common_widgets.dart';
import 'package:eco_water_app/app/app_icons.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:eco_water_app/models/inventory_summary_model.dart';
import 'dart:async' show Future;

import 'package:eco_water_app/ui/inventory/inventory_update.dart';

Future<AllInventoryLogs> fetchEntries() async {
  final response =
      await rootBundle.loadString('assets/json/inventoryOverall.json');
  if (response != '') {
    //print(response);
    return AllInventoryLogs.fromJson(json.decode(response));
  } else {
    throw Exception('Failed to get entries');
  }
}

class InventoryOverall extends StatefulWidget {
  //final int customerId;
  const InventoryOverall({Key? key}) : super(key: key);
  //const CustomersDetails({Key? key, required this.customerId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _InventoryOverallState();
  }
}

class _InventoryOverallState extends State<InventoryOverall> {
  Future<AllInventoryLogs>? futureEntries;
  @override
  void initState() {
    super.initState();
    futureEntries = fetchEntries();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFdee0df),
        appBar: AppBar(
          title: Text('Overall Inventory'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHistory(context),
            ],
          ),
        ));
  }

  Widget _buildHistory(BuildContext context) {
    return FutureBuilder<AllInventoryLogs>(
        future: futureEntries,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<AllInventoryLogs> allInventoryLogs = [];
                //  print(snapshot.data!.chilledJarsLog.total);
                  return Container(
                        child: Column(
                          children:  [
                               SizedBox(height: 10,),

                              //First Box

                              Card(
                                clipBehavior: Clip.antiAlias,
                                margin:  EdgeInsets.all(10),
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children:  [
                                    ListTile(
                                      tileColor: Colors.white,
                                      //  color:Colors.
                                      leading: CircleAvatar(
                                          child:Image.asset(
                                            AppIcons.chilledJar,
                                            height: 25,
                                              width: 25,
                                          ),
                                      ),
                                      title: Text('Chilled Jars',style:TextStyle(fontSize: 18,color:Colors.blue,fontWeight:FontWeight.bold)),
                                      trailing: IconButton(
                                          color: Colors.blue,
                                          icon: Icon(Icons.edit),
                                          onPressed: (){

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>  const InventoryUpdate(),
                                                settings: RouteSettings(
                                                  arguments:'Chilled',
                                                ),
                                              ),

                                            ).then((value) => setState(() {}));



                                        //logic to open POPUP window
                                         }),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(width: 0.5, color: Colors.cyan),
                                          left: BorderSide(width: 0, color: Colors.transparent),
                                          right: BorderSide(width:0, color: Colors.transparent),
                                          bottom: BorderSide(width: 0.5,color: Colors.cyan),
                                        ),
                                      ),

                                      child:Row(
                                        children:   [
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              padding: const EdgeInsets.only(top:10.0,bottom:10.0,left:15.0,right:15.0),

                                              child:Text('Total Chilled Jars In Stock'),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child:  Center(
                                                child: Text('${snapshot.data!.chilledJarsLog.total}')
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(width: 0.5, color: Colors.cyan),
                                          left: BorderSide(width: 0, color: Colors.transparent),
                                          right: BorderSide(width:0, color: Colors.transparent),
                                          bottom: BorderSide(width: 0.5,color: Colors.cyan),
                                        ),
                                      ),

                                      child:Row(
                                        children:   [
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              padding: const EdgeInsets.only(top:10.0,bottom:10.0,left:15.0,right:15.0),
                                              color: Color(0xFFebebeb),
                                              child:Text('Jar Entry Calculations',style:TextStyle(color:Colors.blue,)),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child:   Text(''),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(width: 0.5, color: Colors.cyan),
                                          left: BorderSide(width: 0, color: Colors.transparent),
                                          right: BorderSide(width:0, color: Colors.transparent),
                                          bottom: BorderSide(width: 0.5,color: Colors.cyan),
                                        ),
                                      ),

                                      child:Row(
                                        children:   [
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              padding: const EdgeInsets.only(top:10.0,bottom:10.0,left:15.0,right:15.0),
                                              color: Color(0xFFebebeb),
                                              child:Text('Chilled Jars With Customer'),
                                            ),
                                          ),
                                          Expanded(
                                            flex:2,
                                            child:  Center(
                                              child: Text('${snapshot.data!.chilledJarsLog.customerActive}')
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(width: 0.5, color: Colors.cyan),
                                          left: BorderSide(width: 0, color: Colors.transparent),
                                          right: BorderSide(width:0, color: Colors.transparent),
                                          bottom: BorderSide(width: 0.5,color: Colors.cyan),
                                        ),
                                      ),

                                      child:Row(
                                        children:   [
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              padding: const EdgeInsets.only(top:10.0,bottom:10.0,left:15.0,right:15.0),
                                              color: Color(0xFFebebeb),
                                              child:Text('Chilled Jars With Inactive Customer'),
                                            ),
                                          ),
                                          Expanded(
                                            flex:2,
                                            child:  Center(
                                                child: Text('${snapshot.data!.chilledJarsLog.customerInActive}')
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(width: 0.5, color: Colors.cyan),
                                          left: BorderSide(width: 0, color: Colors.transparent),
                                          right: BorderSide(width:0, color: Colors.transparent),
                                          bottom: BorderSide(width: 0.5,color: Colors.cyan),
                                        ),
                                      ),

                                      child:Row(
                                        children:   [
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              padding: const EdgeInsets.only(top:10.0,bottom:10.0,left:15.0,right:15.0),
                                              color: Color(0xFFd1cfcf),
                                              child:Text('Total Chilled Jars With Customer'),
                                            ),
                                          ),
                                          Expanded(
                                            flex:2,
                                            child:  Center(
                                                child: Text('-${snapshot.data!.chilledJarsLog.totalCustomer}')
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(width: 0.5, color: Colors.cyan),
                                          left: BorderSide(width: 0, color: Colors.transparent),
                                          right: BorderSide(width:0, color: Colors.transparent),
                                          bottom: BorderSide(width: 0.5,color: Colors.cyan),
                                        ),
                                      ),

                                      child:Row(
                                        children:   [
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              padding: const EdgeInsets.only(top:10.0,bottom:10.0,left:15.0,right:15.0),

                                              child:Text('Current Available Chilled Jars'),
                                            ),
                                          ),
                                          Expanded(
                                            flex:2,
                                            child:  Center(
                                                child: Text(
                                                    '${snapshot.data!.chilledJarsLog.available}',
                                                    style:TextStyle(color:Colors.blue, fontWeight: FontWeight.bold))
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                            Card(
                              clipBehavior: Clip.antiAlias,
                              margin:  EdgeInsets.all(10),
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children:  [
                                  ListTile(
                                    tileColor: Colors.white,
                                    //  color:Colors.
                                    leading: CircleAvatar(
                                      child:Image.asset(
                                        AppIcons.normalJar,
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                    title: Text('Normal Jars',style:TextStyle(fontSize: 18,color:Colors.blue,fontWeight:FontWeight.bold)),
                                    trailing: IconButton(
                                        color: Colors.blue,
                                        icon: Icon(Icons.edit),
                                        onPressed: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>  const InventoryUpdate(),
                                              settings: RouteSettings(
                                                arguments:'Normal',
                                              ),
                                            ),

                                          ).then((value) => setState(() {}));
                                        }),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(width: 0.5, color: Colors.cyan),
                                        left: BorderSide(width: 0, color: Colors.transparent),
                                        right: BorderSide(width:0, color: Colors.transparent),
                                        bottom: BorderSide(width: 0.5,color: Colors.cyan),
                                      ),
                                    ),

                                    child:Row(
                                      children:   [
                                        Expanded(
                                          flex: 8,
                                          child: Container(
                                            padding: const EdgeInsets.only(top:10.0,bottom:10.0,left:15.0,right:15.0),

                                            child:Text('Total Normal Jars In Stock'),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child:  Center(
                                              child: Text('${snapshot.data!.normalJarsLog.total}')
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(width: 0.5, color: Colors.cyan),
                                        left: BorderSide(width: 0, color: Colors.transparent),
                                        right: BorderSide(width:0, color: Colors.transparent),
                                        bottom: BorderSide(width: 0.5,color: Colors.cyan),
                                      ),
                                    ),

                                    child:Row(
                                      children:   [
                                        Expanded(
                                          flex: 8,
                                          child: Container(
                                            padding: const EdgeInsets.only(top:10.0,bottom:10.0,left:15.0,right:15.0),
                                            color: Color(0xFFebebeb),
                                            child:Text('Jar Entry Calculations',style:TextStyle(color:Colors.blue,)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child:   Text(''),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(width: 0.5, color: Colors.cyan),
                                        left: BorderSide(width: 0, color: Colors.transparent),
                                        right: BorderSide(width:0, color: Colors.transparent),
                                        bottom: BorderSide(width: 0.5,color: Colors.cyan),
                                      ),
                                    ),

                                    child:Row(
                                      children:   [
                                        Expanded(
                                          flex: 8,
                                          child: Container(
                                            padding: const EdgeInsets.only(top:10.0,bottom:10.0,left:15.0,right:15.0),
                                            color: Color(0xFFebebeb),
                                            child:Text('Normal Jars With Customer'),
                                          ),
                                        ),
                                        Expanded(
                                          flex:2,
                                          child:  Center(
                                              child: Text('${snapshot.data!.normalJarsLog.customerActive}')
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(width: 0.5, color: Colors.cyan),
                                        left: BorderSide(width: 0, color: Colors.transparent),
                                        right: BorderSide(width:0, color: Colors.transparent),
                                        bottom: BorderSide(width: 0.5,color: Colors.cyan),
                                      ),
                                    ),

                                    child:Row(
                                      children:   [
                                        Expanded(
                                          flex: 8,
                                          child: Container(
                                            padding: const EdgeInsets.only(top:10.0,bottom:10.0,left:15.0,right:15.0),
                                            color: Color(0xFFebebeb),
                                            child:Text('Normal Jars With Inactive Customer'),
                                          ),
                                        ),
                                        Expanded(
                                          flex:2,
                                          child:  Center(
                                              child: Text('${snapshot.data!.normalJarsLog.customerInActive}')
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(width: 0.5, color: Colors.cyan),
                                        left: BorderSide(width: 0, color: Colors.transparent),
                                        right: BorderSide(width:0, color: Colors.transparent),
                                        bottom: BorderSide(width: 0.5,color: Colors.cyan),
                                      ),
                                    ),

                                    child:Row(
                                      children:   [
                                        Expanded(
                                          flex: 8,
                                          child: Container(
                                            padding: const EdgeInsets.only(top:10.0,bottom:10.0,left:15.0,right:15.0),
                                            color: Color(0xFFd1cfcf),
                                            child:Text('Total Normal Jars With Customer'),
                                          ),
                                        ),
                                        Expanded(
                                          flex:2,
                                          child:  Center(
                                              child: Text('-${snapshot.data!.normalJarsLog.totalCustomer}')
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(width: 0.5, color: Colors.cyan),
                                        left: BorderSide(width: 0, color: Colors.transparent),
                                        right: BorderSide(width:0, color: Colors.transparent),
                                        bottom: BorderSide(width: 0.5,color: Colors.cyan),
                                      ),
                                    ),

                                    child:Row(
                                      children:   [
                                        Expanded(
                                          flex: 8,
                                          child: Container(
                                            padding: const EdgeInsets.only(top:10.0,bottom:10.0,left:15.0,right:15.0),

                                            child:Text('Current Available Chilled Jars'),
                                          ),
                                        ),
                                        Expanded(
                                          flex:2,
                                          child:  Center(
                                              child: Text(
                                                  '${snapshot.data!.normalJarsLog.available}',
                                                  style:TextStyle(color:Colors.blue, fontWeight: FontWeight.bold))
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                  );

          } else if (snapshot.hasError) {
            print(snapshot.toString());
            return const Center(
              child: Text('Error!'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
