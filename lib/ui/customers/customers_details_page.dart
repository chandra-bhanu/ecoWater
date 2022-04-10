import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:eco_water_app/ui/widgets/common_widgets.dart';
import 'package:eco_water_app/app/app_icons.dart';
import 'package:flutter/services.dart';
import 'list_page.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:eco_water_app/models/delivery_list_model.dart';
import 'dart:async' show Future;

Future<All> fetchEntries() async
{
  final response = await rootBundle.loadString('assets/json/deliveryEntryList.json');
  if(response != '')
    {
    //  print(response);
      return All.fromJson(json.decode(response));
    }
  else{
    throw Exception('Failed to get entries');
  }
}



class CustomersDetails extends StatefulWidget {
  //final int customerId;
  const CustomersDetails({Key? key}) : super(key: key);
  //const CustomersDetails({Key? key, required this.customerId}) : super(key: key);

  @override  State<StatefulWidget> createState() {
    return new _CustomersDetailsState();
  }
}



class _CustomersDetailsState extends State<CustomersDetails> {

  TextEditingController searchController = new TextEditingController();
  String filter='';
  DateTime? _selected;
  var currDt = DateTime.now();
  int _selectedMonth = 0;
  var reportMonths = <String>[
    'January 2022',
    'February 2022',
    'March 2022',
    'April 2022',
    'May 2022',
    'June 2022',
    'July 2022',
    'August 2022',
    'September 2022',
    'October 2022',
    'November 2022',
    'December 2022',
  ];
  bool viewVisible = true ;

  void showWidget(){
    setState(() {
      viewVisible = true ;
    });
  }

  void hideWidget(){
    setState(() {
      viewVisible = false ;
    });
  }




  _CustomersDetailsState()
  {
    _selectedMonth=currDt.month-1;
  }
  Future<All>? futureEntries;
 @override
 void initState()
 {
   super.initState();
   futureEntries=fetchEntries();
 }
 Widget build(BuildContext context) {
     int customerId = ModalRoute.of(context)!.settings.arguments as int;
     int dataIndex=Customers.indexWhere((f)=>f.id == customerId);
       return Scaffold(
         appBar: AppBar(
           title: Text('Customer Details'),
         ),
         body: SingleChildScrollView(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: <Widget>[
               _buildTitle(Customers[dataIndex].fullName,Customers[dataIndex].address,Customers[dataIndex].number),
              _buildInventory(),
              _buildEntryList(customerId),
             _buildDisplayEntries(context,customerId,_selectedMonth),
             ],
           ),
         ),

           floatingActionButton: FloatingActionButton(
                    backgroundColor: Colors.green,
                    //label: Text('New Entry'),
                    child: Icon(Icons.add_business),
                   onPressed: () => {
                          //Take to new entry page with id  customerId
                   },
               ),
       );


  }


  Widget _buildTitle(name,address,number)=>Column(
    children: <Widget>[

      Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Center(
          child:new Row(
                children: [
                    Container(
                      padding: const EdgeInsets.only(top: 30.0,bottom:20.0),

                      width: MediaQuery.of(context).size.width,
                      color: Colors.blue,
                      child:new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  <Widget>[
                          Text(name, style: TextStyle(color: Colors.white, fontSize: 24),),
                          Text(address, style: TextStyle(color: Colors.white, fontSize: 14),),
                          Text('+91-'+number, style: TextStyle(color: Colors.white, fontSize: 14),),
                        ],
                      ),
                ),
              ],
            ),
        ),

      ),
    ],
  );


  Widget _buildInventory()=>Stack(
    children: <Widget>[
       Container(
         alignment: Alignment.topCenter,
         height:100,
         width: MediaQuery.of(context).size.width,
         color: Colors.blue,
       ),
       Container(
         child: Center(
           child: Container(
             //margin: const EdgeInsets.only(top:20.0,left: 20.0, right: 20.0),
             padding: const EdgeInsets.only(top: 10.0,bottom:10.0,left: 10.0, right: 10.0),
             width: MediaQuery.of(context).size.width-30,
             //eight:150,
             decoration: BoxDecoration(
                 color: Colors.white,
                 border: Border.all(
                  // width: 5,
                   color: Colors.white,
                 ),
                 borderRadius: BorderRadius.all(Radius.circular(10)),
               boxShadow: [
                 BoxShadow(
                   color: Colors.grey.withOpacity(0.5),
                   spreadRadius: 5,
                   blurRadius: 7,
                   offset: Offset(0, 3), // changes position of shadow
                 ),
               ],
             ),
             child:Column(
               mainAxisSize: MainAxisSize.min,
               children: [
                 //Jar Stocks
                Container(
                child:Column(
                children: [
                //Title Text
                Container(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Text(
                  'Balance Jars',
                  style: TextStyle(color: Colors.blue, fontSize:16,fontWeight: FontWeight.bold),
                ),
                ],
                ),
                ),




                Container(
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  JarIcons('Chilled', AppIcons.chilledJar, 40, 40),
                Container(
                 child: Text(
                    'X ',
                    style: TextStyle(color: Color(0xff4374ba), fontSize:16,fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(
                    '5pc',
                    style: TextStyle(color: Color(0xff4374ba), fontSize:16,fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(
                    '  +  ',
                    style: TextStyle(color: Color(0xff4374ba), fontSize:16,fontWeight: FontWeight.bold),
                  ),
                ),

                  JarIcons('Normal', AppIcons.normalJar, 40, 40),

                Container(
                  child: Text(
                    'X ',
                    style: TextStyle(color: Color(0xff4374ba), fontSize:16,fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                  child: Text(
                    '2pc',
                    style: TextStyle(color: Color(0xff4374ba), fontSize:16,fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(
                    '  = ',
                    style: TextStyle(color:Color(0xff4374ba), fontSize:16,fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(
                    '7Pc',
                    style: TextStyle(color: Color(0xff4374ba), fontSize:20,fontWeight: FontWeight.bold),
                  ),
                ),
                ],
                ),
                ),
                ],
                ),
                ),
                //Amount Paid / Pending
                Container(
                padding: const EdgeInsets.only(top:10.0,bottom:10.0),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Container(

                color: Colors.green,
                padding: const EdgeInsets.only(top:10.0,bottom:10.0,left:30,right:30),

                child:Column(
                children: [

                Text(
                    'Paid',
                    style: TextStyle(color: Colors.white, fontSize:14,fontWeight: FontWeight.bold),
                  ),


                 Text(
                    '\u{20B9} 5230.00',
                    style: TextStyle(color: Colors.white, fontSize:14,fontWeight: FontWeight.bold),
                  ),

                ],
                ),
                ),
                Container(

                color: Colors.red,
                padding: const EdgeInsets.only(top:10.0,bottom:10.0,left:30,right:30),

                child:Column(
                children: [

                Text(
                'Pending',
                style: TextStyle(color: Colors.white, fontSize:14,fontWeight: FontWeight.bold),
                ),


                Text(
                '\u{20B9} 530.00',
                style: TextStyle(color: Colors.white, fontSize:14,fontWeight: FontWeight.bold),
                ),

                ],
                ),
                ),
                ],
                ),
                ),
                Visibility(
                visible:  viewVisible,
                child: TextButton(
                child: Text('Show Details'),
                onPressed: hideWidget,
                ),
                ),
                Visibility(
                   visible: !viewVisible,
                   child: TextButton(
                     child: Text('Hide Details'),
                     onPressed: showWidget,
                   ),
                 ),
                Column(
                      children: <Widget>[
                          Visibility(
                                  maintainSize: false,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: !viewVisible,
                                      child: Container(

                                          padding: const EdgeInsets.only(top:5.0,bottom:5.0,left:10.0,right:10.0),
                                          color:Colors.black12,
                                          child: Column(
                                            children: [
                                              Text(
                                                'Subscription & Refill',
                                                style: TextStyle(color: Colors.blue, fontSize:12),
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,

                                                children: [

                                                  Row(
                                                    children: [
                                                      JarIcons('Chilled', AppIcons.chilledJar, 20, 20),
                                                      SizedBox(width: 5),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            'X '+'2pc',
                                                            style: TextStyle(color: Colors.blue, fontSize:12),
                                                          ),
                                                          Text(
                                                            '\u{20B9} 60.00',
                                                            style: TextStyle(color: Colors.blue, fontSize:12),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        '|',
                                                        style: TextStyle(color: Colors.blue, fontSize:16),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 5),
                                                  Row(
                                                    children: [
                                                      JarIcons('NC', AppIcons.mixJar, 20, 20),
                                                      SizedBox(width: 5),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            'X '+'1pc',
                                                            style: TextStyle(color: Colors.blue, fontSize:12),
                                                          ),
                                                          Text(
                                                            '\u{20B9} 50.00',
                                                            style: TextStyle(color: Colors.blue, fontSize:12),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        '|',
                                                        style: TextStyle(color: Colors.blue, fontSize:16),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 5),
                                                  Row(
                                                    children: [
                                                      JarIcons('Normal', AppIcons.normalJar, 20, 20),
                                                      SizedBox(width: 5),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            'X '+'4pc',
                                                            style: TextStyle(color: Colors.blue, fontSize:12),
                                                          ),
                                                          Text(
                                                            '\u{20B9} 40.00',
                                                            style: TextStyle(color: Colors.blue, fontSize:12),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),

                                      )
                                  ),
                          Visibility(
                              maintainSize: false,
                              maintainAnimation: true,
                              maintainState: true,
                              visible: !viewVisible,
                              child: Container(

                                  padding: const EdgeInsets.only(top:10.0,bottom:0.0,left:10.0,right:10.0),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Column(
                                        children: [

                                          Text(
                                            'Security Paid',
                                            style: TextStyle(color: Colors.blue, fontSize:12),
                                          ),
                                          Text(
                                            '\u{20B9} 600.00',
                                            style: TextStyle(color: Colors.blue, fontSize:12),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 30),
                                      Column(
                                        children: [
                                          Text(
                                            'Delivery',
                                            style: TextStyle(color: Colors.blue, fontSize:12),
                                          ),
                                          Text(
                                            'Alternate Days',
                                            style: TextStyle(color: Colors.blue, fontSize:12),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 30),
                                      Column(
                                        children: [
                                          Text(
                                            'Billed',
                                            style: TextStyle(color: Colors.blue, fontSize:12),
                                          ),
                                          Text(
                                            'Monthly',
                                            style: TextStyle(color: Colors.blue, fontSize:12),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),

                              )
                          ),
                      ]
                ),




                 //Security, Jar subscribed/Billling Cycle











               ],
             ),
           ),
         ),
       ),
    ],
  );


  Widget _buildEntryList(customerId){
    return Stack(
    children: <Widget>[
      Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top:20.0,bottom:30.0,left:20.0,right:20.0),
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                //month Selector
                Container(
                  padding: const EdgeInsets.only(top:10.0,bottom:10.0,left:10.0,right:10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                                  Text(
                                  'Monthly Entry',
                                  style: TextStyle(color: Colors.blue, fontSize:16,fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.calendar_month_outlined, size: 24,color: Colors.blue,),
                                      //month Changer
                                      DropdownButton<String>(
                                        hint: new Text('Report for Month'),
                                        value: _selectedMonth == null ? null : reportMonths[_selectedMonth],
                                        items: reportMonths.map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedMonth = reportMonths.indexOf(value!);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                  ),
                ),
              Container(
                color:Colors.blue,
                height: 1,

              ),
            ],
          ),
        ),
      ],
  );

}





  Widget  _buildDisplayEntries(BuildContext context,customerId,_selectedMonth,)
  {
        return FutureBuilder<All>(
          future: futureEntries,
          builder: (context,snapshot){
            if(snapshot.hasData)
              {
                List<Deliveries> deliveries = [];

                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:0.0, bottom:10.0),
                        child: Text(
                            '${snapshot.data!.deliveries.length} Days, This Month',
                          style:TextStyle(fontSize: 16,color:Colors.blue,fontWeight:FontWeight.bold),
                        ),

                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.deliveries.length,
                        itemBuilder: (BuildContext context, index) {
                          return Card(

                            clipBehavior: Clip.antiAlias,
                            margin: const EdgeInsets.all(10),
                            elevation: 5,
                            shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                ListTile(
                                  tileColor: Color(0xff4274BA),
                                  //  color:Colors.
                                leading: CircleAvatar(
                                    child:Icon(
                                      Icons.assignment,
                                      color: Color(0xff4274BA),
                                      size: 25.0,
                                    )
                                ),
                                  title: Text(snapshot.data!.deliveries[index].day,style:TextStyle(fontSize: 18,color:Colors.white,fontWeight:FontWeight.bold)),
                                  subtitle: Text(
                                    '${snapshot.data!.deliveries[index].count} Entries',
                                    style: TextStyle(color: Colors.white.withOpacity(0.8)),
                                  ),
                                ),
                                Column(

                                  children:[
                                    for(var item in snapshot.data!.deliveries[index].delivery )  Row(children: [
                                      Container(
                                              padding: const EdgeInsets.all(10),
                                              margin: const EdgeInsets.all(10),
                                              width: MediaQuery.of(context).size.width-40,
                                              color: Color(0xFFf2f2f2),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [

                                                      //1st Line
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [

                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Icon(
                                                                  Icons.access_time,
                                                                  color:  Colors.cyan,
                                                                  size: 24.0,
                                                                ),
                                                                Text(item.deliveryDetails.time,style:TextStyle(fontSize: 14,color:Colors.cyan,fontWeight:FontWeight.bold)),
                                                              ],
                                                            ),
                                                          Row(
                                                          //  textDirection:
                                                            children: [
                                                              Icon(
                                                                Icons.account_circle,
                                                                color:  Colors.cyan,
                                                                size: 24.0,
                                                              ),
                                                              Text(item.deliveryDetails.deliveryPerson.length>15?item.deliveryDetails.deliveryPerson.substring(0,15):item.deliveryDetails.deliveryPerson,style:TextStyle(fontSize: 14,color:Colors.cyan,fontWeight:FontWeight.bold)),
                                                            ],
                                                          ),

                                                        ],
                                                      ),

                                                      Container(
                                                          color:Color(0xFFDDDDDD),
                                                        height: 1,
                                                        margin: const EdgeInsets.only(top:10.0,bottom:0.0,left:0.0,right:0.0),
                                                      ),

                                                        Center(
                                                          child: Column(children:[
                                                              Container(
                                                                padding: EdgeInsets.all(10),
                                                                child: Table(
                                                                //  border: TableBorder.all(),
                                                                 // columnWidths: const {0: FractionColumnWidth(.4), 1: FractionColumnWidth(.2), 2: FractionColumnWidth(.2)},
                                                                  children: [
                                                                      TableRow( children: [
                                                                        Center(child: Text('Delivered',style:TextStyle(fontSize: 16,color:Colors.cyan,fontWeight:FontWeight.bold))),
                                                                        Center(child: Text('Jars Collected',style:TextStyle(fontSize: 16,color:Colors.cyan,fontWeight:FontWeight.bold))),
                                                                      ]),
                                                                    TableRow( children: [

                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            JarIcons('Chilled',AppIcons.chilledJarOut, 50, 50),
                                                                            Text('X ${item.deliveryJarOut.chilled} Pc',style:TextStyle(fontSize: 16,color:Colors.black,fontWeight:FontWeight.bold)),
                                                                          ],
                                                                        ),


                                                                       Row(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              JarIcons('Chilled',AppIcons.chilledJarIn, 50, 50),
                                                                              Text('X ${item.deliveryJarIn.chilled} Pc',style:TextStyle(fontSize: 16,color:Colors.black,fontWeight:FontWeight.bold)),
                                                                            ],
                                                                          ),

                                                                    ]),
                                                                    TableRow( children: [
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          JarIcons('Normal',AppIcons.normalJarOut, 50, 50),
                                                                          Text('X ${item.deliveryJarOut.normal} Pc',style:TextStyle(fontSize: 16,color:Colors.black,fontWeight:FontWeight.bold)),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          JarIcons('Normal',AppIcons.normalJarIn, 50, 50),
                                                                          Text('X ${item.deliveryJarIn.normal} Pc',style:TextStyle(fontSize: 16,color:Colors.black,fontWeight:FontWeight.bold)),
                                                                        ],
                                                                      ),
                                                                    ]),
                                                                    TableRow( children: [
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          JarIcons('NC Jar',AppIcons.mixJarIn, 50, 50),
                                                                          Text('X ${item.deliveryJarOut.nc} Pc',style:TextStyle(fontSize: 16,color:Colors.black,fontWeight:FontWeight.bold)),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                         // JarIcons('NC Jar',AppIcons.mixJarOut, 50, 50),
                                                                          Text('-'),
                                                                        ],
                                                                      )
                                                                    ]),
                                                                  ],
                                                                ),
                                                              ),
                                                          ]),
                                                        ),
                                                          // Time and Name
                                                      Container(
                                                        color:Color(0xFFDDDDDD),
                                                        height: 1,
                                                          margin: const EdgeInsets.only(top:10.0,bottom:0.0,left:0.0,right:0.0),
                                                      ),
                                                      Container(
                                                        child:Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children:[
                                                            Chip(
                                                              avatar: CircleAvatar(
                                                                backgroundColor: Colors.grey.shade800,
                                                                child: const Text('\u{20B9}'),
                                                              ),
                                                              label:  Text('${item.deliveryPayments.amount}'),
                                                            ),
                                                            Chip(
                                                              avatar: CircleAvatar(
                                                                backgroundColor: Colors.grey.shade800,
                                                                child: Icon(
                                                                  Icons.wb_sunny_sharp,
                                                                  color:  (item.deliveryPayments.status =='paid'?Colors.green:Colors.red),
                                                                  size: 20.0,
                                                                ),
                                                              ),
                                                              label:  Text('${item.deliveryPayments.status}'),
                                                            ),
                                                            Chip(
                                                              avatar: CircleAvatar(
                                                                backgroundColor: Colors.grey.shade800,
                                                                child: Icon(
                                                                  Icons.account_balance,
                                                                  color: Colors.amber,
                                                                  size: 15.0,
                                                                ),
                                                              ),
                                                              label:  Text(item.deliveryPayments.mode ==''?'N/A':item.deliveryPayments.mode),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                              ),
                                      ),
                                    ])]

                                ),
                              ],
                            ),
                          );

                          return Card(
                            margin: const EdgeInsets.all(15.0),
                            color: Colors.green[600],
                            child: ListTile(
                              title: Text(snapshot.data!.deliveries[index].day),
                            ),
                          );
                        },
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
            else
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );

  }


}




class Contact {
  final String fullName;
  final String address;
  final String number;
  final int id;

  const Contact({required this.fullName, required this.address, required this.number, required this.id});
}


