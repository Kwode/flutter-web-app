import 'package:flutter/material.dart';

class UserManagementPage extends StatelessWidget {
  const UserManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 34, 61),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Icon(Icons.notification_add, color: Colors.white),

                SizedBox(width: 20),

                Icon(Icons.logout, color: Colors.white),
              ],
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "User Management",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
