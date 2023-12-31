import "dart:math";

import "package:alx_voyager/models/user.dart";
import "package:alx_voyager/services/database.dart";
import "package:firebase_auth/firebase_auth.dart";

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Create User Object based on Firebase User
  Voyager? _voyagerUser(User user) {
    return user != null
        ? Voyager(
            uid: user.uid,
            displayName: user.displayName,
            email: user.email,
            creationTime: user.metadata.creationTime,
            lastSignInTime: user.metadata.lastSignInTime,
            photoURL: user.photoURL)
        : null;
  }

  //sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      User? user = userCredential.user;
      return _voyagerUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Auth Change User Stream
  Stream<Voyager?> get voyagerStream {
    return _firebaseAuth.authStateChanges().map((user) => _voyagerUser(user!));
  }

  //sign in with email and password
  Future signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      /*if (user != null) {
        user.providerData.forEach((element) {
          print("Provider: " + element.providerId.toString());
          print("UID: " + element.uid.toString());
          print("Email: " + element.email.toString());
          print("Name: " + element.displayName.toString());
        });
      }*/

      return _voyagerUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmail(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      await user!.updateDisplayName(name);

      //Create Voyager doc using uid
      await DatabaseService(uid: user!.uid).updateLocationData('', '', '', '', '', 0, false );

      /*Voyager voyager = Voyager(
          uid: user.uid,
          displayName: user.displayName,
          email: user.email,
          creationTime: user.metadata.creationTime,
          lastSignInTime: user.metadata.lastSignInTime,
          photoURL: user.photoURL);

          print("Voyager properties:");
      print("  uid: ${voyager.uid}");
      print("  displayName: ${voyager.displayName}");
      print("  email: ${voyager.email}");
      print("  creationTime: ${voyager.creationTime}");
      print("  lastSignInTime: ${voyager.lastSignInTime}");
      print("  photoURL: ${voyager.photoURL}");*/


      return _voyagerUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

Future getUID() async {
  dynamic getId = await FirebaseAuth.instance.currentUser!.uid;
  return getId;
}
