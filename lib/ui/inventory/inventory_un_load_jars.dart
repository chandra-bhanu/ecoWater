import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eco_water_app/ui/widgets/common_widgets.dart';
import 'package:eco_water_app/app/app_icons.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:eco_water_app/models/base_data_model.dart';
import 'dart:async' show Future;

Future<AllbaseData> fetchEntries() async {
  final response =
  await rootBundle.loadString('assets/json/baseData.json');
  if (response != '') {
    return AllbaseData.fromJson(json.decode(response));
  } else {
    throw Exception('Failed to get entries');
  }
}


class InventoryLoadJars extends StatefulWidget {
  //final int customerId;
  const InventoryLoadJars({Key? key}) : super(key: key);
  //const CustomersDetails({Key? key, required this.customerId}) : super(key: key);

  @override  State<StatefulWidget> createState() {
    return new _InventoryLoadJarsState();
  }
}

class _InventoryLoadJarsState extends State<InventoryLoadJars> {

  Future<AllbaseData>? futureEntries;
  @override
  void initState() {
    super.initState();
    futureEntries = fetchEntries();
  }

  String _employeeSelection = 'Employee';
  String _vehicleSelection = 'Vehicle';
  List data = List.empty(growable: true);

  //String _employeeSelection='';

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021, 12),
        lastDate: DateTime(2025));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFdee0df),
      appBar: AppBar(
        title: Text('Load Jars'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildForm(context),
          ],
        ),
      ),
    );
  }


  Widget _buildForm(BuildContext context) =>
      Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(0.0),
        // elevation: 5,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child:Column(
          children: [
             //TOP BAR
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //calender and vehicle , employee
                Container(
                  margin: EdgeInsets.only(bottom: 10.0, top: 20.0,),
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.2,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5,
                                    spreadRadius: 0.5,
                                    offset: Offset(0, 2)
                                ),
                              ],
                            ),
                            child: Text(
                                DateFormat('dd-MMMM-yyyy').format(selectedDate))
                        ),
                      ),


                    ],
                  ),
                ),
                //vehicle , employee
                Container(
                  margin: EdgeInsets.only(bottom: 10.0, top: 20.0,),
                  padding: const EdgeInsets.only(left:10.0, right:10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          spreadRadius: 0.5,
                          offset: Offset(0, 2)
                      ),
                    ],
                  ),
                  child:FutureBuilder<AllbaseData>(
                      future: futureEntries,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<AllbaseData> allbaseData = [];
                          return  DropdownButton(
                            isExpanded: false,
                            value: _employeeSelection,
                            items: snapshot.data!.employeeList.map(
                                    (value) {
                                  return DropdownMenuItem(
                                    value: value.name,
                                    child:Text('${value.name}'),
                                  );
                                }
                            ).toList(),
                            onChanged: (value) {
                              setState((){
                                _employeeSelection = value as String;
                              });
                            },
                          );
                        }
                        else if (snapshot.hasError) {
                          print(snapshot.toString());
                          return const Center(
                            child: Text('Error!'),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                      }
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0, top: 20.0,),
                  padding: const EdgeInsets.only(left:10.0, right:10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          spreadRadius: 0.5,
                          offset: Offset(0, 2)
                      ),
                    ],
                  ),
                  child:FutureBuilder<AllbaseData>(
                      future: futureEntries,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<AllbaseData> allbaseData = [];
                          return  DropdownButton(
                            isExpanded: false,
                            value: _vehicleSelection,
                            items: snapshot.data!.vehiclesList.map(
                                    (value) {
                                  return DropdownMenuItem(
                                    value: value.name,
                                    child:Text('${value.name}'),
                                  );
                                }
                            ).toList(),
                            onChanged: (value) {
                              setState((){
                                _vehicleSelection = value as String;
                              });
                            },
                          );
                        }
                        else if (snapshot.hasError) {
                          print(snapshot.toString());
                          return const Center(
                            child: Text('Error!'),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                      }
                  ),
                ),

              ],
            ),
        Container(
          margin: EdgeInsets.only(bottom:10.0),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 0.5, color: Colors.cyan),
              left: BorderSide(width: 0, color: Colors.transparent),
              right: BorderSide(width:0, color: Colors.transparent),
              bottom: BorderSide(width: 0.5,color: Colors.cyan),
            ),
          ),),
            //F0rm Body
        Container(
          margin: EdgeInsets.only(left: 80.0, right: 80.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Filled Jars\n',style:TextStyle(fontSize: 16,color:Colors.blue),),
              Row(
                children: [
                  JarIcons('Chilled', AppIcons.chilledJar, 30, 30),
                  SizedBox(width: 25),
                  Expanded(
                    child:TextFormField(
                      initialValue: "0",
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText:"Quantity",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  JarIcons('Normal', AppIcons.normalJar, 30, 30),
                  SizedBox(width: 25),
                  Expanded(
                    child:TextFormField(
                      initialValue: "0",
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText:"Quantity",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  JarIcons('NC jAR', AppIcons.mixJar, 30, 30),
                  SizedBox(width: 25),
                  Expanded(
                    child:TextFormField(
                      initialValue: "0",
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText:"Quantity",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
            Container(
              margin: EdgeInsets.only(bottom:10.0),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 0.5, color: Colors.cyan),
                  left: BorderSide(width: 0, color: Colors.transparent),
                  right: BorderSide(width:0, color: Colors.transparent),
                  bottom: BorderSide(width: 0.5,color: Colors.cyan),
                ),
              ),),
            //F0rm Body
            Container(
              margin: EdgeInsets.only(left: 80.0, right: 80.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Empty Jars\n',style:TextStyle(fontSize: 16,color:Colors.red),),
                  Row(
                    children: [
                      JarIcons('Chilled', AppIcons.chilledJar, 30, 30),
                      SizedBox(width: 25),
                      Expanded(
                        child:TextFormField(
                          initialValue: "0",
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText:"Quantity",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      JarIcons('Normal', AppIcons.normalJar, 30, 30),
                      SizedBox(width: 25),
                      Expanded(
                        child:TextFormField(
                          initialValue: "0",
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText:"Quantity",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 0.5, color: Colors.cyan),
                  left: BorderSide(width: 0, color: Colors.transparent),
                  right: BorderSide(width:0, color: Colors.transparent),
                  bottom: BorderSide(width: 0.5,color: Colors.cyan),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      const snackBar = SnackBar(
                        content: Text('Jar Loaded!'),
                        backgroundColor: Colors.green,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context);

                    },
                    child: Text('Save'),
                  ),

                ],


              ),

            ),


          ],
        ),

      );


}
