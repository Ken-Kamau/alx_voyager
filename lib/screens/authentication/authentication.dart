import 'package:alx_voyager/screens/authentication/sign_in.dart';
import 'package:alx_voyager/screens/authentication/signup.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn = true;
  void toggleScreen() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleScreen: toggleScreen);
    } else {
      return Register(toggleScreen: toggleScreen);
    }
  }
}
