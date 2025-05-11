import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:admin_dash/components/trip_form_dialog.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final String broker = 'broker.hivemq.com';
  final int tcpPort = 1883; // TCP for non-web
  final int wsPort = 8000; // WebSocket for web (not used due to error)
  final String clientId = 'flutter-subscriber-${DateTime.now().millisecondsSinceEpoch}';
  final String topic = 'truck/track/data';
  MqttServerClient? client;
  Function(Map<String, dynamic>)? onMessageReceived;
  Function(String)? onConnectionStatusChanged;

  MqttService() {
    if (!kIsWeb) {
      _initializeMQTTClient();
    } else {
      // Mock connection for web until a proper MQTT web solution is implemented
      print('MQTT disabled on web due to SecurityContext error. Using mock data.');
      onConnectionStatusChanged?.call('Mocked (Web)');
      Future.delayed(const Duration(seconds: 1), () {
        // Mock data to simulate MQTT message
        final mockData = {
          'temperature': '25.0',
          'oilVolume': '10.0',
          'speed': '60.0',
        };
        onMessageReceived?.call(mockData);
      });
    }
  }

  void _initializeMQTTClient() {
    client = MqttServerClient.withPort(
      broker,
      clientId,
      tcpPort, // Only used for non-web
    );
    client!.logging(on: true);
    client!.keepAlivePeriod = 60;
    client!.onDisconnected = _onDisconnected;
    client!.onConnected = _onConnected;
    client!.onSubscribed = _onSubscribed;
    client!.onSubscribeFail = _onSubscribeFail;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .withWillTopic('will/topic')
        .withWillMessage('Subscriber disconnected')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client!.connectionMessage = connMessage;
  }

  Future<void> connect() async {
    if (kIsWeb) {
      // Skip MQTT connection on web
      print('Skipping MQTT connect on web.');
      return;
    }

    if (client?.connectionStatus?.state == MqttConnectionState.connected) {
      onConnectionStatusChanged?.call('Connected');
      return;
    }

    int maxRetries = 3;
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        onConnectionStatusChanged?.call('Connecting (Attempt ${retryCount + 1}/$maxRetries)...');
        print('Attempting to connect to $broker:$tcpPort (Attempt ${retryCount + 1})');
        await client!.connect();
        print('Connection successful, subscribing to $topic');
        client!.subscribe(topic, MqttQos.atLeastOnce);
        break;
      } catch (e) {
        print('Connection failed: $e');
        retryCount++;
        if (retryCount == maxRetries) {
          onConnectionStatusChanged?.call('Connection failed after $maxRetries attempts: $e');
          disconnect();
          return;
        }
        await Future.delayed(const Duration(seconds: 2));
      }
    }

    client!.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      try {
        final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
        final payload = MqttPublishPayload.bytesToStringAsString(message.payload.message);
        print('Received payload: $payload');
        final data = jsonDecode(payload);
        print('Parsed data: $data');
        if (data is Map<String, dynamic>) {
          onMessageReceived?.call(data);
        } else {
          print('Invalid payload format: not a JSON object');
        }
      } catch (e) {
        print('Error processing MQTT message: $e');
      }
    }, onError: (e) {
      print('Error in MQTT updates stream: $e');
    });
  }

  void disconnect() {
    if (kIsWeb) {
      print('Skipping MQTT disconnect on web.');
      return;
    }
    try {
      client?.disconnect();
      onConnectionStatusChanged?.call('Disconnected');
    } catch (e) {
      print('Error during disconnect: $e');
    }
  }

  void _onConnected() {
    print('Connected to MQTT broker');
    onConnectionStatusChanged?.call('Connected');
  }

  void _onDisconnected() {
    print('Disconnected from MQTT broker');
    onConnectionStatusChanged?.call('Disconnected');
  }

  void _onSubscribed(String topic) {
    print('Subscribed to $topic');
  }

  void _onSubscribeFail(String topic) {
    print('Failed to subscribe to $topic');
    onConnectionStatusChanged?.call('Subscription failed');
  }

  void dispose() {
    disconnect();
    client = null;
  }
}

class TripManagementPage extends StatelessWidget {
  const TripManagementPage({super.key});

  Future<String> getAddressFromGeoPoint(GeoPoint geoPoint) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${geoPoint.latitude}&lon=${geoPoint.longitude}',
    );

    try {
      final response = await http.get(url, headers: {
        'User-Agent': 'flutter-web-app (adetomiwa2006@gmail.com)'
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final address = data['address'];
        return '${address['county']}, ${address['state']}';
      } else {
        return 'Failed to fetch address (status: ${response.statusCode})';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

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
                  DataColumn(label: Text('S/N', style: headerStyle)),
                  DataColumn(label: Text('Driver', style: headerStyle)),
                  DataColumn(label: Text('Customer', style: headerStyle)),
                  DataColumn(label: Text('Pickup Location', style: headerStyle)),
                  DataColumn(label: Text('Dropoff Location', style: headerStyle)),
                  DataColumn(
                    label: Text('Scheduled Date', style: headerStyle),
                  ),
                  DataColumn(label: Text('Status', style: headerStyle)),
                  DataColumn(label: Text('', style: headerStyle)),
                ],
                rows: List.generate(trips.length, (index) {
                  final trip = trips[index].data() as Map<String, dynamic>;
                  print('Trip data: $trip');

                  String formattedDate = '';
                  if (trip['scheduledDate'] != null && trip['scheduledDate'] is Timestamp) {
                    final date = (trip['scheduledDate'] as Timestamp).toDate();
                    formattedDate = DateFormat('dd MMM yyyy').format(date);
                  }

                  String pickupLocation = '';
                  String dropoffLocation = '';

                  return DataRow(
                    cells: [
                      DataCell(Text('${index + 1}', style: cellStyle)),
                      DataCell(FutureBuilder<DocumentSnapshot>(
                        future: (trip['driver'] is DocumentReference)
                            ? trip['driver'].get()
                            : Future.value(null),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            print('Driver fetch error: ${snapshot.error}');
                            return const Text('Error', style: cellStyle);
                          }
                          if (!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
                            return const Text('Unknown Driver', style: cellStyle);
                          }
                          final driverData = snapshot.data!.data() as Map<String, dynamic>?;
                          return Text(
                            driverData?['name'] ?? 'Unknown Driver',
                            style: cellStyle,
                          );
                        },
                      )),
                      DataCell(FutureBuilder<DocumentSnapshot>(
                        future: (trip['customer'] is DocumentReference)
                            ? trip['customer'].get()
                            : Future.value(null),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            print('Customer fetch error: ${snapshot.error}');
                            return const Text('Error', style: cellStyle);
                          }
                          if (!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
                            return const Text('Unknown Customer', style: cellStyle);
                          }
                          final customerData = snapshot.data!.data() as Map<String, dynamic>?;
                          return Text(
                            customerData?['name'] ?? 'Unknown Customer',
                            style: cellStyle,
                          );
                        },
                      )),
                      DataCell(FutureBuilder(
                        future: getAddressFromGeoPoint(
                          trip['pickup'] is GeoPoint
                              ? trip['pickup']
                              : GeoPoint(
                                  trip['pickup']?['latitude'] ?? 0.0,
                                  trip['pickup']?['longitude'] ?? 0.0,
                                ),
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            print('Pickup address error: ${snapshot.error}');
                            return Text('Error: ${snapshot.error}', style: cellStyle);
                          }
                          if (!snapshot.hasData) {
                            return const Text('Loading...', style: cellStyle);
                          }
                          pickupLocation = snapshot.data as String;
                          return Text(pickupLocation, style: cellStyle);
                        },
                      )),
                      DataCell(FutureBuilder(
                        future: getAddressFromGeoPoint(
                          trip['dropoff'] is GeoPoint
                              ? trip['dropoff']
                              : GeoPoint(
                                  trip['dropoff']?['latitude'] ?? 0.0,
                                  trip['dropoff']?['longitude'] ?? 0.0,
                                ),
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            print('Dropoff address error: ${snapshot.error}');
                            return Text('Error: ${snapshot.error}', style: cellStyle);
                          }
                          if (!snapshot.hasData) {
                            return const Text('Loading...', style: cellStyle);
                          }
                          dropoffLocation = snapshot.data as String;
                          return Text(dropoffLocation, style: cellStyle);
                        },
                      )),
                      DataCell(Text(formattedDate, style: cellStyle)),
                      DataCell(Text(trip['status'] ?? '', style: cellStyle)),
                      DataCell(
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                String temperature = 'N/A';
                                String oilVolume = 'N/A';
                                String speed = 'N/A';
                                String connectionStatus = 'Disconnected';

                                final mqtt = MqttService();

                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    mqtt.onConnectionStatusChanged = (status) {
                                      setState(() {
                                        connectionStatus = status;
                                        print('Connection status: $status');
                                      });
                                    };

                                    mqtt.onMessageReceived = (data) {
                                      setState(() {
                                        print('Message received: $data');
                                        temperature = data['temperature']?.toString() ?? 'N/A';
                                        oilVolume = data['oilVolume']?.toString() ?? 'N/A';
                                        speed = data['speed']?.toString() ?? 'N/A';
                                        print('Updated values: T=$temperature, V=$oilVolume, S=$speed');
                                      });
                                    };

                                    mqtt.connect();

                                    return AlertDialog(
                                      title: const Text('Live Trip Details'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Connection: $connectionStatus'),
                                          const SizedBox(height: 8),
                                          Text('Temperature: $temperature °C'),
                                          Text('Oil Volume: $oilVolume L'),
                                          Text('Speed: $speed km/h'),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            mqtt.disconnect();
                                            mqtt.dispose();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: const Text('Details'),
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
    );
  }
}