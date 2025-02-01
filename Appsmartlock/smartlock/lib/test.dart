import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class UserIdScreen extends StatefulWidget {
  const UserIdScreen({Key? key}) : super(key: key);

  @override
  UserIdScreenState createState() => UserIdScreenState();
}

class UserIdScreenState extends State<UserIdScreen> {
  final TextEditingController _userIdController = TextEditingController();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  String? _message;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkFirebaseInitialization();
  }

  // Ensure Firebase is initialized
  Future<void> _checkFirebaseInitialization() async {
    try {
      await Firebase.initializeApp();
      print("Firebase Initialized Successfully!");
    } catch (e) {
      print("Firebase Initialization Failed: $e");
      setState(() {
        _message = "Firebase Initialization Failed: $e";
      });
    }
  }

  Future<void> _saveUserId() async {
    setState(() {
      _isLoading = true;
      _message = null;
    });

    try {
      final userId = _userIdController.text.trim();
      if (userId.isEmpty) {
        throw Exception('User ID cannot be empty');
      }

      // Log the userId for debugging purposes
      print("Attempting to save User ID: $userId");

      // Save user ID directly under a specific node using userId as a unique child
      await _database.child('users').child(userId).set({
        'userId': userId,
        'timestamp': ServerValue.timestamp,
      });

      setState(() {
        _message = 'User ID saved successfully!';
        _userIdController.clear();
      });

      print("User ID saved successfully!");
    } catch (e) {
      // Log the error for debugging
      print('Error saving user ID: $e');
      setState(() {
        _message = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set User ID'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _userIdController,
              decoration: const InputDecoration(
                labelText: 'Enter User ID',
                border: OutlineInputBorder(),
                hintText: 'e.g., user123',
              ),
              enabled: !_isLoading,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveUserId,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Save User ID'),
              ),
            ),
            if (_message != null) ...[
              const SizedBox(height: 20),
              Text(
                _message!,
                style: TextStyle(
                  color:
                      _message!.startsWith('Error') ? Colors.red : Colors.green,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }
}
