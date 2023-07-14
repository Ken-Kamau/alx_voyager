import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(
    home: DestinationsScreen(
      apiKey: 'YOUR_API_KEY',
    ),
  ));
}

class Destination {
  final String name;
  final String formattedAddress;
  late final String? photoReference;
  final String placeId;
  bool liked;

  Destination({
    required this.name,
    required this.formattedAddress,
    this.photoReference,
    required this.placeId,
    this.liked = false,
  });
}

class DestinationsScreen extends StatefulWidget {
  final String apiKey;

  const DestinationsScreen({required this.apiKey});

  @override
  _DestinationsScreenState createState() => _DestinationsScreenState();
}

class _DestinationsScreenState extends State<DestinationsScreen> {
  late GoogleMapsPlaces places;
  List<Destination> destinations = [];
  TextEditingController searchController = TextEditingController();
  bool reachedEnd = false;

  List<Destination> likedDestinations = [];

  @override
  void initState() {
    super.initState();
    places = GoogleMapsPlaces(apiKey: widget.apiKey);
    // Perform a search on initial load or update
    searchDestinations('');
  }

  @override
  void dispose() {
    places.dispose();
    super.dispose();
  }

  Future<void> searchDestinations(String query) async {
    PlacesAutocompleteResponse response = await places.autocomplete(query);
    if (response.isOkay) {
      setState(() {
        destinations = response.predictions
            .map((prediction) => Destination(
                  name: prediction.description!,
                  formattedAddress: '',
                  liked: likedDestinations.any((likedDestination) =>
                      likedDestination.name == prediction.description),
                  placeId: prediction.placeId!,
                ))
            .toList();
      });

      for (var destination in destinations) {
        await getPlaceDetails(destination);
      }
    } else {
      print(response.errorMessage);
    }
  }

  Future<void> getPlaceDetails(Destination destination) async {
    PlacesDetailsResponse response =
        await places.getDetailsByPlaceId(destination.placeId!);
    if (response.isOkay) {
      if (response.result.photos?.isNotEmpty == true) {
        destination.photoReference = response.result.photos![0].photoReference;
      }
    } else {
      print(response.errorMessage);
    }
  }

  void likeDestination(Destination destination) {
    setState(() {
      destination.liked = !destination.liked;
      if (destination.liked) {
        likedDestinations.add(destination);
        Fluttertoast.showToast(msg: 'Added to Wishlist');
      } else {
        likedDestinations.remove(destination);
        Fluttertoast.showToast(msg: 'Removed from Wishlist');
      }
    });
  }

  void removeFromWishlist(Destination destination) {
    setState(() {
      likedDestinations.remove(destination);
    });
  }

  String buildPhotoUrl(String? photoReference) {
    if (photoReference != null) {
      return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photoreference=$photoReference&key=${widget.apiKey}';
    }
    // Placeholder image if no photo available
    return 'https://via.placeholder.com/800';
  }

  void handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      final metrics = notification.metrics;
      final maxScrollExtent = metrics.maxScrollExtent;
      final pixels = metrics.pixels;
      if (pixels == maxScrollExtent) {
        setState(() {
          reachedEnd = true;
        });
        Fluttertoast.showToast(msg: 'End of results');
      } else {
        setState(() {
          reachedEnd = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Destinations'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                searchDestinations(value);
              },
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                handleScrollNotification(notification);
                return true;
              },
              child: ListView.builder(
                itemCount: destinations.length,
                itemBuilder: (context, index) {
                  Destination destination = destinations[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DestinationScreen(
                            apiKey: widget.apiKey,
                            destination: destination,
                            buildPhotoUrl: buildPhotoUrl,
                          ),
                        ),
                      );
                    },
                    child: DestinationCard(
                      destination: destination,
                      buildPhotoUrl: buildPhotoUrl,
                      onLikePressed: () => likeDestination(destination),
                    ),
                  );
                },
              ),
            ),
          ),
          if (reachedEnd)
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0),
              child: Text(
                'End of Results',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WishlistScreen(
                wishlist: likedDestinations,
                buildPhotoUrl: buildPhotoUrl,
                removeFromWishlist: removeFromWishlist,
              ),
            ),
          );
        },
      ),
    );
  }
}

class DestinationScreen extends StatelessWidget {
  final String apiKey;
  final Destination destination;
  final Function(String?) buildPhotoUrl;

  const DestinationScreen({
    required this.apiKey,
    required this.destination,
    required this.buildPhotoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(destination.name),
      ),
      body: ListView(
        children: [
          Image.network(
            buildPhotoUrl(destination.photoReference),
            fit: BoxFit.cover,
            height: 200.0,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destination.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  destination.formattedAddress,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.all(16.0),
            child: FloatingActionButton(
              child: Icon(Icons.location_on),
              onPressed: () {
                // Open maps with the destination's location
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WishlistScreen extends StatelessWidget {
  final List<Destination> wishlist;
  final Function(Destination) removeFromWishlist;
  final Function(String?) buildPhotoUrl;

  const WishlistScreen({
    required this.wishlist,
    required this.removeFromWishlist,
    required this.buildPhotoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: ListView.builder(
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          Destination destination = wishlist[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                buildPhotoUrl(destination.photoReference),
              ),
            ),
            title: Text(destination.name),
            subtitle: Text(destination.formattedAddress),
            trailing: IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => removeFromWishlist(destination),
            ),
          );
        },
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final Destination destination;
  final Function() onLikePressed;
  final Function(String?) buildPhotoUrl;

  const DestinationCard({
    required this.destination,
    required this.onLikePressed,
    required this.buildPhotoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DestinationScreen(
                    apiKey: '',
                    destination: destination,
                    buildPhotoUrl: buildPhotoUrl,
                  ),
                ),
              );
            },
            child: Image.network(
              buildPhotoUrl(destination.photoReference),
              fit: BoxFit.cover,
              height: 200.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      destination.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        destination.liked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: destination.liked ? Colors.red : null,
                      ),
                      onPressed: onLikePressed,
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Text(
                  destination.formattedAddress,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.all(16.0),
            child: FloatingActionButton(
              child: Icon(Icons.location_on),
              onPressed: () {
                // Open maps with the destination's location
              },
            ),
          ),
        ],
      ),
    );
  }
}
