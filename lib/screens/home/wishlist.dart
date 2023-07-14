import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

void main() {
  runApp(MaterialApp(
    home: DestinationsScreen(apiKey: 'AIzaSyBECKhNWD8tFE17X8Fx1MyBPk8kj54-G6Y'),
  ));
}

class DestinationsScreen extends StatefulWidget {
  final String apiKey;

  const DestinationsScreen({required this.apiKey});

  @override
  _DestinationsScreenState createState() => _DestinationsScreenState();
}

class _DestinationsScreenState extends State<DestinationsScreen> {
  late GoogleMapsPlaces places;
  List<PlacesSearchResult> destinations = [];

  @override
  void initState() {
    super.initState();
    places = GoogleMapsPlaces(apiKey: widget.apiKey);
    searchDestinations('YOUR_QUERY');
  }

  @override
  void dispose() {
    places.dispose();
    super.dispose();
  }

  Future<void> searchDestinations(String query) async {
    PlacesSearchResponse response = await places.searchByText(query);
    if (response.isOkay) {
      setState(() {
        destinations = response.results;
      });
    } else {
      print(response.errorMessage);
    }
  }

  String buildPhotoUrl(String? photoReference) {
    if (photoReference != null) {
      return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photoreference=$photoReference&key=${widget.apiKey}';
    }
    // Placeholder image if no photo available
    return 'https://via.placeholder.com/800';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Destinations'),
      ),
      body: Column(
        children: [
          // Search bar and filter dropdown
          // Add your implementation here

          // Destination cards
          Expanded(
            child: ListView.builder(
              itemCount: destinations.length,
              itemBuilder: (context, index) {
                final destination = destinations[index];
                return DestinationCard(
                  destination: destination,
                  buildPhotoUrl: buildPhotoUrl,
                  onLikePressed: () {
                    // Handle like button press
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final PlacesSearchResult destination;
  final String Function(String?) buildPhotoUrl;
  final VoidCallback? onLikePressed;

  const DestinationCard({
    required this.destination,
    required this.buildPhotoUrl,
    this.onLikePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
            buildPhotoUrl(destination.photos?.first.photoReference),
            fit: BoxFit.cover,
            height: 200,
          ),
          ListTile(
            title: Text(destination.name),
            subtitle: Text(destination.formattedAddress ?? ''),
            trailing: IconButton(
              icon: Icon(Icons.favorite),
              color: Colors.red,
              onPressed: onLikePressed,
            ),
          ),
        ],
      ),
    );
  }
}
