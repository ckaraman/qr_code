import 'package:flutter/material.dart';

import 'Pages/Setup/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qr Code',
      theme: ThemeData.dark(),
      home: LoginPage(),
    );
  }
}
