import 'package:flutter/material.dart';
import 'package:eco_water_app/ui/home/widgets/animated_percentage_widget.dart';
import 'package:eco_water_app/ui/home/widgets/activities/activities_widget.dart';
import 'package:eco_water_app/ui/home/widgets/activities/activity_widget.dart';
import 'package:eco_water_app/app/app_icons.dart';
import '../user/profile_page.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  //final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
          actions: <Widget>[
                IconButton(
                icon: const Icon(Icons.account_circle),
                tooltip: 'Profile',
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => ProfilePage()));
                },
              ),
          ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
              _buildTitle(),
              _buildBoxes(),
          ],
        ),
      ),
        bottomNavigationBar: BottomAppBar(
          color:Colors.blue,
          shape: const CircularNotchedRectangle(),
          child: Container(
              height: 50.0,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () => setState(() {}),
          tooltip: 'New Delivery',
          child: const Icon(Icons.add_shopping_cart_outlined),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }

  Widget _buildTitle()=>Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Center(
            child: Container(
                width: 150,
                height: 75,
                /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                child: Image.asset(AppIcons.ecoLogo)),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 0.0),
        //   child: Center(
        //           child:Text(
        //                 'EcoFresh Water',
        //                 style: TextStyle(color: Colors.blue, fontSize: 25),
        //             ),
        // ),
        //
        // ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Center(
            child:Text(
              'Location - Keonjhar',
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ),

        ),
      ],
  );


  Widget _buildBoxes() => Column(
      children: <Widget>[
        Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            padding: EdgeInsets.all(3.0),
            children: <Widget>[
              makeDashboardItem("Customers", Icons.account_circle_outlined,"customerList"),
              makeDashboardItem("Payments", Icons.account_balance_wallet_outlined,"profile"),
              makeDashboardItem("Load/unload", Icons.airport_shuttle_outlined,"profile"),
              makeDashboardItem("Reports", Icons.book_outlined,"profile"),
            ],
        ),
        ),

      ],
  );

  Card makeDashboardItem(String title, IconData icon, String PageName ) {
    return Card(
        elevation: 0.0,
        margin: new EdgeInsets.all(8.0),

        child: Container(
          decoration: BoxDecoration(
              color: Colors.white70,
              boxShadow: [
                 //background color of box
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 1),
                )
              ],
              border: Border.all(
                color: Colors.black12,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: new InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(PageName);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                      icon,
                      size: 40.0,
                      color: Colors.blue,
                    )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                      new TextStyle(fontSize: 18.0, color: Colors.blue)),
                )
              ],
            ),
          ),
        ));
  }



}

