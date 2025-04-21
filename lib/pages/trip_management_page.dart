import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:admin_dash/components/trip_form_dialog.dart';
import 'package:intl/intl.dart';

class TripManagementPage extends StatelessWidget {
  const TripManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle _headerStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 0, 34, 61),
    );

    const TextStyle _cellStyle = TextStyle(
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
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => TripFormDialog(),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 34, 61),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
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
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.logout),
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
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "Trip Management",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Color.fromARGB(255, 0, 34, 61),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('trips').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No trips found."));
            }

            final trips = snapshot.data!.docs;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('S/N', style: _headerStyle)),
                  DataColumn(label: Text('Trip ID', style: _headerStyle)),
                  DataColumn(label: Text('Driver Name', style: _headerStyle)),
                  DataColumn(label: Text('Vehicle Name', style: _headerStyle)),
                  DataColumn(label: Text('Route', style: _headerStyle)),
                  DataColumn(
                    label: Text('Scheduled Date', style: _headerStyle),
                  ),
                  DataColumn(label: Text('Status', style: _headerStyle)),
                ],
                rows: List.generate(trips.length, (index) {
                  final trip = trips[index].data() as Map<String, dynamic>;

                  // Format scheduled date
                  String formattedDate = '';
                  if (trip['scheduledDate'] != null &&
                      trip['scheduledDate'] is Timestamp) {
                    final date = (trip['scheduledDate'] as Timestamp).toDate();
                    formattedDate = DateFormat('dd MMM yyyy').format(date);
                  }

                  return DataRow(
                    cells: [
                      DataCell(Text('${index + 1}', style: _cellStyle)),
                      DataCell(Text(trip['tripId'] ?? '', style: _cellStyle)),
                      DataCell(Text(trip['driver'] ?? '', style: _cellStyle)),
                      DataCell(Text(trip['vehicle'] ?? '', style: _cellStyle)),
                      DataCell(Text(trip['route'] ?? '', style: _cellStyle)),
                      DataCell(Text(formattedDate, style: _cellStyle)),
                      DataCell(Text(trip['status'] ?? '', style: _cellStyle)),
                    ],
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
