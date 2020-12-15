import 'package:flutter/material.dart';
import 'package:bookevritin/screens/Home.dart';
import 'package:bookevritin/screens/Create.dart';

void main() => runApp( MyApp() );

class MyApp extends StatelessWidget {

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp( title: _title, home: MyStatefulWidget() );
  }

}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();

}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _widgetOptions = [
    Home(),
    Text( 'Index 0: Create', style: optionStyle ),
    Text( 'Index 0: Send', style: optionStyle ),
    Text( 'Index 0: Saved', style: optionStyle ),
    Text( 'Index 0: Settings', style: optionStyle )
  ];

  void _onItemTapped(int index) {
    setState(() { _selectedIndex = index; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          title: const Text('BookEvritin'),
          actions: <Widget> [
            IconButton( icon: const Icon(Icons.notifications ), tooltip: 'Notifications', onPressed: () {} ),
            IconButton( icon: const Icon(Icons.shopping_cart_sharp ), tooltip: 'Cart', onPressed: () {} ),
            PopupMenuButton<Text>(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: ListTile( leading: const Icon(Icons.account_circle_sharp ), title: Text('TemmyScope'), ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    child: ListTile( leading: const Icon(Icons.person_add), title: Text('Add Account') ),
                  ),
                ];
              },
            ),
          ],
          backgroundColor: Colors.lightGreen,
      ),

      body: Center(
          child: RefreshIndicator(
              child: _widgetOptions.elementAt(_selectedIndex),
              onRefresh: (){
                return Future<void>.delayed(const Duration(seconds: 1))
                ..then<void>((_) {
                  //if (mounted) { setState(() => ()); }
                });
              }
          )

      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem( icon: Icon(Icons.home_sharp), label: 'Home' ),
          BottomNavigationBarItem( icon: Icon(Icons.create_sharp), label: 'Create'),
          BottomNavigationBarItem( icon: Icon(Icons.send_sharp), label: 'Send'),
          BottomNavigationBarItem( icon: Icon(Icons.bookmarks_sharp), label: 'Saved'),
          BottomNavigationBarItem( icon: Icon(Icons.settings_sharp), label: 'Settings'),
        ],
        unselectedItemColor: Colors.black45,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreen,
        onTap: _onItemTapped,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightGreen
              ),
              child: Center(
                child: Text( 'Drawer', style: TextStyle( color: Colors.white, fontSize: 24 ) ),
              )
            ),
            ListTile( leading: Icon(Icons.account_circle), title: Text('Profile') ),
            ListTile( leading: Icon(Icons.storefront_sharp ), title: Text('My Stores') ),
            ListTile( leading: Icon(Icons.history_sharp ), title: Text('Transactions') ),
            ListTile( leading: Icon(Icons.message), title: Text('Messages') ),
            ListTile( leading: Icon(Icons.lightbulb ), title: Text('Dark Mode') ),
            ListTile( leading: Icon(Icons.devices ), title: Text('My Devices') ),
            ListTile( leading: Icon(Icons.power_settings_new_sharp ), title: Text('Sign Out') ),
          ],
        )
      )
    );
  }
}