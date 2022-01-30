import 'package:flutter/material.dart';
import 'package:flutter_app_day10/login_widget.dart';
import 'package:flutter_app_day10/signup_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({ Key? key }) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) =>
   isLogin ? Login(onClickedSignUp: toggle) 
           : SignUpWidget(onClickedSignIn: toggle);

  void toggle() => setState(() {
    isLogin = !isLogin;
  }); 
}