import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Icon(
                  Icons.notification_add,
                  color: const Color.fromARGB(255, 0, 34, 61),
                ),

                SizedBox(width: 20),

                IconButton(
                  icon: Icon(Icons.logout),
                  color: const Color.fromARGB(255, 0, 34, 61),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, "login");
                  },
                ),
              ],
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "Logs & Audits",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: const Color.fromARGB(255, 0, 34, 61),
            ),
          ),
        ),
      ),
    );
  }
}
