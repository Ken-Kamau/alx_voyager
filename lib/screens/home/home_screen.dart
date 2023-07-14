import 'package:alx_voyager/screens/home/home.dart';
import 'package:alx_voyager/screens/home/profile.dart';
import 'package:alx_voyager/screens/home/trip_planning.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist Screen'),
      ),
      body: Center(
        child: Text('Wishlist Screen Content'),
      ),
    );
  }
}

class PlanTripScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan Trip Screen'),
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
        title: Text('My Trips Screen'),
      ),
      body: Center(
        child: Text('My Trips Screen Content'),
      ),
    );
  }
}

class ProfileScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
      ),
      body: Center(
        child: Text('Profile Screen Content'),
      ),
    );
  }
}
