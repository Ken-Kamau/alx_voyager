import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  //collection reference
  final CollectionReference voyagerCollection =
      FirebaseFirestore.instance.collection('voyagers');

  Future updateVoyagerData(String displayName) async {
    return await voyagerCollection.doc(uid).set({'displayName' : displayName});
  }
}
