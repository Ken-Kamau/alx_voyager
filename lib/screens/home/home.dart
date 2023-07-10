import "package:alx_voyager/services/auth.dart";
import "package:flutter/material.dart";

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Voyager'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: [
          TextButton.icon(
              onPressed: () async {
                await _authService.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('Logout'))
        ],
      ),
    );
  }
}
