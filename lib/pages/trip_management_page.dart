import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TripManagementPage extends StatelessWidget {
  const TripManagementPage({super.key});

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
                MouseRegion(
                  cursor:
                      SystemMouseCursors
                          .click, // Changes the cursor to a clickable hand
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 34, 61),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Add Trip",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
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
            "Trip Management",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: const Color.fromARGB(255, 0, 34, 61),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(
                    label: Text(
                      'S/N',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Truck',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Route',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Location',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Age',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Years of Work',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Jurisdiction',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                      ),
                    ),
                  ),
                ],
                rows: const [
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          '1',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'John Stone',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'johnstone@gmail.com',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Admin',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Lagos, Nigeria',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '24',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '10',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Abuja Branch',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          '1',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'John Stone',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'johnstone@gmail.com',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Admin',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Lagos, Nigeria',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '24',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '10',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Abuja Branch',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          '1',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'John Stone',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'johnstone@gmail.com',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Admin',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Lagos, Nigeria',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '24',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '10',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Abuja Branch',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          '1',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'John Stone',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'johnstone@gmail.com',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Admin',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Lagos, Nigeria',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '24',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '10',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Abuja Branch',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          '1',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'John Stone',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'johnstone@gmail.com',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Admin',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Lagos, Nigeria',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '24',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '10',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Abuja Branch',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          '1',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'John Stone',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'johnstone@gmail.com',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Admin',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Lagos, Nigeria',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '24',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '10',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Abuja Branch',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          '1',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'John Stone',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'johnstone@gmail.com',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Admin',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Lagos, Nigeria',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '24',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '10',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Abuja Branch',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          '2',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'John Stone',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'johnstone@gmail.com',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Admin',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Lagos, Nigeria',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '24',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '10',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Abuja Branch',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          '3',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'John Stone',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'johnstone@gmail.com',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Admin',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Lagos, Nigeria',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '24',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '10',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Abuja Branch',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          '4',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'John Stone',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'johnstone@gmail.com',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Admin',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Lagos, Nigeria',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '24',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '10',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Abuja Branch',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          '5',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'John Stone',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'johnstone@gmail.com',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Admin',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Lagos, Nigeria',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '24',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '10',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Abuja Branch',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          '6',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'John Stone',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'johnstone@gmail.com',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Admin',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Lagos, Nigeria',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '24',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '10',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          'Abuja Branch',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 34, 61),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
