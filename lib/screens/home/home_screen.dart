import 'package:alx_voyager/screens/home/home.dart';
import 'package:alx_voyager/screens/home/location_list.dart';
import 'package:alx_voyager/screens/home/profile.dart';
import 'package:alx_voyager/screens/home/trip_planning.dart';
import 'package:alx_voyager/services/auth.dart';
import 'package:alx_voyager/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alx_voyager/models/location.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    VoyagerHomeScreen(),
    WishlistScreenWidget(),
    TripPlanningScreen(),
    MyTripsScreenWidget(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor:
            Colors.white, // Set bottom navigation bar background color to white
        selectedItemColor: Colors.blue, // Set selected item color
        unselectedItemColor: Colors.grey, // Set unselected item color
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flight),
            label: 'Plan Trip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            label: 'My Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text('Home Screen Content'),
      ),
    );
  }
}

class WishlistScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Location>>.value(
      value: DatabaseService(uid: getUID().toString()).locations,
      initialData: [],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'My Wishlist',
            style: TextStyle(color: Colors.black87),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: LocationInfo()
        ),
      ),
    );
  }
}

class PlanTripScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Trip Planning',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Plan Trip Screen Content'),
      ),
    );
  }
}

class MyTripsScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Trips',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('You have not been on any trips yet!'),
      ),
    );
  }
}

class ProfileScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Profile',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Profile Screen Content'),
      ),
    );
  }
}
