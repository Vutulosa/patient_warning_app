import 'package:flutter/material.dart';
import 'package:patient_warning_app/Screens/AccountScreen/account_screen.dart';
import 'package:patient_warning_app/Screens/AddScreen/Components/body.dart';
import 'package:patient_warning_app/Screens/SearchScreen/Components/body.dart';
import 'Components/body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    // HomeBody(),
    SearchBody(),
    AddMediaScreen(),
    AccountScreen(),
    Text(
      'Index 4: Patients',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          // BottomNavigationBarItem(
          //   label: 'Home',
          //   icon: Icon(Icons.home),
          // ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'Add Media',
            icon: Icon(Icons.add),
          ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: Icon(Icons.account_circle),
          ),
          BottomNavigationBarItem(
            label: 'Patients',
            icon: Icon(
              Icons.people,
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
