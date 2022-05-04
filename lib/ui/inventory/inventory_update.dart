import 'package:flutter/material.dart';
import 'package:eco_water_app/app/app_icons.dart';





class InventoryUpdate extends StatefulWidget {
  //final int customerId;
  const InventoryUpdate({Key? key}) : super(key: key);
  //const CustomersDetails({Key? key, required this.customerId}) : super(key: key);

  @override  State<StatefulWidget> createState() {
    return new _InventoryUpdateState();
  }
}

class _InventoryUpdateState extends State<InventoryUpdate> {
  Widget build(BuildContext context) {
    String paramName = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Jar Inventory'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
              _buildForm(paramName,context),
          ],
        ),
      ),
    );
  }
}

Widget _buildForm(paramName,context)=> Card(
      clipBehavior: Clip.antiAlias,
      margin:  EdgeInsets.only(top:25.0, left: 10.0, right: 10.0),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
      children:  [
        ListTile(
          tileColor: Colors.white,
          //  color:Colors.
          leading: CircleAvatar(
            child:Image.asset(
              paramName=='Chilled'?AppIcons.chilledJar:AppIcons.normalJar,
              height: 25,
              width: 25,
            ),
          ),
          title: Text(paramName+' Jars',style:TextStyle(fontSize: 18,color:Colors.blue,fontWeight:FontWeight.bold)),
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
          child: Column(
            children:  [
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Add Jars To Inventory',
                    labelText:"Add Jars To Inventory",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Remove Jars From Inventory',
                    labelText:"Remove Jars From Inventory",
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  maxLines: 3,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                   // hintText: 'Reason',
                    labelText:"Reason(Optional)",
                  ),
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
    ),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
                              content: Text('Jar Inventory Updated!'),
                              backgroundColor: Colors.green,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);

                      },
                      child: Text('Update Jar Inventory'),
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