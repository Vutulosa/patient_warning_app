import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_warning_app/Screens/HomeScreen/home_screen.dart';
import 'package:patient_warning_app/Screens/LoginScreen/Screens/login_screen.dart';

class LoginController extends StatefulWidget {
  const LoginController({Key? key}) : super(key: key);

  @override
  _LoginControllerState createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.idTokenChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.connectionState == ConnectionState.done) {
            return const Text('Done.');
          } else if (snapshot.hasError) {
            return const Text("Error has occured");
          } else {
            if (snapshot.data != null) {
              return GetUserRole(
                documentId: snapshot.data!.uid.toString(),
              );
            } else {
              return const LoginScreen();
            }
          }
        });
  }
}

class GetUserRole extends StatelessWidget {
  const GetUserRole({Key? key, required this.documentId}) : super(key: key);
  final String documentId;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return HomeScreen(
            role: data['role'],
          );
        }

        return Container();
      },
    );
  }
}
