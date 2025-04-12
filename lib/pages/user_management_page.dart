import 'package:admin_dash/components/status_badge.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserManagementPage extends StatelessWidget {
  const UserManagementPage({super.key});

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
            "User Management",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: const Color.fromARGB(255, 0, 34, 61),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  height: 120,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.add,
                      color: const Color.fromARGB(255, 0, 34, 61),
                      weight: 10,
                      size: 40,
                    ),
                    title: Text(
                      "Create User",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                        fontSize: 27,
                      ),
                    ),
                    subtitle: Text(
                      "Add a new admin, driver or customer",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 34, 61),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  height: 120,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.qr_code,
                      color: const Color.fromARGB(255, 0, 34, 61),
                      weight: 10,
                      size: 40,
                    ),
                    title: Text(
                      "Roles & Permissions",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                        fontSize: 27,
                      ),
                    ),
                    subtitle: Text(
                      "Assign and manage user roles",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 34, 61),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  height: 120,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.history,
                      color: const Color.fromARGB(255, 0, 34, 61),
                      weight: 10,
                      size: 40,
                    ),
                    title: Text(
                      "Activity Logs",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                        fontSize: 27,
                      ),
                    ),
                    subtitle: Text(
                      "View user actions and events",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 34, 61),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Admins",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 34, 61),
                    fontSize: 27,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            Container(
              height: 400,
              width: 1220,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: RecentRequestsCard(),
            ),
          ],
        ),
      ),
    );
  }
}
