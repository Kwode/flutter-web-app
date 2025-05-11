import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore, QuerySnapshot, Timestamp;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// StatusBadge widget for styled status display
class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  Color getStatusColor() {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'suspended':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: getStatusColor().withOpacity(0.1),
        border: Border.all(color: getStatusColor()),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(color: getStatusColor(), fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Main RecentRequestsCard Widget
class RecentRequestsCard extends StatelessWidget {
  const RecentRequestsCard({super.key});

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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No users found."));
          }

          final users = snapshot.data!.docs;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('S/N', style: headerStyle)),
                DataColumn(label: Text('Name', style: headerStyle)),
                DataColumn(label: Text('Email', style: headerStyle)),
                DataColumn(label: Text('Status', style: headerStyle)),
                DataColumn(label: Text('Role', style: headerStyle)),
                DataColumn(label: Text('Location', style: headerStyle)),
                DataColumn(label: Text('Age', style: headerStyle)),
                DataColumn(label: Text('Jurisdiction', style: headerStyle)),
              ],
              rows: List.generate(users.length, (index) {
                final user = users[index].data() as Map<String, dynamic>;

                return DataRow(
                  cells: [
                    DataCell(Text('${index + 1}', style: cellStyle)),
                    DataCell(Text(user['name'] ?? '', style: cellStyle)),
                    DataCell(Text(user['email'] ?? '', style: cellStyle)),
                    DataCell(StatusBadge(status: user['status'] ?? 'default')),
                    DataCell(Text(user['role'] ?? '', style: cellStyle)),
                    DataCell(Text(user['location'] ?? '', style: cellStyle)),
                    DataCell(Text(user['age'] ?? '', style: cellStyle)),
                    DataCell(Text(user['jurisdiction'] ?? '', style: cellStyle)),
                  ],
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
