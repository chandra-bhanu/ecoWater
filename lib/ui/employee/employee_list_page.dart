import 'package:eco_water_app/models/employee_model.dart';
import 'package:eco_water_app/ui/employee/employee_detail_page.dart';
import 'package:eco_water_app/ui/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:eco_water_app/app/app_icons.dart';
import 'package:url_launcher/url_launcher.dart';


import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:async' show Future;

import 'package:eco_water_app/services/employee_services.dart';


class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);
  @override  State<StatefulWidget> createState() {
    return _EmployeeListState();
  }
}
class _EmployeeListState extends State<EmployeeList> {
  late Future<EmployeeListResponse> futureEntries;

  // @override
  // void initState()
  // {
  //   super.initState();
  //   futureEntries=fetchEmployees();
  // }



  @override  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Employees',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        body:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildList(context),
            ],
          ),
        ),
    );
  }

  _buildList(BuildContext context) {
    return FutureBuilder<List <DataReturn>>(
      future: getEmployeeList(),
      builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, index) {
                    return Column(
                      children: [
                        const SizedBox(height: 10,),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          margin:  const EdgeInsets.all(10),
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            children:  [
                              ListTile(
                                tileColor: Colors.white,
                                //  color:Colors.
                                leading: CircleAvatar(
                                    backgroundColor: (snapshot.data![index].status=="1")? Colors.green: Colors.red,
                                    child: Text(
                                        snapshot.data![index].name!.substring(0, 1))

                                ),
                                title: Text('${snapshot.data![index].name}(${snapshot.data![index].statusLabel})',style:const TextStyle(fontSize: 18,color:Colors.blue,fontWeight:FontWeight.bold)),
                                subtitle: Text(
                                  '${snapshot.data![index].mobile}\n${snapshot.data![index].registeredOn}\nType: ${snapshot.data![index].type}',
                                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                ),
                                trailing: IconButton(
                                    color: Colors.blue,
                                    icon: const Icon(Icons.arrow_forward_rounded),
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>  const EmployeeDetails(),
                                          settings: RouteSettings(
                                            arguments: snapshot.data![index].userId,
                                          ),
                                        ),

                                      ).then((value) => setState(() {}));
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          }
          else if (snapshot.hasError) {
            //print(snapshot.toString());
            return const Center(
              child: Text('Error!'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
      }
    );
  }




}

