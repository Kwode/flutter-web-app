import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VehicleFormDialog extends StatefulWidget {
  const VehicleFormDialog({super.key});

  @override
  _VehicleFormDialogState createState() => _VehicleFormDialogState();
}

class _VehicleFormDialogState extends State<VehicleFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController plateController = TextEditingController();
  final TextEditingController driverIdController = TextEditingController();
  final TextEditingController fuelController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  bool isLoading = false;

  void saveVehicle() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      try {
        await FirebaseFirestore.instance.collection('vehicles').add({
          'plateNumber': plateController.text,
          'driverId': driverIdController.text,
          'fuelLevel': int.tryParse(fuelController.text) ?? 0,
          'capacity': int.tryParse(capacityController.text) ?? 0,
          'status': statusController.text,
          'location': GeoPoint(0, 0), // Placeholder for GPS
          'currentTrip': '',
          'serviceHistory': [],
          'createdAt': FieldValue.serverTimestamp(),
        });

        Navigator.pop(context);
      } on Exception catch (e) {
        // TODO
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Vehicle'),
      contentPadding: const EdgeInsets.all(20),
      content:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTextField(plateController, 'Plate Number'),
                      _buildTextField(driverIdController, 'Driver ID'),
                      _buildTextField(
                        fuelController,
                        'Fuel Level (%)',
                        isNumber: true,
                      ),
                      _buildTextField(
                        capacityController,
                        'Capacity (kg)',
                        isNumber: true,
                      ),
                      _buildTextField(
                        statusController,
                        'Status (e.g. Active/Inactive)',
                      ),
                    ],
                  ),
                ),
              ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: saveVehicle, child: const Text('Save')),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator:
            (value) => value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }
}
