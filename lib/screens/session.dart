import "package:alx_voyager/models/user.dart";
import "package:alx_voyager/screens/authentication/authentication.dart";
import "package:alx_voyager/screens/home/home.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class Session extends StatelessWidget {
  const Session({super.key});

  @override
  Widget build(BuildContext context) {
    final voyager = Provider.of<Voyager?>(context);
    print(voyager);

    //Return either home or authenticate widget
    if (voyager == null) {
      return Authentication();
    } else {
      return Home();
    }
  }
}
