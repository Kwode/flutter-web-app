import 'dart:html' as html; // only works on Flutter Web
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart'; // Used for mobile

class LogsPage extends StatefulWidget {
  const LogsPage({super.key});

  @override
  _LogsPageState createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  String _search = '';
  List<QueryDocumentSnapshot> _allLogs = [];
  DateTimeRange? _selectedDateRange;

  // Export Logs to PDF (Web + Mobile)
  void _exportLogsToPDF() async {
    final pdf = pw.Document();

    final filteredLogs = _allLogs.where((doc) {
      final log = doc.data() as Map<String, dynamic>;
      final name = log['name']?.toLowerCase() ?? '';
      final action = log['action']?.toLowerCase() ?? '';
      return name.contains(_search) || action.contains(_search);
    }).toList();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text(
            'User Activity Logs',
            style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Table.fromTextArray(
            headers: ['Name', 'Action', 'Timestamp', 'Role'],
            data: filteredLogs.map((doc) {
              final log = doc.data() as Map<String, dynamic>;
              return [
                log['name'] ?? '',
                log['action'] ?? '',
                log['timestamp']?.toDate().toString() ?? '',
                log['role'] ?? '',
              ];
            }).toList(),
          ),
        ],
      ),
    );

    final Uint8List bytes = await pdf.save();

    // Check if the platform is Web or Mobile
    if (kIsWeb) {
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'activity_logs.pdf')
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      await Printing.sharePdf(bytes: bytes, filename: 'activity_logs.pdf');
    }
  }

  // Function to generate chart data for roles in logs
  void _generateRoleCounts(List<QueryDocumentSnapshot> logs) {
    final Map<String, int> roleCounts = {'Admin': 0, 'Driver': 0, 'Customer': 0};

    for (var log in logs) {
      final logData = log.data() as Map<String, dynamic>;
      final role = logData['role'] as String?;
      if (role != null && roleCounts.containsKey(role)) {
        roleCounts[role] = roleCounts[role]! + 1;
      }
    }

    setState(() {
      // _roleCounts = [
      //   roleCounts['Admin'] ?? 0,
      //   roleCounts['Driver'] ?? 0,
      //   roleCounts['Customer'] ?? 0,
      // ];
    });
  }

  // Function to pick a date range for filtering logs
  Future<void> _showDatePickerDialog(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        title: const Text('Activity Logs', style: TextStyle(color: Color.fromARGB(255, 0, 34, 61), fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf, color: Color.fromARGB(255, 0, 34, 61),),
            tooltip: 'Export to PDF',
            onPressed: _exportLogsToPDF,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔍 Search Bar
            TextField(
              decoration: InputDecoration(
                labelText: 'Search logs...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _search = value.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 20),

            // 📅 Button to open Date Range Picker Dialog
            Row(
              children: [
                const Text('Filter by date: '),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _showDatePickerDialog(context),
                ),
                if (_selectedDateRange != null)
                  Text(
                    '${_selectedDateRange!.start.toLocal()} - ${_selectedDateRange!.end.toLocal()}',
                  ),
              ],
            ),
            const SizedBox(height: 20),

            // 🔄 Log Stream
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('activity_logs')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  _allLogs = snapshot.data!.docs;

                  final filteredLogs = _allLogs.where((doc) {
                    final log = doc.data() as Map<String, dynamic>;
                    final name = log['name']?.toLowerCase() ?? '';
                    final action = log['action']?.toLowerCase() ?? '';

                    // Apply date filter if selected
                    if (_selectedDateRange != null) {
                      final timestamp = log['timestamp']?.toDate();
                      if (timestamp == null ||
                          timestamp.isBefore(_selectedDateRange!.start) ||
                          timestamp.isAfter(_selectedDateRange!.end)) {
                        return false;
                      }
                    }

                    return name.contains(_search) ||
                        action.contains(_search);
                  }).toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🧾 Summary
                      Text(
                        'Total Logs: ${filteredLogs.length}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // 🪵 Log List
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredLogs.length,
                          itemBuilder: (context, index) {
                            final log =
                                filteredLogs[index].data() as Map<String, dynamic>;
                            final timestamp =
                                log['timestamp']?.toDate().toString() ?? '';

                            Color chipColor;
                            switch (log['role']) {
                              case 'Admin':
                                chipColor = Colors.redAccent;
                                break;
                              case 'Driver':
                                chipColor = Colors.green;
                                break;
                              case 'Customer':
                                chipColor = Colors.blue;
                                break;
                              default:
                                chipColor = Colors.grey;
                            }

                            return Card(
                              child: ListTile(
                                title: Text(
                                  '${log['action']} - ${log['name']}',
                                ),
                                subtitle: Text(timestamp),
                                trailing: Chip(
                                  label: Text(log['role'] ?? 'Unknown'),
                                  backgroundColor: chipColor.withOpacity(0.2),
                                  labelStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
