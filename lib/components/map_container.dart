import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class TruckMap extends StatefulWidget {
  const TruckMap({super.key});

  @override
  State<TruckMap> createState() => _TruckMapState();
}

class _TruckMapState extends State<TruckMap> {
  final Set<Marker> _markers = {};
  late GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
    _fetchTruckLocations();
  }

  void _fetchTruckLocations() async {
    final vehiclesSnapshot = await FirebaseFirestore.instance
        .collection('vehicles')
        .where('status', isEqualTo: 'Active') // or all vehicles
        .get();

    final Set<Marker> loadedMarkers = {};

    for (var doc in vehiclesSnapshot.docs) {
      final data = doc.data();
      final location = data['location'];
      if (location != null) {
        final marker = Marker(
          markerId: MarkerId(doc.id),
          position: LatLng(location['lat'], location['lng']),
          infoWindow: InfoWindow(title: data['id'] ?? 'Truck'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        );
        loadedMarkers.add(marker);
      }
    }

    setState(() {
      _markers.clear();
      _markers.addAll(loadedMarkers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 580,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(6.5244, 3.3792), // Lagos as default center
            zoom: 10,
          ),
          onMapCreated: (controller) {
            _mapController = controller;
          },
          markers: _markers,
          myLocationEnabled: false,
          zoomControlsEnabled: true,
        ),
      ),
    );
  }
}
