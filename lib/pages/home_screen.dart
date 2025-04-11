import 'package:admin_dash/pages/dashboard_page.dart';
import 'package:admin_dash/pages/home_page.dart';
import 'package:admin_dash/pages/user_management_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex = 0; // Default page is Home

  // List of pages
  final List<Widget> _pages = [
    DashboardPage(),
    UserManagementPage(),
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ];

  void _onTileTap(int index) {
    setState(() {
      _selectedPageIndex = index; // Update the displayed page
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Drawer-Like Sidebar with ListTiles
          Container(
            width: 250,
            color: const Color.fromARGB(255, 0, 34, 61),
            child: Column(
              children: [
                GestureDetector(
                  child: Container(
                    height: 70,
                    color: const Color.fromARGB(255, 0, 74, 134),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: Text("data"),
                        ),

                        SizedBox(width: 10),

                        Text(
                          FirebaseAuth.instance.currentUser?.email ??
                              "Not Logged In",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                    left: 12,
                    right: 12,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        tileColor: Colors.black,
                        leading: Icon(
                          Icons.dashboard,
                          color: const Color.fromARGB(255, 240, 240, 240),
                        ),
                        title: Text(
                          "Dashboard",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 240, 240, 240),
                          ),
                        ),
                        onTap: () => _onTileTap(0),
                      ),

                      SizedBox(height: 10),

                      ListTile(
                        selectedTileColor: Colors.black,
                        leading: Icon(
                          Icons.person,
                          color: const Color.fromARGB(255, 240, 240, 240),
                        ),
                        title: Text(
                          "User Management",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 240, 240, 240),
                          ),
                        ),
                        onTap: () => _onTileTap(1),
                      ),

                      SizedBox(height: 10),

                      ListTile(
                        leading: Icon(
                          Icons.fire_truck,
                          color: const Color.fromARGB(255, 240, 240, 240),
                        ),
                        title: Text(
                          "Vehicle Management",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 240, 240, 240),
                          ),
                        ),
                        onTap: () => _onTileTap(2),
                      ),

                      SizedBox(height: 10),

                      ListTile(
                        leading: Icon(
                          Icons.car_crash,
                          color: const Color.fromARGB(255, 240, 240, 240),
                        ),
                        title: Text(
                          "Trip Management",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 240, 240, 240),
                          ),
                        ),
                        onTap: () => _onTileTap(3),
                      ),

                      SizedBox(height: 10),

                      ListTile(
                        leading: Icon(
                          Icons.notification_important,
                          color: const Color.fromARGB(255, 240, 240, 240),
                        ),
                        title: Text(
                          "Alerts & Notifications",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 240, 240, 240),
                          ),
                        ),
                        onTap: () => _onTileTap(3),
                      ),

                      SizedBox(height: 10),

                      ListTile(
                        leading: Icon(
                          Icons.bar_chart,
                          color: const Color.fromARGB(255, 240, 240, 240),
                        ),
                        title: Text(
                          "Reports & Analytics",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 240, 240, 240),
                          ),
                        ),
                        onTap: () => _onTileTap(3),
                      ),

                      SizedBox(height: 10),

                      ListTile(
                        leading: Icon(
                          Icons.star,
                          color: const Color.fromARGB(255, 240, 240, 240),
                        ),
                        title: Text(
                          "Ratings & Feedback",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 240, 240, 240),
                          ),
                        ),
                        onTap: () => _onTileTap(3),
                      ),

                      SizedBox(height: 10),

                      ListTile(
                        leading: Icon(
                          Icons.book,
                          color: const Color.fromARGB(255, 240, 240, 240),
                        ),
                        title: Text(
                          "Logs & Audit",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 240, 240, 240),
                          ),
                        ),
                        onTap: () => _onTileTap(3),
                      ),

                      SizedBox(height: 10),

                      ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: const Color.fromARGB(255, 240, 240, 240),
                        ),
                        title: Text(
                          "System Settings",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 240, 240, 240),
                          ),
                        ),
                        onTap: () => _onTileTap(3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main Content Area (Dynamic Page Display)
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: _pages[_selectedPageIndex], // Show selected page
            ),
          ),
        ],
      ),
    );
  }
}
