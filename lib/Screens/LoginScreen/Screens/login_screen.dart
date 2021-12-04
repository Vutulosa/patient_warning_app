import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _loginFormKey,
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsetsDirectional.all(15),
                  child: Text("Login",
                      style: Theme.of(context).textTheme.headline4)),
              Padding(
                  padding: const EdgeInsetsDirectional.all(15),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your e-mail';
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
                      return 'Please enter your password';
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
                      if (_loginFormKey.currentState!.validate()) {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
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
                          } else if (e.code == 'user-not-found') {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                    content: Text(
                                  'No user found for that email.',
                                ));
                              },
                            );
                          } else if (e.code == 'wrong-password') {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                    content: Text(
                                  'Invalid Password',
                                ));
                              },
                            );
                          }
                        }
                      }
                    },
                    icon: const Icon(Icons.login),
                    label: const Text("Login")),
              ),
            ],
          )),
    );
  }
}
