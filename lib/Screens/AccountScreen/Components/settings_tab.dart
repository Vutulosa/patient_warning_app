import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_warning_app/Screens/AccountScreen/Components/update_details_screen.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab(
      {Key? key,
      required this.age,
      required this.gender,
      required this.address})
      : super(key: key);
  final String age;
  final String gender;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                  minimumSize: const Size(230, 40),
                  primary: Colors.teal),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateDetailsScreen(
                      age: age,
                      gender: gender,
                      address: address,
                    ),
                  ),
                );
              },
              child: const Text('Update Account Details')),
          const Divider(),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                  minimumSize: const Size(230, 40),
                  primary: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Log Out?'),
                      content: const Text('Are you sure you want to log out?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('CANCEL'),
                        ),
                        TextButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          },
                          child: const Text(
                            'LOG OUT',
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Log Out')),
        ]));
  }
}
