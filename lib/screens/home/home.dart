import 'package:flutter/material.dart';
import "package:alx_voyager/models/location.dart";
import "package:alx_voyager/screens/home/location_list.dart";
import "package:alx_voyager/services/auth.dart";
import "package:alx_voyager/services/database.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:provider/provider.dart";

class VoyagerHomeScreen extends StatefulWidget {
  @override
  _VoyagerHomeScreenState createState() => _VoyagerHomeScreenState();
}

class _VoyagerHomeScreenState extends State<VoyagerHomeScreen> {
  final AuthService _authService = AuthService();
  bool _isVisible = true;
  int _selectedIndex = 0;

  void _onBottomNavigationItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _logout(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Perform logout logic here
                await _authService.signOut();
                Navigator.pop(context);
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/alx-voyager.appspot.com/o/portrait.jpg?alt=media&token=be1496c8-a895-4a68-8956-92b5037ae3e4',
                )),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Welcome back, User',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Location',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Dismissible(
                            key: Key('notification'),
                            direction: DismissDirection.vertical,
                            onDismissed: (_) {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 200,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  'No New Notifications!',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.logout,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      _logout(context);
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search destination',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Text(
                        'Browse Categories',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CategoryDetailsPage(category: category),
                            ),
                          );
                        },
                        child: Container(
                          width: 150,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(category.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              category.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.black38),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Text(
                        'Top Destinations',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      //LocationInfo(),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final destination = destinations[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DestinationDetailsPage(
                                destination: destination),
                          ),
                        );
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(destination.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                destination.title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor: Colors.black38),
                              ),
                              SizedBox(height: 4),
                              Text(
                                destination.details,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    backgroundColor: Colors.black38),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: destinations.length,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Text(
                        'Destinations On the Most Bucketlists',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final bucketItem = bucketList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BucketItemDetailsPage(bucketItem: bucketItem),
                          ),
                        );
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(bucketItem.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              bucketItem.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.black38),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: bucketList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Center(
        child: Text('Search Page'),
      ),
    );
  }
}

class CategoryDetailsPage extends StatelessWidget {
  final Category category;

  const CategoryDetailsPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          category.title,
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Text(
        'Category Details Page',
      )),
    );
  }
}

class DestinationDetailsPage extends StatelessWidget {
  final Destination destination;

  const DestinationDetailsPage({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          destination.title,
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Destination Details Page'),
      ),
    );
  }
}

class BucketItemDetailsPage extends StatelessWidget {
  final BucketItem bucketItem;

  const BucketItemDetailsPage({required this.bucketItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          bucketItem.title,
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Bucket Item Details Page'),
      ),
    );
  }
}

class Category {
  final String title;
  final String image;

  const Category({
    required this.title,
    required this.image,
  });
}

final List<Category> categories = [
  Category(
    title: 'Beach',
    image: 'assets/beach.jpg',
  ),
  Category(
    title: 'Safari',
    image: 'assets/safari.jpg',
  ),
  Category(
    title: 'Surfing',
    image: 'assets/surfing.jpg',
  ),
  // Add more categories as needed
];

class Destination {
  final String title;
  final String details;
  final String image;

  const Destination({
    required this.title,
    required this.details,
    required this.image,
  });
}

final List<Destination> destinations = [
  Destination(
    title: 'Santorini, Greece',
    details: 'Most highly rated by fellow Voyagers!',
    image: 'assets/destination1.jpg',
  ),
  Destination(
    title: 'Venice, Italy',
    details: 'The architecture is to die for',
    image: 'assets/destination2.jpg',
  ),
  Destination(
    title: 'Marseille, France',
    details: 'Waltz through the city on a canoe!',
    image: 'assets/destination3.jpg',
  ),
  // Add more destinations as needed
];

class BucketItem {
  final String title;
  final String image;

  const BucketItem({
    required this.title,
    required this.image,
  });
}

final List<BucketItem> bucketList = [
  BucketItem(
    title: 'London',
    image: 'assets/bucketitem1.jpg',
  ),
  BucketItem(
    title: 'Switzerland',
    image: 'assets/bucketitem2.jpg',
  ),
  BucketItem(
    title: 'Himalayas',
    image: 'assets/bucketitem3.jpg',
  ),
  // Add more bucket items as needed
];
