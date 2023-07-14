import "package:alx_voyager/models/location.dart";
import "package:alx_voyager/screens/home/location_list.dart";
import "package:alx_voyager/services/auth.dart";
import "package:alx_voyager/services/database.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Location>>.value(
      value: DatabaseService(uid: getUID().toString()).locations,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Text(
            'Voyager',
            style: TextStyle(color: Colors.black87),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 4.0,
          actions: [
            TextButton(
              child: Icon(
                Icons.exit_to_app,
                color: Colors.black87,
              ),
              onPressed: () async {
                await _authService.signOut();
              },
            )
          ],
        ),
        body: LocationInfo(),
      ),
    );
  }
}
