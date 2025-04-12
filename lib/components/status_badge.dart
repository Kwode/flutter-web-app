import 'package:flutter/material.dart';

// StatusBadge widget for styled status display
class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({required this.status});

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
  const RecentRequestsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    'Email',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 34, 61),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Status',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 34, 61),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Role',
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
                    DataCell(StatusBadge(status: "Active")),
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
                    DataCell(StatusBadge(status: "Active")),
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
                    DataCell(StatusBadge(status: "Active")),
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
                    DataCell(StatusBadge(status: "Active")),
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
                    DataCell(StatusBadge(status: "Active")),
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
                    DataCell(StatusBadge(status: "Active")),
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
    );
  }
}
