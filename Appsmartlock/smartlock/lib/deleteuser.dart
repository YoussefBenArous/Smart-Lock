import 'package:flutter/material.dart';

class deleteuser extends StatelessWidget {
  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TextField for entering the ID
              TextField(
                controller: idController,
                decoration: InputDecoration(
                  labelText: "Enter ID",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Spacing between TextField and button
              // ElevatedButton for delete action
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Set color to red for delete
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Access the entered ID and perform delete action
                  String enteredId = idController.text;
                  print("Delete button pressed with ID: $enteredId");
                  // Add delete logic here
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

