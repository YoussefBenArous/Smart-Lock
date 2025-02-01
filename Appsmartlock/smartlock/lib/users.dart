import 'package:flutter/material.dart';
import 'package:lock/login.dart';
import 'DashboardScreen.dart'; // Assuming you have a DashboardScreen
import 'package:curved_navigation_bar/curved_navigation_bar.dart'; // Import the curved navigation bar package

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  int _currentIndex = 0; // Current index of the bottom navigation bar
  final List<Map<String, String>> users = [
    {'name': 'User1', 'role': 'Owner', 'id': '1154-4541-2463'},
    {'name': 'User2', 'role': 'Child', 'id': '2201-4856-1426'},
    {'name': 'User3', 'role': 'Visitor', 'id': '1424-5426-7785'},
    {'name': 'User4', 'role': 'Wife', 'id': '1546-1843-4535'},
  ];

  // Callback function to save changes from UserDetailsScreen
  void saveUserChanges(Map<String, String> updatedUser) {
    setState(() {
      int index = users.indexWhere((user) => user['id'] == updatedUser['id']);
      if (index != -1) {
        users[index] = updatedUser;
      }
    });
  }

  void addUser(BuildContext context) {
    final _nameController = TextEditingController();
    final _roleController = TextEditingController();
    final _idController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _roleController,
                decoration: const InputDecoration(labelText: 'Role'),
              ),
              TextField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'ID'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty &&
                    _roleController.text.isNotEmpty &&
                    _idController.text.isNotEmpty) {
                  setState(() {
                    users.add({
                      'name': _nameController.text,
                      'role': _roleController.text,
                      'id': _idController.text,
                    });
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void logOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              LoginScreen()), // Navigate to LoginScreen after logout
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/dash.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Hello, User!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Keep Your House Safe With Lockly\nHave a Nice Day!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(137, 252, 250, 250),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailsScreen(
                              user: user,
                              onSaveChanges: saveUserChanges,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.green.withOpacity(0.5),
                            child: Text(
                              user['name']![0],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Text(
                            user['name']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(user['role']!),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                          backgroundColor: Colors.green,
                          child: const Icon(Icons.add),
                          onPressed: () => addUser(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex, // Track selected index
        height: 60,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.dashboard, size: 30),
          Icon(Icons.logout, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected index
          });
          switch (index) {
            case 0:
              // Navigate to Home (current screen)
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        UsersScreen()), // Home screen (Users screen)
              );
              break;
            case 1:
              // Navigate to Dashboard screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              );
              break;
            case 2:
              // Log out
              logOut();
              break;
          }
        },
      ),
    );
  }
}

class UserDetailsScreen extends StatefulWidget {
  final Map<String, String> user;
  final Function(Map<String, String>) onSaveChanges;

  const UserDetailsScreen({
    required this.user,
    required this.onSaveChanges,
  });

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late TextEditingController _nameController;
  late TextEditingController _roleController;
  late TextEditingController _idController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user['name']);
    _roleController = TextEditingController(text: widget.user['role']);
    _idController = TextEditingController(text: widget.user['id']);
  }

  void saveChanges() {
    widget.user['name'] = _nameController.text;
    widget.user['role'] = _roleController.text;
    widget.user['id'] = _idController.text;
    widget.onSaveChanges(widget.user);
    Navigator.of(context).pop(); // Navigate back after saving changes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/dash.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Edit User Details',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _nameController,
                            decoration:
                                const InputDecoration(labelText: 'Name'),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _roleController,
                            decoration:
                                const InputDecoration(labelText: 'Role'),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _idController,
                            decoration: const InputDecoration(labelText: 'ID'),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: saveChanges,
                            child: const Text(
                              'Save Changes',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
