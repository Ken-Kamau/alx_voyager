import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  //collection reference
  final CollectionReference voyagerCollection =
      FirebaseFirestore.instance.collection('locations');

  Future updateLocationData(String locationName, String locationAddress, String city, String country, String photoURL, double rating, bool liked) async {
    return await voyagerCollection
    .doc(uid)
    .set({
      'locationName': locationName,
      'locationAddress': locationAddress,
      'city': city,
      'country': country,
      'photoURL': photoURL,
      'rating': rating,
      'liked' : liked,
      });
  }

  Stream<QuerySnapshot> get voyagers {
    return voyagerCollection.snapshots();
  }
}
