import "package:alx_voyager/screens/authentication/authentication.dart";
import "package:alx_voyager/screens/home/home.dart";
import "package:flutter/material.dart";

class Session extends StatelessWidget {
  const Session({super.key});

  @override
  Widget build(BuildContext context) {

    //Return either home or authenticate widget
    return const Authentication();
  }
}