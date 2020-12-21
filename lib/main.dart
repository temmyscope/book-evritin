import 'package:bookevritin/screens/Saved.dart';
import 'package:flutter/material.dart';
import 'package:bookevritin/screens/Home.dart';
import 'package:bookevritin/screens/Send.dart';
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

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold, );

  final List<Widget> _widgetOptions = [
    Home(),
    Create(),
    Send(),
    Saved(),
    Text( 'Index 0: Settings', style: optionStyle )
  ];
  final List<String> _titles = [
    'Home', 'Create Store', 'Money Transfer', 'Bookmarks', 'Settings'
  ];

  Future<void> _showDemoDialog<T>({BuildContext context, Widget child}) async {
    child = Theme( data: Theme.of(context), child: child );
    await showDialog<T>( context: context, builder: (context) => child );
  }

  confirmLogout(BuildContext context) {
    final theme = Theme.of(context);
    _showDemoDialog<String>(
      context: context,
      child: SimpleDialog(
        title: Text("Accounts"),
        children: [
          _DialogDemoItem(
            icon: Icons.warning_amber_sharp ,
            color: theme.colorScheme.primary,
            text: 'You are about to be logged out.',
          ),
          _DialogDemoItem(
            icon: Icons.power_settings_new_sharp,
            text: "Sign Out",
            color: theme.disabledColor,
          ),
        ],
      ),
    );
  }

  void _showSimpleDialog(BuildContext context) {
    final theme = Theme.of(context);
    _showDemoDialog<String>(
      context: context,
      child: SimpleDialog(
        title: Text("Accounts"),
        children: [
          _DialogDemoItem(
            icon: Icons.account_circle,
            color: theme.colorScheme.primary,
            text: 'username@gmail.com',
          ),
          _DialogDemoItem(
            icon: Icons.account_circle,
            color: theme.colorScheme.secondary,
            text: 'user02@gmail.com',
          ),
          _DialogDemoItem(
            icon: Icons.add_circle,
            text: "Add Account",
            color: theme.disabledColor,
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() { _selectedIndex = index; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          title: Text(_titles.elementAt(_selectedIndex) ),
          actions: <Widget> [
            IconButton( icon: const Icon(Icons.notifications ), tooltip: 'Notifications', onPressed: () {} ),
            IconButton( icon: const Icon(Icons.shopping_cart_sharp ), tooltip: 'Cart', onPressed: () {} ),
            IconButton(icon: const Icon(Icons.more_vert), tooltip: 'Switch Account', onPressed: (){
              _showSimpleDialog(context);
            })
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
              },
              color: Colors.lightGreen,
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
          children: <Widget>[
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
            ListTile( leading: Icon(Icons.power_settings_new_sharp ), title: Text('Sign Out'), onTap: (){
              confirmLogout(context);
            }),
          ],
        )
      )
    );
  }
}

class _DialogDemoItem extends StatelessWidget {
  const _DialogDemoItem({
    Key key,
    this.icon,
    this.color,
    this.text,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop(text);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: color),
          Flexible(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}
