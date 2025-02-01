import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:lock/home.dart';
import 'package:lock/login.dart'; // Import CurvedNavigationBar

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 1; // Default to Dashboard screen
  bool _showRfidHistory =
      false; // To toggle the visibility of RFID connection history

  // Dummy data: Replace with actual RFID data
  final List<Map<String, String>> rfidData = [
    {"user": "John Doe", "time": "2024-12-16 08:30 AM"},
    {"user": "Jane Smith", "time": "2024-12-16 09:15 AM"},
    {"user": "Alice Brown", "time": "2024-12-16 10:00 AM"},
    {"user": "Bob Johnson", "time": "2024-12-16 11:20 AM"},
  ];

  // Method to handle navigation between pages
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Method to toggle the visibility of the RFID connection history
  void _toggleRfidHistory() {
    setState(() {
      _showRfidHistory = !_showRfidHistory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Remove app bar
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/dash.jpg', // Background image for the dashboard
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Welcome to Your Dashboard',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 1, // Only one card per row
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: <Widget>[
                      // RFID Connection History card
                      DashboardCard(
                        title: 'RFID Connection History',
                        icon: Icons.access_time,
                        onTap: _toggleRfidHistory, // Toggle visibility
                      ),
                    ],
                  ),
                ),
                // Show RFID connection history if _showRfidHistory is true
                if (_showRfidHistory) ...[
                  const SizedBox(height: 20),
                  const Text(
                    'RFID Connection History',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // List the RFID connection history here
                  Expanded(
                    child: ListView.builder(
                      itemCount: rfidData.length,
                      itemBuilder: (context, index) {
                        final user = rfidData[index]['user'];
                        final time = rfidData[index]['time'];

                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(user!),
                            subtitle: Text('Connected at: $time'),
                            trailing:
                                Icon(Icons.access_time, color: Colors.green),
                          ),
                        );
                      },
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
      // Using CurvedNavigationBar for navigation
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Colors.transparent, // Transparent background
        color: Colors.green.shade800, // Bottom navigation bar color
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.dashboard, size: 30),
          Icon(Icons.logout, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          // Handle bottom navigation actions
          switch (index) {
            case 0:
              // Navigate to HomeScreen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
              break;
            case 1:
              // Stay on the Dashboard Screen
              break;
            case 2:
              // Navigate to LoginScreen (Logout)
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}

// DashboardCard for the "RFID Connection History" card
class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DashboardCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white.withOpacity(0.8),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.green,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
