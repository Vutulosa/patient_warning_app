//REGISTER
//VIEW PATIENTS
//* VIEW PATIENT

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _registerFormKey,
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsetsDirectional.all(15),
                  child: Row(children: [
                    const BackButton(),
                    Text("Register",
                        style: Theme.of(context).textTheme.headline6)
                  ])),
              Padding(
                  padding: const EdgeInsetsDirectional.all(15),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter patient's e-mail";
                      }
                      return null;
                    },
                    // The validator receives the text that the user has entered.
                    decoration: const InputDecoration(
                      labelText: 'E-Mail',
                      border: OutlineInputBorder(),
                    ),
                  )),
              Padding(
                padding: const EdgeInsetsDirectional.all(15),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter patient's password";
                    }
                    return null;
                  },
                  // The validator receives the text that the user has entered.
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.all(15),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        minimumSize: const Size(100, 50)),
                    onPressed: () async {
                      if (_registerFormKey.currentState!.validate()) {
                        try {
                          String adminUid =
                              FirebaseAuth.instance.currentUser!.uid;
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                          //create entry in users
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(userCredential.user!.uid)
                              .set({
                            'role': 'user',
                            'email': userCredential.user!.email,
                            'uid': userCredential.user!.uid,
                            'admin': adminUid
                          });
                          //create entry in user details
                          FirebaseFirestore.instance
                              .collection('userDetails')
                              .doc(userCredential.user!.uid)
                              .set({
                            'address': '',
                            'age': '',
                            'epilepsy': '',
                            'issues': '',
                            'gender': '',
                          });
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                  content: Text(
                                'User Created.',
                              ));
                            },
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'invalid-email') {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                    content: Text(
                                  'Please enter a valid email.',
                                ));
                              },
                            );
                          } else if (e.code == 'email-already-in-use') {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                    content: Text(
                                  'E-mail already in use.',
                                ));
                              },
                            );
                          } else if (e.code == 'weak-password') {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                    content: Text(
                                  'Password is too weak',
                                ));
                              },
                            );
                          }
                        }
                      }
                    },
                    icon: const Icon(Icons.person_add_sharp),
                    label: const Text("Register")),
              ),
            ],
          )),
    );
  }
}
