//VIEW PATIENTS
//* VIEW PATIENT

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_warning_app/Screens/AccountScreen/Components/account_screen_view.dart';
import 'package:patient_warning_app/Screens/LoginScreen/Screens/register_screen.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({Key? key}) : super(key: key);

  @override
  _PatientsScreenState createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  final Stream<QuerySnapshot> _patientsStream = FirebaseFirestore.instance
      .collection('users')
      .where('admin', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _patientsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }

        final data = snapshot.requireData;

        return Column(children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Register New Patient')),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: data.size,
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(
                  Icons.account_circle,
                  color: Colors.teal,
                ),
                title: Text(data.docs[index]['email']),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  //pass UID

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountViewScreen(
                        uid: data.docs[index]['uid'],
                        email: data.docs[index]['email'],
                      ),
                    ),
                  );
                },
              );
            },
          )
        ]);
      },
    );
  }
}
