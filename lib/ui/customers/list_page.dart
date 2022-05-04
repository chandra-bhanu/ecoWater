import 'package:flutter/material.dart';
import 'package:eco_water_app/app/app_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'customers_details_page.dart';
import 'package:eco_water_app/ui/customers/customer_new_entry_page.dart';

class CustomersList extends StatefulWidget {
  static String tag = 'customerList';
  final String customerId='';
  @override  State<StatefulWidget> createState() {
    return _CustomersListState();
  }
}

List<Contact> Customers = [
  Contact(fullName: 'AKASH TRADERS', number: '90000 124521', address : "JAMUHATA,KEONJHAR",id:1),
  Contact(fullName: 'MAA SANTOSHI STEEL', number: '9437086229', address : "JAMUHATA,KEONJHAR",id:2),
  Contact(fullName: 'MRF TYRE', number: '9437179311', address : "JAMUHATA,KEONJHAR",id:3),
  Contact(fullName: 'CELL PLANET', number: '7008088823', address : "DHOBADIA CHOWK,KEONJHAR",id:4),
  Contact(fullName: 'KIRAN KUMAR DHAL', number: '7008086775', address : "MADHAPUR,KEONJHAR",id:5),
  Contact(fullName: 'DIPAK KU SAHOO', number: '9853988988', address : "MINING ROAD,KEONJHAR",id:6),
  Contact(fullName: 'PRITISH KU BEHERA', number: '8917433908', address : "MINING ROAD KEONJHAR",id:7),
  Contact(fullName: 'DIPALI NURSING HOME', number: '000000000', address : "DHOBADIA CHOWK,KEONJHAR",id:8),
  Contact(fullName: 'RAM GARAGE', number: '9861486393', address : "DHOBADIA CHOWK,KEONJHAR",id:9),
  Contact(fullName: 'JITENDRA KUMAR', number: '7008818158', address : "DHOBADIA CHOWK,KEONJHAR",id:10),
];
class _CustomersListState extends State<CustomersList> {
  TextEditingController searchController = TextEditingController();
   String filter='';
   String conditionValue='';

  @override  initState() {
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }

  @override  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Customers',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search Customers',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: Customers.length,
                itemBuilder: (context, index) {
                  // if filter is null or empty returns all data
                  return filter == "" ? ListTile(
                  title: Text(
                    '${Customers[index].fullName}',
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text('${Customers[index].address}'),
                  leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                  '${Customers[index].fullName.substring(0, 1)}')

                  ),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.white,

                    child: TextButton(
                        onPressed: () => launch('tel://${Customers[index].number}'),
                        child:Icon(Icons.call),
                       ),
                  ),
                  onTap: () => _onTapItem(context, Customers[index].id),
                  )
                      : '${Customers[index].fullName}'.toLowerCase()
                      .contains(filter.toLowerCase())
                  ? ListTile(
                  title: Text(
                  '${Customers[index].fullName}',
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text('${Customers[index].address}'),
                  leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                  '${Customers[index].fullName.substring(0, 1)}')),
                    trailing: CircleAvatar(
                      backgroundColor: Colors.white,

                      child: TextButton(
                        onPressed: () => launch('tel://${Customers[index].number}'),
                        child:Icon(Icons.call),
                      ),
                    ),
                  onTap: () =>
                  _onTapItem(context, Customers[index].id),
                  )
                      : Container();
                },
              ),
            ),
          ],
        ));
  }

  void _onTapItem(BuildContext context, customerId) {
   String?  conditionValue = ModalRoute.of(context)!.settings.arguments as String?;
    if(conditionValue == 'makeEntry')
      {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  const CustomersEntry(),
            settings: RouteSettings(
              arguments: customerId,
            ),
          ),

        ).then((value) => setState(() {}));

      }
    else{
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  const CustomersDetails(),
          settings: RouteSettings(
            arguments: customerId,
          ),
        ),

      ).then((value) => setState(() {}));
      }


  }
}


class Contact {
  final String fullName;
  final String address;
  final String number;
  final int id;

  const Contact({required this.fullName, required this.address, required this.number, required this.id});
}

