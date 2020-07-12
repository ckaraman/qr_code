import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../Pages/home.dart';
import '../teddy_controller.dart';
import '../tracking_text_input.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

TeddyController _teddyController;
@override
Widget build(BuildContext context) {
  initState() {
    _teddyController = TeddyController();
    initState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _animationName = "idle";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt Olun'),
      ),
      body: Container(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              fit: FlexFit.loose,
              child: SizedBox(
                height: 250,
                width: 300,
                child: FlareActor(
                  'assets/Teddy(2).flr',
                  animation: _animationName,
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                  controller: _teddyController,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Lütfen email giriniz.';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: "Thy email adresinizi giriniz"),
              ),
            ),
            Flexible(
              flex: 1,
              child: TextFormField(
                validator: (input) {
                  if (input.length < 6) {
                    return 'Lütfen en az 6 haneli şifre giriniz.';
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  labelText: 'Şifre',
                ),
                obscureText: true,
              ),
            ),
            Flexible(
              flex: 1,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    _animationName = "success";
                  });
                  signIn(context);
                },
                child: Text('Giriş yap'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signIn(BuildContext context) async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        AuthResult user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user: user)));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
