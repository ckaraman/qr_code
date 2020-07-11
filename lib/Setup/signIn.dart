import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:smart_flare/actors/pan_flare_actor.dart';
import '../Pages/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                height: 310,
                width: 300,
                child: FlareActor(
                  'assets/Teddy(2).flr',
                  animation: 'idle',
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                  shouldClip: true,
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
                ),
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
