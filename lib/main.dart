import 'package:flutter/material.dart';

import 'Setup/signIn.dart';

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
