import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:eco_water_app/ui/widgets/common_widgets.dart';
import 'package:eco_water_app/app/app_icons.dart';
import 'package:flutter/services.dart';
import 'list_page.dart';


class CustomersEntry extends StatefulWidget {
  //final int customerId;
  const CustomersEntry({Key? key}) : super(key: key);
  //const CustomersDetails({Key? key, required this.customerId}) : super(key: key);

  @override  State<StatefulWidget> createState() {
    return _CustomersEntryState();
  }
}


class _CustomersEntryState extends State<CustomersEntry> {
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    int customerId = ModalRoute.of(context)!.settings.arguments as int;
    int dataIndex=Customers.indexWhere((f)=>f.id == customerId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Entry'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTitle(Customers[dataIndex].fullName,Customers[dataIndex].address,Customers[dataIndex].number),

            _buildEntryForm(customerId),
            _buildBalanceJar(customerId),
            _buildPaymentEntry(customerId),
          ],
        ),
      ),
    );
  }


Widget _buildTitle(name,address,number)=>Column(
  children: <Widget>[
            Padding(
            padding: const EdgeInsets.all(10.0),
            child:Row(
              children:  [
                const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.account_circle, color: Colors.white,),
                ),
                const SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),),
                    Text(address+', +91-'+number, style: const TextStyle(color: Colors.blue, fontSize: 12),),
                  ],
                ),

              ],
              
            ),
            ),



  ],
);

Widget _buildEntryForm(customerId)=>Column(
  children: [
    Container(
      margin: const EdgeInsets.only(bottom:10.0),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5, color: Colors.cyan),
          left: BorderSide(width: 0, color: Colors.transparent),
          right: BorderSide(width:0, color: Colors.transparent),
          bottom: BorderSide(width: 0.5,color: Colors.cyan),
        ),
      ),
    ),
    Text(DateFormat('dd-MMMM-yyyy').format(DateTime.now()), style: const TextStyle(color: Colors.indigo, fontSize: 16, fontWeight: FontWeight.bold),),
    Container(
      margin: const EdgeInsets.only(top:10.0),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5, color: Colors.cyan),
          left: BorderSide(width: 0, color: Colors.transparent),
          right: BorderSide(width:0, color: Colors.transparent),
          bottom: BorderSide(width: 0.5,color: Colors.cyan),
        ),
      ),
    ),



    //F0rm Body
  Container(
    padding: const EdgeInsets.all(20.0),
    width: double.infinity,
    color: const Color(0xffe3f9ff),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Chilled Jars', style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),),
        Row(
          children: [
            JarIcons('Jar In', AppIcons.chilledJarIn, 40, 40),
            const SizedBox(width: 10),
            const Text('Full Jar', style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),),
            const SizedBox(width: 70),
            //Button Start
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blue),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 30,
                      )),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white),
                    child: const Text(
                      '0',
                      style: TextStyle(color:  Color(0xffe303030), fontSize: 30),
                    ),
                  ),
                  InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      )),
                ],
              ),
            ),
            //Button end
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            JarIcons('Jar Out', AppIcons.chilledJarOut, 40, 40),
            const SizedBox(width: 10),
            const Text('Empty Jar', style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),),
            const SizedBox(width: 50),
            //Button Start
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 30,
                      )),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white),
                    child: const Text(
                      '0',
                      style: TextStyle(color:  Color(0xffe303030), fontSize: 30),
                    ),
                  ),
                  InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      )),
                ],
              ),
            ),
            //Button end
          ],
        ),
      ],
    ),
  ),

    Container(
      padding: const EdgeInsets.all(20.0),
      width: double.infinity,
      color: const Color(0xffe3f9ff),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Normal Jars', style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),),
          Row(
            children: [
              JarIcons('Jar In', AppIcons.chilledJarIn, 40, 40),
              const SizedBox(width: 10),
              const Text('Full Jar', style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),),
              const SizedBox(width: 70),
              //Button Start
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 30,
                        )),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white),
                      child: const Text(
                        '0',
                        style: TextStyle(color:  Color(0xffe303030), fontSize: 30),
                      ),
                    ),
                    InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        )),
                  ],
                ),
              ),
              //Button end
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              JarIcons('Jar Out', AppIcons.chilledJarOut, 40, 40),
              const SizedBox(width: 10),
              const Text('Empty Jar', style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),),
              const SizedBox(width: 50),
              //Button Start
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 30,
                        )),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white),
                      child: const Text(
                        '0',
                        style: TextStyle(color:  Color(0xffe303030), fontSize: 30),
                      ),
                    ),
                    InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        )),
                  ],
                ),
              ),
              //Button end
            ],
          ),
        ],
      ),
    ),


    Container(
      padding: const EdgeInsets.all(20.0),
      width: double.infinity,
      color: const Color(0xffe3f9ff),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('NC Jars', style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),),
          Row(
            children: [
              JarIcons('Jar In', AppIcons.chilledJarIn, 40, 40),
              const SizedBox(width: 10),
              const Text('Full Jar', style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),),
              const SizedBox(width: 70),
              //Button Start
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 30,
                        )),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white),
                      child: const Text(
                        '0',
                        style: TextStyle(color:  Color(0xffe303030), fontSize: 30),
                      ),
                    ),
                    InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        )),
                  ],
                ),
              ),
              //Button end
            ],
          ),
       ],
      ),
    ),

    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // background
            onPrimary: Colors.white, // foreground
          ),
          onPressed: () {
            const snackBar = SnackBar(
              content: Text('Delivery attempted but customer denied!'),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
          },
          child: const Text('No Delivery'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green, // background
            onPrimary: Colors.white, // foreground
          ),
          onPressed: () {
            const snackBar = SnackBar(
              content: Text('Entry Saved For Customer!'),
              backgroundColor: Colors.green,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);

          },
          child: const Text('Submit Delivery'),
        ),

      ],


    ),

    const SizedBox(height: 20),

  ],
);

Widget _buildBalanceJar(customerId)=>Container(
  color: const Color(0xffdddddd) ,
  padding: const EdgeInsets.all(10.0),
  child: Column(
  children:  [
  const Center(
  child: Text('Balance Jars\n'),
  ),
  Row(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
  JarIcons('Chilled', AppIcons.chilledJar, 30, 30),
  const Text(
  'X ',
  style: TextStyle(color: Color(0xff4374ba), fontSize:16,fontWeight: FontWeight.bold),
  ),
  const Text(
  '5pc',
  style: TextStyle(color: Color(0xff4374ba), fontSize:16,fontWeight: FontWeight.bold),
  ),
  const Text(
  '  +  ',
  style: TextStyle(color: Color(0xff4374ba), fontSize:16,fontWeight: FontWeight.bold),
  ),

  JarIcons('Normal', AppIcons.normalJar, 30, 30),

  const Text(
  'X ',
  style: TextStyle(color: Color(0xff4374ba), fontSize:16,fontWeight: FontWeight.bold),
  ),

  const Text(
  '2pc',
  style: TextStyle(color: Color(0xff4374ba), fontSize:16,fontWeight: FontWeight.bold),
  ),
  const Text(
  '  = ',
  style: TextStyle(color:Color(0xff4374ba), fontSize:16,fontWeight: FontWeight.bold),
  ),
  const Text(
  '7Pc',
  style: TextStyle(color: Color(0xff4374ba), fontSize:20,fontWeight: FontWeight.bold),
  ),
  ],
  ),



  ],
  ),
  );

Widget _buildPaymentEntry(customerId) {
  String _radioSelected = 'cash';
  String _radioVal= 'cash';


  return Container(
    padding: const EdgeInsets.all(20.0),
    color: const Color(0xffefefef),
    child: Column(
      children: <Widget>[
        const Center(
          child: Text('Payment Entry\n'),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 0.0, right: 0.0, top: 10, bottom: 10),
          //  padding: EdgeInsets.symmetric(horizontal: 0),
          child: TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Amount',
              hintText: 'Please enter collected amount',
            ),
            style: TextStyle(fontSize: 18),

          ),

        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Cash'),
            Radio(
              value: 'cash',
              groupValue: _radioSelected,
              activeColor: Colors.green,
              onChanged: (value) {
                setState(() {
                  _radioSelected = 'cash';
                  _radioVal = 'cash';
                });
              },
            ),
            Text('UPI'),
            Radio(
              value: 'upi',
              groupValue: _radioSelected,
              activeColor: Colors.blue,
              onChanged: (value) {
                setState(() {
                  _radioSelected = 'upi';
                  _radioVal = 'upi';
                });
              },
            )
          ],
        ),

        const Padding(
          padding: EdgeInsets.only(left: 0.0, right: 0.0, top: 10, bottom: 20),
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
              color: Colors.green, borderRadius: BorderRadius.circular(0)),
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
    ),
  );
}
}