import 'package:eco_water_app/ui/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:eco_water_app/app/app_icons.dart';


import 'list_page.dart';



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


 @override
 Widget build(BuildContext context) {
     int customerId = ModalRoute.of(context)!.settings.arguments as int;
     int dataIndex=Customers.indexWhere((f)=>f.id == customerId);
       return Scaffold(
         appBar: AppBar(
           title: Text('Customer Details'),
         ),
         body: SafeArea(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: <Widget>[
               _buildTitle(Customers[dataIndex].fullName,Customers[dataIndex].address,Customers[dataIndex].number),
              _buildInventory(),
             ],
           ),
         ),

           floatingActionButton: FloatingActionButton.extended(
                    backgroundColor: Colors.green,
                    label: Text('New Entry'),
                    icon: Icon(Icons.add_business),
                   onPressed: () => {
                            _openPopup(context),
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
                 //Security, Jar subscribed/Billling Cycle
                Container(
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
                ),




                 Container(
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
                 ),





               ],
             ),
           ),
         ),
       ),
    ],
  );



  _openPopup(context) {}











}
class Contact {
  final String fullName;
  final String address;
  final String number;
  final int id;

  const Contact({required this.fullName, required this.address, required this.number, required this.id});
}


