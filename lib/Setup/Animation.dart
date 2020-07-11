import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/cupertino.dart';

class LoginAnimation extends StatelessWidget {
  final FlareController controller;
  const LoginAnimation({Key key,this.controller});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlareActor('assets/Teddy.flr',alignment: Alignment.topCenter,controller: controller,),
    );
  }
}