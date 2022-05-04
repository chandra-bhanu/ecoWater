import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:eco_water_app/ui/widgets/common_widgets.dart';
import 'package:eco_water_app/app/app_icons.dart';



import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:eco_water_app/models/inventory_entries_model.dart';
import 'dart:async' show Future;

Future<AllInventory> fetchEntries() async
{
  final response = await rootBundle.loadString('assets/json/inventoryEntryListData.json');
  if(response != '')
  {
    //print(response);
    return AllInventory.fromJson(json.decode(response));
  }
  else{
    throw Exception('Failed to get entries');
  }
}



class InventoryList extends StatefulWidget {
  //final int customerId;
  const InventoryList({Key? key}) : super(key: key);
  //const CustomersDetails({Key? key, required this.customerId}) : super(key: key);

  @override  State<StatefulWidget> createState() {
    return new _InventoryListState();
  }
}



class _InventoryListState extends State<InventoryList> {

  Future<AllInventory>? futureEntries;
  @override
  void initState()
  {
    super.initState();
    futureEntries=fetchEntries();
  }


  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Inventory'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTopButton(),
            _buildLong(),
            //_buildMasterLink(),
           _buildHistory(context),
          ],
        ),
      )
    );


  }


  Widget _buildTopButton()=>Stack(
    children: <Widget>[
      Container(
        alignment: Alignment.topCenter,
        height:110,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
      ),
      Container(
        child: Center(
              child: Container(
                padding: const EdgeInsets.only(top: 30.0,bottom:20.0),
                width: MediaQuery.of(context).size.width-50,
                color: Colors.transparent,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  <Widget>[
                    makeLinkItem("Load Jars", AppIcons.loadJar,"loadJars"),
                    makeLinkItem("Unload Jars", AppIcons.unloadJar,"unloadJars"),
                  ],
      ),
          ),
        ),
      ),





    ],
  );


  Widget _buildLong()=>Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children:  <Widget>[
      makeLongLink("Overall Jars Inventory", AppIcons.normalJar,"inventoryOverall"),
      makeLongLink("Inventory Report", AppIcons.ecoSmallIcon,"inventoryReport"),
    ],
  );


 Container makeLongLink(String title, String icon, String pageName )
 {
   return Container(

     padding: const EdgeInsets.all(20.0),
     margin: const EdgeInsets.only(top:5.0,bottom: 5.0, left:40.0, right: 40.0),
     decoration: BoxDecoration(
         color: Colors.white,
         boxShadow: [
           //background color of box
           // BoxShadow(
           //   color: Colors.grey.withOpacity(0.3),
           //   spreadRadius: 3,
           //   blurRadius: 5,
           //   offset: Offset(0, 1),
           // )
         ],
         border: Border.all(
           color: Colors.black12,
         ),
         borderRadius: BorderRadius.all(Radius.circular(15))
     ),
     child: InkWell(
       onTap: () {
         Navigator.of(context).pushNamed(pageName);
       },
       child: Row(

         children: [
           Image.asset(
             icon,
             width: 30.0,
             height: 30.0,
           ),
           SizedBox(width: 15.0),
           Text(
             title,
             style: TextStyle(color: Color(0xff4374ba), fontSize:14,fontWeight: FontWeight.bold),
           ),
           SizedBox(width: 15.0),
           Text(
             '>',
             style: TextStyle(color: Color(0xff4374ba), fontSize:14,fontWeight: FontWeight.bold),
           ),
         ],
       ),
     ),
   );
 }


Container makeLinkItem(String title, String icon, String pageName ) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            //background color of box
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 2),
            )
          ],
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: InkWell(
        onTap: () {
         Navigator.of(context).pushNamed(pageName);

        },
      child: Column(

        children: [
           Image.asset(
            icon,
            width: 100.0,
            height: 100.0,
          ),
          SizedBox(height: 5.0),
          Text(
            title,
            style: TextStyle(color: Color(0xff4374ba), fontSize:14,fontWeight: FontWeight.bold),
          ),
        ],
      ),
      ),
    );
  }


  Widget  _buildHistory(BuildContext context)
  {
    return FutureBuilder<AllInventory>(
        future: futureEntries,
        builder: (context,snapshot)
        {
          if (snapshot.hasData) {
            List<InventoryListData> inventoryListData = [];
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(top:10.0),
                                      padding: const EdgeInsets.only(top:10.0, bottom:10.0),
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.blue,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Today's Load / Unload History",
                                              style:TextStyle(fontSize: 16,color:Colors.white,fontWeight:FontWeight.bold),
                                            ),
                                            Text(
                                              "(Tap row to edit the entry)",
                                              style:TextStyle(fontSize: 12,color:Colors.white,fontWeight:FontWeight.bold),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                     // / margin: const EdgeInsets.only(left:10.0, right:10.0),
                                      padding: const EdgeInsets.only(top:10.0, bottom:10.0),
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children:const [
                                          Text(
                                            "Time",
                                            style:TextStyle(fontSize: 14,color:Colors.black),
                                          ),
                                          Text(
                                            "Employee",
                                            style:TextStyle(fontSize: 14,color:Colors.black),
                                          ),
                                          Text(
                                            "Type",
                                            style:TextStyle(fontSize: 14,color:Colors.black),
                                          ),
                                          Text(
                                            "Quantity",
                                            style:TextStyle(fontSize: 14,color:Colors.black),
                                          ),
                                        ],

                                      ),
                                    ),

                                    ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data!.inventoryList.length,
                                    itemBuilder: (BuildContext context, index) {

                                        return Container(
                                            padding: const EdgeInsets.only(top:10.0, bottom:10.0),
                                            width: MediaQuery.of(context).size.width,
                                            color: index%2 == 0? Color(0xFFefefef):Colors.white,
                                            child: InkWell(
                                              onTap: (){
                                               showAlertDialog(context,snapshot.data!.inventoryList[index].time,snapshot.data!.inventoryList[index].name,snapshot.data!.inventoryList[index].id,snapshot.data!.inventoryList[index]);
                                              },
                                              child:Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                                    snapshot.data!.inventoryList[index].time,
                                                    style:TextStyle(fontSize: 12,color:Colors.black),
                                                  ),
                                                  Text(
                                                    snapshot.data!.inventoryList[index].name,
                                                    style:TextStyle(fontSize: 12,color:Colors.black),
                                                  ),
                                                  Text(
                                                    snapshot.data!.inventoryList[index].type,
                                                    style:TextStyle(fontSize: 12,color:Colors.black),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Container(

                                                        width :120,
                                                        color: Colors.lightGreen,
                                                        child:Center(
                                                            child:Text(
                                                                'Filled Jars',
                                                                //   '(${snapshot.data!.inventoryList[index].inventoryJarEmpty.total})',
                                                                style:TextStyle(fontSize: 12,color:Colors.black)
                                                            )
                                                        ),
                                                      ),
                                                      SizedBox(height: 5.0),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              JarIcons('Chilled',AppIcons.chilledJar, 30, 30),
                                                              Text('${snapshot.data!.inventoryList[index].inventoryJarFilled.chilled} Pc',style:TextStyle(fontSize: 12,color:Colors.black)),
                                                            ],
                                                          ),
                                                          SizedBox(width: 10.0),
                                                          Column(
                                                            children: [
                                                              JarIcons('Normal',AppIcons.normalJar, 30, 30),
                                                              Text('${snapshot.data!.inventoryList[index].inventoryJarFilled.normal} Pc',style:TextStyle(fontSize: 12,color:Colors.black)),
                                                            ],
                                                          ),
                                                          SizedBox(width: 10.0),
                                                          Column(
                                                            children: [
                                                              JarIcons('Nc',AppIcons.mixJar, 30, 30),
                                                              Text('${snapshot.data!.inventoryList[index].inventoryJarFilled.nc} Pc',style:TextStyle(fontSize: 12,color:Colors.black)),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Container(

                                                        width :120,
                                                        color: Colors.redAccent,
                                                        child:Center(
                                                            child:Text('Empty Jars',style:TextStyle(fontSize: 12,color:Colors.black))
                                                        ),
                                                      ),
                                                      SizedBox(height: 5.0),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              JarIcons('Chilled',AppIcons.chilledJar, 30, 30),
                                                              Text('${snapshot.data!.inventoryList[index].inventoryJarEmpty.chilled} Pc',style:TextStyle(fontSize: 12,color:Colors.black)),
                                                            ],
                                                          ),
                                                          SizedBox(width: 10.0),
                                                          Column(
                                                            children: [
                                                              JarIcons('Normal',AppIcons.normalJar, 30, 30),
                                                              Text('${snapshot.data!.inventoryList[index].inventoryJarEmpty.normal} Pc',style:TextStyle(fontSize: 12,color:Colors.black)),
                                                            ],
                                                          ),

                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                        )
                                        ; //

                                       }
                                    ),


                          ],
        );

          }
          else if(snapshot.hasError)
          {
            print(snapshot.toString());
            return Center(
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


showAlertDialog(BuildContext context,String time,String name,int entryId,inventoryList) {

  // set up the button
  Widget okButton =  Padding(
    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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

            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
              content: Text('Entry updated!'),
              backgroundColor: Colors.green,
            ));
            Navigator.pop(context);

          },
          child: Text('Save'),
        ),

      ],


    ),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Center(
      child: Text(inventoryList.type+'-'+name+'-'+time,style:TextStyle(fontSize: 14,color:Colors.blue)),
    ),
    content: SingleChildScrollView(
    child:Form(
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
        Text('Filled Jars\n',style:TextStyle(fontSize: 12,color:Colors.blue),),
      Row(
      children: [
      JarIcons('Chilled', AppIcons.chilledJar, 30, 30),
  SizedBox(width: 25),
  Expanded(
  child:TextFormField(
  initialValue: inventoryList.inventoryJarFilled.chilled.toString(),
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
  border: OutlineInputBorder(),
  labelText:"Quantity",
  ),
  ),
  ),
  ],
  ),
  SizedBox(height: 10),
  Row(
  children: [
  JarIcons('Normal', AppIcons.chilledJar, 30, 30),
  SizedBox(width: 20),
  Expanded(
  child:TextFormField(
  initialValue: inventoryList.inventoryJarFilled.normal.toString(),
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
  border: OutlineInputBorder(),
  labelText:"Quantity",
  ),
  ),
  ),
  ],
  ),
  SizedBox(height: 10),
  Row(
  children: [
  JarIcons('NC Jar', AppIcons.chilledJar, 30, 30),
  SizedBox(width: 20),
  Expanded(
  child:TextFormField(
  initialValue: inventoryList.inventoryJarFilled.nc.toString(),
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
  border: OutlineInputBorder(),
  labelText:"Quantity",
  ),
  ),
  ),
  ],
  ),
  SizedBox(height: 10),
  Text('Empty Jars',style:TextStyle(fontSize: 12,color:Colors.blue),),
  SizedBox(height: 10),
  Row(
  children: [
  JarIcons('Chilled', AppIcons.chilledJar, 30, 30),
  SizedBox(width: 20),
  Expanded(
  child:TextFormField(
  initialValue: inventoryList.inventoryJarEmpty.chilled.toString(),
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
  border: OutlineInputBorder(),
  labelText:"Quantity",
  ),
  ),
  ),
  ],
  ),
  SizedBox(height: 10),
  Row(
  children: [
  JarIcons('Normal', AppIcons.chilledJar, 30, 30),
  SizedBox(width: 20),
  Expanded(
  child:TextFormField(
  initialValue: inventoryList.inventoryJarEmpty.normal.toString(),
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
  border: OutlineInputBorder(),
  labelText:"Quantity",
  ),
  ),
  ),
  ],
  ),





  ],
  ),




  ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}