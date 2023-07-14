import 'package:alx_voyager/models/user.dart';
import 'package:alx_voyager/screens/session.dart';
import 'package:alx_voyager/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Voyager?>.value(
      catchError: (context, error) => null,
      initialData: null,
      value: AuthService().voyagerStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Session(),
      ),
    );
  }
}
