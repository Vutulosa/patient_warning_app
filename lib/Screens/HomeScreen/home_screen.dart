import 'package:flutter/material.dart';
import 'package:patient_warning_app/Screens/AccountScreen/account_screen.dart';
import 'package:patient_warning_app/Screens/AddScreen/Components/body.dart';
import 'package:patient_warning_app/Screens/PatientsScreen/patients_screen.dart';
import 'package:patient_warning_app/Screens/SearchScreen/Components/body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.role}) : super(key: key);
  final String role;

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
    PatientsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> patientsBar({required String role}) {
    List<BottomNavigationBarItem> bottomNavigationBar = [];

    bottomNavigationBar.add(const BottomNavigationBarItem(
      label: 'Search',
      icon: Icon(Icons.search),
    ));
    bottomNavigationBar.add(const BottomNavigationBarItem(
      label: 'Add Media',
      icon: Icon(Icons.add),
    ));
    bottomNavigationBar.add(const BottomNavigationBarItem(
      label: 'Account',
      icon: Icon(Icons.account_circle),
    ));

    if (role.toString() == 'admin') {
      bottomNavigationBar.add(const BottomNavigationBarItem(
        label: 'Patients',
        icon: Icon(
          Icons.people,
        ),
      ));
    }
    return bottomNavigationBar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          ...patientsBar(role: widget.role),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
