import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eco_water_app/ui/widgets/common_widgets.dart';
import 'package:eco_water_app/app/app_icons.dart';



import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:eco_water_app/models/inventory_reports_model.dart';
import 'package:eco_water_app/models/base_data_model.dart';
import 'dart:async' show Future;

Future<AllReports> fetchReportEntries() async
{
  final response = await rootBundle.loadString('assets/json/inventoryReport.json');
  if(response != '')
  {
   // print(response);
    return AllReports.fromJson(json.decode(response));
  }
  else{
    throw Exception('Failed to get entries');
  }
}

Future<AllbaseData> fetchEntries() async {
  final response =
  await rootBundle.loadString('assets/json/baseData.json');
  if (response != '') {
    return AllbaseData.fromJson(json.decode(response));
  } else {
    throw Exception('Failed to get entries');
  }
}



class InventoryReports extends StatefulWidget {
  //final int customerId;
  const InventoryReports({Key? key}) : super(key: key);
  //const CustomersDetails({Key? key, required this.customerId}) : super(key: key);

  @override  State<StatefulWidget> createState() {
    return new _InventoryReportsState();
  }
}



class _InventoryReportsState extends State<InventoryReports> {

  Future<AllReports>? futureReportEntries;
  Future<AllbaseData>? futureEntries;

  @override
  void initState()
  {
    super.initState();
    futureEntries=fetchEntries();
    futureReportEntries=fetchReportEntries();
  }

  String _employeeSelection = 'Employee';
  String _vehicleSelection = 'Vehicle';
  List data = List.empty(growable: true);


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


  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Day To Day Inventory'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTop(context),
            _buildHistory(context),
          ],
        ),
      )
    );


  }


 _buildTop(context)=>Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.all(0.0),
          child:Column(
              children: [
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

              ],
          ),
      );

  Widget  _buildHistory(BuildContext context)
  {
    return FutureBuilder<AllReports>(
        future: futureReportEntries,
        builder: (context,snapshot)
        {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.deliveries.length,
                            itemBuilder: (BuildContext context, index) {
                              return Container(
                                //padding: const EdgeInsets.only(bottom:10.0),
                               // margin: EdgeInsets.only(bottom:15.0),
                                width: MediaQuery.of(context).size.width,
                                color: Color(0xFFefefef),
                                child: Column(
                                  children:   [
                                    ListTile(
                                      tileColor: Colors.white,
                                      //  color:Colors.
                                      leading: const CircleAvatar(
                                        child:Icon(
                                          Icons.account_circle,
                                          color:Colors.blue,
                                          size: 40,
                                        ),
                                      ),
                                      title: Text(
                                          snapshot.data!.deliveries[index].name,
                                          style:const TextStyle(fontSize: 16,color:Colors.blue,fontWeight:FontWeight.bold)
                                      ),

                                    ),

                                    Container(
                                      padding: EdgeInsets.all(15.0),
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.asset(
                                                AppIcons.loadJarIcon,
                                                width: 35.0,
                                                height: 35.0,
                                              ),

                                               SizedBox(width: 10.0),

                                              Center(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text('Total Jars'),
                                                    Text('Loaded'),
                                                    SizedBox(height: 10.0),
                                                    Text('${snapshot.data!.deliveries[index].inventoryDetails.loaded}',
                                                      style: TextStyle(fontSize: 20, color: Colors.indigo, fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Image.asset(
                                                AppIcons.rightArrow,
                                                width: 20.0,
                                                height: 20.0,
                                              ),

                                              Center(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text('Delivered'),
                                                    Text('Jar'),
                                                    SizedBox(height: 10.0),
                                                    Text('${snapshot.data!.deliveries[index].inventoryDetails.delivered}',
                                                      style: TextStyle(fontSize: 20, color: Colors.indigo, fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Image.asset(
                                                AppIcons.rightArrow,
                                                width: 20.0,
                                                height: 20.0,
                                              ),

                                              Center(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text('Returned'),
                                                    Text('Filled Jar'),
                                                    SizedBox(height: 10.0),
                                                    Text('${snapshot.data!.deliveries[index].inventoryDetails.returnFilled}',
                                                      style: TextStyle(fontSize: 20, color: Colors.indigo, fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),


                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      alignment: Alignment.topRight,
                                      width:  double.infinity,
                                      padding: EdgeInsets.only(right: 40.0),
                                      color: Colors.white,
                                      child: Column(
                                       // mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            SizedBox(height: 5.0),
                                            Image.asset(
                                              AppIcons.downArrow,
                                              width: 25.0,
                                              height: 25.0,
                                            ),

                                            SizedBox(height: 5.0),
                                          ],
                                      ),
                                    ),

                                    Container(
                                      padding: EdgeInsets.all(15.0),
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.asset(
                                                AppIcons.unloadJarIcon,
                                                width: 35.0,
                                                height: 35.0,
                                              ),

                                              SizedBox(width: 10.0),

                                              Center(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text('Actual Jars'),
                                                    Text('UnLoaded'),
                                                    SizedBox(height: 10.0),
                                                    Text('${snapshot.data!.deliveries[index].inventoryDetails.loaded}',
                                                      style: TextStyle(fontSize: 20, color: Colors.indigo, fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Image.asset(
                                                AppIcons.leftArrow,
                                                width: 20.0,
                                                height: 20.0,
                                              ),

                                              Center(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text('Calculated Jar'),
                                                    Text('Unloaded'),
                                                    SizedBox(height: 10.0),
                                                    Text('${snapshot.data!.deliveries[index].inventoryDetails.delivered}',
                                                      style: TextStyle(fontSize: 20, color: Colors.indigo, fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Image.asset(
                                                AppIcons.leftArrow,
                                                width: 20.0,
                                                height: 20.0,
                                              ),

                                              Center(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text('Collected'),
                                                    Text('Empty Jar'),
                                                    SizedBox(height: 10.0),
                                                    Text('${snapshot.data!.deliveries[index].inventoryDetails.returnFilled}',
                                                      style: TextStyle(fontSize: 20, color: Colors.indigo, fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),


                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                Container(
                                  alignment: Alignment.topRight,
                                  width:  double.infinity,
                                  height: 2,
                                  padding: EdgeInsets.only(right: 40.0),
                                  color: Colors.indigoAccent,
                                ),
                                  ],
                                ),
                              );
                            }
                          ),
              ],
            );
          }
          else if(snapshot.hasError)
          {
            print(snapshot.toString());
            return const Center(
              child:Text('Error!'),
            );
          }
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );
  }





}


