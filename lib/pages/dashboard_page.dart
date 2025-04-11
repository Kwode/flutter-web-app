import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 34, 61),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Icon(Icons.notification_add, color: Colors.white),

                SizedBox(width: 20),

                IconButton(
                  icon: Icon(Icons.logout),
                  color: Colors.white,
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
            "Dashboard",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            //dashboard containers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  height: 120,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(
                      "Active Trips",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "12",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(8),
                  height: 120,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(
                      "Idle Trucks",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "5",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(8),
                  height: 120,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(
                      "Alerts",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "3",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(8),
                  height: 120,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(
                      "Notifications",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "8",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //notifications and truck location
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("lib/images/maps.jpeg"),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 220,
                      width: 580,
                      child: Center(
                        child: Icon(
                          Icons.fire_truck_rounded,
                          color: const Color.fromARGB(255, 0, 34, 61),
                          size: 55,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    Container(
                      padding: EdgeInsets.all(8),
                      height: 220,
                      width: 580,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Text(
                        "Latest Notifications",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 34, 61),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 50),

                //others
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 140,
                      width: 580,
                      child: Text(
                        "KPIs",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 34, 61),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    Container(
                      padding: EdgeInsets.all(8),
                      height: 140,
                      width: 580,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Text(
                        "Latest Notifications",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 34, 61),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    Container(
                      padding: EdgeInsets.all(8),
                      height: 140,
                      width: 580,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Text(
                        "System Health",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 34, 61),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),  
              ], 
            ),
          ],
        ),
      ),
    );
  }
}
