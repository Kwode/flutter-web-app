import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

const TextStyle _headerStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(255, 0, 34, 61),
  fontSize: 20,
);

const TextStyle _cellStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(255, 0, 34, 61),
);

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

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
            "Reports & Analytics",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Color.fromARGB(255, 0, 34, 61),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Activity Logs',
              style: _headerStyle, // Apply header style here
            ),
            const SizedBox(height: 20),
            SizedBox(
              height:
                  300, // Give fixed height for ListView to avoid infinite height error
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance
                        .collection('activity_logs')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final logs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      final log = logs[index].data() as Map<String, dynamic>;
                      return Card(
                        elevation: 2,
                        color: const Color.fromARGB(255, 238, 238, 238),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(
                            '${log['action']} - ${log['name']}',
                            style: _cellStyle,
                          ), // Apply cell style here
                          subtitle: Text(
                            '${log['timestamp'].toDate()}',
                            style: _cellStyle,
                          ), // Apply cell style here
                          trailing: Text(
                            log['role'] ?? 'Unknown Role',
                            style: _cellStyle,
                          ), // Apply cell style here
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'User Statistics',
              style: _headerStyle, // Apply header style here
            ),
            const SizedBox(height: 20),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('users').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final users = snapshot.data!.docs;
                final totalUsers = users.length;
                final roleCounts = {'Admin': 0, 'Driver': 0, 'Customer': 0};

                for (var user in users) {
                  final role = user['role'];
                  if (role != null && roleCounts.containsKey(role)) {
                    roleCounts[role] = roleCounts[role]! + 1;
                  }
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Users: $totalUsers',
                      style: _cellStyle,
                    ), // Apply cell style here
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Admins: ${roleCounts['Admin']}',
                          style: _cellStyle,
                        ), // Apply cell style here
                        Text(
                          'Drivers: ${roleCounts['Driver']}',
                          style: _cellStyle,
                        ), // Apply cell style here
                        Text(
                          'Customers: ${roleCounts['Customer']}',
                          style: _cellStyle,
                        ), // Apply cell style here
                      ],
                    ),
                  ],
                );
              },
            ),
            // Vehicle Information Section
            const SizedBox(height: 40),
            Text('Vehicle Information', style: _headerStyle),
            const SizedBox(height: 20),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('vehicles').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final vehicles = snapshot.data!.docs;
                final totalVehicles = vehicles.length;
                final available =
                    vehicles.where((v) => v['status'] == 'available').length;
                final inUse =
                    vehicles.where((v) => v['status'] == 'in_use').length;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Vehicles: $totalVehicles', style: _cellStyle),
                    Text('Available: $available', style: _cellStyle),
                    Text('In Use: $inUse', style: _cellStyle),
                  ],
                );
              },
            ),

            // Trip Information Section
            const SizedBox(height: 40),
            Text('Trip Information', style: _headerStyle),
            const SizedBox(height: 20),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('trips').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final trips = snapshot.data!.docs;
                final totalTrips = trips.length;
                final completed =
                    trips.where((t) => t['status'] == 'completed').length;
                final ongoing =
                    trips.where((t) => t['status'] == 'ongoing').length;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Trips: $totalTrips', style: _cellStyle),
                    Text('Completed Trips: $completed', style: _cellStyle),
                    Text('Ongoing Trips: $ongoing', style: _cellStyle),
                  ],
                );
              },
            ),

            const SizedBox(height: 40),
            Text(
              'Role Distribution',
              style: _headerStyle, // Apply header style here
            ),
            const SizedBox(height: 20),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('users').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final users = snapshot.data!.docs;
                final roleCounts = {'Admin': 0, 'Driver': 0, 'Customer': 0};

                for (var user in users) {
                  final role = user['role'];
                  if (role != null && roleCounts.containsKey(role)) {
                    roleCounts[role] = roleCounts[role]! + 1;
                  }
                }

                final counts = [
                  roleCounts['Admin']!,
                  roleCounts['Driver']!,
                  roleCounts['Customer']!,
                ];

                return RoleDistributionChart(counts);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RoleDistributionChart extends StatelessWidget {
  final List<int> counts;

  const RoleDistributionChart(this.counts, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: counts[0].toDouble(),
                  width: 20,
                  color: Colors.blue,
                ),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  toY: counts[1].toDouble(),
                  width: 20,
                  color: Colors.green,
                ),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                  toY: counts[2].toDouble(),
                  width: 20,
                  color: Colors.orange,
                ),
              ],
            ),
          ],
          minY: 0,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final labels = ['Admin', 'Driver', 'Customer'];
                  final index = value.toInt();
                  if (index < 0 || index >= labels.length) {
                    return const SizedBox.shrink();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      labels[index],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: true),
        ),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      ),
    );
  }
}
