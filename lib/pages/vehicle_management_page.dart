import 'package:admin_dash/components/vehicle_form_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VehicleManagementPage extends StatelessWidget {
  const VehicleManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle headerStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 0, 34, 61),
    );

    const TextStyle cellStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 0, 34, 61),
    );

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
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => VehicleFormDialog(),
                            );
                          },
                          child: Text(
                            "Register Truck",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
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
            "Vehicle Management",
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
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance
                        .collection('vehicles')
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No vehicles found.'));
                  }

                  final vehicles = snapshot.data!.docs;

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('S/N', style: headerStyle)),
                        DataColumn(label: Text('Driver', style: headerStyle)),
                        DataColumn(
                          label: Text('Truck ID', style: headerStyle),
                        ),
                        DataColumn(label: Text('Route', style: headerStyle)),
                        DataColumn(
                          label: Text('Location', style: headerStyle),
                        ),
                        DataColumn(
                          label: Text('Current Trip', style: headerStyle),
                        ),
                        DataColumn(
                          label: Text('Capacity', style: headerStyle),
                        ),
                        DataColumn(
                          label: Text('Plate Number', style: headerStyle),
                        ),
                      ],
                      rows: List.generate(vehicles.length, (index) {
                        final vehicle = vehicles[index];
                        return DataRow(
                          cells: [
                            DataCell(Text('${index + 1}', style: cellStyle)),
                            DataCell(
                              Text(
                                vehicle['driverId'] ?? '-',
                                style: cellStyle,
                              ),
                            ),
                            DataCell(
                              Text(vehicle.id, style: cellStyle),
                            ), // Document ID as Truck ID
                            DataCell(
                              Text(vehicle['status'] ?? '-', style: cellStyle),
                            ), // Assuming "status" is used like route
                            DataCell(
                              Text('N/A', style: cellStyle),
                            ), // Placeholder if location not reverse-geocoded
                            DataCell(
                              Text(
                                vehicle['currentTrip'] ?? '-',
                                style: cellStyle,
                              ),
                            ),
                            DataCell(
                              Text('${vehicle['capacity']}', style: cellStyle),
                            ),
                            DataCell(
                              Text(
                                vehicle['plateNumber'] ?? '-',
                                style: cellStyle,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
