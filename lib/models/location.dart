class Location {
  final String locationName;
  final String locationAddress;
  final String city;
  final String country;
  final String photoURL;
  final int rating;
  final bool liked;

  Location({
    required this.locationName,
    required this.locationAddress,
    required this.city,
    required this.country,
    required this.photoURL,
    required this.rating,
    required this.liked,
  });
}
