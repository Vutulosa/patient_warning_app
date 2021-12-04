import 'package:flutter/material.dart';
import 'package:patient_warning_app/Screens/LoginScreen/Screens/login_screen.dart';

class LoginController extends StatefulWidget {
  const LoginController({Key? key}) : super(key: key);

  @override
  _LoginControllerState createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {
  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
