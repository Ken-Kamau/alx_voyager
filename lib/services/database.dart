import "package:cloud_firestore/cloud_firestore.dart";
import 'package:alx_voyager/models/location.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  DatabaseService.withoutUID() : uid = '';
  //collection reference
  final CollectionReference locationCollection =
      FirebaseFirestore.instance.collection('locations');

  Future updateLocationData(
      String locationName,
      String locationAddress,
      String city,
      String country,
      String photoURL,
      double rating,
      bool liked) async {
    return await locationCollection.doc(uid).set({
      'locationName': locationName,
      'locationAddress': locationAddress,
      'city': city,
      'country': country,
      'photoURL': photoURL,
      'rating': rating,
      'liked': liked,
    });
  }

  List<Location> _locationListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return Location(
        locationName: doc.get('locationName') ?? '',
        locationAddress: doc.get('locationAddress') ?? '',
        city: doc.get('city') ?? '',
        country: doc.get('country') ?? '',
        photoURL: doc.get('photoURL') ?? '',
        rating: doc.get('rating') ?? 0.0,
        liked: doc.get('liked') ?? false,
      );
    }).toList();
  }

  Stream<List<Location>> get locations {
    return locationCollection.snapshots().map(_locationListFromSnapshot);
  }
}
