import 'package:flutter/material.dart';
import 'package:lock/DashboardScreen.dart';
import 'package:lock/about.dart';
import 'package:lock/users.dart'; // Import the AboutScreen
import 'package:curved_navigation_bar/curved_navigation_bar.dart'; // Import curved_navigation_bar

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Centralized logout function
  void _logout(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/login'); // Navigate to login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/dash.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.shade800,
                      Colors.green.shade400,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      "WELCOME TO UR LOCKLY APP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Your security, our priority. Explore the dashboard!",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Dashboard Cards
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.all(16.0),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    DashboardCard(
                      icon: Icons.person,
                      title: "Users",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UsersScreen(),
                          ),
                        );
                      },
                    ),
                    DashboardCard(
                      icon: Icons.dashboard,
                      title: "Dashboard",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardScreen(),
                          ),
                        );
                      },
                    ),
                    DashboardCard(
                      icon: Icons.info,
                      title: "About",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutScreen(),
                          ),
                        );
                      },
                    ),
                    DashboardCard(
                      icon: Icons.logout,
                      title: "Logout",
                      onTap: () {
                        _logout(context); // Use centralized logout function
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      // Using CurvedNavigationBar
      bottomNavigationBar: CurvedNavigationBar(
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
              Navigator.of(context).pop(); // Go back to home
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(),
                ),
              );
              break;
            case 2:
              _logout(context); // Call the centralized logout function
              break;
          }
        },
      ),
    );
  }
}

// DashboardCard Widget
class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DashboardCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.green,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
