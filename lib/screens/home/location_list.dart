import 'package:alx_voyager/screens/home/location_card.dart';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:provider/provider.dart";
import 'package:alx_voyager/models/location.dart';
import 'package:alx_voyager/screens/home/location_tile.dart';

class LocationInfo extends StatefulWidget {
  const LocationInfo({super.key});

  @override
  State<LocationInfo> createState() => _LocationInfoState();
}

class _LocationInfoState extends State<LocationInfo> {
  @override
  Widget build(BuildContext context) {
    final locations = Provider.of<List<Location>>(context);
    //print(locations.docs);
    /*for (var doc in locations.docs) {
      print(doc.data());
    }*/
    locations.forEach((location) {
      print(location.locationName);
      print(location.locationAddress);
      print(location.city);
      print(location.country);
      print(location.rating);
      print(location.liked);
      print(location.photoURL);
    });

    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        return LocationTile(location: locations[index]);
      },
    );
  }
}
