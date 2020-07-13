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

class _LoginPageState extends State<LoginPage> {
  TeddyController _teddyController;
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _animationName = "idle";
  @override
  initState() {
    _teddyController = TeddyController();
    super.initState();
  }

  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;
    return Scaffold(
      appBar: AppBar(
        title: Text('Qrcode ile Mdv takip sistemi'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  alignment: Alignment.bottomCenter,
                  controller: _teddyController,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: TrackingTextInput(
                  label: "Email",
                  hint: "Thy Email adresinizi girin",
                  onTextChanged: (String value) => _email = value,
                  onCaretMoved: (Offset caret) {
                    _teddyController.lookAt(caret);
                  }),
              // child: TextFormField(
              //   validator: (input) {
              //     if (input.isEmpty) {
              //       return 'Lütfen email giriniz.';
              //     }
              //   },
              //   onSaved: (input) => _email = input,
              //   decoration: InputDecoration(
              //       labelText: 'Email',
              //       hintText: "Thy email adresinizi giriniz"),
              //),
            ),
            Flexible(
              flex: 1,
              child: TrackingTextInput(
                label: "Şifre",
                hint: "Daha önceden belirlediğiniz şifrenizi giriniz.",
                onTextChanged: (String value) => _password = value,
                onCaretMoved: (Offset caret) {
                  _teddyController.lookAt(caret);
                },
                isObscured: true,
              ),

              // child: TextFormField(
              //   validator: (input) {
              //     if (input.length < 6) {
              //       return 'Lütfen en az 6 haneli şifre giriniz.';
              //     }
              //   },
              //   onSaved: (input) => _password = input,
              //   decoration: InputDecoration(
              //     labelText: 'Şifre',
              //   ),
              //   obscureText: true,
              // ),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {});
                signIn(context);
              },
              child: Text('Giriş yap'),
            ),
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
        _teddyController.play("fail");
      }
    }
  }
}
