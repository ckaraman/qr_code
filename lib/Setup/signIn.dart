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
      body: Container(
        child: Stack(children: <Widget>[
          // Positioned.fill(
          //     child: Container(
          //   decoration: BoxDecoration(
          //     // Box decoration takes a gradient
          //     gradient: LinearGradient(
          //       // Where the linear gradient begins and ends
          //       begin: Alignment.topRight,
          //       end: Alignment.bottomLeft,
          //       // Add one stop for each color. Stops should increase from 0 to 1
          //       stops: [0.0, 1.0],
          //       colors: [
          //         Color.fromRGBO(170, 207, 211, 1.0),
          //         Color.fromRGBO(93, 142, 155, 1.0),
          //       ],
          //     ),
          //   ),
          // )),
          Positioned.fill(
            child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: devicePadding.top + 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 250,
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: FlareActor(
                        'assets/Teddy(2).flr',
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter,
                        controller: _teddyController,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TrackingTextInput(
                                  label: "Email",
                                  hint: "Thy Email adresinizi girin",
                                  onTextChanged: (String value) =>
                                      _email = value,
                                  onCaretMoved: (Offset caret) {
                                    _teddyController.lookAt(caret);
                                  }),
                              TrackingTextInput(
                                label: "Şifre",
                                hint:
                                    "Daha önceden belirlediğiniz şifrenizi giriniz.",
                                onTextChanged: (String value) =>
                                    _password = value,
                                onCaretMoved: (Offset caret) {
                                  _teddyController.lookAt(caret);
                                },
                                isObscured: true,
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
                      ),
                    ),
                  ],
                )),
          )
        ]),
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
        _teddyController.play("success");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user: user)));
      } catch (e) {
        print(e.message);
        _teddyController.play("fail");
      }
    }
  }
}
