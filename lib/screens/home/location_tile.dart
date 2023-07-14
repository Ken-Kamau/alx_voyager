import 'package:flutter/material.dart';
import 'package:alx_voyager/models/location.dart';

class LocationTile extends StatelessWidget {
  final Location location;
  LocationTile({required this.location, super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: 
      /*LocationCard(
            location.city,
            location.country,
            location.locationName,
            location.photoURL,
            location.rating,
            location.liked)*/
      Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: FadeInImage.assetNetwork(
            placeholder: 'assets/placeholder.gif',
            // Replace with your network image URL
            image: location.photoURL,
            fit: BoxFit.cover,
          ),
          title: Text(location.locationName),
          subtitle: Text('${location.city}, ${location.country}.'),
        ),
      ),
    );
  }
}
