class Voyager {
  final String uid;
  final String? displayName;
  final String? email;
  final DateTime? creationTime;
  final DateTime? lastSignInTime;
  final String? photoURL;

  Voyager({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.creationTime,
    required this.lastSignInTime,
    required this.photoURL,
  });
}
