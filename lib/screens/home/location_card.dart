import "package:flutter/material.dart";

Widget LocationCard(
    String city, country, name, url, int rating, bool like)  {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Stack(
      children: [
        Positioned.fill(
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/loading.gif',
             // Replace with your network image URL
             image: url,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            icon: Icon(Icons.favorite),
            color: IconColor(like),
            onPressed: () {
              // Handle like button tap
              if (like == true) {
                like = !like;
              }
            },
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                city +', ' + country,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Text(
            rating.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}

Color IconColor(liked) {
  if (liked == true) {
    return Colors.red;
  } else {
    return Colors.grey;
  }
}
