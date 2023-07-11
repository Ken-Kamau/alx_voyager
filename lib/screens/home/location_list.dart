import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:provider/provider.dart";

class LocationInfo extends StatefulWidget {
  const LocationInfo({super.key});

  @override
  State<LocationInfo> createState() => _LocationInfoState();
}

class _LocationInfoState extends State<LocationInfo> {
  @override
  Widget build(BuildContext context) {
    final locations = Provider.of<QuerySnapshot>(context);
    //print(locations.docs);
    for (var doc in locations.docs) {
      print(doc.data());
    }
    return Container();
  }
}
