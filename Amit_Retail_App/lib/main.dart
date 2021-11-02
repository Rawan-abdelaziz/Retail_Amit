import 'package:flutter/material.dart';

import 'Login_Register/login_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Auth System",
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
