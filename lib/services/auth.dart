import "package:alx_voyager/models/user.dart";
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
            photoURL: user.photoURL
          )
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

  //sign in with email and password

  //register with email and password

  //sign out
}
